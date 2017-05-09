<?php

namespace App\Presenters;

use Nette,
    App\Model,
    Nette\Application\UI\Form;

/**
 * Admin section
 */
class NominationsPresenter extends BaseSecuredPresenter {

    /** @var Nette\Database\Context */
    private $database;

    private $db_members;
    private $elections;


    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();

        \Nella\Forms\DateTime\DateInput::register();
        $this->database = $database;

        $this->db_members = $this->database->table('members_member')
                    ->where("id_rank.active", 1)
                    ->order('name ASC');
        }


    public function renderDefault() {
        $this->template->elections = $this->database->table('members_elections')->order('from ASC');
                                         // ->where("from <= '" . date("Y-m-d G:i") . "'")
                                         // ->where("to >= '" . date("Y-m-d G:i") . "'");
        $this->template->db_members = $this->db_members;
    }

    public function renderNew($id){
        $this->template->id_election = $id;
        $this->template->election = $this->database->table('members_elections')->get($id);
    }

    public function renderOverview($id){
        $this->template->id_election = $id;
        $this->template->database = $this->database;
        $this->template->election = $this->database->table('members_elections')->get($id);
        $this->template->members = $this->db_members;
        $this->template->positions= $this->database->table('members_nomination_pos')->where('id_election = ' . $id);
        $this->template->nominations = $this->database->table('members_nominations')->where('id_election = ' . $id)->where('id_nominee IS NOT NULL');
        $this->template->nominations_bs = $this->database->table('members_nominations')->where('id_election = ' . $id)->where('id_nominee IS NULL');
    }

    public function renderMyself($id){
        $user = $this->getUser();
        $this->template->id_election = $id;
        $this->template->election = $this->database->table('members_elections')->get($id);
        $this->template->nominations = $this->database->table('members_nominations')->where('id_election = ' . $id)->where('id_nominee =' . $user->getId());
    }

    public function renderEdit($id){
        $this->template->id_election = $id;
        $this->template->positions = $this->database->table('members_board_pos');
    }

    public function renderAdd(){
        $this->template->positions = $this->database->table('members_board_pos');
    }

    public function renderAdmin(){
        $this->template->elections = $this->database->table('members_elections')->order('from ASC');
        $this->template->elections = $this->template->elections;
        $this->template->db_members = $this->db_members;
    }

    public function actionEdit($id_election)
    {   
        $election = $this->database->table('members_elections')->get($id_election);
        if (!$election) {
            $this->error('Nominace nenalezeny');
        }
        $user = $this->getUser();
        if ($user->isInRole('admin')) {
            foreach ($election->related('members_nomination_pos.id_election') as $id => $row) {
                $this['electionsForm'][$row->id_board_pos]->setDefaultValue(True);
            }
            $this['electionsForm']['submit']->caption = 'Uložit';

            // $this['electionsForm']->onSuccess[] = array($this, 'editFormSucceeded');
            $this['electionsForm']->setDefaults($election->toArray());
            $this['electionsForm']['from']->setDefaultValue($election->from->format('d.m.Y G:i'));
            $this['electionsForm']['to']->setDefaultValue($election->to->format('d.m.Y G:i'));
        }
    }

    public function handleDelete($id_election)
    {
        $this->database->table('members_elections')->get($id_election)->delete();
        $this->flashMessage('Volby smazány.');
        $this->redirect('Nominations:admin');
    }

    private function makeFormLookGood($form) {
        // All of this is only additional code that makes Nette form look good in Bootstrap
        // setup form rendering
        $renderer = $form->getRenderer();
        $renderer->wrappers['controls']['container'] = NULL;
        $renderer->wrappers['pair']['container'] = 'div class=form-group';
        $renderer->wrappers['pair']['.error'] = 'has-error';
        $renderer->wrappers['control']['container'] = 'div class=col-sm-9';
        $renderer->wrappers['label']['container'] = 'div class="col-sm-3 control-label"';
        $renderer->wrappers['control']['description'] = 'span class=help-block';
        $renderer->wrappers['control']['errorcontainer'] = 'span class=help-block';
        // make form and controls compatible with Twitter Bootstrap
        $form->getElementPrototype()->class('form-horizontal');
        foreach ($form->getControls() as $control) {
            if ($control instanceof Controls\Button) {
                $control->getControlPrototype()->addClass(empty($usedPrimary) ? 'btn btn-primary' : 'btn btn-default');
                $usedPrimary = TRUE;
            } elseif ($control instanceof Controls\TextBase || $control instanceof Controls\SelectBox || $control instanceof Controls\MultiSelectBox) {
                $control->getControlPrototype()->addClass('form-control');
            } elseif ($control instanceof Controls\Checkbox || $control instanceof Controls\CheckboxList || $control instanceof Controls\RadioList) {
                $control->getSeparatorPrototype()->setName('div')->addClass($control->getControlPrototype()->type);
            }
        }
    }

    protected function createComponentNominationsForm()
    {
        $user = $this->getUser();
        $members = array();

        $members[0] = "- jiný (vyplň)";
        foreach ($this->db_members as $id => $row) {
            $members[$id] = $row['name'] . " " . $row['surname'];
        }

        $form = new Form;

        $positions_select = $this->database->table('members_nomination_pos')->where('id_election = ', $this->getParameter('id'));
        $positions = array();

        foreach ($positions_select as $id => $row) {
            $positions[$row->id_board_pos] = $this->database->table('members_board_pos')->get($row->id_board_pos)->name;
        }
        $form->addSelect('id_board_pos', 'Pozice*:', $positions);

        $form->addSelect('id_member', 'Člen*:', $members);
        $form->addText('member_name', 'Jméno člena:')->setOption('description', 'Vyplň pouze pokud chceš nominovat jiného člena.');
        $form->addTextArea('note', 'Komentář:')->setOption('description', 'Nepovinný komentář, zobrazí se nominovanému.');

        $form->addSubmit('submit', 'Nominovat');
        $form->addHidden('userid');
        $form->onSuccess[] = array($this, 'nominationsFormSucceeded');

        $form->onValidate[] = array($this, 'validateNominationsForm');
        $this->makeFormLookGood($form);

        return $form;
    }

    public function validateNominationsForm($form) {
        $values = $form->getValues();

        if ($values['id_member'] == 0 && empty($values['member_name']) ) {
            $form->addError('Vyber člena ze seznamu nebo vypiš jeho jméno ručně, pokud se v seznamu nenachází.');
        }
    }

    protected function createComponentElectionsForm()
    {
        $user = $this->getUser();
        $form = new Form;

        $form->addText('name', 'Název:')->setRequired('Pojmenuj ty volby, co ti to udělá...');

        $form->addText("from", "Začátek nominací:")
        ->setRequired("Začátek nominací je povinný údaj!")
        ->setAttribute("placeholder", "dd.mm.rrrr hh:mm")
        ->setDefaultValue(date("d.m.Y H:i"));

        $form->addText("to", "Konec nominací:")
        ->setRequired("Konec nominací je povinný údaj!")
        ->setAttribute("placeholder", "dd.mm.rrrr hh:mm")
        ->setDefaultValue(date("d.m.Y H:i"))
        ->addRule($form::PATTERN, "Datum musí být ve formátu dd.mm.rrrr hh:mm", "(0[1-9]|[12][0-9]|3[01])\.(0[1-9]|1[012])\.(19|20)\d\d (0|1|2)[0-9]:[0-5][0-9]");

        $form->addCheckbox("nominations_visible", " Členové si mohou zobrazit vlastní nominace (zapnout po volbách)");

        $positions_select = $this->database->table('members_board_pos');
        $positions = array();

        foreach ($positions_select as $id => $row) {
            $positions[$id] = $positions_select->name;
            $form->addCheckbox($id);
        }

        $form->addSubmit('submit', 'Vypsat nominace');
        $form->onSuccess[] = array($this, 'electionsFormSucceeded');
        $form->onValidate[] = array($this, 'validateElectionsForm');
        $this->makeFormLookGood($form);

        return $form;
    }

    public function validateElectionsForm($form) {
        $values = $form->getValues();
        $empty = True;

        foreach ($values as $i => $value) {
            if (is_numeric($i) && $value != False) {
                $empty = False;
            }
        }
        if ($empty) {
            $form->addError("Vyplň aspoň jednu pozici.");
        }
    }

    public function makeStringsNull($values) {
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }
    }

    public function nominationsFormSucceeded($form, $values) {   
        $user = $this->getUser();
        $this->makeStringsNull($values);

        $this->database->table('members_nominations')->insert(array(
            'id_board_pos' => $values['id_board_pos'],
            'id_election' => $this->getParameter('id'),
            'id_proposer' => $user->getId(),
            'id_nominee' => $values['id_member'] == 0 ? NULL : $values['id_member'],
            'name' => $values['member_name'],
            'note' => $values['note'],
            'timestamp' => date('Y-m-d H:i:s')
            ));
        $this->flashMessage("Člen byl úspěšně nominován!");
        $this->redirect('Nominations:new', array("id" => $this->getParameter('id')));
    }

    public function electionsFormSucceeded($form, $values)
    {   
        $user = $this->getUser();
        $this->makeStringsNull($values);
        $id_election = $this->getParameter('id_election');

        //     \Tracy\Debugger::enable();
        // \Tracy\Debugger::barDump($form['1']->isFilled());

        // Editing existing election
        if ($id_election) {
            $election = $this->database->table('members_elections')->get($id_election);
            $election->update(array(
                'name' => $values['name'],
                'from' => \Nette\Utils\DateTime::createFromFormat('d.m.Y H:i', $values['from']),
                'to' => \Nette\Utils\DateTime::createFromFormat('d.m.Y H:i', $values['to']),
                'nominations_visible' => $values['nominations_visible']
            ));

            $election->related('members_nomination_pos.id_election')->delete();

            foreach ($values as $i => $value) {
                if (is_numeric($i) && $value != False) {

                    $row = $this->database->table('members_nomination_pos')->insert(array(
                        'id_election' => $id_election,
                        'id_board_pos' => $i,
                        )) ;
                }
            }
            $this->flashMessage("Nominace do voleb byly úspěšně upraveny.", 'success');
            $this->redirect('Nominations:admin');
        } else {
            $row = $this->database->table('members_elections')->insert(array(
                'name' => $values['name'],
                'from' => \Nette\Utils\DateTime::createFromFormat('d.m.Y H:i', $values['from']),
                'to' => \Nette\Utils\DateTime::createFromFormat('d.m.Y H:i', $values['to']),
                'nominations_visible' => $values['nominations_visible']
                ));

            $id_election = $row->id_election;
            foreach ($values as $i => $value) {
                if (is_numeric($i) && $value != NULL) {
                    $this->database->table('members_nomination_pos')->insert(array(
                        'id_election' => $id_election,
                        'id_board_pos' => $i,
                        ));
                }
            }
            $this->flashMessage("Nominace do voleb byly úspěšně vypsány.", 'success');
            $this->redirect('Nominations:admin');
        }
    }
}
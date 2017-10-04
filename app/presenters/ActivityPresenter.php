<?php

namespace App\Presenters;

use Nette,
    App\Model,
    Nette\Application\UI\Form;

/**
 * Admin section
 */
class ActivityPresenter extends BaseSecuredPresenter {

    /** @var Nette\Database\Context */
    private $database;

    /** @var ImageStorage */
    private $imageStorage;

    private $db_members;
    private $activities;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();

        \Nella\Forms\DateTime\DateInput::register();
        $this->database = $database;

        $this->db_members = $this->database->table('members_member')
                    ->where("id_rank.active", 1)
                    ->select('id_member, members_member.name, members_member.surname')
                    ->order('name ASC');
        
        $db_activities = $this->database->table('members_activities')->select('id_activity, name, points, description')
        ->order('name');
        
        $this->activities = array();

        foreach ($db_activities as $id => $row) {
            $this->activities[$id] = $row['name'] . " (" . $row['points'] . " b.)";
        }
    }

    public function renderNew() {
        $this->template->members = $this->database->table('members_member');
        $this->template->points = $this->database->table('members_points');
    }

    public function renderBatch() {
        $user = $this->getUser()->getId();

        if($this->getUser()->getRoles()[0] == "admin")
            $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5 AND id_rank > 1");
        else
            $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5 AND id_rank > 1 AND id_member != $user");

        $this->template->points = $this->database->table('members_points');
    }

    public function renderDefault() {
        $this->template->members = $this->database->table('members_member');
        $this->template->points = $this->database->table('members_points')->where('NOT approved', false)->order('id_points DESC');


        $filterId = isset($_GET['id_member']) ? $_GET['id_member'] : null;
        if($filterId) {
            $this->template->members = $this->template->members->where("id_member", $filterId);
            $this->template->points = $this->template->points->where("id_member", $filterId);
        }
        $filterMonth = isset($_GET['month']) ? $_GET['month'] : null;
        if($filterMonth) {
            $this->template->points = $this->template->points->where("datetime LIKE ?", str_replace('/','-',$filterMonth).'%');
        }
        
        $this->template->db_members = $this->db_members;
    }
	
	public function renderApprovals() {
        $this->template->members = $this->database->table('members_member');
        $this->template->points = $this->database->table('members_points')->where('approved', false)->order('id_points DESC');


        $filterId = isset($_GET['id_member']) ? $_GET['id_member'] : null;
        if($filterId) {
            $this->template->members = $this->template->members->where("id_member", $filterId);
            $this->template->points = $this->template->points->where("id_member", $filterId);
        }
        $filterMonth = isset($_GET['month']) ? $_GET['month'] : null;
        if($filterMonth) {
            $this->template->points = $this->template->points->where("datetime LIKE ?", str_replace('/','-',$filterMonth).'%');
        }
        
        $this->template->db_members = $this->db_members;
    }

    public function beforeRender() {
        $this->template->addFilter('getimage', function ($member) {
            return $this->imageStorage->getProfileImage($member);
        });
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


    protected function createComponentPointsFormBatch()
    {
        $user = $this->getUser();
        
        if (!($user->isInRole('admin'))) {
            return;
        }

        $members = array();

        $form = new Form;

        foreach ($this->db_members as $id => $row) {
            $form->addCheckbox($id);
        }


        $form->addSelect('id_activity', 'Aktivita*', $this->activities);
        $form->addText('name', 'Název');
        $form->addTextArea('description', 'Popis');

        $form->addText('points', 'Počet mrkví')->setType('number');

        $form->addDate('datetime', 'Datum*', 'Y-m-d')
              ->setDefaultValue(\Nette\Utils\DateTime::createFromFormat('Y-m-d', date("Y-m-d")));


        $form->addSubmit('submit', 'Zapsat');
        $form->onSuccess[] = array($this, 'pointsFormBatchSucceeded');

        $this->makeFormLookGood($form);
        
        return $form;
    }

    protected function createComponentPointsForm()
    {
        $user = $this->getUser();
        $members = array();


        $form = new Form;

        $form->addSelect('id_activity', 'Aktivita*', $this->activities);
        $form->addText('name', 'Název');
        $form->addTextArea('description', 'Popis');

        $form->addText('points', 'Počet mrkví')->setType('number');

        $form->addDate('datetime', 'Datum*', 'Y-m-d')
              ->setDefaultValue(\Nette\Utils\DateTime::createFromFormat('Y-m-d', date("Y-m-d")));

        $form->addSubmit('submit', 'Přidat');
        $form->onSuccess[] = array($this, 'pointsFormSucceeded');

        $this->makeFormLookGood($form);

        return $form;
    }

    public function makeStringsNull($values) {
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }
    }

    public function pointsFormSucceeded($form, $values)
    {   
        $values[$this->user->getIdentity()->getId()] = TRUE;
        $this->pointsFormBatchSucceeded($form, $values);
    }

    public function pointsFormBatchSucceeded($form, $values)
    {   
        $user = $this->getUser();
        $this->makeStringsNull($values);

        $last_row = $this->database->table('members_points')->order('id_batch DESC')->fetch();

        if ($last_row == FALSE) {
            $id_batch = 1;
        } else {
            $id_batch = $last_row->id_batch + 1;
        }
		

        foreach ($values as $i => $value) {
            if (is_numeric($i) && $value != NULL) {
                $points = $this->database->table('members_points')->insert(array(
                    'id_member' => $i,
                    'id_batch' => $id_batch,
                    'id_activity' => $values['id_activity'],
                    'points' => $values['points'],
                    'name' => $values['name'],
                    'description' => $values['description'],
                    'datetime' => $values['datetime'],
					'approved' => 0
                    ));
            }

        }
		if($user->isInRole('admin')){
            $this->flashMessage("Aktivita byla úspěšně zapsána.", 'success');
		}else{
			$this->flashMessage("Žádost o mrkvičky odeslána ke schválení. Keep it up!");
		}
        $this->redirect('Activity:default');
    }

    public function handleDelete($id) {
        $this->database->table('members_points')->get($id)->delete();
        $this->flashMessage('Aktivita smazána.');
        $this->redirect('Activity:');
        // $this->redirect('Homepage:');
    }

    public function handleApprove($id) {
        $this->database->table('members_points')->get($id)->update(array('approved' => 1));
        $this->flashMessage('Aktivita schválena.');
        $this->redirect('Activity:approvals');
        // $this->redirect('Homepage:');
    }
	
}
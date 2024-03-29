<?php

namespace App\Presenters;

use Nette,
    Nette\Utils\Image,
    App\Model,
    Nette\Application\UI\Form;

/**
 * Profile of a member
 */
class ProfilePresenter extends BaseSecuredPresenter {
    /** @var Nette\Database\Context */
    private $database;

    /** 
    * @inject
    * @var \App\Model\UsersModel */
    public $usersModel;

    /** 
    * @inject
    * @var \App\Model\ImageStorage */
    public $imageStorage;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderShow($id_member){
    $this->template->members = $this->database->table('members_member');
    $this->template->member = $this->database->table('members_member')->get($id_member);
    $this->template->hr = $this->database->table('members_board_pos')->where(array("id_member" => $this->getUser()->getId(), "id_board_pos" => 3))->fetch();
    $this->template->rank = $this->database->table('members_rank');
    $this->template->carrot32 = $this->imageStorage->getCarrot(32);
}

    public function beforeRender() {
        $this->template->addFilter('getimage', function ($member) {
            return $this->imageStorage->getProfileImage($member);
        });
    }

    /**
     * Form - edit member
     */
    protected function createComponentPostForm()
    {
        $user = $this->getUser();
        $id_member = $this->getParameter('id_member');
        
        // Admin can edit all members, member only himself/herself
        if (!($user->isInRole('admin')  || $user->id == $id_member)) {
            return;
        }
        $sex = array(
            'M' => 'muž',
            'F' => 'žena',
        );

        $wgs  = array(
            '' => '-', 
            'PR' => 'PR', 
            'CR' => 'CR', 
            'HR' => 'HR'
        );

        $role = array(
            'member' => 'member',
            'admin' => 'admin',
            'guest' => 'guest'
        );

        $faculties = array(
         '' => '-',
         'FIT' => "FIT",
         'FEL' => "FEL",
         'FA' => "FA",
         'FSv'=> "FSv",
         'FS' => "FS",
         'FD' => "FD",
         'MÚVS' => "MÚVS",
         'FJFI' => "FJFI",
         'FBMI' => "FBMI",
         'VŠCHT' => "VŠCHT",
         'UK' => "UK",
         'Pardubice' => "Pardubice"
        );

        $form = new Form;

        $form->addGroup('Základní informace');
        $form->addText('name', 'Jméno*')
            ->setRequired('Děláš si prdel? To nevíš ani jméno?');
        $form->addText('surname', 'Příjmení*')
            ->setRequired('Zadej i příjmení, jinak budeme mít problém udělat tomuhle člověku vizitku.');
        $form->addText('email', 'Email*');

        $angels = array();

        $db_angels = $this->database->table('members_member')->select('id_member, name, surname')->order('name ASC');
        $angels[''] = '-';

        foreach ($db_angels as $id => $row) {
            $angels[$id] = $row['name'] . " " . $row['surname'];
        }

        $rank = array();
        $db_rank = $this->database->table('members_rank')->select('id_rank, name');

        foreach ($db_rank as $id => $row) {
            $rank[$id] = $row['name'];
        }

        $form->addRadioList('gender', 'Pohlaví*', $sex)->setRequired('Hermafrodity neberem.');

        \Nella\Forms\DateTime\DateInput::register();
        $form->addDate('joined', 'V BESTu od', 'Y-m')->setDefaultValue(\Nette\Utils\DateTime::createFromFormat('Y-m', date("Y-m")));

        if ($user->isInRole('admin')) {
            $form->addGroup('Členství');

            $form->addSelect('id_rank', 'Pozice*', $rank);
            $form->addSelect('role', 'Role v DB*', $role)->setOption('description', '"guest" má přístup přes svůj účet i jako alumni a inactive');
        }


        $form->addGroup('Další');

        $form->addSelect('id_angel', 'Angel', $angels);
        $form->addSelect('wg', 'WG', $wgs);

        $form->addText('telephone', 'Telefon')->addFilter(function ($value) {
            $value = str_replace(' ', '', $value);
            if (strlen($value) == 9) {
                $value= "+420" . $value;
            }
            return $value;
        });
        $form->addText('nickname', 'Přezdívka');
        $form->addText('tshirt', 'Tričko');

        $form->addSelect("faculty", "Fakulta", $faculties);

        $form->addTextArea('fb', 'Facebook')->addCondition($form::FILLED)->addRule(Form::URL);
        $form->AddText("trello_username", "Username v Trellu");

        if ($id_member) { // user already exists
             $form->addUpload('image', 'Fotka')->setOption('description', 'nejlépe ve čtvercovém formátu ;)')
            ->setRequired(FALSE)
            ->addCondition(Form::FILLED)->addRule(Form::IMAGE, 'Obrázek musí být JPEG, PNG nebo GIF.')
            ->addRule(Form::MAX_FILE_SIZE, 'Maximální velikost souboru je 128 kB.', 128 * 1024);
        }

        $form->addSubmit('submit', 'Přidat');
        $form->onSuccess[] = array($this, 'postFormSucceeded');

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

        return $form;
    }

    public function postFormSucceeded($form, $values)
    {   
        // Substitute empty values with NULL
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }

        $id_member = $this->getParameter('id_member');


        // Editing existing member
        if ($id_member) {
            $member = $this->database->table('members_member')->get($id_member);

            $profileImage = $values['image'];

            if ($profileImage->isImage() and $profileImage->isOk()) {
                $file_ext=strtolower(mb_substr($profileImage->getSanitizedName(), strrpos($profileImage->getSanitizedName(), ".")));
                $file_name = $id_member . $file_ext;
                $profileImage->move($this->imageStorage->www_dir . '/' . $file_name);
                $values['image'] = $file_name;
            } else {
                $values['image'] = $member->image;
            }

            $member->update($values);
            $this->flashMessage("Údaje byly upraveny.", 'success');
            $this->redirect('Profile:show', $id_member);
        // Adding new member
        } else {
            $new_member = $this->database->table('members_member')->insert($values);
            $this->flashMessage("Nový člen byl úspěšně přidán.", 'success');
            $this->redirect('Profile:show', $new_member->id_member);
        }
    }

    public function actionEdit($id_member)
    {   
        $member = $this->database->table('members_member')->get($id_member);
        if (!$member) {
            $this->error('Člen nenalezen');
        }
        $user = $this->getUser();
        if ($user->isInRole('admin') || $user->id == $id_member) {
            $this['postForm']['submit']->caption = 'Uložit';
            $memberArr = $member->toArray();
            unset($memberArr["wg"]);
            // dump($memberArr);
            $this['postForm']->setDefaults($memberArr);
        }
    }

    public function handleDelete($id_member)
    {
        $user = $this->getUser();
        if ($user->isInRole('admin')) {
            $this->database->table('members_member')->get($id_member)->delete();
            $this->flashMessage('Člen smazán.');
            $this->redirect('Homepage:');
        }
    }

    public function renderHr($id_member) {
        $this->template->id_member = $id_member;
        $this->template->userDisplayed = $this->database->table("members_member")->where(array("id_member" => $id_member))->fetch();
        $this->template->records = $this->database->table("members_121")->where(array("id_member" => $id_member))->order("created")->fetchAll();
    }

    public function createComponentOne2OneForm() {
        $form = new Form();

        $form->addTextArea("note");
        $form->addHidden("id_member");
        $form->addSubmit("submit");
        $form->onSuccess[] = array($this, "one2OneFormSubmitted");

        return $form;
    }

    public function one2OneFormSubmitted($form) {
        $note = $form->getValues()->note;
        $id_member = $form->getValues()->id_member;

        $this->database->table("members_121")->insert(array("id_member" => $id_member, "created" => new Nette\Utils\DateTime("now"), "note" => ($note)));
        $this->redirect("Profile:hr", $id_member);
    }
}
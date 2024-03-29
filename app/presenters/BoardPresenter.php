<?php

namespace App\Presenters;

use Nette,
    App\Model,
    Nette\Application\UI\Form;

/**
 * Board section
 */
class BoardPresenter extends BaseSecuredPresenter
{
    /** @var Nette\Database\Context */
    private $database;

    /** 
    * @inject
    * @var \App\Model\ImageStorage */
    public $imageStorage;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

     public function beforeRender() {
        $this->template->addFilter('getimage', function ($id_member) {
            $member = $this->database->table('members_member')->get($id_member);
            return $this->imageStorage->getProfileImage($member);
        });
    }

    public function renderDefault()
    {
        $this->template->members = $this->database->table('members_member')
            ->order('name ASC');

        $board_pos = $this->database->table('members_board_pos');

        $this->template->board = array();

        foreach ($board_pos as $id => $row) {
            $this->template->board[$row->name]  = $row->id_member;
        }
    }

    /**
     * Form - edit board positions
     */
    protected function createComponentPostForm()
    {
        $user = $this->getUser();
        if (!$user->isInRole('admin')) {
            return;
        }
        $form = new Form;

        $members = array();

        $db_members = $this->database->table('members_member')->select('id_member, name, surname')->order('name ASC');

        // Empty position option
        $members[''] = '-';

        foreach ($db_members as $id => $row) {
            $members[$id] = $row['name'] . " " . $row['surname'];
        }

        $board_pos = $this->database->table('members_board_pos');

        foreach ($board_pos as $id => $row) {
            $form->addSelect($id, $row->name, $members);
        }

        $form->addSubmit('submit', 'Uložit');
        $form->onSuccess[] = array($this, 'postFormSucceeded');

        // All of this is only additional code that makes Nette form look good in Bootstrap
        // setup form rendering
        $renderer = $form->getRenderer();
        $renderer->wrappers['controls']['container'] = NULL;
        $renderer->wrappers['pair']['container'] = 'div class=form-group';
        $renderer->wrappers['pair']['.error'] = 'has-error';
        $renderer->wrappers['control']['container'] = 'div class=col-sm-4';
        $renderer->wrappers['label']['container'] = 'div class="col-sm-5 control-label"';
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

    /**
     * Save board positions
     */
    public function postFormSucceeded($form, $values)
    {
        // Substitute empty values with NULL
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }

        foreach ($values as $id_pos => $id_member) {
            $pos = $this->database->table('members_board_pos')->get($id_pos);
            $pos->update(array('id_member' => $id_member));
        }
        $this->flashMessage("Boardí pozice byly úspěšně upraveny. Hodně štěstí novým boardies!", 'info');
    }

    /**
     * Edit board positions
     */
    public function actionEdit()
    {   
        $members = $this->database->table('members_member')
            ->order('active DESC')->order('name ASC');

        $board_pos = $this->database->table('members_board_pos');

        $board = array();

        foreach ($board_pos as $id => $row) {
            $board[$id]  = $row->id_member;
        }

        $this['postForm']->setDefaults($board);
    }
}
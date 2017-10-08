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

    public function __construct(Nette\Database\Context $database) {
        parent::__construct();

        \Nella\Forms\DateTime\DateInput::register();
        $this->database = $database;

        $this->db_members = $this->database->table('members_member')
                    ->where("id_rank.active", 1)
                    ->select('id_member, members_member.name, members_member.surname')
                    ->order('name ASC');
        
        $db_activities = $this->database->table('members_activities')->select('id_activity, name, points, description')->order('name');
        
        $this->activities = array();

        foreach ($db_activities as $id => $row) {
            $this->activities[$id] = $row['name'] . " (" . $row['points'] . " b.)";
        }
    }

    public function renderNew() {
        $this->template->members = $this->database->table('members_member');
        $this->template->points = $this->database->table('members_points');
    }

    public function makeStringsNull($values) {
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }
    }

    public function renderBatch() {
        $user = $this->getUser()->getId();

        if($this->getUser()->getRoles()[0] == "admin")
            $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5 AND id_rank > 1");
        else
            $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5 AND id_rank > 1 AND id_member != $user");

        $this->template->points = $this->database->table('members_points');
    }

    public function renderList() {
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

    /*
     * The list of user's carrots per this month, last month and last half-year
     */
    public function renderDefault() {
        $user = $this->getUser()->getId();

        $currentMonthBegin = new Nette\Utils\DateTime("first day of this month midnight");
        $currentMonthEnd = new Nette\Utils\DateTime("first day of next month midnight");
        $previousMonthBegin = new Nette\Utils\DateTime("first day of last month midnight");

        if($currentMonthBegin->format("m") > 6) //from july to december
            $halfYearBegin = new Nette\Utils\DateTime("first day of this year July midnight");
        else //from january to july
            $halfYearBegin = new Nette\Utils\DateTime("first day of this year January midnight");

        $halfYearEnd = $halfYearBegin->modifyClone("+6 month");

        $this->template->pointsThisMonth = $this->database->table('members_points')->where("approved = 1 AND id_member = $user AND datetime > '$currentMonthBegin' AND datetime < '$currentMonthEnd'")->sum("points");
        $this->template->pointsLastMonth = $this->database->table('members_points')->where("approved = 1 AND id_member = $user AND datetime > '$previousMonthBegin' AND datetime < '$currentMonthBegin'")->sum("points");
        $this->template->pointsHalfYear = $this->database->table('members_points')->where("approved = 1 AND id_member = $user AND datetime > '$halfYearBegin' AND datetime < '$halfYearEnd'")->sum("points");
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

    protected function createComponentPointsFormBatch()
    {
        $form = new Form;

        foreach ($this->db_members as $id => $row) {
            $form->addCheckbox($id);
        }

        $form->addSelect('id_activity', 'Aktivita', $this->activities);
        $form->addText('name', 'Název');
        $form->addTextArea('description', 'Popis');

        $form->addText('points', 'Počet mrkví')->setType('number');

        $form->addDate('datetime', 'Datum*', 'Y-m-d')->setDefaultValue(\Nette\Utils\DateTime::createFromFormat('Y-m-d', date("Y-m-d")));

        $form->addSubmit('submit', 'Zapsat');
        $form->onSuccess[] = array($this, 'pointsFormBatchSucceeded');
        
        return $form;
    }

    public function pointsFormBatchSucceeded($form, $values)
    {
        $this->makeStringsNull($values);

        if(!$values['points'])
            $points = $this->database->table('members_activities')->where("id_activity", $values['id_activity'])->fetch();
        else
            $points = $values['points'];

        foreach ($values as $i => $value) {
            if (is_numeric($i) && $value != NULL) {
                $this->database->table('members_points')->insert(array(
                    'id_member' => $i,
                    'id_activity' => $values['id_activity'],
                    'points' => $points,
                    'name' => $values['name'],
                    'description' => $values['description'],
                    'datetime' => $values['datetime'],
					'id_author' => $this->getUser()->getId(),
					'approved' => 0
                    ));
            }
        }

        $this->flashMessage("Díky za návrh na mrkvičky! HRoyt na to koukne :-)", 'success');
        $this->redirect('Activity:default');
    }

    public function handleDelete($id) {
        $this->database->table('members_points')->get($id)->delete();
        $this->flashMessage('Aktivita smazána.');
        $this->redirect('Activity:approvals');
    }

    public function handleApprove($id) {
        $this->database->table('members_points')->get($id)->update(array('approved' => 1));
        $this->flashMessage('Aktivita schválena.');
        $this->redirect('Activity:approvals');
    }
}
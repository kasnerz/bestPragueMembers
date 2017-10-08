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

    public function __construct(Nette\Database\Context $database) {
        parent::__construct();

        \Nella\Forms\DateTime\DateInput::register();
        $this->database = $database;

        $this->db_members = $this->database->table('members_member')
                    ->where("id_rank.active", 1)
                    ->select('id_member, members_member.name, members_member.surname')
                    ->order('name ASC');
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
        $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5 AND id_rank > 1");
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

    protected function createComponentPointsFormBatch() {
        $form = new Form;

        foreach ($this->db_members as $id => $row) {
            $form->addCheckbox($id);
        }

        $db_activities = $this->database->table('members_activities')->where("active", 1)->select('id_activity, name, points, description')->order('name');

        foreach ($db_activities as $id => $row) {
            $activities[$id] = $row['name'] . " (" . $row['points'] . " b.)";
        }

        $form->addSelect('id_activity', 'Aktivita', $activities);
        $form->addText('name', 'Název');
        $form->addTextArea('description', 'Popis');
        $form->addText('points', 'Počet mrkví')->setType('number');
        $form->addDate('datetime', 'Datum*', 'Y-m-d')->setDefaultValue(\Nette\Utils\DateTime::createFromFormat('Y-m-d', date("Y-m-d")));
        $form->addCheckbox("method")->setAttribute("data-toggle", "toggle")->setAttribute("data-on", "Vlastní")->setAttribute("data-off", "Zadat aktivitou");

        $form->addSubmit('submit', 'Zapsat');
        $form->onSuccess[] = array($this, 'pointsFormBatchSucceeded');
        
        return $form;
    }

    public function pointsFormBatchSucceeded($form, $values)
    {
        $this->makeStringsNull($values);

        if(!$values->method) {
            $activity = $values['id_activity'];
            $points = NULL;
        } else {
            $activity = NULL;
            $points = $values->points;
        }

        foreach ($values as $i => $value) {
            if (is_numeric($i) && $value != NULL) {
                $this->database->table('members_points')->insert(array(
                    'id_member' => $i,
                    'id_activity' => $activity,
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

    public function renderChange() {
        $this->template->activities = $this->database->table("members_activities")->where("active", 1)->order("points")->fetchAll();
        $this->template->activitiesOff = $this->database->table("members_activities")->where("active", 0)->order("points")->fetchAll();

    }

    public function renderEditActivity($idActivity) {
        $activity = $this->database->table("members_activities")->where("id_activity", $idActivity)->fetch();

        $this["editActivityForm"]->setDefaults(array("name" => $activity->name, "points" => $activity->points, "idActivity" => $activity->id_activity, "active" => $activity->active));
    }

    public function createComponentEditActivityForm() {
        $form = new Form();

        $form->addText("name");
        $form->addText("points");
        $form->addCheckbox("active");
        $form->addHidden("idActivity");
        $form->addSubmit("submit", "Uložit");

        $form->onSuccess[] = array($this, "editActivityFormSubmitted");

        return $form;
    }

    public function editActivityFormSubmitted(Form $form)  {
        $val = $form->getValues();

        $this->database->table("members_activities")->where("id_activity", $val->idActivity)->update(array("name" => $val->name, "points" => $val->points, "active" => $val->active));

        $this->flashMessage("Aktivita byla upravena");
        $this->redirect("Activity:change");
    }

    public function createComponentNewActivityForm() {
       $form = new Form();

       $form->addText("name")->setAttribute("placeholder", "název aktivity");
       $form->addText("points")->setAttribute("placeholder", "počet mrkví");
       $form->addSubmit("submit", "Přidat");

       $form->onSuccess[] = array($this, "newActivityFormSubmitted");

       return $form;
    }

    public function newActivityFormSubmitted(Form $form) {
        $val = $form->getValues();

        $this->database->table("members_activities")->insert(array("name" => $val->name, "points" => $val->points));

        $this->redirect("Activity:change");
        $this->flashMessage("Aktivita přidána!");
    }
}

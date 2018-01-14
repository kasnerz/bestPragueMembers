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

    /** 
    * @inject
    * @var \App\Model\ImageStorage */
    public $imageStorage;

    /** 
    * @inject
    * @var \App\Model\UsersModel */
    public $usersModel;


    private $db_members;



    public function __construct(Nette\Database\Context $database) {
        parent::__construct();

        \Nella\Forms\DateTime\DateInput::register();
        $this->database = $database;

        $this->db_members = $this->database->table('members_member')
                    ->select('id_member, members_member.name, members_member.surname')
                    ->where("id_rank < 5");
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
        $this->template->db_members = $this->database->table('members_member')->where("id_rank < 5");
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

        $this->template->members = $this->database->table('members_member');
        $this->template->points = $this->database->table('members_points')->where('NOT approved', false)->order('id_points DESC');
        $this->template->db_members = $this->db_members;


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



        $join_stats = [
            'all' => [
                'rank' => $this->usersModel->getJoinedStats('members_rank.name'),
                'gender' => $this->usersModel->getJoinedStats('members_member.gender'),
                'wg' => $this->usersModel->getJoinedStats('members_member.wg')
            ],
            'active' => [
                'rank' => $this->usersModel->getJoinedStats('members_rank.name', true),
                'gender' => $this->usersModel->getJoinedStats('members_member.gender', true),
                'wg' => $this->usersModel->getJoinedStats('members_member.wg', true)
            ]
        ];
        $this->template->join_stats = Nette\Utils\Json::encode($join_stats);
        $angel_tree = $this->database->query('SELECT COALESCE(member.wg,"?") as member_wg, CONCAT(member.name, " ", member.surname) as member_name, 
            COALESCE(CONCAT(angel.name, " ", angel.surname),"The Archangel") as angel_name
            FROM members_member member
            LEFT JOIN members_member angel ON angel.id_member=member.id_angel')->fetchPairs('member_name');
                    $this->template->angel_tree = Nette\Utils\Json::encode($angel_tree);

        $this->template->points_activity = $this->database->query('SELECT members_member.id_member, members_member.name, members_member.surname, members_points.approved AS approved, SUM( COALESCE( members_points.points, members_activities.points ) ) AS sum
                                                            FROM members_points
                                                            JOIN members_activities USING (id_activity)
                                                            JOIN members_member USING (id_member)
                                                            WHERE approved = 1
                                                            GROUP BY id_member
                                                            ORDER BY sum DESC');


            $months = array(date('Y/m', strtotime("now")), date('Y/m', strtotime("-1 month")));
            $this->template->months = $months;
            $this->template->points_month = [];

            for($i=0; $i<2; $i++) {
                $month = $months[$i];

            $result = $this->database->query("SELECT members_member.id_member,members_member.name,surname,members_points.approved as approved,
                SUM(COALESCE(members_points.points,members_activities.points,0)) as total,
                DATE_FORMAT(members_points.datetime,'%Y/%m') as period FROM `members_points` 
                INNER JOIN `members_member` USING (id_member)
                LEFT JOIN `members_activities` USING (id_activity)
                WHERE approved = 1
                GROUP BY members_member.id_member,period
                HAVING period='$month'
                ORDER BY total DESC,members_member.joined DESC");

                        $this->template->points_month[$month] = $result;
                    }


                    $this->template->kings = [];
                    for($i=1;$i<12;$i++) {
                        $kingPeriod = date('Y/m', strtotime("-$i month"));
                        $result = $this->database->query("SELECT members_member.id_member,members_member.name,surname,members_points.approved as approved,
                SUM(COALESCE(members_points.points,members_activities.points,0)) as total,
                DATE_FORMAT(members_points.datetime,'%Y/%m') as period FROM `members_points` 
                INNER JOIN `members_member` USING (id_member)
                LEFT JOIN `members_activities` USING (id_activity)
                WHERE approved = 1
                GROUP BY members_member.id_member,period
                HAVING period='$kingPeriod'
                ORDER BY total DESC,members_member.joined DESC
                LIMIT 3");

                        if ($result->fetch()) {
                            $this->template->kings[$kingPeriod] = $result;
                        }
                    }
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
        $this->template->addFilter('getimage', function ($id_member) {
            $member = $this->database->table('members_member')->get($id_member);
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

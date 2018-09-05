<?php

namespace App\Presenters;

use Nette,
    App\Model;

/**
 * Statistics
 */
class StatsPresenter extends BaseSecuredPresenter
{
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

    public function beforeRender() {
        $this->template->addFilter('getimage', function ($id_member) {
            $member = $this->database->table('members_member')->get($id_member);
            return $this->imageStorage->getProfileImage($member);
        });
    }

    public function renderDefault()
    {
        $this->template->ranks = $this->usersModel->getRanks();
        $this->template->ranks_json = Nette\Utils\Json::encode($this->usersModel->getActiveRanks());
        $this->template->faculties = $this->usersModel->getFacultiesWithGender();
        $this->template->wgs = $this->usersModel->getActiveWgs();
        $this->template->ages = $this->usersModel->getActiveAges();
        $this->template->config = $this->getConfig();

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

        $this->template->points = $this->database->query('SELECT members_member.id_member, members_member.name, members_member.surname, members_points.approved AS approved, SUM( COALESCE( members_points.points, members_activities.points ) ) AS sum
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

    public function getConfig() {
        return file_get_contents(__DIR__ ."/../config/config.local.neon");
    }
}
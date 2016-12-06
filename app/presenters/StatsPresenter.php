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
        $this->template->ranks_json = Nette\Utils\Json::encode($this->template->ranks);

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

        $this->template->points = $this->database->query('SELECT members_member.id_member, members_member.name, members_member.surname, SUM( COALESCE( members_points.points, members_activities.points ) ) AS sum
                                                            FROM members_points
                                                            JOIN members_activities USING (id_activity)
                                                            JOIN members_member USING (id_member)
                                                            GROUP BY id_member
                                                            ORDER BY sum DESC');

<<<<<<< HEAD
        $this->template->kings = [];
        for($i=0;$i<12;$i++) {
            $kingPeriod = date('Y/n', strtotime("-$i month"));
            $this->template->kings[$kingPeriod] = $this->database->query("SELECT members_member.id_member,members_member.name,surname,
    SUM(COALESCE(members_points.points,members_activities.points,0)) as total,
    CONCAT(YEAR(members_points.datetime),'/',MONTH(members_points.datetime)) as period FROM `members_points` 
    INNER JOIN `members_member` USING (id_member)
    LEFT JOIN `members_activities` USING (id_activity)
    GROUP BY members_member.id_member,period
    HAVING period='$kingPeriod'
    ORDER BY total DESC
    LIMIT 3");
        }
        //print_r($this->template->kings);

=======
>>>>>>> 3247b7cc26fff79c58c5c53b822dd08c257c4453
    }
}
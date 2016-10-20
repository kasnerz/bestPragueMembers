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

        $this->template->new_member_counts = $this->database->query('SELECT members_member.joined as name, COUNT(members_member.id_member) as y FROM members_member GROUP BY (name) ORDER BY name ');
        $this->template->new_member_counts_json = Nette\Utils\Json::encode($this->template->new_member_counts);

        $this->template->points = $this->database->query('SELECT members_member.id_member, members_member.name, members_member.surname, SUM( COALESCE( members_points.points, members_activities.points ) ) AS sum
                                                            FROM members_points
                                                            JOIN members_activities USING (id_activity)
                                                            JOIN members_member USING (id_member)
                                                            GROUP BY id_member
                                                            ORDER BY sum DESC');

    }
}
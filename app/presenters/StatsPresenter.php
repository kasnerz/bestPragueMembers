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
    * @var \App\Model\StatsModel */
    public $statsModel;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderDefault()
    {
        // $this->template->members = $this->database->table('members_member')
        //     ->order('active DESC')->order('name ASC');

        // $board_pos = $this->database->table('members_board_pos');

        // $this->template->board = array();

        // foreach ($board_pos as $id => $row) {
        //     $this->template->board[$row->name]  = $row->id_member;
        // }

        // $ranks = $this->statsModel->getRanks();
        // $this->sendResponse(new Nette\Application\Responses\JsonResponse($ranks));
        
        $this->template->ranks = $this->statsModel->getRanks();
        $this->template->ranks_json = Nette\Utils\Json::encode($this->statsModel->getRanks());
    }


    public function handleRanksJson() {
        // $ranks = $this->statsModel->getRanks();
        // $this->sendResponse(new Nette\Application\Responses\JsonResponse($ranks));
    }
}
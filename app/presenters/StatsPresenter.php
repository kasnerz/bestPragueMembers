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

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderDefault()
    {
        $this->template->members = $this->database->table('members_member')
            ->order('active DESC')->order('name ASC');

        $board_pos = $this->database->table('members_board_pos');

        $this->template->board = array();

        foreach ($board_pos as $id => $row) {
            $this->template->board[$row->name]  = $row->id_member;
        }
    }
}
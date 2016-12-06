<?php

namespace App\Presenters;

use Nette,
    App\Model;

/**
 * Admin section
 */
class AdminPresenter extends BaseSecuredPresenter {

    /** @var Nette\Database\Context */
    private $database;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderDefault(){
        $this->template->members = $this->database->table('members_member');
        $this->template->board = $this->database->table('members_board_pos');
        $this->template->points = $this->database->table('members_points');
    }
}
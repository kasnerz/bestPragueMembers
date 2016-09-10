<?php

namespace App\Presenters;

use Nette,
    App\Model;

/**
 * LBG list
 */
class HomepagePresenter extends BaseSecuredPresenter
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
        $this->template->members = $this->database->table('members_member')->order('name ASC');
    }
}
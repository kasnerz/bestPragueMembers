<?php

namespace App\Presenters;

use Nette,
    App\Model;

/**
 * Tools
 */
class ToolsPresenter extends BaseSecuredPresenter
{
    /** @var Nette\Database\Context */
    private $database;

    /** 
    * @inject
    * @var \App\Model\UsersModel */
    public $usersModel;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderDefault()
    {
        // $this->template->ranks = $this->statsModel->getRanks();
        // $this->template->ranks_json = Nette\Utils\Json::encode($this->statsModel->getRanks());
    }
}
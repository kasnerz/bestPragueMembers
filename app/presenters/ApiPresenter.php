<?php

namespace App\Presenters;

use Nette;
use Tracy\Dumper;

class ApiPresenter extends BasePresenter
{
    /** @var Nette\Database\Context */
    private $database;

    public function __construct()
    {
        parent::__construct();
    }

    public function injectDatabase(Nette\Database\Context $database)
    {
        $this->database = $database;
    }

    public function actionAddCarrots($data)
    {
        $this->database->table("members_points")->insert(
            array(
                "id_batch" => 3,
                "id_member" => 109,
                "points" => 999,
                "description" => $data
            )
        );

        return 200;
    }
}

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
        $dataInArray = explode("\n", $data);

        $cardFullName = $dataInArray[0];

        $trelloName = substr($cardFullName, 1);
        $trelloName = explode("]", $trelloName);

        $cardPoints = $trelloName[0];
        $cardName = $trelloName[1];

        $trelloUsername = substr($dataInArray[5], 10);

        $member = $this->database->table("members_member")->where("trello_username", $trelloUsername)->fetch();

        $this->database->table("members_points")->insert(
            array(
                "id_batch" => 3,
                "id_member" => $member->id_member,
                "points" => $cardPoints,
                "name" => $cardName,
                "description" => $cardName,
                "datetime" => new Nette\Utils\DateTime("now"),
                "approved" => 0
            )
        );

        return 200;
    }
}


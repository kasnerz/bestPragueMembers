<?php

namespace App\Model;

use Nette;
use Nette\Security as NS;

class StatsModel extends Nette\Object
{
    /** @var Nette\Database\Context */
    private $database;

    public function __construct(Nette\Database\Context $database)
    {
        $this->database = $database;
    }

    public function getRanks()
    {
        $response = array();

        $ranks = $this->database->table("members_rank")->fetchAll();

        // \Tracy\Debugger::enable();
        // \Tracy\Debugger::barDump($ranks);

        foreach ($ranks as $id => $row) {
            $count = $this->database->table("members_member")->where("id_rank", $id)->count("*");
            array_push($response, array("name" => $row->name, "y" => $count));
        }

        return $response;
    }

}
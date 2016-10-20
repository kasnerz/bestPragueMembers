<?php

namespace App\Model;

use Nette;
use Nette\Security as NS;

class UsersModel extends Nette\Object
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

        foreach ($ranks as $id => $row) {
            $count = $this->database->table("members_member")->where("id_rank", $id)->count("*");
            array_push($response, array("name" => $row->name, "y" => $count));
        }

        return $response;
    }
    public function getJoinedStats(){
        $counts_arr = [];
        $counts = $this->database->query('SELECT DATE_FORMAT(members_member.joined,"%Y-%m-01") as join_date, members_rank.name as rank, COUNT(members_member.id_member) as y, GROUP_CONCAT(CONCAT(members_member.name," ",members_member.surname) SEPARATOR ", ") as names FROM members_member
INNER JOIN members_rank ON members_rank.id_rank=members_member.id_rank
GROUP BY join_date, rank HAVING join_date IS NOT NULL ORDER BY join_date');
        foreach ($counts as $id => $row) {
            if(!isset($counts_arr[$row['join_date']]))
                $counts_arr[$row['join_date']] = [];
            $counts_arr[$row['join_date']][$row['rank']] = ['join_date'=>$row['join_date'],'y' => $row['y'],'names'=>$row['names']];
        }
        return $counts_arr;
    }

    public function getContacts()
    {
        $null = NULL;

        $contacts = $this->database->table("members_member")
                    ->where("id_rank.active", 1)
                    ->where("telephone NOT", $null)
                    ->select("members_member.name,members_member.surname,members_member.email,members_member.telephone")
                    ->order("name ASC");

        return $contacts;
    }
}
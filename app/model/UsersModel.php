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

     public function getActiveRanks()
    {
        $response = array();
        $ranks = $this->database->table("members_rank")->where("active", 1)->fetchAll();

        foreach ($ranks as $id => $row) {
            $count = $this->database->table("members_member")->where("id_rank", $id)->count("*");
            array_push($response, array("name" => $row->name, "y" => $count));
        }

        return $response;
    }

    public function getActiveWgs()
    {
        $response = array();
        $wgs_db = $this->database->table("members_member")->where("id_rank.active", 1)->select("wg")->group("wg")->fetchAll();

        foreach ($wgs_db as $id => $wg) {
            $count = $this->database->table("members_member")->where("id_rank.active", 1)->where("wg", $wg->wg)->count("*");
            array_push($response, array($wg->wg ?: "Nezařazení", $count));
        }
        return $response;
    }

    public function getActiveAges()
    {
        $dicks = array_fill(0, 17, 0);
        $boobs = array_fill(0, 17, 0);
        $active_members = $this->database->table("members_member")->where("id_rank.active", 1)->fetchAll();

        $now =  new Nette\Utils\DateTime("now");

        foreach ($active_members as $id => $member) {
            $diff = $member->joined->diff($now);
            $diff_months =  ($diff->y) * 12 + $diff->m;

            $idx = min((int) floor($diff_months / 3),17);

            if ($member->gender == "M") {
                $dicks[$idx]--;
            } else if ($member->gender == "F") {
                $boobs[$idx]++;
            }
        }

        $response = array("dicks" => $dicks, "boobs" => $boobs);
        return $response;
    }

    public function getFacultiesWithGender()
    {
        $faculties = array();
        $dicks = array();
        $boobs = array();
        $faculties_db = $this->database->table("members_member")->where("id_rank.active", 1)->select("faculty")->group("faculty")->fetchAll();

        foreach ($faculties_db as $id => $faculty) {
            array_push($faculties, $faculty->faculty);
            $count_dicks = $this->database->table("members_member")->where("id_rank.active", 1)->where("faculty", $faculty->faculty)->where("gender", "M")->count("*");
            $count_boobs = $this->database->table("members_member")->where("id_rank.active", 1)->where("faculty", $faculty->faculty)->where("gender", "F")->count("*");
            array_push($dicks, $count_dicks);
            array_push($boobs, $count_boobs);
        }
        $people = array(array("name" => "dicks", "data" => $dicks), array("name" => "boobs", "data" => $boobs));
        $response = array("faculties" => $faculties, "people" => $people);

        return $response;
    }

    public function getJoinedStats($group, $activeOnly=false){
        $counts_arr = [];
        $counts = $this->database->query('SELECT DATE_FORMAT(members_member.joined,"%Y-%m-01") as join_date, '.$group.'  as grp, COUNT(members_member.id_member) as y, GROUP_CONCAT(CONCAT(members_member.name," ",members_member.surname) SEPARATOR ", ") as names FROM members_member
INNER JOIN members_rank ON members_rank.id_rank=members_member.id_rank
 '.($activeOnly ? 'WHERE members_rank.active' : '').' 
GROUP BY join_date, grp HAVING join_date IS NOT NULL ORDER BY join_date');
        foreach ($counts as $id => $row) {
            if(!isset($counts_arr[$row['join_date']]))
                $counts_arr[$row['join_date']] = [];
            $counts_arr[$row['join_date']][$row['grp']] = ['join_date'=>$row['join_date'],'y' => $row['y'],'names'=>$row['names']];
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
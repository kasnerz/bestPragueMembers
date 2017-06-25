<?php

namespace App\Presenters;

use Nette,
    App\Model,
    Nette\Application\UI\Form,
    Nette\Application\Responses\FileResponse,
    Nette\Latte,
    Nette\Templating\Template;

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

    public function actionExportContacts($id) {
        $filename = __DIR__ . "/../../temp/best-prague-contacts.csv";
        $contacts = $this->usersModel->getContacts();

        $df = fopen("$filename", 'w');
        fputcsv($df, array("First Name", "Last Name", "E-mail Address", "Mobile Phone"));

        foreach ($contacts as $id => $row) {
            fputcsv($df, array_values($row->toArray()));
        }
        fclose($df);

        $this->sendResponse(new FileResponse($filename));
    }

    public function renderHr() {
        // variable round is the number of round, empty string when the system is off
        $this->template->round = "4";

        $userRound = $this->database->table('members_hr_survey')->where(array("id_member" => $this->getUser()->getId()))->max("round");

        if($this->template->round == $userRound) {
            $this->template->repeat = true;
        } else {
            $this->template->repeat = false;
        }
    }

    public function createComponentHrSurveyForm() {
        $form = new Form;

        $options = [
            1 => 1,
            2 => 2,
            3 => 3
        ];

        $form->addRadioList("one", NULL, $options);
        $form->addRadioList("two", NULL, $options);
        $form->addRadioList("three", NULL, $options);
        $form->addRadioList("four", NULL, $options);
        $form->addRadioList("five", NULL, $options);
        $form->addRadioList("six", NULL, $options);
        $form->addRadioList("seven", NULL, $options);
        $form->addRadioList("eight", NULL, $options);
        $form->addRadioList("nine", NULL, $options);

        $form->addHidden("round");

        $form->addSubmit('submit', 'Odpálit to');

        $form->onSuccess[] = array($this, 'hrSurveyFormSucceeded');

        return $form;
    }

    public function hrSurveyFormSucceeded($form, $values) {
        $values = $form->getValues();

        foreach($values as $value) {
            if($value == NULL) {
                $this->flashMessage("Bylo by lepší to zaškrtat všechno, to dáš! :-)", "error");
                return;
            }
        }

        $this->database->table('members_hr_survey')->insert(array(
            'id_member' => $this->getUser()->getId(),
            'created' => new Nette\Utils\DateTime("now"),
            "round" => $values->round,
            "one" => $values->one,
            "two" => $values->two,
            "three" => $values->three,
            "four" => $values->four,
            "five" => $values->five,
            "six" => $values->six,
            "seven" => $values->seven,
            "eight" => $values->eight,
            "nine" => $values->nine

        ));

        $this->database->table('members_points')->insert(array(
            'id_member' => $this->getUser()->getId(),
            'id_batch' => $this->database->table('members_points')->max("id_batch"),
            'id_activity' => 35,
            'points' => 10,
            'name' => "Vyplnění HR dotazníku",
            'description' => "",
            'datetime' => new Nette\Utils\DateTime("now"),
            'approved' => 1
        ));

        $this->flashMessage("Koytas ti děkuje. Budou z toho krásný data :-) No a aby to bylo fér, dám ti za to 10 mrkví, juhůůů!");
        $this->redirect("Homepage:default");

    }

}
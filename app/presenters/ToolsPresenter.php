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
}
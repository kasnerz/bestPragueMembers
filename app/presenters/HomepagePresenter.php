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

    /** @var ImageStorage */
    private $imageStorage;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function injectImages(\App\Model\ImageStorage $storage)
    {
        $this->imageStorage = $storage;
    }


    public function beforeRender()
    {
        $this->template->addFilter('getimage', function ($member) {
            return $this->imageStorage->getProfileImage($member);
        });
    }

    public function renderDefault()
    {
        $this->template->members = $this->database->table('members_member')->order('name ASC');

        

    }
}
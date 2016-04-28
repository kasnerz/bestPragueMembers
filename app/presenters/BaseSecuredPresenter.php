<?php

namespace App\Presenters;

use Nette;
use App\Model;

/**
 * Base presenter for all application presenters that are accessible only by BEST Prague members (all except Sign-in)
 */
abstract class BaseSecuredPresenter extends BasePresenter
{
    public function __construct()
    {
        parent::__construct();
    }

    public function startup() {
        parent::startup();

        // Always redirect to sign-in screen
        if (!$this->user->isLoggedIn()) {
            $this->redirect('Sign:in');
        }
    }

    public function beforeRender()
    {
        parent::beforeRender();
    }
}

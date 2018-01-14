<?php

namespace App\Presenters;

use Nette;
use App\Model;

/**
 * Unsecured Base presenter that serves ONLY for presenters accessible by public.
 */
abstract class BasePresenter extends Nette\Application\UI\Presenter
{
    
    /** 
    * @inject
    * @var \Kdyby\Google\Google */
    public $google;

    /** 
    * @inject
    * @var \App\Model\AuthorizationModel */
    public $authorizationModel;


    public function __construct()
    {
    }

    public function startup() {
        parent::startup();
    }

    public function beforeRender()
    {
        parent::beforeRender();
    }

    // Google Authentization
    /** @return \Kdyby\Google\Dialog\LoginDialog */
    protected function createComponentGoogleLogin()
    {
        $dialog = new \Kdyby\Google\Dialog\LoginDialog($this->google);
        $dialog->onResponse[] = function (\Kdyby\Google\Dialog\LoginDialog $dialog) {
            $google = $dialog->getGoogle();

            if (!$google->getUser()) {
                $this->flashMessage("Autentikace Google účtem se nezdařila. Pokud chceš opravdu nutně dovnitř, napiš na it@bestprague.cz.");
                return;
            } 
            /**
             * If we get here, it means that the user was recognized
             * and we can call the Google API
             */
            try {
               
                $me = $google->getProfile();

                \Tracy\Debugger::enable();

                try {
                    $existing = $this->authorizationModel->findUser($me);
                }  catch (Nette\Security\AuthenticationException $e) {
                    $this->flashMessage($e->getMessage());
                    return;
                }

                if ($existing->email != $me->email) {
                    // Email does not match, but user has signed in before
                    $this->flashMessage("Byl jsi přihlášen na základě google id, ale bacha - tvůj mail v databázi je $existing->email.");
                }
                if ($existing->role == "guest") {
                    $this->flashMessage("Byl jsi přihlášen jako guest.");
                }

                /**
                 * Nette\Security\User accepts not only textual credentials,
                 * but even an identity instance!
                 */

                $this->user->login(new \Nette\Security\Identity($existing->id_member, $existing->role, array('username' => $existing->email, 'name' => $existing->name, 'surname' => $existing->surname)));

                /**
                 * You can celebrate now! The user is authenticated :)
                 */

            } catch (Exception $e) {
                $this->flashMessage($e->getMessage());
            }

            $this->redirect('Homepage:');
        };

        return $dialog;
    }

}

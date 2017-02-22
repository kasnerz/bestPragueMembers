<?php

namespace App\Presenters;

use Nette,
App\Model,
Nette\Application\UI\Form,
Nette\Utils\Strings,
Nette\Http\Session;

/**
 * Email section
 */
class EmailPresenter extends BaseSecuredPresenter
{
    /** @var Nette\Database\Context */
    private $database;

    public function __construct(Nette\Database\Context $database)
    {
        parent::__construct();
        $this->database = $database;
    }

    public function renderDefault()
    {
        $user = $this->getUser();
        $member = $this->database->table('members_member')->get($user->getId());

        $name = Strings::lower(Strings::toAscii($member->name));
        $surname = Strings::lower(Strings::toAscii($member->surname));

        $session = $this->getSession('email');
        $session->name = $name;
        $session->surname = $surname;

        $state = file_get_contents('http://best-vps.bestprague.cz/email/get.php?auth=token2016&name='.$name.'&surname='.$surname);

        if( $state > 0 )
            $created = true;
        else
            $created = false;

        $session->created = $created;
        $this->template->created = $created;
    }

    /**
     * Form - edit board positions
     */
    protected function createComponentPostForm()
    {
        $session = $this->getSession('email');

        $name = $session->name;
        $surname = $session->surname;
        $created = $session->created;

        $form = new Form;

        $email = $name . '.' . $surname . '@bestprague.cz';

        $form->addGroup('Přihlašovací údaje');
        $form->addText('email', 'Email:')
            ->setDisabled()->setValue($email)
            ->setAttribute('size',30);

        if( !$created )
        {
            $form->addPassword('password', 'Heslo:')
                ->setRequired('Bez hesla to nepůjde.')
                ->setAttribute('size',30);
            $form->addPassword('passwordAgain', 'Heslo znovu:')
                ->setRequired('Pro kontrolu heslo opiš.')
                ->addRule(Form::EQUAL, 'Hesla se neshodují', $form['password'])
                ->addRule(Form::PATTERN, 'Heslo může obsahovat pouze písmena a číslice', '^[a-zA-Z0-9]+$')
                ->setAttribute('size',30);


            $form->addSubmit('submit', 'Přidat');
            $form->onSuccess[] = array($this, 'postFormSucceeded');
        }

        // All of this is only additional code that makes Nette form look good in Bootstrap
        // setup form rendering
        $renderer = $form->getRenderer();
        $renderer->wrappers['controls']['container'] = NULL;
        $renderer->wrappers['pair']['container'] = 'div class=form-group';
        $renderer->wrappers['pair']['.error'] = 'has-error';
        $renderer->wrappers['control']['container'] = 'div class=col-sm-9';
        $renderer->wrappers['label']['container'] = 'div class="col-sm-3 control-label"';
        $renderer->wrappers['control']['description'] = 'span class=help-block';
        $renderer->wrappers['control']['errorcontainer'] = 'span class=help-block';
        // make form and controls compatible with Twitter Bootstrap
        $form->getElementPrototype()->class('form-horizontal');
        foreach ($form->getControls() as $control) {
            if ($control instanceof Controls\Button) {
                $control->getControlPrototype()->addClass(empty($usedPrimary) ? 'btn btn-primary' : 'btn btn-default');
                $usedPrimary = TRUE;
            } elseif ($control instanceof Controls\TextBase || $control instanceof Controls\SelectBox || $control instanceof Controls\MultiSelectBox) {
                $control->getControlPrototype()->addClass('form-control');
            } elseif ($control instanceof Controls\Checkbox || $control instanceof Controls\CheckboxList || $control instanceof Controls\RadioList) {
                $control->getSeparatorPrototype()->setName('div')->addClass($control->getControlPrototype()->type);
            }
        }

        return $form;
    }

    /**
     * Save board positions
     */
    public function postFormSucceeded($form, $values)
    {
        // Substitute empty values with NULL
        foreach ($values as $i => $value) {
            if ($value === "") $values[$i] = NULL;
        }

        $session = $this->getSession('email');

        $name = $session->name;
        $surname = $session->surname;
        $password = urlencode($values['password']);

        file_get_contents('http://best-vps.bestprague.cz/email/create.php?auth=token2016&name='.$name.'&surname='.$surname.'&password='.$password);

        $this->flashMessage("Tvůj email byl úspěšně vytvořen!", 'info');
        $this->redirect('Email:');
    }
}
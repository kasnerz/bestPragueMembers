<?php

namespace App\Presenters;

use Nette;
use App\Forms\SignFormFactory;

/**
 * Sign in/out
 * Note: Signing in is taken care of in BasePresenter (Google redirect issues...)
 */
class SignPresenter extends BasePresenter
{

	public function actionOut()
	{
		$this->getUser()->logout();
	}

}

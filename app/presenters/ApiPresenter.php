<?php

namespace App\Presenters;

use Nette;
use App\Forms\SignFormFactory;
use Tracy\Dumper;

class ApiPresenter extends BasePresenter
{

    public function actionAddCarrots($data)
    {
        $this->sendResponse(new Nette\Application\Responses\TextResponse(Dumper::dump($data)));
    }

}

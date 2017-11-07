<?php
namespace Modules\module1\Controller;
use System\Renderer;
use System\Translator;
use Modules\module1\Form\newForm;

class izej1{
    public function listAction($params){
        return '<div class="c2">list_' . $params['par'] . '</div>';
    }
    
    public function viewAction($params){
        return '<div class="c1">view_' . $params['par'] . '</div>';
    }
    
}
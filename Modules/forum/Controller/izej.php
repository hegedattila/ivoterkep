<?php
namespace Modules\module1\Controller;
use System\Renderer;
use System\Translator;
use Modules\module1\Form\newForm;

class izej extends \System\AbstractClasses\abstractController{
    public function letsShow($params){
        $view = new Renderer();
        $view->setModuleView('module1', $params['template']);
        $view->setData('a', 12314);
        $view->renderView();
        return $view->getContent();
    }
    
    public function sdfa($params){
        $view = new Renderer();
        $view->setModuleView('module1',$params['template']);
        $form = new newForm();
        
        $view->setData('azenformom', $form);
        $view->setData('a', 687564123);
        $view->renderView();
        return $view->getContent();
    }
    
        
    public function ajax1($params){
        return json_encode($params);
    }        
    public function ajax2($params){
        return json_encode($params);
    }
    
}
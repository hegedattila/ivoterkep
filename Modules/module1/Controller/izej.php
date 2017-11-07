<?php
namespace Modules\module1\Controller;
use System\Renderer;

class izej extends \System\AbstractClasses\abstractController{
    public function letsShowAction($params){
        $view = new Renderer();
        $view->setModuleView('module1', $params['template']);
        $view->setData('a', 12314);
        $view->renderView();
        return $view->getContent();
    }
    
    public function sdfaAction(){
        var_dump($this->getParam());
        $this->setMeta('hihi', "huhu") ;
        $view = new Renderer();
        $view->setModuleView('module1','mod1view1');
        
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
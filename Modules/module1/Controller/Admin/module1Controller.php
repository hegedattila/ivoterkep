<?php
namespace Modules\module1\Controller\Admin;
class module1Controller extends \System\AbstractClasses\abstractController{
    
    public function listAction(){
        header('Content-Type: application/json');
        //...
        return json_encode(['type' => 'LIST','listData' => $listData, 'massbuttons' => $massButtons]);
    }
    
    public function deleteAction() {
        header('Content-Type: application/json');
        return json_encode([ 'type' => 'MESSAGE']);
    }
    
    public function tplForm1Action(){
        $form = new \Modules\module1\Form\tplBuilder1Form();
        $view = new \System\Renderer();
        if(!$view->setModuleView('module1', 'tplForm')){
            $view->setAdminView('module/tplForm');
        }
        $view->setData('form', $form);
        $view->renderView();
        return $view->getContent();
    }
        
    public function tplForm2Action(){
        $form = new \Modules\module1\Form\tplBuilder2Form();
        $view = new \System\Renderer();
        if(!$view->setModuleView('module1', 'tplForm')){
            $view->setAdminView('module/tplForm');
        }
        $view->setData('form', $form);
        $view->renderView();
        return $view->getContent();
    }
        
    public function tplForm3Action(){
        $form = new \Modules\module1\Form\tplBuilder3Form();
        $view = new \System\Renderer();
        if(!$view->setModuleView('module1', 'tplForm')){
            $view->setAdminView('module/tplForm');
        }
        $view->setData('form', $form);
        $view->renderView();
        return $view->getContent();
    }
    
}

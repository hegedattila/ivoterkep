<?php
namespace Modules\pubMap\Controller;
use System\Renderer;

class pubMap extends \System\AbstractClasses\abstractController{
    
    public function showMapAction(){
        $view = new Renderer();
        $params = $this->getParam();
      //  var_dump($params);
        $view->setModuleView('pubMap', 'map');
        $view->setData('valami', "A view számára adat, lehet tömb is, vagy objektum...");
        $view->renderView();
        return $view->getContent();
    }
    
    public function showPubAction(){
        $view = new Renderer();
        $params = $this->getParam();
     //   var_dump($params);
        $view->setModuleView('pubMap', 'pub');
        $view->setData('valami', "A view számára adat, lehet tömb is, vagy objektum...");
        $view->renderView();
        return $view->getContent();
    }
}
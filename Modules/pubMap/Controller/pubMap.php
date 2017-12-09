<?php
namespace Modules\pubMap\Controller;
use System\Renderer;

class pubMap extends \System\AbstractClasses\abstractController{
    private $db;
    
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Modules\pubMap\Model\pubTable_front;
        }
        return $this->db;
    }
    
    public function showMapAction(){
        $view = new Renderer();
        $params = $this->getParam();
      //  var_dump($params); // sok-sok parameter
        $view->setModuleView('pubMap', 'map');
        $view->setData('valami', "A view számára adat, lehet tömb is, vagy objektum...");
        $view->renderView();
        return $view->getContent();
    }
    
    public function showPubAction(){
        $view = new Renderer();
        $pubSef = $this->getParam(['moduleRouteParams','pub'],['routeParams',-1]);
        
        // adatok lekérdezése DB-ből...
        
        $view->setModuleView('pubMap', 'pub');
        $view->setData('valami', $pubSef);
        $view->renderView();
        if($this->checkIsAjax()){
            $window = new Renderer();
            $window->setView('popupWindow');
            $window->setDataArr(['title' => $pubSef, 'content' => $view->getContent()]);
            $window->renderView();
            return $window->getContent();
        }
        return $view->getContent();
    }
}
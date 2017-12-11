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
        $pubSef = $this->getParam(['routeParams',-1], null);
        $view->setModuleView('pubMap', 'map');
        $view->setData('sef', $pubSef);
        $view->renderView();
        return $view->getContent();
    }
    
    public function showFilterAction(){
        $view = new Renderer();
        $view->setModuleView('pubMap', 'filter');
        $view->renderView();
        return $view->getContent();
    }
    
    // egyetlen kocsma adatait adja
    public function showPubAction(){
        $view = new Renderer();
        $pubSef = $this->getParam(['moduleRouteParams','pub'],['routeParams',-1]);
        
        //---> adatok lekérdezése DB-ből...
        $data = $this->getTable()->getPub($pubSef);
        
        $view->setModuleView('pubMap', 'pub');
        $view->setData('data', $data);
        $view->renderView();
        if($this->checkIsAjax()){
            $window = new Renderer();
            $window->setView('popupWindow');
            $window->setDataArr(['title' => 'Kocsma', 'content' => $view->getContent()]);
            $window->renderView();
            return $window->getContent();
        }
        return $view->getContent();
    }
    
    public function showFrontPubFormAction(){
        $form = new \Modules\pubMap\Form\pubForm('/____/pubMap/admin/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setModuleView('pubMap','pubFormView');
        $view->renderView();
            $window = new Renderer();
            $window->setView('popupWindow');
            $window->setDataArr(['title' => 'Új kocsma létrehozása', 'content' => $view->getContent()]);
            $window->renderView();
        return $window->getContent();
    }
    
    public function pubListAction(){
        $this->setHeaderDataType('JSON');
        $params = $this->getParam('POSTParams');
        $list = $this->getTable()->getPubList($params);
       // var_dump($params);
        return json_encode($list);
    }
}
<?php

namespace System\SystemModels;

class Template {
    private $layoutPlaces = [];
    private $params = [];
    private $view;
    private $headData = null;
    
    public function __construct() {
        $this->view = new \System\Renderer;
        $this->headData = new \System\PageHeadData();
    }
    
    public function setLayout($layout) {
        $this->view->setView( $layout );
    }
    
    public function setPlaces($places) {
        $this->layoutPlaces = $places;
    }
    
    public function setParam($key, $param) {
        $this->params[$key] = $param;
    }
    
    public function getView() {
        return $this->view;
    }
    
    public function getHeadData() {
        return $this->headData;
    }
    
    public function setModule() {
        foreach ($this->layoutPlaces as $key => $value) {
            $placeStr = '';
            foreach ($value as $moduleSet) {
                if(isset($moduleSet['module'])){
                    
//                    if(isset($moduleSet['replaceAction']) && $moduleSet['replaceAction'] === true){
//                        $addRoute = $this->additionalRoute;
//                        $moduleSet['action'] = preg_replace_callback(
//                            '/\[([0-9]+)\]/',
//                            function($i) use ($addRoute){
//                                return (isset($addRoute[$i[1]]))?$addRoute[$i[1]]:'';
//                            },
//                            $moduleSet['action']);
//                    }
                    
                    $mod = new \System\ModuleHandler($moduleSet);
                    $mod->setParams($this->params);
                    
                    $placeStr .= $mod->runModule();
                    if(isset($moduleSet['head']) && $moduleSet['head']){
                        $this->headData->mergeHeadData($mod->getPageHeadData());
                    }
                }
            }
            $this->view->setData( $key, $placeStr );
        }
    }
    
}

<?php
namespace System;

class ModuleHandler {

    private $moduleName;
    private $params;
    private $onlyExactRoute = false;
    
    private $callableRoutes;
    private $callableClass;
    private $callableControllerName;
    private $callableFunction;
    private $callableInstance;
    private $config;
    public $errMsg = null;
        
    public function __construct($module) {
        $this->setParam('moduleParams', isset($module['params'])?$module['params']:[] );
        $this->moduleName = $module['module'];
        
        if(ConfigLoader::getActiveModules($this->moduleName)){
        
            if(isset($module['action'])){
                if(is_array($module['action'])){
                    $this->callableRoutes = $module['action'];
                } else {
                    $this->callableRoutes = preg_split('@/@', $module['action'], NULL, PREG_SPLIT_NO_EMPTY);
                }
            } else {
                $this->callableRoutes = [];
            }

            $this->config = \System\ConfigLoader::getModuleConfig($this->moduleName);
            if(isset($this->config['defaults'])){
                $this->params['defaultParams'] = $this->config['defaults'];
            }
            $this->getCallables($this->config['routes'],0);
            
        }
    }
    
    public function setParam($key,$val){
        $this->params[$key] = $val;
    }
    
    public function setParams($parr){
        foreach ($parr as $key => $val) {
            $this->params[$key] = $val;
        }
    }
    
    private function getCallables($routes,$i){
        if(isset($routes['permission'])){
            if( \System\SessionHandler::getPermission('OR', $routes['permission'], 'all') ){
                $this->setParam('lPerm', $routes['permission']);
            } else {
                $this->errMsg = 'AccessDenied';
                return;
            }
        }
        if(isset($routes['controller'])){
            $this->callableControllerName = $routes['controller'];
        }
        if(isset($routes['action'])){
            $this->callableFunction = $routes['action'] . 'Action';
        }
        if( isset($routes['parameters']) ){
            $this->setParam('moduleConfigParams', $routes['parameters']);
        }
        if( isset($routes['childRoutes']) && isset($this->callableRoutes[$i]) ){
            $actualRoute = $this->callableRoutes[$i];
            if( isset($routes['childRoutes'][$actualRoute]) ){ // literal
                $this->params['routeName'] = $actualRoute;
                $this->getCallables($routes['childRoutes'][$actualRoute], $i+1);
                return;
            } else if( isset($routes['childRoutes']['@number']) && is_numeric($actualRoute) ){ // parameter
                $this->params['moduleRouteParams'][$routes['childRoutes']['@number']['paramName']] = $actualRoute;
                $this->getCallables($routes['childRoutes']['@number'], $i+1);
                return;
            } else if( isset($routes['childRoutes']['@']) ){ // parameter
                $this->params['moduleRouteParams'][$routes['childRoutes']['@']['paramName']] = $actualRoute;
                $this->getCallables($routes['childRoutes']['@'], $i+1);
                return;
            }
        }
        if( !$this->onlyExactRoute || count($this->callableRoutes) == $i ){
            
            $this->callableClass = $this->config['controllers'][$this->callableControllerName];
            if(class_exists($this->callableClass)){
                $this->params['routeParams'] = array_slice($this->callableRoutes,$i);
                $this->callableInstance = new $this->callableClass;
                return;
            }
        }
        $this->errMsg = 'RouteNotFound';
    }
    
    public function runModule() {
        $funcStr = $this->callableFunction;
        if($this->callableInstance == NULL){
            return '';//$this->errMsg;
        }
        if(!is_callable([$this->callableInstance,$funcStr],false)){
            return '';//No Callable Instance';
        }
        $this->callableInstance->setParams($this->params);
        return $this->callableInstance->$funcStr();
    }
    
    public function getPageHeadData(){
        return $this->callableInstance->getHeadData();
    }
    
}
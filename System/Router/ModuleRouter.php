<?php

namespace System\Router;

class ModuleRouter{
    private $projectName;
    private $gdata;
    private $pdata;
    private $uriComponents;


    public function init(){
        $this->projectName = \System\ProjectManager::getProjectName();
        
        define( "PROJECTNAME", $this->projectName );
        define( "PROJECTPATH", "Projects/" . PROJECTNAME );
        define( "ADMINPATH", "Admin" );
        define( "MODULEPATH", "Modules" );
        define( "CONFPATH", PROJECTPATH . "/config" );
        define( "ADMINCONFPATH", ADMINPATH . "/config" );
        
        \System\SessionHandler::initSession();
        
        $this->scanUrl();
        return $this->route();
    }
    
    private function scanUrl() {
        if(isset($_SERVER['REDIRECT_URL'])){
            $this->uriString = $_SERVER['REDIRECT_URL'];
            $this->uriComponents = preg_split('@/@', $this->uriString, NULL, PREG_SPLIT_NO_EMPTY);
        }
        $this->gdata = \System\RequestHandler::getGet();
        $this->pdata = \System\RequestHandler::getPost();
    }
    
    public function route(){
        if(is_array($this->uriComponents) && count($this->uriComponents) > 1) {
            $param = [
                'module' => $this->uriComponents[1],
                'action' => count($this->uriComponents) > 2 ? array_slice($this->uriComponents, 2) : null
            ];
            $module = new \System\ModuleHandler($param, true);
            
            $module->setParam('GETParams', $this->gdata);
            $module->setParam('POSTParams', $this->pdata);
            return $module->runModule();
        }
        return '';
    }
}

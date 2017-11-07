<?php
namespace System\Router;

class AdminRouter{
    
    private $projectName;
    private $view;
    private $uriComponents = [];
    private $getComponents = [];
    private $uriString = '';
    private $layoutFile;
    private $layoutPlaces;
    private $loggedIn = false;
    
    public function init(){
        $this->projectName = \System\ProjectManager::getProjectName();
        
        define( "PROJECTNAME", $this->projectName );
        define( "PROJECTPATH", "Projects/" . PROJECTNAME );
        define( "ADMINPATH", "Admin" );
        define( "MODULEPATH", "Modules" );
        define( "CONFPATH", PROJECTPATH . "/config" );
        define( "ADMINCONFPATH", ADMINPATH . "/config" );
        
        \System\SessionHandler::initSession();
        \System\SettingHandler::saveAllSettingsToSession();
        $this->loggedIn = \System\UserHandler::checkIsAdminUser();
        
      //  $this->scanUrl();
        $this->getLayout();
        
        $this->getModuleTemplates();
    }
    
    private function getModuleTemplates() {
        foreach ($this->layoutPlaces as $key => $value) {
            $placeStr = '';
            foreach ($value as $moduleSet) {
                if(isset($moduleSet['module'])){
                    $mod = new \System\ModuleHandler($moduleSet);
                    $placeStr .= $mod->runModule();
                }
            }
            $this->view->setData( $key, $placeStr );
        }
    }
    
    private function getLayout() {
        if($this->loggedIn){           
            $this->layoutFile = \System\ConfigLoader::getConfig("layoutConfig","layout",true);
            $this->layoutPlaces = \System\ConfigLoader::getConfig("layoutConfig","layoutPlaces",true);
        } else {
            $this->layoutFile = \System\ConfigLoader::getConfig("layoutConfig","loginLayout",true);
            $this->layoutPlaces = \System\ConfigLoader::getConfig("layoutConfig","loginLayoutPlaces",true);
        }
        
        $this->view = new \System\Renderer;
        $this->view->setAdminView( $this->layoutFile );
    }

    private function scanUrl(){
        if(isset($_SERVER['REDIRECT_URL'])){
            $this->uriString = $_SERVER['REDIRECT_URL'];
            $this->uriComponents = preg_split('@/@', $this->uriString, NULL, PREG_SPLIT_NO_EMPTY);
            $this->getComponents = \System\RequestHandler::getGet();
        }
    }
    
    public function showPage() {
        $this->view->renderView();
        echo $this->view->getContent();
    }
}
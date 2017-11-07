<?php
namespace System\Router;

class PageRouter{
    
    private $projectName;
    private $htmlView;
    private $uriComponents = [];
    private $getComponents = [];
    private $uriString = '';
    private $headData;
    private $template;
    private $siteConfig;

    public function init(){
        $this->projectName = \System\ProjectManager::getProjectName();
        define( "PROJECTNAME", $this->projectName );
        define( "PROJECTPATH", "Projects/" . PROJECTNAME );
        define( "MODULEPATH", "Modules" );
        define( "CONFPATH", PROJECTPATH . "/config" );
        
        \System\SessionHandler::initSession();
        $this->siteConfig = \System\ConfigLoader::getConfig('siteConfig');
        
        $this->scanUrl();
        $this->setHtmlView();
        $this->initHeadData();
        $this->initTemplate();
    }
    
    private function initTemplate(){
        $this->template = new \System\SystemModels\Template;
        
        $table = new \System\SystemModels\Tables\TemplateTable;
        
        $layoutDB = $table->getPageLayout($this->uriString);
        
        if($layoutDB){
            $this->template->setLayout($layoutDB['filename']);
            $this->template->setPlaces($layoutDB['places']);
            $this->template->setParam('routeParams', $layoutDB['additionalRoute']);
        } elseif(count($this->uriComponents) > 0) {
            $this->template->setLayout($this->siteConfig['defaultView']);
            $places = [
                $this->siteConfig['defaultContentPlaceholder'] => [
                    [
                    'module' => $this->uriComponents[0],
                    'action' => array_slice($this->uriComponents, 1)
                    ]
                ]
            ];
            $this->template->setPlaces($places);
        } else {
            //404 hiba
            return;
        }
        
        $this->template->setParam('GETParams', $this->getComponents);
        $this->template->setModule();
        
        $this->headData->mergeHeadData($this->template->getHeadData());
    }
    
    private function initHeadData(){
        $this->headData = new \System\PageHeadData( $this->siteConfig['defaultHeadData'] );
    }
    
    private function setHtmlView(){
        $htmlViewFile = \System\ConfigLoader::getConfig('siteConfig','htmlView');
        $this->htmlView = new \System\Renderer;
        $this->htmlView->setView( $htmlViewFile );
    }

    private function scanUrl(){
        if(isset($_SERVER['REDIRECT_URL'])){
            $this->uriString = $_SERVER['REDIRECT_URL'];
            $this->uriComponents = preg_split('@/@', $this->uriString, NULL, PREG_SPLIT_NO_EMPTY);
            $this->getComponents = \System\RequestHandler::getGet();
        }
    }
    
    public function showPage() {
        $this->htmlView->setData('head', $this->headData);
        $this->htmlView->setData('body', $this->template->getView());
        echo $this->htmlView;
    }
}
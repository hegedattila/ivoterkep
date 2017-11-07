<?php
namespace Admin\Controller\module;
class moduleController extends \System\AbstractClasses\abstractController{
    
    private $db;
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Admin\Model\module\moduleTable;
        }
        return $this->db;
    }
    
    public function listAction(){
        $this->setHeaderDataType('JSON');
        $moduleNames = \System\ConfigLoader::getActiveModules();
        $modules = [];
        foreach ($moduleNames as $mname) {
            $moduleInfo = \System\ConfigLoader::getModuleConfig($mname, 'tplFormInfo');
            $modules[$mname] = $moduleInfo;
        }
        return json_encode($modules);
    }
    
//    public function getModuleTplFormAction() {
//        $moduleName = $this->getParam('module', null);
//        $class = '\Modules\\' . $moduleName . '\Form\tplBuilderForm';
//        $form = new $class();
//        $view = new \System\Renderer();
//        if(!$view->setModuleView($moduleName, 'tplForm')){
//            $view->setAdminView('module/tplForm');
//        }
//        $view->setData('form', $form);
//        $view->renderView();
//        return $view->getContent();
//    }
}

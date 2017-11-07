<?php
namespace Modules\menu\Controller;
use System\Translator;

class menuController extends \System\AbstractClasses\abstractController{
    
    public function jsonAdminMenuAction(){
        $elements = [];
        $modules = \System\ConfigLoader::getActiveModules();
        if(isset($modules) && count($modules) > 0){
            foreach ($modules as $value) {
                $mfilename = MODULEPATH . '/' . $value . '/Admin/menu.php';
                if(is_file($mfilename)){
                    $elements[$value] = include $mfilename;
                }
            }
        }
        
        $filename = ADMINPATH . '/menu/menu.php';
        if(is_file($filename)){
            $elements['system'] = include $filename;
        }
        $this->selectPermission($elements);
        return json_encode( $elements );
    }
    
    private function selectPermission(&$menu) {
        foreach ($menu as &$value) {            
            if(isset($value['permission']) && !\System\SessionHandler::getPermission('OR',$value['permission'],'all')){
                $value = null;
            }
            if(isset($value['subMenu'])){
                $this->selectPermission($value['subMenu']);
            }
        }
    }
    
}
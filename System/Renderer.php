<?php
namespace System;
class Renderer{
    
    private $data = [];
    private $content = '';
    private $viewFilename;
    private $templateBuilder = false;
    
    public function __construct($file = null,$forBuilder = false) {
        $this->templateBuilder = $forBuilder;
        $this->viewFilename = $file;
    }
    
    public function __toString(){
        $this->renderView();
        return $this->getContent();
    }
    
    public function setData($key,$data){
        $this->data[$key] = $data;
    }
    public function setDataArr($array){
        foreach ($array as $key => $value) {
            $this->data[$key] = $value;
        }
    }
    
    public function getContent(){
        return $this->content;
    }

    public function setView($file){
        $path = PROJECTPATH . '/view/' . $file . '.phtml';
        if(is_file($path)){
            $this->viewFilename = $path;
            return true;
        }
        return false;
    }
    
    public function setAdminView($file){
        $path = ADMINPATH . '/view/' . $file . '.phtml';
        if(is_file($path)){
            $this->viewFilename = $path;
            return true;
        }
        return false;
    }
    
    public function setModuleView($module, $file){
        
        $path1 = PROJECTPATH . '/view/modules/' . $module . '/' . $file . '.phtml';
        $path2 = MODULEPATH . '/' . $module . '/view/' . $file . '.phtml';
        
        if(is_file($path1)){
            $this->viewFilename = $path1; 
            return true;
        } elseif (is_file($path2)) {
            $this->viewFilename = $path2;
            return true;
        }
        return false;
    }
    
    public function renderView() {
        if(is_file($this->viewFilename)){
            ob_start();
            include $this->viewFilename;
            $this->content = ob_get_clean();
        } else {
            $this->content = '';
          //  throw new \Exception("File not found! - " . $this->viewFilename);
        }
    }
    
    private function get($key){
        if($this->templateBuilder){
            return '<div data-placename="' . $key . '" class="place"></div>';
        } else if(isset($this->data[$key])){
            return $this->data[$key];
        } else {
            return null;
        }
    }
    
}
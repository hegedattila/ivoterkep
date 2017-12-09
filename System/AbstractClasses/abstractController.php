<?php

namespace System\AbstractClasses;

abstract class abstractController{
    private $params = [];
    private $headData;
    private $isAjax;
    
    function __construct(){
        $this->headData = new \System\PageHeadData;
    }
    
    public function getHeadData(){
        return $this->headData;
    }
    
    public function setParam($key,$val){
        $this->params[$key] = $val;
    }
    
    public function setParams($param) {
        $this->params = array_merge($this->params, $param);
    }

    protected function getParam() {
        $argNum = func_num_args();
        $args = func_get_args();
        if($argNum < 1){
            return $this->params;
        }
        
        foreach ($args as $arg) {
            if(is_array($arg)){
                if(count($arg) == 2 && isset($this->params[$arg[0]]) && is_array($this->params[$arg[0]])){
                    if(isset($this->params[$arg[0]][$arg[1]])){
                        return $this->params[$arg[0]][$arg[1]];
                    } elseif ($arg[1] === -1) {
                        return end($this->params[$arg[0]]);
                    }
                }
            } else {
                if(isset($this->params[$arg])){
                    return $this->params[$arg];
                }
            }
        }
        return end($args); // utolsó arg default
    }
    
//    protected function checkParam($keys,$val = null) {
//        if(is_array($keys)){
//            foreach ($keys as $key) {
//                if(isset( $this->params[$key]) && $this->params[$key] == $val ){
//                    return true;
//                }
//            }
//        } else if(isset($this->params[$keys]) && $this->params[$keys] == $val ){
//            return true;
//        }
//        return false;
//    }
    
    protected function setHeaderDataType($type) { //TODO Nem itt kellene...
        switch ($type) {
            case 'JSON':
                header('Content-Type: application/json');
                break;
            case 'HTML':
                header('Content-Type: text/html');
                break;
            case 'RSS':
                header('Content-Type: application/rss+xml; charset=ISO-8859-1');
                break;
            case 'XML':
                header('Content-Type: text/xml');
                break;
            case 'PLAIN':
                header('Content-Type: text/plain');
                break;

            default:
                header('Content-Type: text/html');
        }
    }
    
    protected function setMeta($name, $content) {
        $this->headData->setMetaData($name, $content);
    }
    protected function checkIsAjax() {
        return $this->getParam('isAjax',null);
    }
}
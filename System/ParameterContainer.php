<?php

namespace System;
class ParameterContainer {
    private $params = [];
    
    public function addParam($name,$value,$type){
        $this->params[$name] = [
            'name' => $name,
            'value' => $value,
            'type' => $type,
        ];
    }
    
    public function bindAll(&$obj){
        foreach ($this->params as $value) {
            $obj->bindValue($value['name'],$value['value'],$value['type']);
        }
    }
        
    public function setEmptyValuesToNull($keys = null) {
     //   $valuesNumber = 0;
        if(is_array($keys)){
            foreach ($keys as $key) {
                if(isset($this->params[$key]) && $this->params[$key]['value'] === ''){
                    $this->params[$key]['value'] = NULL;
                }
                
//                if(is_array($arr[$key])){
//                    $valuesNumber += self::setValuesToNull($arr[$key]);
//                } elseif(!is_null($arr[$key])){
//                    $valuesNumber++;
//                }
            }
        } else {
            foreach ($this->params as &$par) {
                if(!isset($par['value']) || $par['value'] === ''){
                    $par['value'] = NULL;
                }
                
//                if(is_array($value)){
//                    $valuesNumber += self::setValuesToNull($value);
//                } elseif(!is_null($value)){
//                    $valuesNumber++;
//                }
            }
        }
    //    return $valuesNumber;
        
    }
    
}

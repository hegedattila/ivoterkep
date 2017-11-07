<?php

namespace System\SystemModels\htmlDom;

class DOMElement {
    protected $elementName;
    protected $content;
    protected $isEmpty;
    protected $attributes = [];
    
    public function __construct($name = null, $content = null, $isEmpty = false, $attributes = []) {
        $this->elementName = $name;
        $this->content = $content;
        $this->isEmpty = $isEmpty;
        $this->attributes = $attributes;
    }
    
    public function __toString() {
        return $this->render();
    }
    
    public function setElementName($name) {
        $this->elementName = $name;
    }
    
    public function setContent($content) {
        $this->content = $content;
    }
    
    public function getAttribute($name) {
        return isset($this->attributes[$name])?$this->attributes[$name]:null;
    }
    
    public function setAttribute($name, $value) {
        $this->attributes[$name] = $value;
    }
    
    public function setAttributes($attributes) {
        $this->attributes = $attributes;
    }
    
    private function renderAttributes() {
        $html = '';
        foreach ($this->attributes as $key => $value) {
            $html .= " $key=\"$value\"";
        }
        return $html;
    }
    
    public function render() {
        if(is_null($this->elementName)){
            return '';
        }
        $html = "<$this->elementName";
        if(is_array($this->attributes) && count($this->attributes) > 0){
            $html .= $this->renderAttributes();
        }
        $html .= '>';
        if(!$this->isEmpty){
            if(is_array($this->content)){
                foreach ($this->content as $content) {
                    $html .= $content;
                }
            } else {
                $html .= $this->content;
            }
            $html .= "</$this->elementName>";
        }
        return $html;
    }
}

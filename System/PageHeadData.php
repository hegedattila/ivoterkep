<?php
namespace System;

use \System\SystemModels\htmlDom\DOMElement as element;

class PageHeadData {
    private $metaData = [];
    private $title = null;
    private $charset = null;
    private $links = [];
    private $scripts = [];
    
    public function __construct($data = []) {
        if(isset($data['title'])){
            $this->setTitle($data['title']);
        }
        if(isset($data['charset'])){
            $this->setCharset($data['charset']);
        }
        if(isset($data['meta']) && is_array($data['meta'])){
            $this->setMetaDatas($data['meta']);
        }
        if(isset($data['links']) && is_array($data['links'])){
            $this->addCSSs($data['links']);
        }
        if(isset($data['scripts']) && is_array($data['scripts'])){
            $this->addScripts($data['scripts']);
        }
    }
    
    public function __toString(){
        return $this->getHTML();
    }
    
    public function mergeHeadData($new) {
        if(!$new instanceof self){
            return;
        }
        $newData = $new->getData();
        if(is_array($newData['meta'])){
            $this->metaData = array_merge($this->metaData, $newData['meta']);
        }
        if(!is_null($newData['title'])){
            $this->title = $newData['title'];
        }
        if(!is_null($newData['charset'])){
            $this->charset = $newData['charset'];
        }
        if(is_array($newData['links'])){
            $this->links = array_merge($this->links, $newData['links']);
        }
        if(is_array($newData['scripts'])){
            $this->scripts = array_merge($this->scripts, $newData['scripts']);
        }
    }
    
    public function setMetaDatas($mdataArr){
        foreach ($mdataArr as $key => $value) {
            $this->setMetaData($key, $value);
        }
    }
    
    public function setMetaData($name, $content, $attrs = []){
        $attributes = [
                    'name' => $name,
                    'content' => $content
                ];
        $this->metaData[$name] = new element("meta", null, true, array_merge($attrs,$attributes));
    }
    
    public function unsetMetaData($name){
        unset($this->metaData[$name]);
    }
    
    public function addCSS($href){
        $this->addLink($href, 'stylesheet', 'text/css');
    }
    
    public function addCSSs($linkArr){
        foreach ($linkArr as $value) {
            $this->addCSS($value);
        }
    }
    
    public function addLink($href, $rel='', $type='', $attrs = []){
        $attributes = [
                    'href' => $href,
                    'rel' => $rel,
                    'type' => $type,
                ];
        $this->links[] = new element("link", null, false, array_merge($attrs,$attributes));
    }
    
    public function addScript($src, $attrs = []){
        $attributes = ['src' => $src];
        $this->scripts[] = new element("script", '', false, array_merge($attrs,$attributes));
    }
    
    public function addScripts($scriptsArr){
        foreach ($scriptsArr as $value) {
            $this->addScript($value);
        }
    }
    
    public function setTitle($title){
        $this->title = new element("title", $title);
    }
    
    public function setCharset($charset){
        $this->charset = new element("meta", null, true, ['charset' => $charset]);
    }
    
    public function getData(){
        return [
            'charset' => $this->charset,
            'links' => $this->links,
            'meta' => $this->metaData,
            'scripts' => $this->scripts,
            'title' => $this->title,
        ];
    }
    
    public function getHTML() {
        $html = '';
        if(!is_null($this->title)){
            $html .= $this->title;
        }
        if(!is_null($this->charset)){
            $html .= $this->charset;
        }
        if(count($this->metaData) > 0){
            foreach ($this->metaData as $meta) {
                $html .= $meta;
            }
        }
        if(count($this->links) > 0){
            foreach ($this->links as $link) {
                $html .= $link;
            }
        }
        if(count($this->scripts) > 0){
            foreach ($this->scripts as $script) {
                $html .= $script;
            }
        }
        return $html;
    }
}

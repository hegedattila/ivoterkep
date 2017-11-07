<?php
namespace System\AbstractClasses;
use System\FormElement AS elem;

abstract class abstractForm{
    public $formElements = [];
    protected $formMethod = 'post';
    protected $formAction = '';
    protected $ajaxSend = true;
    protected $formAttributes = [];

    protected function addElement($name,$element){
        if(isset($element['type'])){
            $element['name'] = $name;
            if(isset($element['isArray'])){
                $this->formElements[$name] = [];
                foreach ($element['isArray'] as $value) {
                    $element['array_key'] = $value;
                    $this->formElements[$name][$value] = new elem($element);
                }
            } else {
                $this->formElements[$name] = new elem($element);
            }
            return true;
        }
        return false;
    }
    
    public function openTag() {
        $html = '<form method="' . $this->formMethod . '" ' .
                'action="' . $this->formAction . '" enctype="multipart/form-data" ';
        if(count($this->formAttributes) > 0){
            foreach ($this->formAttributes as $key => $value) {
                $html .= $key . '="' . $value . '" ';
            }
        }
        $html .= '>';
        return $html;
    }
    
    public function closeTag() {
        return '</form>';
    }
    
    public function formElement($elementName, $label = true, $tooltip = true, $idx = 0){
        if(isset($this->formElements[$elementName])){
            if(is_array($this->formElements[$elementName])){
                if(isset($this->formElements[$elementName][$idx])){
                    return $this->formElements[$elementName][$idx]->render($label,$tooltip);
                }
            } else {
                return $this->formElements[$elementName]->render($label,$tooltip);
            }
        }
        return '';
    }
    
    public function renderToRowsByName($elements = [], $label = true, $tooltip = true) {
        $html = '<table cellspacing="0" class="form-table"><tbody>';
        foreach ($elements as $elementName) {
            if(is_array($this->formElements[$elementName])){
                foreach ($this->formElements[$elementName] as $e) {
                    $html .= $e->renderRow($label,$tooltip);
                }
            } else {
                $html .= $this->formElements[$elementName]->renderRow($label,$tooltip);
            }
            
        }
        $html .= '</tbody></table>';
        return $html;
    }
    
    public function renderAllToRows($label = true, $tooltip = true) {
        $html = '<table cellspacing="0" class="form-table"><tbody>';
        foreach ($this->formElements as $element) {
            if(is_array($element)){
                foreach ($element as $e) {
                    $html .= $e->renderRow($label,$tooltip);
                }
            } elseif($element->type !== 'submit'){
                $html .= $element->renderRow($label,$tooltip);
            }
        }
        $html .= '</tbody></table>';
        return $html;
    }
    
    protected function validateMulElements($validator,$elementsArr = []) {
        foreach ($elementsArr as $element) {
            $this->validateElement($element, $validator);
        }
    }
    
    public function setValues($values) {
        foreach ($values as $key => $value) {
            if(isset($this->formElements[$key])){
                if(is_array($this->formElements[$key]) && is_array($value)){
                    foreach ($value as $k => $v) {
                        if(isset($this->formElements[$key][$k]) && $this->formElements[$key][$k] instanceof elem){
                            $this->formElements[$key][$k]->setValue($v);
                        }
                    }
                } elseif(!is_array($this->formElements[$key]) && !is_array($value)){
                    $this->formElements[$key]->setValue($value);
                }
            }
        }
    }
        
    public function getValues() {
        $result = [];
        foreach ($this->formElements as $key => $element) {
            if(is_array($element)){
                $result[$key] = [];
                foreach ($element as $k => $e) {
                    $result[$key][$k] = $e->getValue();
                }
            } else {
                $result[$key] = $element->getValue();
            }
        }
        return $result;
    }
    
    public function validateForm(){
        return false;
    }
    
    protected function validateElement($elementName,$validator){
        $element = $this->formElements[$elementName];
        
        if(is_array($element)){
            foreach ($element as $key => $e) {
                $e->validate($validator);
            }
        } elseif($element instanceof elem) {
            $element->validate($validator);
        }
    }
    
    public function isValid() {
        foreach ($this->formElements as $element) {
            if(is_array($element)){
                foreach ($element as $e) {
                    if($e->isValid() == FALSE){
                        return false;
                    }
                }
            } elseif($element->isValid() == FALSE){
                return false;
            }
        }
        return true;
    }
    
//    public function getMessages() {
//        $result = [];
//        foreach ($this->formElements as $key => $element) {
//            if(is_array($element)){
//                $result[$key] = [];
//                foreach ($element as $k => $e) {
//                    $result[$key][$k] = $e->validateMessages;
//                }
//            } else {
//                $result[$key] = $element->validateMessages;
//            }
//        }
//        return $result;
//    }
    
    public function setAction($action) {
        $this->formAction = $action;
    }
    
    public function getInvalidElements() {
        $elems = [];
        foreach ($this->formElements as $element) {
            if(is_array($element)){
                foreach ($element as $e) {
                    if(!$e->isValid()){
                        $elems[] = [
                            'name' => $e->name,
                            'htmlid' => $e->getAttribute('id'),
                            'value' => $e->value,
                            'msg' => $e->getMessages()
                            ];
                    }
                }
            } else {
                if(!$element->isValid()){
                    $elems[] = [
                        'name' => $element->name,
                        'htmlid' => $element->getAttribute('id'),
                        'value' => $element->value,
                        'msg' => $element->getMessages()
                        ];
                }
            }
        }
        return $elems;
    }
    
}

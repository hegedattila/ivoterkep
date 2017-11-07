<?php

namespace System;
class FormElement extends \System\SystemModels\htmlDom\DOMElement{
    public $type = '';
    public $name = '';
    public $label = '';
    public $value = null;
    public $validateMessages = [];
    public $inArrayKey = null;
    public $tooltipText = '';
    
    private $valid = true;
    private $options;

    public function __construct($c_arr) {
        $this->type = $c_arr['type'];
        $this->name = $c_arr['name'];
        
        $this->setElementName('input');
        
        if(isset($c_arr['label'])){
            $this->label = $c_arr['label'];
        }
        if(isset($c_arr['attributes'])){
            $this->setAttributes($c_arr['attributes']);
            
            if(!isset($this->attributes['id'])){
                $this->setAttribute('id', $this->name);
            }
        }
        
        if(isset($c_arr['array_key'])){
            $this->inArrayKey = $c_arr['array_key'];
            $this->setAttribute("name", $this->name . '[' . $c_arr['array_key'] . ']');
            $this->attributes['id'] .= ('_' . $c_arr['array_key']);
        } else {
            $this->setAttribute("name", $this->name);
        }
        
        if($this->type == 'select'){
            if(isset($c_arr['nullOption'])){
                $this->options[''] = new \System\SystemModels\htmlDom\DOMElement('option', $c_arr['nullOption'], false, ['value'=>'']);
            }
            if(isset($c_arr['options'])){
                foreach ($c_arr['options'] as $key => $value) {
                    $this->options[$key] = new \System\SystemModels\htmlDom\DOMElement('option', $value, false, ['value'=>$key]);
                }
            }
        }
        
        if(isset($c_arr['tooltip'])){
            $this->tooltipText = $c_arr['tooltip'];
        }
    }
    
    public function renderRow($label = true, $tooltip = true){
        $html = '<tr class="form-row">';
        if($label){
            $html .= '<td class="form-cell label-cell">' . $this->renderLabel();
            if($tooltip){
                $html .= $this->renderTooltip();
            }
            $html .= '</td>';
        }
        $html .= '<td class="form-cell value-cell">' . $this->render(false,false) . '</td>';
        return $html;
    }
    
    public function render($label = true, $tooltip = true, $invalidTooltip = true) {
        $html = '';
        if($label){
            $html .= $this->renderLabel();
        }
        if($tooltip){
            $html .= $this->renderTooltip();
        }
        if($invalidTooltip){
            $html .= $this->renderInvalidElementTooltip();
        }
        
        switch ($this->type){
            case 'select':
                $html .= $this->renderSelect();
                break;
            case 'textarea':
                $html .= $this->renderTextarea();
                break;
            case 'checkbox':
                $html .= $this->renderCheckbox();
                break;
            default :
                $html .= $this->renderInput();
        }
        return $html;
    }
    
    private function renderSelect(){
        $this->setElementName('select');
        if(count($this->options) > 0){
            if(!isset($this->value) && isset($this->options[''])){
                $this->options['']->setAttribute('selected', true);
            } else {
                if( is_array($this->value) ){
                    foreach ($this->value as $value) {
                        $this->options[$value]->setAttribute('selected', true);
                    }
                } else {
                    $this->options[$this->value]->setAttribute('selected', true);
                }
            }
            $this->setContent($this->options);
        }
        return parent::render();
    }
        
    private function renderTextarea(){
        $this->setElementName('textarea');
        if(isset($this->value)){
            $this->setContent($this->value);
        }
        return parent::render();
    }

    public function renderInput() {
        $this->setAttribute('type', $this->type);
        if(isset($this->value)){
            $this->setAttribute('value', $this->value);
        }
        return parent::render();
    }
    
    public function renderCheckbox() {
        $this->setAttribute('type', 'checkbox');
        if(isset($this->value) && $this->value){
            $this->setAttribute('checked', true);
        }
        return parent::render();
    }
    
    public function renderInvalidElementTooltip() {
        return '<div id="'.$this->attributes['id'].'_invalid" class="formelement_invalid_icon tooltip">
                <div class="tooltipText">
                </div></div>';
    }
    
    public function renderTooltip() {
        if($this->tooltipText != ''){
            return '<div class="formelement-tt tooltip fa fa-info-circle"><div class="tooltipText">' .
                $this->tooltipText .
                '</div></div>';
        }
        return '';
    }
    
    public function renderLabel() {
        if($this->label != ''){
            return '<label for="' . $this->attributes['id'] . '">' . $this->label . '</label>';
        }
        return '';
    }
    
    public function setValue($val = null){
        $this->value = $val;
    }
        
    public function getValue($def = null){
        if(isset($this->value)){
            return $this->value;
        } else {
            return $def;
        }
    }
    
    public function valueIsEmpty() {
        return ($this->value === '' || $this->value === null)?true:false;
    }

    public function validate($validator){
        $this->valid = true;
        $value = $this->value;
//        if(isset($validator['required']) && $validator['required']['value'] == true && !isset($value)){
//            $this->validateMessages[] =
//                    (isset($validator['required']['errMsg']))?
//            $validator['required']['errMsg']:
//            'REQUIRED';
//            $valid = false;
//            return false; //gondolom ha ures, akkor nem is kell tovabb vizsgalni...
//        }
        
        if(isset($validator['beforeValidate'])){
            $validator['beforeValidate']($this,$validator);
        }
        
        if(isset($validator['emptyDisabled']) && $validator['emptyDisabled']['value'] === true && $this->valueIsEmpty()){
            $this->validateMessages[] =
                    (isset($validator['emptyDisabled']['errMsg']))?
                    $validator['emptyDisabled']['errMsg']:
                    'EMPTYVALUE';
            $this->valid = false;
            return false; //gondolom ha ures, akkor nem is kell tovabb vizsgalni...
        } elseif((!isset($validator['emptyDisabled']) || $validator['emptyDisabled']['value'] === false) && $this->valueIsEmpty()){
            $this->valid = true;
            return true;
        }
        
        if(isset($validator['function']) &&
                !$validator['function']['value']($this)){
            $this->validateMessages[] =
                    (isset($validator['function']['errMsg']))?
                    $validator['function']['errMsg']:
                    'FUNCTION';
            $this->valid = false;
        }
        
        if(isset($validator['regex']) && !preg_match($validator['regex']['value'], $value)){
            $this->validateMessages[] =
                    (isset($validator['regex']['errMsg']))?
                    $validator['regex']['errMsg']:
                    'REGEXP';
            $this->valid = false;
        }
        
        if(isset($validator['minLength']) && strlen($value) < $validator['minLength']['value']){
            $this->validateMessages[] =
                    (isset($validator['minLength']['errMsg']))?
                    $validator['minLength']['errMsg']:
                    'MINLEGTH';
            $this->valid = false;
        }
        
        if(isset($validator['maxLength']) && strlen($value) > $validator['maxLength']['value']){
            $this->validateMessages[] =
                    (isset($validator['maxLength']['errMsg']))?
                    $validator['maxLength']['errMsg']:
                    'MAXLENGTH';
            $this->valid = false;
        }
        
        if(isset($validator['valueList']) && !in_array($value, $validator['valueList']['value'])){
            $this->validateMessages[] =
                    (isset($validator['valueList']['errMsg']))?
                    $validator['valueList']['errMsg']:
                    'VALUELIST';
            $this->valid = false;
        }
        
        if(isset($validator['excludeList']) && in_array($value, $validator['excludeList']['value'])){
            $this->validateMessages[] =
                    (isset($validator['excludeList']['errMsg']))?
                    $validator['excludeList']['errMsg']:
                    'EXCLUDELIST';
            $this->valid = false;
        }
        
        return $this->valid;
        // regex, function, minlength, maxlength,
        // valueList, excludeList, required, emptyEnabled...
    }
    
    public function isValid() {
        return $this->valid;
    }
        
    public function getMessages() {
        return implode(', ', $this->validateMessages);
    }
    
}

<?php
namespace Modules\pubMap\Form;
use \System\Translator as tr;

class pubForm extends \System\AbstractClasses\abstractForm{
    public function __construct($action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'pubForm';
        
        $this->addElement('active',
            [
                'type' => 'checkbox',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'isactive'),
                'attributes' => [
                    'value' => 1,
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('image',
            [
                'type' => 'file',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'image'),
                'attributes' => [
                    'multiple' => false,
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
                
        $this->addElement('no_lead_image',
            [
                'type' => 'checkbox',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'noImage'),
                'attributes' => [
                    'class' => 'hideElements',
                    'value' => 1
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        $this->addElement('name',
            [
                'type' => 'text',
                'label' => tr::translateModule('pubMap', '', 'name'),
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('sef',
            [
                'type' => 'text',
                'label' => \System\Translator::translateAdmin('Labelll', 'sef'),
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('address',
            [
                'type' => 'text',
                'label' => \System\Translator::translateAdmin('Labelll', 'address'),
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('comment',
            [
                'type' => 'textarea',
                'label' => \System\Translator::translateAdmin('Labelll', 'description'),
                'attributes' => [
                    'class' => 'tinymce',
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('submit',
            [
                'type' => 'submit',
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
    }
    public function validateForm(){
//        $this->formElements['username']->validate([ //peldanak!!!!
//            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
//            'regex' => ['value'=> '/^.$/'],
//            'function' => ['value'=> function($element){ return false; }],
//            'minLength' => ['value'=> 30],
//            'maxLength' => ['value'=> 1],
//            'valueList' => ['value'=> ['wazemaki1', 'masik']],
//            'excludeList' => ['value'=> ['hal']],
//        ]);
            
        $this->formElements['image']->validate([
            'maxLength' => ['value'=> 50],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_ENCHARS_AND_NUMBERS .'/'],
        ]);
        
        
        $this->formElements['name']->validate([
            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
            'maxLength' => ['value'=> 60],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_HUCHARS_AND_PUNCTUATIONS .'/'],
        ]);
        
        $this->formElements['sef']->validate([
            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
            'maxLength' => ['value'=> 50],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_ENCHARS_AND_NUMBERS .'/'],
        ]);
        
        return $this->isValid();
    }
    
}

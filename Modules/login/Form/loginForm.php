<?php
namespace Modules\login\Form;
class loginForm extends \System\AbstractClasses\abstractForm{
    public function __construct($action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'loginForm';
        
        
        $this->addElement('username', // ezzel hivatkozunk a view fileban az elementre
            [
                'type' => 'text', // kotelezo
                'attributes' => [ // html attributumok
                    'placeholder' => \System\Translator::translateModule('login', 'login', 'username'),
                    'class' => 'box-element input-field input-field-text'
                ]
            ]);
                
        $this->addElement('password', // ezzel hivatkozunk a view fileban az elementre
            [
                'type' => 'password', // kotelezo
                'attributes' => [ // html attributumok
                    'placeholder' => \System\Translator::translateModule('login', 'login', 'password'),
                    'class' => 'box-element input-field input-field-text'
                ]
            ]);
                        
        $this->addElement('staylogin', // ezzel hivatkozunk a view fileban az elementre
            [
                'type' => 'checkbox', // kotelezo
                'attributes' => [ // html attributumok
                    'value' => 1
                ]
            ]);
                
        $this->addElement('login',
            [
                'type' => 'submit',
                'name' => 'send',
                'attributes' => [
                    'value' => \System\Translator::translateModule('login', 'login', 'login'),
                    'class' => 'submit-button'
                ]
            ]);
    }
    public function validateForm(){
//        $this->formElements['username']->validate([ //peldanak!!!!
//            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
//            'regex' => ['value'=> '/^.$/'],
//            'function' => ['value'=> function($val){ return false; }],
//            'minLength' => ['value'=> 30],
//            'maxLength' => ['value'=> 1],
//            'valueList' => ['value'=> ['wazemaki1', 'masik']],
//            'excludeList' => ['value'=> ['hal']],
//        ]);
        
                
//        $this->formElements['staylogin']->validate([
//            'valueList' => ['value'=> [1]],
//        ]);
        
        $this->formElements['username']->validate([
            'emptyDisabled' => ['value'=> true],
            'regex' => ['value'=> '/^[a-z][\w]+$/'],
            'minLength' => ['value'=> 3]
        ]);
        
        $this->formElements['password']->validate([
            'emptyDisabled' => ['value'=> true],
            'minLength' => ['value'=> 3]
        ]);
        
        return $this->isValid();
    }
    
}

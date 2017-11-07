<?php
namespace Admin\Form\usergroup;
class ugroupForm extends \System\AbstractClasses\abstractForm{
    public function __construct($action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'ugroupForm';

        $this->addElement('name',
            [
                'type' => 'text',
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'name'),
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);        
        $this->addElement('description',
            [   
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'description'),
                'type' => 'text',
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);
                        
        $this->addElement('admin',
            [
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'adminGroup'),
                'type' => 'checkbox',
                'attributes' => [
                    'value' => 1
                ]
            ]);
                
        $this->addElement('submit',
            [
                'type' => 'submit',
                'name' => 'send',
                'attributes' => [
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
        
        $this->formElements['name']->validate([
            'regex' => ['value'=> '/^[\w]{3,45}$/'],
        ]);
        
        $this->formElements['description']->validate([
            'maxLength' => ['value'=> 150],
        ]);
        
        return $this->isValid();
    }
    
}

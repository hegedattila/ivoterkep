<?php
namespace Admin\Form\route;
class routeForm extends \System\AbstractClasses\abstractForm{
    public function __construct($templates,$action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'routeForm';

        $this->addElement('route',
            [
                'type' => 'text',
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'route'),
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('params',
            [
                'type' => 'number',
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'params'),
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('template',
            [   
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'layout'),
                'type' => 'select',
                'options' => $templates,
                'nullOption' => '---',
                'attributes' => [
                    'class' => 'initChosen',
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
        
//        $this->formElements['name']->validate([
//            'regex' => ['value'=> '/^[\w]{3,45}$/'],
//        ]);
//        
//        $this->formElements['description']->validate([
//            'maxLength' => ['value'=> 150],
//        ]);
        
        return $this->isValid();
    }
    
}

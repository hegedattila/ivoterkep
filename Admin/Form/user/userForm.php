<?php
namespace Admin\Form\user;
class userForm extends \System\AbstractClasses\abstractForm{
    public function __construct($action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'userForm';
        
        $this->addElement('nick',
            [
                'type' => 'text',
              //  'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'nick'),
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);        
        $this->addElement('fullName',
            [   
             //   'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'fullname'),
                'type' => 'text',
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);        
        $this->addElement('email',
            [   
             //   'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'email'),
                'type' => 'text',
                'attributes' => [
                  //  'placeholder' => \System\Translator::translateModule('login', 'login', 'username')
                ]
            ]);
                        
        $this->addElement('langId',
            [
              //  'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'lang'),
                'type' => 'select',
                'options' => \System\LangHandler::getLangs(),
                'attributes' => [
                    'class' => 'initChosen',
                ]
            ]);
        
                                
        $this->addElement('groups',
            [
                'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'groups'),
                'type' => 'select',
                'options' => \System\UserGroupHandler::getGroups(),
                'attributes' => [
                    'multiple' => true,
                    'class' => 'initChosen',
                ]
            ]);
                                
        $this->addElement('settings',
            [
              //  'tooltip' => \System\Translator::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'settings'),
                'type' => 'textarea',
                'attributes' => [
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
        
        $this->formElements['nick']->validate([
            'emptyDisabled' => ['value'=> true,],
            'regex' => ['value'=> '/^[\w]{2,25}$/']
        ]);
            
        $this->formElements['fullName']->validate([
           // 'regex' => ['value'=> '/^.$/'],
            'maxLength' => ['value'=> 60]
        ]);
            
        $this->formElements['email']->validate([
            'emptyDisabled' => ['value'=> true],
            'regex' => ['value'=> '/^[\w-\.]+@[\w-\.]+\.[\w]{2,5}$/'],
        ]);
            
        $this->formElements['langId']->validate([
            'valueList' => ['value'=> \System\LangHandler::getLangs('ID')],
        ]);
//        $this->formElements['username']->validate([ //peldanak!!!!
//            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
//            'regex' => ['value'=> '/^.$/'],
//            'function' => ['value'=> function($val){ return false; }],
//            'minLength' => ['value'=> 30],
//            'maxLength' => ['value'=> 1],
//            'valueList' => ['value'=> ['wazemaki1', 'masik']],
//            'excludeList' => ['value'=> ['hal']],
//        ]);
        
        
        return $this->isValid();
    }
    
}

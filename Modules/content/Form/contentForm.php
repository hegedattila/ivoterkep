<?php
namespace Modules\content\Form;
use \System\Translator as tr;

class contentForm extends \System\AbstractClasses\abstractForm{
    public function __construct($action = '') {
        $this->formMethod = "POST";
        $this->formAction = $action;
        $this->formAttributes['id'] = 'contentForm';
        
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
        
        $this->addElement('publish_date',
            [
                'type' => 'text',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'pubdate'),
                'attributes' => [
                  //  'pattern' => \System\StringHandler::REGEX_DB_DATE,
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('unpublish_date',
            [
                'type' => 'text',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'unpubdate'),
                'attributes' => [
                    'pattern' => \System\StringHandler::REGEX_DB_DATE,
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('lead_image',
            [
                'type' => 'file',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'leadimage'),
                'attributes' => [
                    'multiple' => true,
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
                
        $this->addElement('no_lead_image',
            [
                'type' => 'checkbox',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'noleadimage'),
                'attributes' => [
                    'class' => 'hideElements',
                    'value' => 1
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('category',
            [
                'type' => 'select',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'label' => \System\Translator::translateAdmin('Labelll', 'categ'),
                'options' => [1 => 'Cat1', 2 => 'Cat2'], // validalni!!
                'nullOption' => 'Válassz, vagy ne',
                'attributes' => [
                    'class' => 'initChosen',
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $defLangId = \System\LangHandler::getDefaultLang();
        $langs = \System\LangHandler::getLangs('ID');
        $nonRequiredLangs = array_diff($langs, [$defLangId]);
                
        $this->addElement('enabled',
            [
                'type' => 'checkbox',
              //  'tooltip' => tr::translateAdmin('tooltip', 'tippp'),
                'isArray' => $nonRequiredLangs,
                'attributes' => [
                 //   'class' => 'inTab',
                    'value' => 1
                ]
            ]);
        
        $this->addElement('title',
            [
                'type' => 'text',
                'label' => tr::translateModule('content', '', 'title'),
                'isArray' => $langs,
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);

        $this->addElement('sef',
            [
                'type' => 'text',
                'label' => \System\Translator::translateAdmin('Labelll', 'sef'),
                'isArray' => $langs,
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('keywords',
            [
                'type' => 'textarea',
                'label' => \System\Translator::translateAdmin('Labelll', 'keywords'),
                'isArray' => $langs,
                'attributes' => [
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('lead',
            [
                'type' => 'textarea',
                'label' => \System\Translator::translateAdmin('Labelll', 'lead'),
                'isArray' => $langs,
                'attributes' => [
                    'style' => 'height:200px',
                  //  'placeholder' => tr::translateModule('login', 'login', 'username')
                ]
            ]);
        
        $this->addElement('content',
            [
                'type' => 'textarea',
                'label' => \System\Translator::translateAdmin('Labelll', 'content'),
                'isArray' => $langs,
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
        $defLangId = \System\LangHandler::getDefaultLang();
    //   $langs = \System\LangHandler::getLangs('ID');
     //   $nonRequiredLangs = array_diff($langs, [$defLangId]);
        
        $enLangArr = $this->formElements['enabled'];
        $beforeFunc = function($elem,&$validator) use ($enLangArr, $defLangId){
                    $actualLangId = $elem->inArrayKey;
                    if( (isset($enLangArr[$actualLangId]) && $enLangArr[$actualLangId]->getValue()) ||
                            $actualLangId == $defLangId ){
                        $validator['emptyDisabled'] = ['value' => true];
                    }
                };
        
//        $this->formElements['username']->validate([ //peldanak!!!!
//            'emptyDisabled' => ['value'=> true, 'errMsg'=>'Üres ÉRték!'],
//            'regex' => ['value'=> '/^.$/'],
//            'function' => ['value'=> function($element){ return false; }],
//            'minLength' => ['value'=> 30],
//            'maxLength' => ['value'=> 1],
//            'valueList' => ['value'=> ['wazemaki1', 'masik']],
//            'excludeList' => ['value'=> ['hal']],
//        ]);
            
        $this->formElements['publish_date']->validate([
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_DB_DATE .'/'],
        ]);
            
        $this->formElements['unpublish_date']->validate([
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_DB_DATE .'/'],
        ]);
            
        $this->formElements['lead_image']->validate([
            'maxLength' => ['value'=> 50],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_ENCHARS_AND_NUMBERS .'/'],
        ]);
        
        $this->validateElement('title',[   // többnyelvű / többféle input elemeknél ezt használd!!
            'maxLength' => ['value'=> 50],
            'beforeValidate' => $beforeFunc,
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_HUCHARS_AND_PUNCTUATIONS .'/'],
        ]);
        
        $this->validateElement('sef',[
            'maxLength' => ['value'=> 50],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_ENCHARS_AND_NUMBERS .'/'],
        ]);
        
        $this->validateElement('keywords',[
            'maxLength' => ['value'=> 50],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_HUCHARS_AND_NUMBERS .'/'],
        ]);
        
        $this->validateElement('lead',[
            'maxLength' => ['value'=> 500],
            'regex' => ['value'=> '/'. \System\StringHandler::REGEX_HUCHARS_AND_PUNCTUATIONS .'/'],
        ]);
        
        $this->validateElement('content',[
            'beforeValidate' => $beforeFunc,
        ]);
        
        
        return $this->isValid();
    }
    
}

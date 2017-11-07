<?php
namespace Modules\module1\Form;
class tplBuilder1Form extends \System\AbstractClasses\abstractForm{
    public function __construct() {
        
        $this->addElement('elso', // ezzel hivatkozunk a view fileban az elementre
        [
            'type' => 'text', // kotelezo
            'attributes' => [ // html attributumok
                'class' => 'eee',
                'placeholder' => 'elsooooo'
            ]
        ]);
                
        $this->addElement('masodik', // ezzel hivatkozunk a view fileban az elementre
        [
            'type' => 'text', // kotelezo
            'attributes' => [ // html attributumok
                'class' => 'eee',
                'placeholder' => 'masodik'
            ]
        ]);
    }
    
}

<?php
namespace Modules\module1\Form;
class tplBuilder2Form extends \System\AbstractClasses\abstractForm{
    public function __construct() {
        
        $this->addElement('elso', // ezzel hivatkozunk a view fileban az elementre
        [
            'label' => 'Elso attr',
            'type' => 'text', // kotelezo
            'attributes' => [ // html attributumok
                'class' => 'eee',
                'placeholder' => 'elsooooo'
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
    }
    
}

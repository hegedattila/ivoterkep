<?php

return [
    'label' => 'MMModule1',
    'subMenu' => [
        'module1Cont' => [
            'label' => 'EditVagyMi',
            'permission' => 'mod1Edit',
            'action' => 'module1/admin/456789/sadf',
        ],
        'module1masikIzee' => [
            'permission' => 'mod1Edit',
            'subMenu' => [
                'module1Cont1' => [
                    'permission' => 'mod1Edit',
                    'action' => 'module1/admin', // listaz valamit
                    'label' => 'ADminListProba'
                ],
                'module1masikIzee1' => [
                    'permission' => 'mod1Edit',
                    'action' => 'module1/admin/bigyokaa',
                    'label' => 'Label: Sub2'
                ],
            ],
            'label' => 'Label: Moduuuule1'
        ]
    ]
];

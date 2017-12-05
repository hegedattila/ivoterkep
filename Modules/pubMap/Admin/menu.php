<?php

return [
    'label' => 'Kocsmatérkép-modul',
    'permission' => 'handlePubMap',
    'subMenu' => [
        [
            'label' => 'Kocsmák',
            'action' => 'pubMap/admin',
        ],
        [
            'label' => 'Új kocsma',
            'action' => 'pubMap/admin/form/add',
            
        ]
    ]
];

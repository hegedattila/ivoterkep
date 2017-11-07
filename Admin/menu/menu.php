<?php

return [
    'icon' => 'cogs',
    'label' => \System\Translator::translateAdmin( 'menu', 'system'),
    'subMenu' => [
        'admin' =>[
            'icon' => 'id-card-o',
            'label' => \System\Translator::translateAdmin( 'menu', 'admin'),
            'subMenu' => [
//                'privileges' => [
//                    'icon' => 'unlock-alt',
//                    'label' => \System\Translator::translateAdmin( 'menu', 'permissions'),
//                    'permission' => 'handlePerms',
//                    'action' => 'admin/permission',
//                ],
                'setperms' => [
                    'icon' => 'unlock-alt',
                    'permission' => 'setPermToGroup',
                    'label' => 'Jogosultságkezelés',
                    'action' => 'admin/permission/permToGroupForm',
                ],
                'templates' => [
                    'icon' => 'columns',
                    'permission' => 'handleTemplates',
                    'label' => 'Template kezelés',
                    'action' => 'admin/template',
                ],
                'routes' => [
                    'icon' => 'map-signs',
                    'permission' => 'handleRoutes',
                    'label' => 'URL kezelés',
                    'action' => 'admin/route',
                ]
            ]
        ],
        'users' => [
            'icon' => 'user',
            'label' => \System\Translator::translateAdmin( 'menu', 'users'),
            'permission' => 'handleUsers',
            'action' => 'admin/user',
        ],
        'groups' => [
            'icon' => 'users',
            'permission' => 'handleUgroups',
            'label' => \System\Translator::translateAdmin( 'menu', 'userGroups'),
            'action' => 'admin/usergroup',
        ],
//                'setperms' => [
//                    'permission' => 'setPermToGroup',
//                    'label' => 'Jogosultságkezelés',
//                    'action' => 'admin/permission/permToGroupForm',
//                ]
        
    ]
];

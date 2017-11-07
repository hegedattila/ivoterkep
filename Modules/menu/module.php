<?php
return [
    'controllers' => [
        'menu' => '\Modules\menu\Controller\menuController'
    ],
    'routes' => [
        'controller' => 'menu', //default controller.. de ezt felulirhatod lejjebb
        'action' => 'showMenu',
        'childRoutes' => [
            'admin' => [
                'action' => 'jsonAdminMenu',
            ],
        ]
    ]
];
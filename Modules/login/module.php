<?php
return [
    'controllers' => [
        'login' => '\Modules\login\Controller\loginController'
    ],
    'routes' => [
        'controller' => 'login',
        'action' => 'showLoginForm',
        'childRoutes' => [
            'sendLogin' => [
                'action' => 'login',
            ],
            'logoutBtn' => [
                'action' => 'showLogout',
            ],
            'sendLogout' => [
                'action' => 'logout',
            ],
        ]
    ],
    'tplFormInfo' => [
        'login' => [
            'displayName'=> '_Bejelentkezés',
            'actionRoute' => 'logoutBtn',
            ],
    ],
];
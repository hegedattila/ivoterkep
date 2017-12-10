<?php
return [
    'controllers' => [
        'login' => '\Modules\login\Controller\loginController'
    ],
    'routes' => [
        'controller' => 'login',
        'action' => 'showLoginLogout',
        'parameters' => [
            'loginFormAction'=>'/____/login/sendLogin',
            'logoutFormAction'=>'/____/login/sendLogout'
        ],
        'childRoutes' => [
            'sendLogin' => [
                'action' => 'login',
            ],
            'loginForm' => [
                'action' => 'showLoginForm',
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
            'actionRoute' => 'showLoginLogout',
            ],
    ],
];
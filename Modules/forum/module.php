<?php
return [
    'controllers' => [
        'izej' => '\Modules\module1\Controller\izej',
        'izej1' => '\Modules\module1\Controller\izej1',
        'admin' => '\Modules\module1\Controller\Admin\module1Controller'
    ],
    'routes' => [
        'controller' => 'izej', //default controller.. Kotelezo... de ezt felulirhatod lejjebb
        'action' => 'defult',
        'childRoutes' => [
            'admin' => [
                'permission' => 'admin',
                'controller' => 'admin',
                'action' => 'list',
                'childRoutes' => [
                    'tplForm' => [
                        'childRoutes' => [
                            'form1' => [
                                'action' => 'tplForm1',
                            ],
                            'form2' => [
                                'action' => 'tplForm2',
                            ],
                            'form3' => [
                                'action' => 'tplForm3',
                            ],
                        ]
                    ],
                    '@' => [
                        'paramName' => 'par',
                        'action' => 'list',
                        'childRoutes' => [
                            'asd' => [
                                'action' => 'list',
                            ],
                        ]
                    ],
                    'delete'=> [
                        'action' => 'delete',
                        'childRoutes' => [
                            '@' => [
                                'paramName' => 'delteble',
                            ],
                        ]
                    ],
                ]
            ],
            'wer' => [
                'action' => 'wera',
                'childRoutes' => [
                    'sdf' => [
                        'action' => 'sdfa',
                    ],
                ]
            ],
            'mitakarok' => [
                'action' => 'ajax1',
                'childRoutes' => [
                    '2' => [
                        'action' => 'ajax2',
                    ],
                    '@' => [
                        'paramName' => 'par1', //parameter a route-ban
                        'action' => 'ajax1',
                    ],
                ]
            ],
        ]
    ],
    'tplFormInfo' => [
        'sub1' => [
            'displayName'=> 'Elso Modul - 1',
            'formRoute' => 'admin/tplForm/form1',
            'actionRoute' => 'route1',
            ],
        'sub2' => [
 //           'displayName'=> 'Elso Modul - 2',
            'formRoute' => 'admin/tplForm/form2',
            'actionRoute' => 'route1',
            ],
        'sub3' => [
            'displayName'=> 'Elso Modul - 3',
            'actionRoute' => 'route1',
//            'formRoute' => 'admin/tplForm/form3',
            ],
    ],
    'listTemplates' => [
        'lista1' => [
          //  'mezo1' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L1'],
            'mezo2' => ['type' => 'number', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L2'],
            'mezo3' => ['type' => 'datetime', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L3'],
            'mezo4' => ['type' => 'bool', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L4'],
            'mezo5' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L5'],
      //      'mezo6' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L6'],
        ],
        'lista2' => []
    ],
 //   'tplBuilder' => true, //DEPR
    'views' => [
        'view' => 'Valahogy', //lang fordítás
        'asd' => 'Mashogy', //lang fordítás
    ]
];
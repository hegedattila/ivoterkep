<?php
return [
    'controllers' => [
        'front' => '\Modules\pubMap\Controller\pubMap',
        'admin' => '\Modules\pubMap\Controller\Admin\adminController'
    ],
    'routes' => [
        'controller' => 'front', //default controller.. Kotelezo... de ezt felulirhatod lejjebb
        'childRoutes' => [
            'admin' => [
                'permission' => 'handlePubMap',
                'controller' => 'admin',
                'action' => 'list',
                'childRoutes' => [
                    'tplForm' => [
                        'action' => 'listForm',
                    ],
                    'form' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'addForm',
                                'permission' => 'addContent',
                            ],
                            '@number' => [
                                'action' => 'editForm',
                                'permission' => 'editContent',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'save' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'add',
                                'permission' => 'addContent',
                            ],
                            '@number' => [
                                'action' => 'edit',
                                'permission' => 'editContent',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'delete' => [
                        'action' => 'delete',
                        'permission' => 'deleteContent',
                        'childRoutes' => [
                            '@number' => [
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                ]
            ],
            'showMap' => [
                'action' => 'showMap'
            ],
            'showPub' => ['childRoutes' => [
                    '@' => [
                        'paramName' => 'pub'
                    ]
                ],
                'action' => 'showPub'
            ],
            'getList' => [
                'action' => 'getList'
            ],
            'deletePub' => [ // frontEnd-en kocsma törlése... 
                'permission' => 'loggedIn', // Persze ellenőrizzük ezen felül, hogy az próbál-e törölni, aki létrehozta  kocsmát
                'childRoutes' => [
                    '@number' => [
                        'action' => 'delete',
                        'paramName' => 'id', //parameter a route-ban
                    ]
                ]
            ],
            'pubForm' => [
                'permission' => 'loggedIn',
                'action' => 'showPubForm',
                'childRoutes' => [
                    'edit' => [
                        'childRoutes' => [
                            '@' => [
                                'paramName' => 'id', //parameter a route-ban
                            ]
                        ]
                    ]
                ]
            ],
        ]
    ],
    'tplFormInfo' => [
        'list' => [
            'displayName'=> 'Kocsmalista',
            'formRoute' => 'admin/tplForm/listForm', // Az admin felületen a template összerakóban megjelenő form
            'actionRoute' => 'showList',
        ],
        'pub' => [
            'displayName'=> 'Kocsma adatlap',
        //    'formRoute' => 'admin/tplForm/form2',
            'actionRoute' => 'showPub',
        ],
        'map' => [
            'displayName'=> 'Kocsma térkép',
        //    'formRoute' => 'admin/tplForm/form2',
            'actionRoute' => 'showMap',
        ],
        'editPub' => [
            'displayName'=> 'Kocsma szerkesztése form',
//            'formRoute' => 'admin/tplForm/form3',
            'actionRoute' => 'pubForm/edit',
        ],
        'newPub' => [
            'displayName'=> 'Új kocsma form',
//            'formRoute' => 'admin/tplForm/form3',
            'actionRoute' => 'pubForm',
        ],
    ],
    'listTemplates' => [ // Az admin felületen lévő mezők
        'pubList' => [
          //  'mezo1' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L1'],
            'mezo2' => ['type' => 'number', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L2'],
            'mezo3' => ['type' => 'datetime', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L3'],
            'mezo4' => ['type' => 'bool', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L4'],
            'mezo5' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L5'],
      //      'mezo6' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L6'],
        ],
    ],
    'views' => [
        'view' => 'Valahogy', //lang fordítás
        'asd' => 'Mashogy', //lang fordítás
    ]
];
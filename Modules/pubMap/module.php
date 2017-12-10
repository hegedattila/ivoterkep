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
            'showFilter' => [
                'action' => 'showFilter'
            ],
            'showPub' => ['childRoutes' => [
                    '@' => [
                        'paramName' => 'pub'
                    ]
                ],
                'action' => 'showPub'
            ],
            'getList' => [
                'action' => 'pubList'
                // POST-ban kap majd paramétereket
            ],
//            'deletePub' => [ // frontEnd-en kocsma törlése... 
//                'permission' => 'loggedIn', // Persze ellenőrizzük ezen felül, hogy az próbál-e törölni, aki létrehozta  kocsmát
//                'childRoutes' => [
//                    '@number' => [
//                        'action' => 'delete',
//                        'paramName' => 'id', //parameter a route-ban
//                    ]
//                ]
//            ],
//            'pubForm' => [
//                'permission' => 'loggedIn',
//                'action' => 'showPubForm',
//                'childRoutes' => [
//                    'edit' => [
//                        'childRoutes' => [
//                            '@' => [
//                                'paramName' => 'id', //parameter a route-ban
//                            ]
//                        ]
//                    ]
//                ]
//            ],
        ]
    ],
    'tplFormInfo' => [
        'list' => [
            'displayName'=> 'Kocsmalista',
            'actionRoute' => 'showList',
        ],
        'pub' => [
            'displayName'=> 'Kocsma adatlap',
            'actionRoute' => 'showPub',
        ],
        'map' => [
            'displayName'=> 'Kocsma térkép',
            'actionRoute' => 'showMap',
        ],
        'editPub' => [
            'displayName'=> 'Kocsma szerkesztése form',
            'actionRoute' => 'pubForm/edit',
        ],
        'newPub' => [
            'displayName'=> 'Új kocsma form',
            'actionRoute' => 'pubForm',
        ],
        'showFilter' => [
            'displayName'=> 'Kocsma szűrő',
            'actionRoute' => 'showFilter',
        ],
    ],
    'listTemplates' => [ // Az admin felületen lévő mezők
        'pubList' => [
          //  'mezo1' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L1'],
            'id' => ['type' => 'number', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'ID'],
            'name' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'Name'],
            'address' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'Address'],
            'sef' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'SEF'],
      //      'mezo6' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L6'],
        ],
    ],
    'views' => [
        'view' => 'Valahogy', //lang fordítás
        'asd' => 'Mashogy', //lang fordítás
    ]
];
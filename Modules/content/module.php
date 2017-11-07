<?php
return [
    'controllers' => [
        'admin' => '\Modules\content\Controller\Admin\contentController',
        'frontList' => '\Modules\content\Controller\FrontEnd\contentListController',
        'front' => '\Modules\content\Controller\FrontEnd\contentController'
    ],
    'routes' => [
        'controller' => 'front',
        'action' => 'show',
        'childRoutes' => [
            'admin' => [
                'permission' => 'handleContents',
                'controller' => 'admin',
                'action' => 'list',
                'childRoutes' => [
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
                    'tmceupload' => [
                        'action' => 'tmceUpload',
                     //   'permission' => 'addContent',
                    ],
                    'tplForm' => [
                        'permission' => 'addContent',
                        'childRoutes' => [
                            '@' => [
                                'paramName' => 'section',
                                'action' => 'tplForm',
                            ],
                        ]
                    ],
                ]
            ],
            'list' => [
                'controller' => 'frontList',
                'action' => 'show',
            ],
            'show' => [
                'action' => 'show',
            ]
        ]
    ],
    'tplFormInfo' => [
        'content' => [
            'displayName'=> '_Tartalom',
            'formRoute' => 'admin/tplForm/content',
            'actionRoute' => 'show',
            ],
        'list' => [
            'displayName'=> '_Tartalom lista',
            'formRoute' => 'admin/tplForm/list',
            'actionRoute' => 'list',
            ],
    ],
    'listTemplates' => [
        'contents' => [
            'title' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => '_title'],
            'nick'=>['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => '_crby'],
            'active' => ['type' => 'bool', 'emptyValue' => false, 'sortable' => true, 'searchable' => false,'label' => '_active'],
            'created_date' => ['type' => 'datetime', 'sortable' => true, 'searchable' => true,'label' => '_crdate'],
        ]
    ],
    'views' => [
        'view' => 'Valahogy', //lang fordítás
        'asd' => 'Mashogy', //lang fordítás
    ],
    'defaults' => [
        'view' => 'def'
    ]
];
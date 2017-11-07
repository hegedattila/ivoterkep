<?php
return [
    'controllers' => [
        'route' => '\Admin\Controller\route\routeController',
        'template' => '\Admin\Controller\template\templateController',
        'permission' => '\Admin\Controller\permission\permissionController',
        'usergroup' => '\Admin\Controller\usergroup\usergroupController',
        'modules' => '\Admin\Controller\module\moduleController',
        'users' => '\Admin\Controller\users\userController'
    ],
    'routes' => [
        'permission' => 'handleSystem',
        'controller' => 'permission',
        'action' => 'list',
        'childRoutes' => [
            'permission' => [
                'permission' => 'handlePerms',
                'controller' => 'permission',
                'action' => 'list',
                'childRoutes' => [
                    'list' => [
                    ],
                    'permToGroupForm' => [
                        'action' => 'permToGroupForm',
                    ],
                    'getPermissionsToGroup' => [
                        'action' => 'getPermissionsToGroup',
                    ],
                    'setPermissionToGroup' => [
                        'permission' => 'setPermToGroup',
                        'action' => 'setPermissionToGroup',
                    ]
                ]
            ],
            'usergroup' => [
                'permission' => 'handleUgroups',
                'controller' => 'usergroup',
                'action' => 'list',
                'childRoutes' => [
                    'list' => [
                    ],
                    'form' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'addForm',
                                'permission' => 'addUserGroup',
                            ],
                            '@number' => [
                                'action' => 'editForm',
                                'permission' => 'editUserGroup',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'save' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'add',
                                'permission' => 'addUserGroup',
                            ],
                            '@number' => [ //id
                                'action' => 'edit',
                                'permission' => 'editUserGroup',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'delUg' => [
                        'permission' => 'delUserGroup',
                        'action' => 'delete', //tomeges
                        'childRoutes' => [
                            '@number' => [
                                'paramName' => 'id' //egyeni
                            ]
                        ]
                    ],
                    
                ]
            ],
            'template' => [
                'permission' => 'handleTemplates',
                'controller' => 'template',
                'action' => 'list',
                'childRoutes' => [
                    'form' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'addForm',
                                'permission' => 'addTemplate',
                            ],
                            '@number' => [
                                'action' => 'editForm',
                                'permission' => 'editTemplate',
                                'paramName' => 'id'
                            ],
                            'getView' => [
                                'action' => 'viewToForm',
                            ],
                        ]
                    ],
                    'save' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'add',
                                'permission' => 'addTemplate',
                            ],
                            '@number' => [
                                'action' => 'edit',
                                'permission' => 'editTemplate',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'delete' => [
                        'permission' => 'delTemplate',
                        'childRoutes' => [
                            '@number' => [
                                'action' => 'delete',
                                'paramName' => 'id'
                            ]
                        ]
                    ]
                ]
            ],
            'route' => [
                'permission' => 'handleRoutes',
                'controller' => 'route',
                'action' => 'list',
                'childRoutes' => [
                    'form' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'addForm',
                                'permission' => 'addRoute',
                            ],
                            '@number' => [
                                'action' => 'editForm',
                                'permission' => 'editRoute',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'save' => [
                        'childRoutes' => [
                            'add' => [
                                'action' => 'add',
                                'permission' => 'addRoute'
                            ],
                            '@number' => [ //id
                                'action' => 'edit',
                                'permission' => 'editRoute',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'delete' => [
                        'permission' => 'delRoute',
                        'childRoutes' => [
                            '@number' => [
                                'action' => 'delete',
                                'paramName' => 'id'
                            ]
                        ]
                    ]
                ]
            ],
            'user' => [
                'permission' => 'handleUsers',
                'controller' => 'users',
                'action' => 'list',
                'childRoutes' => [
                    'delete' => [
                        'childRoutes' => [
                            '@number' => [
                                'paramName' => 'id',
                            ]
                        ],
                        'permission' => 'deleteUser',
                        'action' => 'delete',
                    ],
                    'form' => [
                        'action' => 'form',
                        'childRoutes' => [
                            '@number' => [
                                'permission' => 'editUser',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                    'save' => [
                        'action' => 'save',
                        'childRoutes' => [
                            '@number' => [ //id
                                'permission' => 'editUser',
                                'paramName' => 'id'
                            ]
                        ]
                    ],
                ]
            ],
            'languages' => [
                'permission' => 'handleLangs',
            ],
            'module' => [
                'permission' => 'handleModules',
                'controller' => 'modules',
                'action' => 'list',
                'childRoutes' => [
                    'getList' => [
                    ],
                    'getForm' => [
                        'action' => 'getModuleTplForm'
                    ],
                ]
            ],
        ]
    ],
    'listTemplates' => [
        'permissions' => [
            'name' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'L2'],
            'description' => ['type' => 'text', 'emptyValue' => '', 'searchable' => true, 'label' => 'L3']
        ],
        'usergrps' => [
            'name' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true, 'label' => 'L2'],
            'description' => ['type' => 'text', 'emptyValue' => '', 'label' => 'L3'],
            'adminAccess' => ['type' => 'bool', 'emptyValue' => '', 'sortable' => true, 'label' => 'admin'],
        ],
        'users' => [ //'nick','fullName','email','regDate','lastDate'
            'nick' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true, 'label' => 'L2'],
            'fullName' => ['type' => 'text', 'emptyValue' => '--kitudja--', 'sortable' => true, 'searchable' => true, 'label' => 'L3'],
            'email' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => 'admin'],
            'regDate' => ['type' => 'datetime', 'emptyValue' => '', 'sortable' => true,'label' => 'admin'],
            'lastDate' => ['type' => 'datetime', 'emptyValue' => '', 'sortable' => true,'label' => 'admin'],
        ],
        'routes' => [
            'route' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true, 'label' => '_rt'],
            'name' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => '_name'],
            'parameters' => ['type' => 'number', 'emptyValue' => '-', 'sortable' => true, 'searchable' => true,'label' => '_pars'],
        ],
        'templates' => [
            'name' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true, 'label' => '_name'],
            'lname' => ['type' => 'text', 'emptyValue' => '', 'sortable' => true, 'searchable' => true,'label' => '_lname'],
        ]
    ]
];
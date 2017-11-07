<?php
use \System\Translator as tr;

return [
    'label' => tr::translateModule('content', 'module', 'modName'),
    'permission' => 'handleContent',
    'subMenu' => [
        [
            'label' => tr::translateModule('content', 'module', 'contentsList'),
            'permission' => 'contentsList',
            'action' => 'content/admin',
        ],
        [
            'label' => tr::translateModule('content', 'module', 'newContent'),
            'permission' => 'addContent',
            'action' => 'content/admin/form/add',
        ],
    ]
];

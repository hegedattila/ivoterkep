<?php

return [
    // ---- CONTENT
    'content' => [
        'leadImage' => [
            'mode' => \System\UploadHandler::UPLOADER_TYPE_IMAGE,
            'defFilename' => 'lead',
          //  'generateFilename' => \System\Uploaders\AbstractUploader::GEN_ORIG_DATE,
            'acceptFormats' => [
                \System\FileHandler::FORMAT_XBM,
                \System\FileHandler::FORMAT_GIF,
                \System\FileHandler::FORMAT_JPEG_JPG_JPE,
                \System\FileHandler::FORMAT_PNG,
            ],
            'uploaderConf' => [
                'minW' => 500,
               // 'minH' => 500,
                'saveFiles' => [
                    'lim' => [
                   //     'overwrite' => true,
                    //    'addPath' => 'dbgt',
//                        'addFn' => '_bella',
                        'resizeToH' => 300,
                        'resizeToW' => 300,
                        'convertTo' => \System\Uploaders\ImageUploader::OUT_TYPE_JPG,
                    ]
                ],
            ],
//            'newExt' => 'asd',
            'maxSize' => 200000,
            'targetPath' => 'public/upload',
        ]
    ],
    // ---- /CONTENT
];

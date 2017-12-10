<?php

namespace System;
use System\Uploaders ;

class UploadHandler {
    
    const ERR_UPL_1 = 'php.ini max file size exceeded';
    const ERR_UPL_2 = 'html form max file size exceeded';
    const ERR_UPL_3 = 'file upload was only partial';
    const ERR_UPL_4 = 'no file was attached';
    
    const ERR_INV_FORMAT = 'Invalid format';
    const ERR_FILESIZE = 'Too big filesize';
    const ERR_UPLOADER = 'Invalid uploader';
    const ERR_NO_FILES = 'No files found';
    const ERR_UNDEFINED = 'Undefined error';
    
    const UPLOADER_TYPE_IMAGE = 1;
    
    private $config = [];
    private $files = [];
    private $uploader = null;
    private $uploadPath = '/';
    private $messages;
    private $uploadedFiles = [];
    public $error = false;
    private $multipleUploaders = [];
    
    public function __construct($upl_type, $inputNames, $additionalPath = '', $config = []){
        $this->config = array_merge_recursive(
            \System\ConfigLoader::getConfig('uploadConfig', $upl_type),
            $config);
        
        $this->buildPath($additionalPath);
        
        $this->setFiles($inputNames);
        
        $this->setUploader();
    }
    
    public function upload(){
        if($this->error){
            return false;
        }
        if(!$this->uploader || !$this->uploader instanceof \System\Uploaders\AbstractUploader){
            $this->error = true;
            $this->messages = self::ERR_UPLOADER;
            return false;
        }
        foreach ($this->files as $key => $file) {
            if(in_array($key, $this->multipleUploaders)){ //multi uploader
                foreach ($file as $multi_key => $multi_file) {
                    if( !$this->checkErrors($multi_key,$multi_file) ){
                        $this->uploader->setFile($multi_file);
                        $this->configUploader();

                        if( $this->uploader->upload() ){
                            $this->uploadedFiles[$key][$multi_key] = $this->uploader->getSavedFilename();
                        } else {
                            $this->error = true;
                            $this->messages[$key][$multi_key] = $this->uploader->getMessages() || self::ERR_UNDEFINED;
                        }
                    }
                }
            } else {
                if(!$this->checkErrors($key,$file)){
                    $this->uploader->setFile($file);
                    $this->configUploader();

                    if( $this->uploader->upload() ){
                        $this->uploadedFiles[$key] = $this->uploader->getSavedFilename();
                    } else {
                        $this->error = true;
                        $this->messages[$key] = $this->uploader->getMessages() || self::ERR_UNDEFINED;
                    }
                }
            }
        }
        return !$this->error;
    }
    
    private function setUploader() {
        if(class_exists($this->config['uploader'])){
            $this->uploader = new $this->config['uploader'](
                        $this->config['uploaderConf'],
                        $this->uploadPath
                    );
        }
        
//        switch ($this->config['mode']) {
//            case self::UPLOADER_TYPE_IMAGE:
//                $this->uploader = new Uploaders\ImageUploader(
//                        $this->config['uploaderConf'],
//                        $this->uploadPath
//                    );
//                break;
////            case self::UPLOADER_TYPE_FILE:
////                $this->uploader = new Uploaders\FileUploader(
////                        $this->config['uploaderConf'],
////                        $this->uploadPath
////                    );
////                break;
//        }
    }
    
    private function configUploader() {
        if(isset($this->config['defFilename'])){
            $this->uploader->setFilename($this->config['defFilename']);
        } elseif(isset($this->config['generateFilename'])) {
            $this->uploader->generateFilename($this->config['generateFilename']);
        }

        if(isset($this->config['newExt'])){
            $this->uploader->setExtension($this->config['newExt']);
        }
    }
    
    private function setFiles($names) {
        if(!is_array($names)){
            $names = [$names];
        }
        
        foreach ($names as $name) {
            if(isset($_FILES[$name]) && is_array($_FILES[$name])){
                if(is_array($_FILES[$name]['name'])){
                    $this->files[$name] = self::reArrayFiles($_FILES[$name]);
                    $this->multipleUploaders[] = $name;
                } else {
                    $this->files[$name] = $_FILES[$name];
                }
            }
        }
        
        if(count($this->files) === 0){
            $this->messages = self::ERR_NO_FILES;
            $this->error = true;
            return false;
        }
        return true;
    }
    
    private static function reArrayFiles($orig) { // multiple fileInput

        $dest = [];
        $file_count = count($orig['name']);
        $file_keys = array_keys($orig);

        for ($i = 0; $i < $file_count; $i++) {
            foreach ($file_keys as $key) {
                $dest[$i][$key] = $orig[$key][$i];
            }
        }
        return $dest;
    }
    
    private function buildPath($additionalPath){
        $this->uploadPath = $this->config['targetPath'] . '/' . $additionalPath;
    }
    
    public function getMessage($input = null) {
        if(isset($input) && isset($this->messages[$input])){
            return $this->messages[$input];
        }
        return $this->messages;
    }
    
    private function checkErrors($key,$file) {
//        if(is_uploaded_file($file['tmp_name'])){
//            $this->messages[$key] = 'Not HTTP upload';
//            $this->error = true;
//            return true;
//        }
        if($file['error'] > 0){
            $this->messages[$key] = constant('self::ERR_UPL_' . $file['error']);
            $this->error = true;
            return true;
        }
        if(isset($this->config['acceptFormats']) && !in_array($file['type'], $this->config['acceptFormats'])){
            $this->messages[$key] = self::ERR_INV_FORMAT;
            $this->error = true;
            return true;
        }
        if(isset($this->config['maxSize']) && $file['size'] > $this->config['maxSize']){
            $this->messages[$key] = self::ERR_FILESIZE;
            $this->error = true;
            return true;
        }
        return false;
    }
    
    public function getSavedFilenames($input = null) {
        if(isset($input) && isset($this->uploadedFiles[$input])){
            return $this->uploadedFiles[$input];
        }
        return $this->uploadedFiles;
    }
    
}

<?php

namespace System\Uploaders;

abstract class AbstractUploader {
    
    const ERR_UPLOAD_UNSUCCESS = 'Upload unsuccess';
    
    protected $conf;
    protected $file;
    protected $path;
    protected $filename;
    protected $additionalPath;
    protected $additionalFilename;
    protected $extension;
    public $error = false;
    protected $messages;
    protected $savedFilename;
    
    const GEN_ORIG = 0;
    const GEN_RANDOM = 1;
    const GEN_ORIG_DATE = 2;
    const GEN_STATIC = 3;

    public function __construct(array $conf, string $path = ''){
            //,$file = null, string $filename = null, int $generateFilename = null, string $ext = null) {
        $this->conf = $conf;
        $this->setPath($path);
//        if(isset($file)){
//            $this->setFile($file);
//        }
//        if(isset($filename)){
//            $this->setFilename($filename);
//        } elseif(isset($generateFilename)) {
//            $this->generateFilename($generateFilename);
//        } else {
//            $this->setOrigFn();
//        }
//        if(isset($ext)){
//            $this->setExtension($ext);
//        } else {
//            $this->setOrigExt();
//        }
    }
    
    public function setConfig(array $conf = []) {
        $this->conf = $conf;
    }

    public function setFile($file) {
        $this->file = $file;
        $this->setOrigExt();
        $this->setOrigFn();
    }

    public function setPath(string $path = '') {
        $this->path = trim($path,'/');
    }
    public function setAdditionalPath(string $addpath = '') {
        $this->additionalPath = trim($addpath,'/');
    }
    
    public function setFilename(string $filename = 'unnamed') {
        $this->generateFilename(3, $filename);
    }
    public function setAdditionalFilename(string $fn = '') {
        $this->additionalFilename = self::normalize($fn);
    }
        
    public function setExtension(string $ext) {
        $this->extension = self::normalize($ext, '');
    }
    
    public function setOrigFn() {
        $this->generateFilename();
    }
    
    public function setOrigExt() {
        $this->extension = self::normalize($this->getOrigExt());
    }
    
    public function generateFilename($mode = 0, $static = 'unnamed') {
        $fn = '';
        switch ($mode) {
            case self::GEN_RANDOM:
                $fn = self::generateRandomFilename();
                break;
            case self::GEN_ORIG_DATE:
                $fn = self::normalize($this->getOrigFn()) . '_' . time();
                break;
            case self::GEN_STATIC:
                $fn = self::normalize($static);
                break;
            case self::GEN_ORIG:
            default:
                $fn = self::normalize($this->getOrigFn());
        }
        return $this->filename = $fn;
    }
    
    protected static function generateRandomFilename($length = 10) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_';
        $charactersLength = strlen($characters);
        $random = '';
        for ($i = 0; $i < $length; $i++) {
            $random .= $characters[rand(0, $charactersLength - 1)];
        }
        return $random;
    }
    
    protected function getOrigFn() {
        return preg_replace('/\.[\w]*$/', '', $this->file['name']);
    }
    
    protected function getOrigExt() {
        return preg_replace('/^.*\./', '', $this->file['name']);
    }
    
    protected static function normalize($fn, $replace = "_") {
        return preg_replace("#[^\w]#", $replace, $fn);
    }
        
    public function getMessages() {
        return $this->messages;
    }
    
//    public function getFilename() {
//        return $this->filename . '.' . $this->extension;
//    }
//    
    public function getFullPath() {
        return $this->path . '/' . $this->additionalPath;
    }
        
//    public function getFullFilename() {
//        return $this->path . $this->filename . '.' . $this->extension;
//    }
            
    public function getSavedFilename() {
        return $this->savedFilename;
    }
        
    public function getFinalFilename($overwrite = false) {
        $addp = ($this->additionalPath)?$this->additionalPath . '/':'';
        $fn = $this->path . '/' . $addp . $this->filename . $this->additionalFilename;
        if(!$overwrite && is_file($fn . '.' . $this->extension)){
            $cnt = 1;
            while(is_file($fn . '_' . $cnt . '.' . $this->extension)){
                $cnt++;
            }
            return $fn . '_' . $cnt . '.' . $this->extension;
        } else {
            return $fn . '.' . $this->extension;
        }
    }
}

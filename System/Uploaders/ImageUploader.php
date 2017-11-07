<?php

namespace System\Uploaders;

class ImageUploader extends \System\Uploaders\AbstractUploader{
    
    const SCALE_MODE_FIT = 0;
    const SCALE_MODE_FILL = 1;
    
    const OUT_TYPE_PNG = 1;
    const OUT_TYPE_GIF = 2;
    const OUT_TYPE_JPG = 3;
    const OUT_TYPE_BMP = 4;
    
    const ERR_NOT_IMAGE = 'File is not image';
    const ERR_SMALL_IMAGE = 'Too small image';
    const ERR_LARGE_IMAGE = 'Too large image';

    private $picH;
    private $picW;
    private $newH;
    private $newW;
    private $imgObj;
    
    private $saveFileConf;
    private $savedFilenamesArr;

    public function upload(){
        list($this->picW, $this->picH) = getimagesize($this->file['tmp_name']);
        if($this->checkErrors()){
            return false;
        }
        foreach ($this->conf['saveFiles'] as $key => $saveFileConf) {
            $this->saveFileConf = $saveFileConf;
            $this->calcNewSizes();
            $this->imgResize();

            $this->saveResizedImage();

            imagedestroy($this->imgObj);

            if(is_file($this->savedFilename)){
                chmod($this->savedFilename, 0666);
                $this->savedFilenamesArr[$key] = $this->savedFilename;
            } else {
                $this->error = true;
                $this->messages[$key] = AbstractUploader::ERR_UPLOAD_UNSUCCESS;
            }
        }
        return !$this->error;
    }
    
    private function checkErrors() {
        if(!getimagesize($this->file['tmp_name'])){
            $this->messages = self::ERR_NOT_IMAGE;
            $this->error = true;
            return true;
        }
        if((isset($this->conf['minW']) && $this->picW < $this->conf['minW']) ||
           (isset($this->conf['minH']) && $this->picH < $this->conf['minH'])){
            $this->messages = self::ERR_SMALL_IMAGE;
            $this->error = true;
            return true;
        }
        if((isset($this->conf['maxW']) && $this->picW > $this->conf['maxW']) ||
           (isset($this->conf['maxH']) && $this->picH > $this->conf['maxH'])){
            $this->messages = self::ERR_LARGE_IMAGE;
            $this->error = true;
            return true;
        }
        return false;
    }
    
    private function calcNewSizes($mode = 0){
        if(
            (!isset($this->saveFileConf['resizeToH']) || $this->picH < $this->saveFileConf['resizeToH']) &&
            (!isset($this->saveFileConf['resizeToW']) || $this->picW < $this->saveFileConf['resizeToH'])
                ){
            $this->newH = $this->picH;
            $this->newW = $this->picW;
            return false;
        }
        $hscale = isset($this->saveFileConf['resizeToH'])?$this->saveFileConf['resizeToH']/$this->picH:1;
        $wscale = isset($this->saveFileConf['resizeToW'])?$this->saveFileConf['resizeToW']/$this->picW:1;
        
        switch ($mode) {
            case self::SCALE_MODE_FILL:
                $scale = max($hscale,$wscale);
                break;
            case self::SCALE_MODE_FIT:
            default:
                $scale = min($hscale,$wscale);
        }
        $this->newH = $scale * $this->picH;
        $this->newW = $scale * $this->picW;
        return true;
    }
    
    private function imgResize() {
	$imgType = $this->file['type'];
        $tmpname = $this->file['tmp_name'];
        $src = null;
        
	if ( strstr($imgType, 'jpeg') ){ 
	    $src = ImageCreateFromJpeg($tmpname);
	}
	if ( strstr($imgType, 'png') ){
	    $src = ImageCreateFromPng($tmpname);
	}
        
        $this->imgObj = imagecreatetruecolor($this->newW, $this->newH);
        imagecopyresampled($this->imgObj, $src, 0, 0, 0, 0, $this->newW, $this->newH, $this->picW, $this->picH);
        
        imagedestroy($src);
    }
    
    private function saveResizedImage(){
        if(!$this->imgObj){
            return false;
        }
        
        $this->setAdditionalPath( isset($this->saveFileConf['addPath'])?$this->saveFileConf['addPath']:'' );
        $this->setAdditionalFilename( isset($this->saveFileConf['addFn'])?$this->saveFileConf['addFn']:'' );
        
        \System\FileHandler::makedir($this->getFullPath());
        
        $overwrite = (isset($this->saveFileConf['overwrite']) && $this->saveFileConf['overwrite'] === true)?true:false;
        $imType = isset($this->saveFileConf['convertTo']) ? $this->saveFileConf['convertTo'] : IMAGETYPE_JPEG;
        $this->setExtension(image_type_to_extension($imType));
        $saved = $this->getFinalFilename($overwrite);
        
        switch ($imType) {
            case IMAGETYPE_PNG:
                imagepng($this->imgObj, $saved);
                break;
            case IMAGETYPE_GIF:
                imagegif($this->imgObj, $saved);
                break;
            default:
                imagejpeg($this->imgObj, $saved);
                break;
        }
        
        return $this->savedFilename = $saved;
    }
    
    public function getSavedFilename() {
        return $this->savedFilenamesArr;
    }
    
}

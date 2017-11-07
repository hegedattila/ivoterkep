<?php
namespace System;
class SessionHandler{
    
    public static function initSession() {
        self::startSession();
        if(self::valSn()){
            self::setSnNow();
        } else {
            self::regSn();
        }
    }
        
    private static function valSn(){ // megallapitja, hogy jo-e a session
        self::startSession();
        $sid = session_id();
        $sDB = new SystemModels\Tables\SessionTable;
        $uid = $sDB->getUserIdFromSession($sid);
        $l_uid = self::getSessionData('uid');
        if( $uid === $l_uid ) { // ha van
            return true;
        } else { // ha nincs
            return false;
        }
    }
    
    private static function idgen($usrid = 'Sajt'){
        $rand = rand(0, 10000);
        //$ip=$_SERVER['REMOTE_ADDR'];
        return md5($usrid.'T0R-9B$v@iz'.$rand.time());
    }
    
    public static function regSn($usrid = null, $sid = null){
        if(!isset($sid)){
            $sid = self::idgen((isset($usrid))?$usrid:null);
        }
        
        self::destroySn();
        session_id($sid);
        self::startSession();
        
        // db insert session
        $sDB = new SystemModels\Tables\SessionTable;
        if($sDB->insertSn($sid,$usrid)){
            self::setSessionData('uid', $usrid);
          //  \System\SettingHandler::saveAllSettingsToSession();
            return true;
        } else {
            return false;
        }
    }

    public static function destroySn(){
        self::startSession();
        $sid = session_id();
        $sDB = new SystemModels\Tables\SessionTable;
        $sDB->deleteSn($sid);
        session_destroy();
//        session_regenerate_id();
//        session_start();
        $_SESSION = [];
    }
    
    public static function startSession(){
        if( session_status() == PHP_SESSION_NONE ){
            session_start();
        }
    }

    public static function setSnNow(){
        self::startSession();
        $sid = session_id();
        $sDB = new SystemModels\Tables\SessionTable;
        $sDB->setSessionModifiedNow($sid);
    }
    
    public static function getSessionData($key = null){
        if(!isset($_SESSION['set'])){
            \System\SettingHandler::saveAllSettingsToSession();
        }
        if(isset($key)){
            if(isset($_SESSION['set'][$key])){
                return $_SESSION['set'][$key];
            } else {
                return null;
            }
        } else {
            return $_SESSION['set'];
        }
    }
        
    public static function setSessionData($key, $value){
        $_SESSION['set'][$key] = $value;
    }
    
    public static function setSessionDataArr($array = []){
        foreach ($array as $key => $value) {
            $_SESSION['set'][$key] = $value;
        }
    }
        
    public static function getPermission($mode){
        if(!isset($_SESSION['perm'])){
            self::setPermissionsFromDb();
        }
        $keys = array_slice(func_get_args(), 1);
        if($mode == 'OR'){
            foreach ($keys as $key) {
                if(in_array($key, $_SESSION['perm'])){
                    return true;
                }
            }
            return false;
        } elseif ($mode == 'AND') {
            foreach ($keys as $key) {
                if(!in_array($key, $_SESSION['perm'])){
                    return false;
                }
            }
            return true;
        }
    }
            
    public static function setPermissionsFromDb(){
        $uid = self::getSessionData('uid');
        $uDB = new SystemModels\Tables\UserTable;
        $_SESSION['perm'] = $uDB->getAllUserPermissions($uid);
    }
    
    public static function getUserId() {
        return self::getSessionData('uid');
    }
}
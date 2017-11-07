<?php
namespace System;

class UserHandler {
    
    public static function getUserId() {
        return SessionHandler::getUserId();
    }

    private static function setLastTimeStampNow(){
        $uid = SessionHandler::getUserId();
        if(isset($uid)){
            $uDB = new SystemModels\Tables\UserTable;
            $uDB->setUserLastNow($uid);
        }
    }
    
    public static function getSettingsFromDb(){ // db
        $uid = SessionHandler::getUserId();
        if(isset($uid)){
            $uDB = new SystemModels\Tables\UserTable;
            return $uDB->getUserSettings($uid);
        } else {
            return null;
        }
    }
    
    public static function getSetting($key) {
        $settings = self::getUserSettings();
        if(isset($settings[$key])){
            return $settings[$key];
        } else {
            return null;
        }
    }
        
    private static function getPermissionFromDb($key){
        $uid = SessionHandler::getUserId();
        if(isset($uid)){
            $uDB = new SystemModels\Tables\UserTable;
            return $uDB->getUserPermission($key,$uid);
        } else {
            return null;
        }
    }
    
    public static function getPermission($key){
        return \System\SessionHandler::getPermission($key);
    }
    
    public static function checkIsAdminUser(){
        $uid = SessionHandler::getUserId();
        if(isset($uid)){
            $uDB = new SystemModels\Tables\UserTable;
            return $uDB->checkIsAdmin($uid);
        } else {
            return false;
        }
    }
}

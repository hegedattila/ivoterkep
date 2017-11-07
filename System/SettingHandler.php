<?php
namespace System;

class SettingHandler{
    
    public static function getSetting($key){
        // $_GET -> session -> database -> cookie -> default
        $val = \System\RequestHandler::getGet($key);
        if($val != null){
            return $val;
        }
        
        $val = SessionHandler::getSessionData($key);
        if($val != null){
            return $val;
        }
        
        $val = UserHandler::getSetting($key);
        if($val != null){
            return $val;
        }
        
        $val = CookieHandler::getCookie($key);
        if($val != null){
            return $val;
        }
        
        $val = ConfigLoader::getConfig('siteConfig',$key);
        if($val != null){
            return $val;
        }
        
        return null;
    }
    
    public static function saveAllSettingsToSession(){
        $val = ConfigLoader::getConfig('siteConfig');
        if(is_array($val)){
            \System\SessionHandler::setSessionDataArr($val);
        }
        
        $val = CookieHandler::getCookie();
        if(is_array($val)){
            \System\SessionHandler::setSessionDataArr($val);
        }
        
        $val = UserHandler::getSettingsFromDb();
        if(is_array($val)){
            \System\SessionHandler::setSessionDataArr($val);
        }
        
        \System\SessionHandler::setSessionDataArr(\System\RequestHandler::getGet());
        
        return null;
    }
    
    public static function saveSettingToSession($key){
        \System\SessionHandler::setSessionData($key, self::getSetting($key));
    }

}
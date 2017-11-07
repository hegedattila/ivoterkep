<?php
namespace System;
class Translator{
    
    public static function translate($file, $key){
        return self::tr(PROJECTPATH . '/lang/' . self::getLang() . '/' . $file . '.php', $key);
    }
    
    public static function translateModule($module, $file, $key){
        return self::tr(MODULEPATH . '/' . $module . '/lang/' . self::getLang() . '/' . $file . '.php', $key);
    }
    
    public static function translateAdmin($file, $key){
        return self::tr(ADMINPATH . '/lang/' . self::getLang() . '/' . $file . '.php', $key);
    }
    
    public static function translateGlob($file, $key){
        return self::tr('lang/' . self::getLang() . '/' . $file . '.php', $key);
    }
    
    public static function getLang(){
        return \System\SettingHandler::getSetting('lang');
    }
    
    private static function tr($fname,$key){
        if(is_file($fname)){
            $arr = include $fname;
            if(isset($arr[$key])){
                return $arr[$key];
            }
        }
        return '_' . $key;
    }
    
}
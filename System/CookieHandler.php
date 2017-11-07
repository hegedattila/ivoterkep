<?php
namespace System;

class CookieHandler {
    
    public static function setCookie($name, $value = null, $expDate = null) {
        if(self::checkCookiesEnabled()){
            $cookieExpDays = ConfigLoader::getConfig('siteConfig', 'cookiesExpDays');
            setcookie($name, $value, time() + (86400 * $cookieExpDays), "/");
            return true;
        } else {
            return false;
        }
    }
    
    public static function enableCookies() {
        $cookieExpDays = ConfigLoader::getConfig('siteConfig', 'cookiesExpDays');
        setcookie('cEnabled', true, time() + (86400 * $cookieExpDays));
    }
    
    public static function checkCookiesEnabled() {
        if(isset($_COOKIE['cEnabled'])){
            return true;
        } else {
            return false;
        }
    }
    
    public static function getCookie($name = null) {
        if(isset($name)){
            if(isset($_COOKIE[$name])){
                return $_COOKIE[$name];
            } else {
                return null;
            }
        } else {
            return $_COOKIE;
        }
    }
    
}

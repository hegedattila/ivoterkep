<?php
namespace System;

class LangHandler {
    
    public static function getLangs($mode = 'ASSOC') {
        return (new \System\SystemModels\Tables\LangTable())->getLangs($mode);
    }
    
    public static function getDefaultLang() {
        return 1;
    }
    
    public static function setSessionLang($langId) {
        
    }
    
    public static function getSessionLang() {
        return SessionHandler::getLangId();
    }
}

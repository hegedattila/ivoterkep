<?php

namespace System;
class DateTimeHandler {

    public static function getTimestamp($string,$format) {
        if(!is_string($string) || $string == ''){
            return null;
        }
        return \DateTime::createFromFormat($format, $string)->getTimestamp();
    }
    
    public static function getNowTimestamp() {
        return time();
    }
    
}

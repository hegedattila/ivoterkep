<?php

namespace System;
class RequestHandler {
    public static function getPost($key = null,$default = null) {
        if($key === null){
            return $_POST;
        } else {
            if(isset($_POST[$key])){
                return $_POST[$key];
            } else {
                return $default;
            }
        }
    }
    
    public static function getGet($key = null,$default = null) {
        if($key === null){
            return $_GET;
        } else {
            if(isset($_GET[$key])){
                return $_GET[$key];
            } else {
                return $default;
            }
        }
    }
    
}

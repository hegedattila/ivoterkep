<?php
namespace System;

class DbHandler{
    
    static function db_connect() {
        $config = \System\ConfigLoader::getConfig("sqlConfig");
        static $connection;
        if(!isset($connection)) {
            $connection = new \PDO("mysql:host=" . $config['host'] . ";dbname=" . $config['dbname'].';charset=utf8',
                    $config['uname'],
                    $config['pass']
                    );
        }
        if($connection === false) {
            return mysqli_connect_error();
        }
        return $connection;
    }
    
    static function disconnect(&$db){
        if(isset($db)){
            $db = null;
        }
    }

}

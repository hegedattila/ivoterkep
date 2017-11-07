<?php
namespace System\AbstractClasses;

abstract class abstractDb{
    public $db;
    
    public function __construct() {
        $this->db = \System\DbHandler::db_connect();
    }
    public function __destruct() {
        \System\DbHandler::disconnect($this->db);
    }

}
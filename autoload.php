<?php
spl_autoload_register(function ($class_name) {
    $filename = str_replace('\\','/',$class_name) . '.php';
    if(is_file($filename)){
        include $filename;
    } else {
    //    throw new \Exception('Autoload - File not found: ' . $filename);
    }
});
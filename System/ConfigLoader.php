<?php
namespace System;
class ConfigLoader{
    
    static function getConfigPhp($conf, $key = null, $admin = FALSE){
        $filename = (($admin)?ADMINCONFPATH:CONFPATH) . "/" . $conf . '.php';
        if(is_file($filename)){
            $arr = include $filename;
            if(isset($key)){
                if(isset($arr[$key])){
                    return $arr[$key];
                } else {
                    return null;
                }
            } else {
                return $arr;
            }
        } else {
            return null;
//throw new \Exception("Config file not found: " . $filename);
        }
    }
    
    static function getConfig($conf, $key = null, $admin = FALSE){
        $filename = (($admin) ? ADMINCONFPATH : CONFPATH) . "/" . $conf . '.ini';
        if(is_file($filename)){
            $arr = self::parse_ini_advanced($filename);
            return self::getByKey($arr, $key);
        } else {
            return null;
//throw new \Exception("Config file not found: " . $filename);
        }
    }
    
    static function getActiveModules($modName = null){
        $filename = CONFPATH . '/activemodules.ini';
        if(is_file($filename)){
            $arr = parse_ini_file($filename)['module'];
            return ($modName)?in_array($modName, $arr):$arr;
        } else {
            return null;
//throw new \Exception("Config file not found: " . $filename);
        }
    }
    
    static function getModuleConfig($module, $key = null){
        $filename = ($module == 'admin')?
                ADMINPATH . '/module.php':
                MODULEPATH . '/' . $module . '/module.php';
        if(is_file($filename)){
            $arr = include $filename;
            return self::getByKey($arr, $key);
        } else {
            return null;
//throw new \Exception("Config file not found: " . $filename);
        }
    }
    
    private static function getByKey($arr, $key){
        if(isset($key)){
            if(isset($arr[$key])){
                return $arr[$key];
            } else {
                return null;
            }
        } else {
            return $arr;
        }
    }
    
    private static function parse_ini_advanced($filename) {
        $array = parse_ini_file($filename, true, INI_SCANNER_TYPED);
        
        $out = [];
        if (is_array($array)) {
            foreach ($array as $key => $value) {
                $e = explode(':', $key);
                if (!empty($e[1])) {
                    $x = [];
                    foreach ($e as $tk => $tv) {
                        $x[$tk] = trim($tv);
                    }
                    $x = array_reverse($x, true);
                    foreach ($x as $k => $v) {
                        $c = $x[0];
                        if (empty($out[$c])) {
                            $out[$c] = array();
                        }
                        if (isset($out[$x[1]])) {
                            $out[$c] = array_merge($out[$c], $out[$x[1]]);
                        }
                        if ($k === 0) {
                            $out[$c] = array_merge($out[$c], $value);
                        }
                    }
                } else {
                    $out[$key] = $value;
                }
            }
        }
        
        return self::recursive_parse($out);
    }
    
    private static function recursive_parse($array){
        $returnArray = [];
        if (is_array($array)) {
            foreach ($array as $key => $value) {
                if (is_array($value)) {
                    $array[$key] = self::recursive_parse($value);
                }
                $x = explode('.', $key);
                if (!empty($x[1])) {
                    $x = array_reverse($x, true);
                    if (isset($returnArray[$key])) {
                        unset($returnArray[$key]);
                    }
                    if (!isset($returnArray[$x[0]])) {
                        $returnArray[$x[0]] = [];
                    }
                    $first = true;
                    foreach ($x as $k => $v) {
                        if ($first === true) {
                            $b = $array[$key];
                            $first = false;
                        }
                        $b = [$v => $b];
                    }
                    $returnArray[$x[0]] = array_merge_recursive($returnArray[$x[0]], $b[$x[0]]);
                } else {
                    $returnArray[$key] = $array[$key];
                }
            }
        }
        return $returnArray;
    }
    
}
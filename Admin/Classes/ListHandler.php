<?php
namespace Admin\Classes;
class ListHandler {
        
    private static function getDataByType($set,$value){
        if((!isset($value) || $value == null || $value == '') && isset($set['emptyValue'])){
            $value = $set['emptyValue'];
        }
        switch ($set['type']) {
            case 'text':
                return '<div class="cellValue text">' . $value . '</div>';
            case 'number':
                return '<div class="cellValue number">' . $value . '</div>';
            case 'datetime':
                return '<div class="cellValue datetime">' . date('Y.m.d H:i', $value) . '</div>';
            case 'date':
                return '<div class="cellValue datetime">' . date('Y.m.d', $value) . '</div>';
            case 'time':
                return '<div class="cellValue datetime">' . date('H:i', $value) . '</div>';
            case 'bool':
                return ($value)?
                    '<div class="cellValue bool green">TRUE</div>':
                    '<div class="cellValue bool red">FALSE</div>';
            default:
                return '<div class="cellValue">' . $value . '</div>';
        }
    }

    public static function prepareList($list,$moduleName,$listName,$idField = 'id',$userFunc = null) {
        $listTemplates = \System\ConfigLoader::getModuleConfig($moduleName, 'listTemplates')[$listName];
        $sorterArray = array_flip(array_keys($listTemplates));
        
        $newData = [];
        if(count($list) > 0){
            foreach ($list as $row) {
                $newRow = ['data' => [], 'opCol' => [], 'id' => null];
                foreach ($row as $ckey => $val) {
                    if(isset($listTemplates[$ckey])){
                        $newRow['data'][$sorterArray[$ckey]] = self::getDataByType($listTemplates[$ckey], $val);
                    }
                }
                if(isset($row[$idField])){
                    $newRow['id'] = $row[$idField];
                }
                if(isset($userFunc) && is_callable($userFunc)){
                    $newRow['opCol'] = $userFunc($row);
                }
                $newData[] = $newRow;
            }
        }
        $output = [
            'data' => $newData,
            'head' => $listTemplates
        ];
        return $output;
    }
    
    public static function getPageinfo(&$params,$rowsNum) {
        $pagelngth = (isset($params['pageLength']))?$params['pageLength']:50;
        $totalPages = ceil($rowsNum / $pagelngth);
        $pageNr = (isset($params['page']))?$params['page']:0;
        if($pageNr >= $totalPages) {
            $pageNr = $totalPages - 1;
        }
        if($pageNr < 0) {
            $pageNr = 0;
        }
        return [
            'pageLength' => $pagelngth,
            'page' => $pageNr,
            'totalRows' => $rowsNum,
            'totalPages' => $totalPages,
        ];
    }
}

<?php
namespace System\SystemModels\Tables;
class TemplateTable extends \System\AbstractClasses\abstractDb{
    
    public function getPageLayout($route) {
        try{
            if(!is_string($route)){
                return false;
            }
            $route = trim($route,'/');
            $routesSql = "SELECT CHAR_LENGTH(`rt`.`route`) AS routeLen, rt.route, rt.parameters, tpl.places, lay.filename FROM `routes` rt
                LEFT JOIN `templates` tpl ON rt.templateId = tpl.id
                LEFT JOIN `layouts` lay ON tpl.layoutId = lay.id
                WHERE :fullRoute LIKE CONCAT(`rt`.`route`, '/%')
                OR `rt`.`route` IS NULL
                ORDER BY routeLen ASC,
                rt.parameters ASC";
            $routesqry = $this->db->prepare($routesSql);
            $routesqry->bindValue('fullRoute', $route . '/', \PDO::PARAM_STR);
            $routesqry->execute();
                
            if($routesqry->rowCount() > 0){
                $result = $routesqry->fetchALL(\PDO::FETCH_ASSOC);

                $ret_val = ['places' => []];
                foreach ($result as $key => $value){
                    $foundParams = preg_match_all('/[\w\d]+/', substr($route, $value['routeLen']));
                    if( !is_null($value['parameters']) &&
                            $value['parameters'] > $foundParams){
                        unset($result[$key]);
                        continue;
                    }
                    
                    $places = json_decode($value['places'], JSON_OBJECT_AS_ARRAY);
                    if(is_array($places)){
                        $ret_val['places'] = array_merge(
                            $ret_val['places'],
                            $places
                        );
                    }
                }
                
                if(count($result) == 0){
                    return false;
                }
                
                $ret_val['filename'] = end($result)['filename'];
                $foundRouteLen = strlen( end($result)['route'] );
                $ret_val['additionalRouteStr'] = trim( substr($route, $foundRouteLen), '/');
                $ret_val['additionalRoute'] = explode('/', $ret_val['additionalRouteStr']);
                return $ret_val;
            } else {
                return false;
            }
        } catch (PDOException $e){
            return false;
        }
    }
    
    
//    public function getPageLayout($route) {
//        try{
//            $params = new \System\ParameterContainer;
//            $joinsStr = '';
//            $fieldsArr = [];
//            if(!is_array($route) || count($route) == 0){
//                return false;
//            }
//            foreach ($route as $key => $value) {
//                $params->addParam('rt_' . $key, $value, \PDO::PARAM_STR);
//                $fieldsArr[] = 't' . $key . '.id'; 
//                if($key > 0){
//                    $key_ = $key - 1;
//                    $joinsStr .= "LEFT JOIN routes AS t$key ON
//                        t$key.parentId = t$key_.id AND (t$key.route = :rt_$key OR t$key.paramName IS NOT NULL) ";
//                }
//            }
//            
//            $routesSql = 'SELECT ' . implode(',', $fieldsArr) . 
//                ' FROM routes AS t0 ' . 
//                    $joinsStr
//                . 'WHERE t0.route = :rt_0 OR t0.paramName IS NOT NULL';
//            $routesqry = $this->db->prepare($routesSql);
//            $params->bindAll($routesqry);
//            $routesqry->execute();
//            
//            if($routesqry->rowCount() == 0){
//                return false;
//            }
//            $routeIds = $routesqry->fetch(\PDO::FETCH_NUM);
//            $ridsStr = implode(',', array_filter($routeIds));
//            $dataSql = 'SELECT rts.paramName, lays.name, lays.places, lays.filename, lays.withParents
//                FROM `layouts` lays
//                LEFT JOIN `routes` rts ON lays.id = rts.layoutId
//                WHERE rts.id IN ('. $ridsStr .')
//                ORDER BY FIELD(rts.id, '. $ridsStr .')';
//            $qry = $this->db->prepare($dataSql);
//            $qry->execute();
//            $numRoutes = $qry->rowCount();
//            if($numRoutes > 0){
//                $result = $qry->fetchALL(\PDO::FETCH_ASSOC);
//
//                $ret_val = ['places' => [],'urlParams'=>[]];
//                foreach ($result as $key => $value){
////                        if($value['withParents'] == 0){
////                            $ret_val = $value;
////                            $ret_val['places'] = [];
////                        }
//                    $places = json_decode($value['places'], JSON_OBJECT_AS_ARRAY);
//                    if(is_array($places)){
//                        $ret_val['places'] = array_merge(
//                            $ret_val['places'],
//                            $places
//                        );
//                    }
//                    if(isset($value['paramName'])){
//                        $ret_val['urlParams'][$value['paramName']] = $route[$key-1];
//                    }
//                }
//                $ret_val['filename'] = end($result)['filename'];
//                $ret_val['additionalRoute'] = array_slice($route, $numRoutes-1);
//                return $ret_val;
//                
//            } else {
//                return false;
//            }
//        } catch (PDOException $e){
//            return false;
//        }
//    }
}
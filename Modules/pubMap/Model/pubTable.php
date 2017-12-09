<?php
namespace Modules\pubMap\Model;

use System\DateTimeHandler as dth;

class pubTable extends \System\AbstractClasses\abstractDb {
    
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['name','address']);
            $fields = ($count)?
                    'COUNT( DISTINCT p.id )':
                    'DISTINCT p.id, p.name, p.address';
            
            $sql = 'SELECT ' . $fields . ' FROM pub p
                 --  LEFT JOIN users u ON u.id = p.created_by
                 --  WHERE p.deleted_date IS NULL;';
            $sql .= $helper->getSql($count, true);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
            
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
    
    public function add($data) {
        try {
            $sql = "INSERT INTO `pub` (comment,address,name)
                    VALUES (:comment,:address,:name);";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('comment', $data['comment'],  \PDO::PARAM_STR);
            $paramCont->addParam('address', $data['address'],  \PDO::PARAM_STR);
            $paramCont->addParam('name', $data['name'],  \PDO::PARAM_STR);
            
           // $paramCont->setEmptyValuesToNull(['active','publishdate','unpublishdate','leadimage']);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                $contentID = $this->db->lastInsertId();
              //  if($this->saveContentLang($contentID, $data)){
                    return $contentID;
             //   }
                return false;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getDataToForm($cid) {
        try {
            $sql = "SELECT * FROM content WHERE id = :cid;";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('cid', $cid, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                $sql_lang = "SELECT * FROM content_lang WHERE content_id = :cid";
                $qry_l = $this->db->prepare($sql_lang);
                $qry_l->bindValue('cid', $cid, \PDO::PARAM_INT);
                $qry_l->execute();
                $ld = $qry_l->fetchAll(\PDO::FETCH_ASSOC);
                $langData = [];
                
                foreach ($ld as $value) {
                    $lng = $value['lang_id'];
                    foreach ($value as $fieldName => $v) {
                        if(isset($langData[$fieldName])){
                            $langData[$fieldName][$lng] = $v;
                        } else {
                            $langData[$fieldName] = [$lng => $v];
                        }
                    }
                }
                
                return array_merge($data, $langData);
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }

    public function update($id, $data) {
        try {
            $sql = "UPDATE `content` SET
                    active = :active,
                    modified_by = :modby,
                    modified_date = :now,
                    publish_date = :publishdate,
                    unpublish_date = :unpublishdate,
                    lead_image = :leadimage
                    WHERE id = :id";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
            $paramCont->addParam('modby', \System\UserHandler::getUserId(),  \PDO::PARAM_INT);
            $paramCont->addParam('active', isset($data['active'])?1:0,  \PDO::PARAM_INT);
            $paramCont->addParam('now',dth::getNowTimestamp(),\PDO::PARAM_INT);
            $paramCont->addParam('publishdate', dth::getTimestamp($data['publish_date'],'Y-m-d'),  \PDO::PARAM_INT);
            $paramCont->addParam('unpublishdate', dth::getTimestamp($data['unpublish_date'],'Y-m-d'),  \PDO::PARAM_INT);
            $paramCont->addParam('leadimage', $data['lead_image'],  \PDO::PARAM_STR);
            
            $paramCont->setEmptyValuesToNull(['active','publishdate','unpublishdate','leadimage']);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                return $this->saveContentLang($id, $data);
            } else {
                return false;
            }
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
    
    public function delete($ids) {
        try {
            if(!is_array($ids)){
                $ids = [$ids];
            }
            
            $paramCont = new \System\ParameterContainer();
            
            $idSqlArr = [];
            foreach ($ids as $key => $id) {
                $paramCont->addParam('id_' . $key, $id, \PDO::PARAM_INT);
                $idSqlArr[] = ':id_' . $key;
            }
            
            $sql = "DELETE FROM `pub`
                    WHERE id IN (" . implode(',',$idSqlArr) . ");" ;
            
            $qry = $this->db->prepare($sql);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == count($ids)){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
}

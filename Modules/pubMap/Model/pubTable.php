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
    
    public function save($data, $id = null) {
        try {
            $this->db->beginTransaction();
            
            $sql = "INSERT INTO `pub` (id,comment,address,name)
                    VALUES (:id,:comment,:address,:name)
                    ON DUPLICATE KEY UPDATE
                        comment = VALUES(comment),
                        address = VALUES(address),
                        name = VALUES(name);";
            
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('comment', $data['comment'],  \PDO::PARAM_STR);
            $paramCont->addParam('address', $data['address'],  \PDO::PARAM_STR);
            $paramCont->addParam('name', $data['name'],  \PDO::PARAM_STR);
            $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
            
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            
            $qry->execute();
            if($qry->rowCount() > 0){
                $contentID = $this->db->lastInsertId();
                if($this->saveContact($contentID, $data) &&
                        $this->saveCoordinates($contentID, $data)// &&
                       // $this->saveOpen($contentID, $data)
                        ){
                    $this->db->commit();
                    return $contentID;
                }
                $this->db->rollBack();
                return false;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    private function saveContact($pubId, $data) {
        try {
            $sql = "INSERT INTO `pub_contact` (email,phone,pubId)
                    VALUES (:email,:phone,:pid)
                    ON DUPLICATE KEY UPDATE
                        email = VALUES(email),
                        phone = VALUES(phone);";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('email', $data['email'],  \PDO::PARAM_STR);
            $paramCont->addParam('phone', $data['phone'],  \PDO::PARAM_STR);
            $paramCont->addParam('pid', $pubId,  \PDO::PARAM_INT);
            
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            
            $qry->execute();
            return true;
        } catch (PDOException $e) {
           // var_dump($e->getMessage());
            return false;
        }
    }
    
    private function saveCoordinates($pubId, $data) {
        try {
            $sql = "INSERT INTO `pub_coordinates` (latitude,longitude,pubId)
                    VALUES (:lat,:long,:pid)
                    ON DUPLICATE KEY UPDATE
                        latitude = VALUES(latitude),
                        longitude = VALUES(longitude);";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('lat', $data['latitude'],  \PDO::PARAM_INT);
            $paramCont->addParam('long', $data['longitude'],  \PDO::PARAM_INT);
            $paramCont->addParam('pid', $pubId,  \PDO::PARAM_INT);
            
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            return true;
        } catch (PDOException $e) {
           // var_dump($e->getMessage());
            return false;
        }
    }
    
    private function saveOpen($pubId, $data) {
        try {
            $sql = "INSERT INTO `pub_open`
                (`mondayOpen`, `mondayClose`, `tuesdayOpen`, `tuesdayClose`, `wednesdayOpen`, `wednesdayClose`, `thursdayOpen`, `thursdayClose`, `fridayOpen`, `fridayClose`, `saturdayOpen`, `saturdayClose`, `sundayOpen`, `sundayClose`, `pubId`)
                    VALUES 
                (:mondayO, :mondayC, :tuesdayO, :tuesdayC, :wednesdayO, :wednesdayC, :thursdayO, :thursdayC, :fridayO, :fridayC, :saturdayO, :saturdayC, :sundayO, :sundayC, :pubId);";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
//            $paramCont->addParam('mondayO', $data['mondayO'],  \PDO::PARAM_INT);
            $paramCont->addParam('pubId', $pubId,  \PDO::PARAM_INT);
            
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            return true;
        } catch (PDOException $e) {
            var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getDataToForm($id) {
        try {
            $sql = "SELECT * FROM pub p
                    LEFT JOIN pub_contact pc ON pc.`pubId` = p.`id`
                    LEFT JOIN pub_coordinates pcts ON pcts.`pubId` = p.`id`
                   -- LEFT JOIN pub_contact pc ON pc.`pubId` = p.`id`
                   WHERE p.id = :pid;
                    ";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('pid', $id, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                
                return $data;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
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

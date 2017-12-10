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
            
            $sql = "INSERT INTO `pub` (id,comment,address,name,sef)
                    VALUES (:id,:comment,:address,:name,:sef)
                    ON DUPLICATE KEY UPDATE
                        comment = VALUES(comment),
                        address = VALUES(address),
                        sef = VALUES(sef),
                        name = VALUES(name);";
            
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('comment', $data['comment'],  \PDO::PARAM_STR);
            $paramCont->addParam('address', $data['address'],  \PDO::PARAM_STR);
            $paramCont->addParam('name', $data['name'],  \PDO::PARAM_STR);
            $paramCont->addParam('sef', $data['sef'],  \PDO::PARAM_STR);
            $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
            
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            $pubId = false;
            if($id){
                $pubId = $id;
            } elseif($qry->rowCount() > 0){
                $pubId = $this->db->lastInsertId();
            } else {
                $this->db->rollBack();
                return false;
            }
            
            if($this->saveContact($pubId, $data) &&
                    $this->saveCoordinates($pubId, $data) &&
                    $this->saveOpen($pubId, $data)
                    ){
                $this->db->commit();
                return $pubId;
            }
            $this->db->rollBack();
            return false;
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
         //   var_dump($e->getMessage());
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
                (:mondayO, :mondayC, :tuesdayO, :tuesdayC, :wednesdayO, :wednesdayC, :thursdayO, :thursdayC, :fridayO, :fridayC, :saturdayO, :saturdayC, :sundayO, :sundayC, :pubId)
                ON DUPLICATE KEY UPDATE
                    mondayOpen = VALUES(mondayOpen),
                    mondayClose = VALUES(mondayClose),
                    tuesdayOpen = VALUES(tuesdayOpen),
                    tuesdayClose = VALUES(tuesdayClose),
                    wednesdayOpen = VALUES(wednesdayOpen),
                    wednesdayClose = VALUES(wednesdayClose),
                    thursdayOpen = VALUES(thursdayOpen),
                    thursdayClose = VALUES(thursdayClose),
                    fridayOpen = VALUES(fridayOpen),
                    fridayClose = VALUES(fridayClose),
                    saturdayOpen = VALUES(saturdayOpen),
                    saturdayClose = VALUES(saturdayClose),
                    sundayOpen = VALUES(sundayOpen),
                    sundayClose = VALUES(sundayClose)";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            foreach ($data['open'] as $key => $value) {
               // if($value) $value .= ':00';
                $paramCont->addParam($key . 'O', $value,  \PDO::PARAM_STR);
            }
            foreach ($data['close'] as $key => $value) {
              //  if($value) $value .= ':00';
                $paramCont->addParam($key . 'C', $value,  \PDO::PARAM_STR);
            }
            $paramCont->addParam('pubId', $pubId,  \PDO::PARAM_INT);
            
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            return true;
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getDataToForm($id) {
        try {
            $sql = "SELECT * FROM pub p
                    LEFT JOIN pub_contact pc ON pc.`pubId` = p.`id`
                    LEFT JOIN pub_coordinates pcts ON pcts.`pubId` = p.`id`
                 --   LEFT JOIN pub_open po ON po.`pubId` = p.`id`
                   WHERE p.id = :pid;
                    ";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('pid', $id, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                
                return array_merge($data,  $this->getOpenDataToForm($id));
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    private function getOpenDataToForm($id) {
        try {
            $sql = "SELECT * FROM pub_open WHERE pubId = :pid;
                    ";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('pid', $id, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                $out = [
                    'open' => [
                        'monday' => $data['mondayOpen'],
                        'tuesday' => $data['tuesdayOpen'],
                        'wednesday' => $data['wednesdayOpen'],
                        'thursday' => $data['thursdayOpen'],
                        'friday' => $data['fridayOpen'],
                        'saturday' => $data['saturdayOpen'],
                        'sunday' => $data['sundayOpen']
                    ],
                    'close' => [
                        'monday' => $data['mondayClose'],
                        'tuesday' => $data['tuesdayClose'],
                        'wednesday' => $data['wednesdayClose'],
                        'thursday' => $data['thursdayClose'],
                        'friday' => $data['fridayClose'],
                        'saturday' => $data['saturdayClose'],
                        'sunday' => $data['sundayClose']
                    ],
                ];
                
                return $out;
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

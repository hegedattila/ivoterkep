<?php
namespace System\SystemModels\Tables;
class SessionTable extends \System\AbstractClasses\abstractDb {

    public function checkSession($sid) {
        try {
            $expTime = time() -
                    (\System\ConfigLoader::getConfig('siteConfig', 'sessionExpMins') * 6000); // 60
            $sql = "SELECT COUNT(id) FROM `sessions` WHERE id = :id AND modified > :exptime";
            $qry = $this->db->prepare($sql);
            $qry->execute(['id' => $sid,'exptime' => $expTime]);
            return ($qry->fetchColumn() == 1)?true:false;
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getUserIdFromSession($sid) {
        try {
            $sql = "SELECT uid FROM `sessions` WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->execute(['id' => $sid]);
            if($qry->rowCount() == 1){
                return $qry->fetchColumn();
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function setSessionModifiedNow($sid) {
        try {
            $sql = "UPDATE `sessions` SET `modified` = :now WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->execute(['now' => time(), 'id' => $sid]);
            return true;
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
        
    public function deleteSn($sid) {
        try {
            $sql = "DELETE FROM `sessions` WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->execute(['id' => $sid]);
            if($qry->rowCount() == 1){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
            
    public function insertSn($sid, $uid = null) {
        try {
            $sql = "INSERT INTO `sessions`
                    (id,uid,created,modified,ip4,stayLoggedIn) VALUES
                    ( :sid, :uid, :now, :now, :ip, 1 )";
            $qry = $this->db->prepare($sql);
            $qry->execute([
                'sid' => $sid,
                'uid' => $uid,    
                'now' => time(),    
                'ip' => 'proba_ip',    
                    ]);
            if($qry->rowCount() == 1){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }

}

<?php
namespace Admin\Model\permission;

class permissionTable extends \System\AbstractClasses\abstractDb {
    
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['id','name','description']);
            $fields = ($count)?
                    'COUNT( id )':
                    'id, name, description';
            $sql = 'SELECT ' . $fields . ' FROM permissions' . $helper->getSql($count);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
        
    public function getPermissionsToForm() {
        try {
            $sql = 'SELECT p.id, CONCAT(p.description,\' (\',p.name,\')\') AS name FROM permissions p ORDER BY p.name';
            $qry = $this->db->prepare($sql);
            $qry->execute();
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return [];
        }
    }
            
    public function getUGroupsToForm() {
        try {
            $sql = "SELECT id, name FROM userGroups WHERE adminAccess = 1;";
            $qry = $this->db->prepare($sql);
            $qry->execute();
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
                
    public function getPermissionsGroupsToForm() {
        try {
            $sql = "SELECT groupId, permId FROM groupsToPermissions;";
            $qry = $this->db->prepare($sql);
            $qry->execute();
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
    
    public function setPermissionToGroup($p,$g,$action) {
        try {
            $sql = ($action == 1)?
                    "INSERT INTO `groupsToPermissions` (groupId, permId)
                    VALUES (:gid,:pid)":
                    "DELETE FROM `groupsToPermissions` WHERE
                    groupId = :gid AND permId = :pid;";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('gid', $g,  \PDO::PARAM_INT);
            $qry->bindValue('pid', $p,  \PDO::PARAM_INT);
            
            $qry->execute();
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

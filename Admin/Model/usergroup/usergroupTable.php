<?php
namespace Admin\Model\usergroup;

class usergroupTable extends \System\AbstractClasses\abstractDb {
    
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['id', 'name', 'description', 'adminAccess']);
            
            $fields = ($count)?
                    'COUNT( id )':
                    'id, name, description, adminAccess';
            
            $sql = 'SELECT ' . $fields . ' FROM userGroups' . $helper->getSql($count);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
        
    public function getPermissionsToForm() {
        try {
            $sql = "SELECT id, name FROM permissions GROUP BY grp,id ORDER BY id";
            $qry = $this->db->prepare($sql);
            $qry->execute();
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
            
    public function getUGroupsToForm() {
        try {
            $sql = "SELECT id, name FROM userGroups";
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
            $sql = "SELECT groupId, permId FROM groupsToPermissions";
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
                    VALUES (:gid,:pid);":
                    "DELETE FROM `groupsToPermissions` WHERE
                    groupId = :gid AND permId = :pid;";
            $qry = $this->db->prepare($sql);
            $qry->execute(['gid' => $g, 'pid' => $p]);
            
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
    
    public function getDataToForm($id) {
        try {
            $sql = 'SELECT name, description, IF(adminAccess=1,1,NULL) AS admin FROM `userGroups` WHERE id = :id';
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            
            $qry->execute(); 
            
            if($qry->rowCount() == 1){
                return $qry->fetch(\PDO::FETCH_ASSOC);
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
        
    public function addUg($params) {
        try {
            $sql = "INSERT INTO `userGroups` (name, description, adminAccess)
                    VALUES (:name,:desc,:adm);";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('name',$params['name'],  \PDO::PARAM_STR);
            $qry->bindValue('desc',$params['description'],  \PDO::PARAM_STR);
            $qry->bindValue('adm', (isset($params['admin']))?1:0,  \PDO::PARAM_INT);
            
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
            
    public function editUg($params,$id) {
        try {
            $sql = "UPDATE `userGroups` SET
                name = :name,
                description = :desc,
                adminAccess = :adm
                WHERE id = :id";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('name',$params['name'],  \PDO::PARAM_STR);
            $qry->bindValue('desc',$params['description'],  \PDO::PARAM_STR);
            $qry->bindValue('adm', (isset($params['admin']))?1:0,  \PDO::PARAM_INT);
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            
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
    
    public function delUg($ids) {
        try {
            if(!is_array($ids)){
                $ids = [$ids];
            }
            
            $params = new \System\ParameterContainer();
            $p_arr = [];
            
            foreach ($ids as $key => $id) {
                $params->addParam('id_' . $key, $id, \PDO::PARAM_INT);
                $p_arr[] = ':id_' . $key;
            }
            
            $sql = 'DELETE FROM `userGroups` WHERE id IN (' .
                implode(',', $p_arr) .
                ');';
            
            $qry = $this->db->prepare($sql);
            $params->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() > 0){
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

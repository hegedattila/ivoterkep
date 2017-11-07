<?php
namespace System\SystemModels\Tables;

class UserTable extends \System\AbstractClasses\abstractDb {
    
    public function setUserLastNow($uid) {
        try {
            $sql = "UPDATE `users` SET `lastDate` = :now WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->execute(['now' => time(), 'id' => $uid]);
            return true;
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
    
    public function getUserSettings($uid = null) {
        try {
            $sql = "SELECT l.id AS lang_id, l.shortname AS lang_shortname, u.settings
                    FROM `users` u
                    LEFT JOIN `languages` l ON u.langId = l.id
                    WHERE u.id = :id";
            $qry = $this->db->prepare($sql);
            $qry->execute(['id' => $uid]);
            if($qry->rowCount() == 1){
                $result = $qry->fetch(\PDO::FETCH_ASSOC);
                $result['settings'] = json_decode($result['settings'], JSON_OBJECT_AS_ARRAY);
                return $result;
            } else {
                return null;
            }
        } catch (PDOException $e) {
           // var_dump($e->getMessage());
            return null;
        }
    }
        
    public function getUserPermission($key, $uid = null) {
        try {
            $sql = "SELECT COUNT(1) FROM `permissions` P
                        LEFT JOIN `groupsToPermissions` GTP ON GTP.permId = P.id
                        LEFT JOIN `usersToGroups` UTG ON UTG.groupId = GTP.groupId
                    LEFT JOIN `users` U ON U.id = UTG.userId
                    WHERE U.id = :id AND
                    ( P.name = :pkey OR P.name = 'all' )";
            $qry = $this->db->prepare($sql);
            $qry->execute(['id' => $uid,'pkey' => $key]);
            return ($qry->fetchColumn() > 0)?true:false;
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
            
    public function getAllUserPermissions($uid = null) {
        try {
            $sql = "SELECT P.name FROM `permissions` P
                        LEFT JOIN `groupsToPermissions` GTP ON GTP.permId = P.id
                        LEFT JOIN `usersToGroups` UTG ON UTG.groupId = GTP.groupId
                        LEFT JOIN `users` U ON U.id = UTG.userId
                    WHERE U.id = :id";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('id', $uid,  \PDO::PARAM_INT);
            
            $qry->execute();
            return $qry->fetchAll(\PDO::FETCH_COLUMN);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
            
    public function checkIsAdmin($uid = null) {
        if($uid){
            try {
                $sql = "SELECT COUNT(1) FROM `userGroups` G
                            LEFT JOIN `usersToGroups` UTG ON UTG.groupId = G.id
                        LEFT JOIN `users` U ON U.id = UTG.userId
                        WHERE G.adminAccess = 1 AND
                        U.id = :id";
                $qry = $this->db->prepare($sql);
                $qry->bindValue('id', $uid,  \PDO::PARAM_INT);

                $qry->execute();
                return ($qry->fetchColumn() > 0)?true:false;
            } catch (PDOException $e) {
              //  var_dump($e->getMessage());
                return null;
            }
        } else {
            return null;
        }
    }
//                NINCS már permission level
//    public function getPermissionLevel($uid = null) {
//        try {
//            $sql = "SELECT COALESCE(MAX(G.permissionLevel),0) FROM `userGroups` G
//                        LEFT JOIN `usersToGroups` UTG ON UTG.groupId = G.id
//                    LEFT JOIN `users` U ON U.id = UTG.userId
//                    WHERE
//                    U.id = :id";
//            $qry = $this->db->prepare($sql);
//            $qry->execute(['id' => $uid]);
//            return $qry->fetchColumn();
//        } catch (PDOException $e) {
//          //  var_dump($e->getMessage());
//            return null;
//        }
//    }
//    

}

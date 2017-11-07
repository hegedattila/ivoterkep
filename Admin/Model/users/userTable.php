<?php
namespace Admin\Model\users;

class userTable extends \System\AbstractClasses\abstractDb {
    
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['nick','fullName','email','regDate','lastDate']);
            $fields = ($count)?
                    'COUNT( DISTINCT u.id )':
                    'DISTINCT u.id, u.`nick`,u.`fullName`,u.`email`,u.`regDate`,u.`lastDate`';
            
            $sql = 'SELECT ' . $fields . ' FROM users u
                   LEFT JOIN usersToGroups utg ON utg.userId = u.id
                   LEFT JOIN userGroups ug ON ug.id = utg.groupId
                   WHERE deleted IS NULL';
            
            $sql .= $helper->getSql($count, true);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
    
    public function getDataToForm($id) {
        try{
            $sql = 'SELECT nick,fullName,email,langId,settings FROM `users` WHERE id = :id';
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            $qry->execute();
            $result = $qry->fetch(\PDO::FETCH_ASSOC);
            
            $groupsSql = 'SELECT groupId FROM `usersToGroups` WHERE userId = :id';
            $groupqry = $this->db->prepare($groupsSql);
            $groupqry->bindValue('id', $id,  \PDO::PARAM_INT);
            
            $groupqry->execute();
            $result['groups'] = $groupqry->fetchAll(\PDO::FETCH_COLUMN , 0);
            
            if($qry->rowCount() == 1){
                return $result;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            return false;
        }
    }
            
    public function editUser($params,$id) {
        try {
            $sql = "UPDATE `users` SET
                nick = :nick,
                fullName = :fulln,
                email = :email,
                langId = :lang,
                settings = :set
                WHERE id = :id";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('nick', $params['nick'],  \PDO::PARAM_STR);
            $qry->bindValue('fulln', $params['fullName'],  \PDO::PARAM_STR);
            $qry->bindValue('email', $params['email'],  \PDO::PARAM_STR);
            $qry->bindValue('lang', $params['langId'],  \PDO::PARAM_INT);
            $qry->bindValue('set', $params['settings'],  \PDO::PARAM_STR);
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            $qry->execute();
            
            if(!in_array('groups', $params)){
                $params['groups'] = null;
            }
            $this->setGroups($id, $params['groups']);
            
            return true;
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function delUser($id) {
        try{
            if(!is_array($id)){
                $id = [$id];
            }
            $pcont = new \System\ParameterContainer;
            $idParsArr = [];
            foreach ($id as $key => $value) {
                $idParsArr[] = ':id_' . $key;
                $pcont->addParam('id_' . $key, $value, \PDO::PARAM_INT);
            }
            $idPars = implode(',', $idParsArr);
            $sql = 'UPDATE users SET deleted=:now WHERE id IN ('. $idPars .')';
            $qry = $this->db->prepare($sql);
            $qry->bindValue('now',time(),\PDO::PARAM_INT);
            $pcont->bindAll($qry);
            $qry->execute();
            
            if($qry->rowCount() > 0){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            return false;
        }
    }
        
    public function setGroups($uid, $groups = []) {
        try{
            $delSql = 'DELETE FROM usersToGroups WHERE userId = :uid';
            $delqry = $this->db->prepare($delSql);
            $delqry->bindValue('uid',$uid,\PDO::PARAM_INT);
            $delqry->execute();
            
            if(!is_array($groups)){
                $groups = [$groups];
            }
            $pcont = new \System\ParameterContainer;
            $parsArr = [];
            $pcont->addParam('uid', $uid, \PDO::PARAM_INT);
            foreach ($groups as $key => $value) {
                $parsArr[] = '(:uid, :gid_' . $key . ')';
                $pcont->addParam('gid_' . $key, $value, \PDO::PARAM_INT);
            }
            $pars = implode(',', $parsArr);
            $sql = 'INSERT INTO usersToGroups (userId, groupId) VALUES ' . $pars;
            $qry = $this->db->prepare($sql);
            $pcont->bindAll($qry);
            $qry->execute();
            
            return true;
        } catch (PDOException $e) {
            return false;
        }
    }

}

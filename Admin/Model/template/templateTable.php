<?php
namespace Admin\Model\template;

use System\ParameterContainer;

class templateTable extends \System\AbstractClasses\abstractDb {
        
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['id','name','lname']);
            $fields = ($count)?
                    'COUNT( t.id )':
                    't.id, t.name, l.name as lname';
            
            $sql = 'SELECT ' . $fields . ' FROM templates t
                   LEFT JOIN layouts l ON l.id = t.layoutId';
            
            $sql .= $helper->getSql($count, false);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return null;
        }
    }
  
    public function save($params, $id = null) {
        try {
            $paramCont = new ParameterContainer();
            
            if(!is_null($id)){
                $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
                $sql = 'UPDATE `templates` SET
                    layoutId = :lid,
                    name = :name,
                    places = :pl
                WHERE id = :id;';
            } else {
                $sql = 'INSERT INTO `templates` (name, layoutId, places)
                VALUES (:name,:lid,:pl);';
            }
            
            $paramCont->addParam('lid', $params['layout'],  \PDO::PARAM_INT);
            $paramCont->addParam('name', $params['name'],  \PDO::PARAM_STR);
            $paramCont->addParam('pl', $params['places'],  \PDO::PARAM_STR);
            
            $paramCont->setEmptyValuesToNull();
            
            $qry = $this->db->prepare($sql);
            $paramCont->bindAll($qry);
            
            $qry->execute(); 
            if($qry->rowCount() == 1){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return false;
        }
    }
        
    public function getDataToForm($id) {
        try {
            $sql = 'SELECT name, layoutId AS layout, places FROM `templates` WHERE id = :id';
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
        
    public function delete($id) {
        try {
            $sql = "DELETE FROM `templates` WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
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
    
    public function getLayouts() {
        try {
            $sql = 'SELECT id,name FROM `layouts`';
            $qry = $this->db->prepare($sql);
            
            $qry->execute(); 
            
            if($qry->rowCount() > 0){
                return $qry->fetchAll(\PDO::FETCH_KEY_PAIR);
            } else {
                return [];
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }

    public function getLayoutFilenames() {
        try {
            $sql = 'SELECT id,filename FROM `layouts`';
            $qry = $this->db->prepare($sql);
            
            $qry->execute(); 
            
            if($qry->rowCount() > 0){
                return $qry->fetchAll(\PDO::FETCH_KEY_PAIR);
            } else {
                return [];
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getLayoutFilename($id) {
        try {
            $sql = 'SELECT filename FROM `layouts` WHERE id = :id';
            $qry = $this->db->prepare($sql);
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            
            $qry->execute(); 
            
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

}

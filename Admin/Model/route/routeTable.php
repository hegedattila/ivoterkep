<?php
namespace Admin\Model\route;

use System\ParameterContainer;

class routeTable extends \System\AbstractClasses\abstractDb {
        
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['id','route','name','parameters']);
            $fields = ($count)?
                    'COUNT( r.id )':
                    'r.id, r.route, r.parameters, t.name';
            
            $sql = 'SELECT ' . $fields . ' FROM routes r
                   LEFT JOIN templates t ON t.id = r.templateId';
            
            $sql .= $helper->getSql($count, false);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
        
    public function save($params, $id = null) {
        try {
            $paramCont = new ParameterContainer;
            
            if(isset($id)){
                $sql = "UPDATE `routes` SET
                    templateId = :tid,
                    route = :rt,
                    parameters = :pars
                WHERE id = :id;";
                $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
            } else {
                $sql = 'INSERT INTO `routes` (templateId, route, parameters)
                    VALUES (:tid, :rt, :pars);';
            }
            $qry = $this->db->prepare($sql);
            
            $paramCont->addParam('tid', $params['template'],  \PDO::PARAM_INT);
            $paramCont->addParam('rt', $params['route'],  \PDO::PARAM_STR);
            $paramCont->addParam('pars', $params['params'],  \PDO::PARAM_INT);
            $paramCont->setEmptyValuesToNull();
            
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
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
        
    public function getDataToForm($id) {
        try {
            $sql = 'SELECT templateId AS template, route, parameters as params FROM `routes` WHERE id = :id';
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
            $sql = "DELETE FROM `routes` WHERE id = :id";
            $qry = $this->db->prepare($sql);
            $qry->bindValue('id', $id,  \PDO::PARAM_INT);
            $qry->execute();
            if($qry->rowCount() > 0){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
            $this->db->rollBack();
          //  var_dump($e->getMessage());
            return false;
        }
    }
      
    public function getTemplates() {
        try {
            $sql = 'SELECT id,name FROM `templates`';
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
}

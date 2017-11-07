<?php
namespace System\SystemModels\Tables;
class uGroupTable extends \System\AbstractClasses\abstractDb {

    public function getGroups($mode) {
        try {
            $sql = 'SELECT id, CONCAT(description,\' (\',name,\')\') FROM `userGroups`';
            $qry = $this->db->prepare($sql);
            
            $qry->execute(); 
            
            if($qry->rowCount() > 0){
                switch ($mode) {
                    case 'ID':
                        return $qry->fetchAll(\PDO::FETCH_COLUMN);
                    case 'ASSOC':
                    default :
                        return $qry->fetchAll(\PDO::FETCH_KEY_PAIR);
                }
            } else {
                return [];
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }

}

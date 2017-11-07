<?php
namespace System\SystemModels\Tables;
class LangTable extends \System\AbstractClasses\abstractDb {

    public function getLangs($mode) {
        try {
            $sql = 'SELECT id,longname FROM `languages`';
            $qry = $this->db->prepare($sql);
            
            $qry->execute(); 
            
            if($qry->rowCount() > 0){
                switch ($mode) {
                    case 'ASSOC':
                        return $qry->fetchAll(\PDO::FETCH_KEY_PAIR);
                    case 'ID':
                        return $qry->fetchAll(\PDO::FETCH_COLUMN);
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

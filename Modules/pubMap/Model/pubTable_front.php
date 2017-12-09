<?php
namespace Modules\pubMap\Model;

use System\DateTimeHandler as dth;

class pubTable_front extends \System\AbstractClasses\abstractDb {
    
    // Kocsmák listája a front-end-re.
    // Paraméterek lehetnek koordináták min-max, valamint a szűrőben lévő feltételek,
    // amiket a Controller fog megkapni, és átadni ennek a functionnek. Szóval ezt csak a controller-ből lehet hívni ;)
    // A kész adatok oda mennek vissza, és a Controller pedig átadja a view-nak.
    public function getPubList($params) {
        try {
            $paramCont = new \System\ParameterContainer();
//            $paramCont->addParam('id', $akarmi,  \PDO::PARAM_INT);
//            $paramCont->addParam('name', $string,  \PDO::PARAM_STR);
            // csak példák!!!
            // De mindenképp használj paramétereket! Így pl: " ... WHERE `id` = :id ... "
            
            $sql = '';
            
            $qry = $this->db->prepare($sql);
            
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
            
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
    
    public function getPub($id_vagy_sef) { 
        try {
            //...
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
}

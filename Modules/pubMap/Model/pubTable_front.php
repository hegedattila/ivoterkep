<?php
namespace Modules\pubMap\Model;

use System\DateTimeHandler as dth;

class pubTable_front extends \System\AbstractClasses\abstractDb {
    
    // Kocsmák listája a front-end-re.
    // Paraméterek lehetnek koordináták min-max, valamint a szűrőben lévő feltételek,
    // amiket a Controller fog megkapni, és átadni ennek a functionnek. Szóval ezt csak a controller-ből lehet hívni ;)
    // A kész adatok oda mennek vissza, és a Controller pedig átadja a view-nak.
    
    // Paraméterként várja koordinátapárok min-max értékét, hogy milyen nap van (0-6),
    // illetve, hogy hány óra van.
    // A nyitvatartás szerinti feltétel jelen formában valószínűleg nem működik.
    // (Attila)
    public function getPubList($params) {
        try {
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('min_lat', $params['min_lat'], \PDO::PARAM_INT);
            $paramCont->addParam('max_lat', $params['max_lat'], \PDO::PARAM_INT);
            $paramCont->addParam('min_long', $params['min_long'], \PDO::PARAM_INT);
            $paramCont->addParam('max_long', $params['max_long'], \PDO::PARAM_INT);
            $paramCont->addParam('day', date('w', strtotime($params['time'])), \PDO::PARAM_INT);
            $paramCont->addParam('hour', date('H', strtotime($params['time'])), \PDO::PARAM_INT);
            //$paramCont->addParam('min', date('i', strtotime($params['time'])), \PDO::PARAM_INT);

            
            switch ($params['day']){
                case 0:
                    $paramCont->addParam('open', '`sundayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`sundayClose`', \PDO::PARAM_STR);
                    break;
                case 1:
                    $paramCont->addParam('open', '`mondayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`mondayClose`', \PDO::PARAM_STR);
                    break;
                case 2:
                    $paramCont->addParam('open', '`tuesdayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`tuesdayClose`', \PDO::PARAM_STR);
                    break;
                case 3:
                    $paramCont->addParam('open', '`wednesdayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`wednesdayClose`', \PDO::PARAM_STR);
                    break;
                case 4:
                    $paramCont->addParam('open', '`thursdayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`thursdayClose`', \PDO::PARAM_STR);
                    break;
                case 5:
                    $paramCont->addParam('open', '`fridayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`fridayClose`', \PDO::PARAM_STR);
                    break;
                case 6:
                    $paramCont->addParam('open', '`saturdayOpen`', \PDO::PARAM_STR);
                    $paramCont->addParam('close', '`saturdayClose`', \PDO::PARAM_STR);
                    
                    break;
            }
            
            
            $sql = 'IF :open > :close'
                    . ' SELECT *'
                    . ' FROM pub p'
                    . ' OUTER JOIN pub_coordinates c ON c.pubId = p.id'
                    . ' OUTER JOIN pub_contact ct ON ct.pubId = p.id'
                    . ' WHERE (`latitude` BETWEEN :min_lat AND :max_lat),'
                    . ' AND (`longitude` BETWEEN :min_long AND :max_long),'
                    . ' AND (:hour NOT BETWEEN :close AND :open);'
                    . ' ELSE'
                    . ' SELECT *'
                    . ' FROM pub p'
                    . ' OUTER JOIN pub_coordinates c ON c.pubId = p.id'
                    . ' OUTER JOIN pub_contact ct ON ct.pubId = p.id'
                    . ' WHERE (`latitude` BETWEEN :min_lat AND :max_lat),'
                    . ' AND (`longitude` BETWEEN :min_long AND :max_long),'
                    . ' AND (:hour BETWEEN :open AND :close);';
            
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
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('key', $id_vagy_sef, \PDO::PARAM_STR);
            
            $sql = "SELECT *
                    FROM pub p
                    LEFT JOIN pub_coordinates c ON c.pubId = p.id
                    LEFT JOIN pub_contact ct ON ct.pubId = p.id
                    WHERE `id` = :key OR `sef` LIKE :key";
            
            $qry = $this->db->prepare($sql);
            
            $paramCont->bindAll($qry);
                        
            $qry->execute();
            $data = $qry->fetch(\PDO::FETCH_ASSOC);
            return array_merge($data,$this->getOpens($data['id']));
            //...
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    private function getOpens($id) {
        try {
            $day = strtolower(date('l'));
            $sql = "SELECT *, (:now BETWEEN ".$day."Open AND ".$day."Close) as opened
                FROM pub_open WHERE pubId = :pid;";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('now', date('H:i:s'), \PDO::PARAM_INT);
            $qry->bindValue('pid', $id, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                $out = [
                    'open' => [
                        'monday' => $data['mondayOpen'],
                        'tuesday' => $data['tuesdayOpen'],
                        'wednesday' => $data['wednesdayOpen'],
                        'thursday' => $data['thursdayOpen'],
                        'friday' => $data['fridayOpen'],
                        'saturday' => $data['saturdayOpen'],
                        'sunday' => $data['sundayOpen']
                    ],
                    'close' => [
                        'monday' => $data['mondayClose'],
                        'tuesday' => $data['tuesdayClose'],
                        'wednesday' => $data['wednesdayClose'],
                        'thursday' => $data['thursdayClose'],
                        'friday' => $data['fridayClose'],
                        'saturday' => $data['saturdayClose'],
                        'sunday' => $data['sundayClose']
                    ],
                ];
                
                return $out;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
}

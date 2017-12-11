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
    public function getPubList($params) {
        try {
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('min_lat', $params['minLat'], \PDO::PARAM_INT);
            $paramCont->addParam('max_lat', $params['maxLat'], \PDO::PARAM_INT);
            $paramCont->addParam('min_long', $params['minLong'], \PDO::PARAM_INT);
            $paramCont->addParam('max_long', $params['maxLong'], \PDO::PARAM_INT);
            $paramCont->addParam('now', date('H:i:s'), \PDO::PARAM_INT);
            //$paramCont->addParam('min', date('i', strtotime($params['time'])), \PDO::PARAM_INT);
            
            $today = strtolower(date('l'));
            
            $sql = "SELECT latitude lat, longitude lng, p.name, p.id,
                IF(`".$today."Open` IS NULL OR `".$today."Close` IS NULL, NULL,
                        IF(:now BETWEEN `".$today."Open` AND `".$today."Close`,
                           IF(TIMEDIFF(`".$today."Close`, :now ) < '01:00:00','1hour','open')
                        ,'close')) as opened
                        FROM pub p
                        LEFT JOIN pub_coordinates c ON c.pubId = p.id
                        LEFT JOIN pub_open po ON po.pubId = p.id
                        WHERE (`latitude` BETWEEN :min_lat AND :max_lat)
                        AND (`longitude` BETWEEN :min_long AND :max_long)";
            
            if($params['timeFilterEnabled'] && $params['date'] && $params['time']){
                $day = strtolower(date('l', strtotime($params['date'])));
                $sql .= " AND (`".$day."Open` IS NULL OR `".$day."Close` IS NULL OR
                            (:time BETWEEN `".$day."Open` AND `".$day."Close`)
                        )";
                $paramCont->addParam('time', $params['time'], \PDO::PARAM_STR);
            }
            
            $sql .= " ORDER BY name";
            
            $qry = $this->db->prepare($sql);
            $paramCont->bindAll($qry);
            $qry->execute();
            return $qry->fetchALL(\PDO::FETCH_ASSOC);
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
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
            if($qry->rowCount() == 1){
                return array_merge($data,$this->getOpens($data['id']));
            } else {
                return false;
            }
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
                return [];
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return [];
        }
    }
}

<?php
namespace Modules\login\Model;

class loginTable extends \System\AbstractClasses\abstractDb {

    public function checkPass($uname, $pass) {
        try {
            $sql = "SELECT id FROM users WHERE nick=:nick AND passw=:passw";
            $qry = $this->db->prepare($sql);
            $qry->execute(['nick' => $uname, 'passw'=>$pass]);
            return ($qry->rowCount() == 1)?$qry->fetchColumn():false;
        } catch (PDOException $e) {
            var_dump($e->getMessage());
            return null;
        }
    }
}

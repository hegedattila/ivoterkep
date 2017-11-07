<?php
namespace Modules\content\Model;

use System\DateTimeHandler as dth;

class contentTable extends \System\AbstractClasses\abstractDb {
    
    public function getList($params, $count = false) {
        try {
            $helper = new \Admin\Classes\SqlListHelper($params,['title','nick','active','created_date']);
            $fields = ($count)?
                    'COUNT( DISTINCT c.id )':
                    'DISTINCT c.id, GROUP_CONCAT(l.title ORDER BY l.lang_id ASC SEPARATOR \'<br>\') AS title,
                    u.`nick`,c.`active`,c.`created_date`';
            
            $sql = 'SELECT ' . $fields . ' FROM content c
                   LEFT JOIN users u ON u.id = c.created_by
                   LEFT JOIN content_lang l ON l.content_id = c.id AND l.enabled = 1
                   WHERE c.deleted_date IS NULL
                   GROUP BY c.id';
            
            $sql .= $helper->getSql($count, true);
            $qry = $this->db->prepare($sql);
            $qry->execute($helper->getParams());
            
            return ($count)?$qry->fetchColumn():$qry->fetchALL(\PDO::FETCH_ASSOC);
            
        } catch (PDOException $e) {
        //    var_dump($e->getMessage());
            return null;
        }
    }
    
    public function add($data) {
        try {
            $sql = "INSERT INTO `content` (created_by,created_date,active,publish_date,unpublish_date,lead_image)
                    VALUES (:createdby,:now,:active,:publishdate,:unpublishdate,:leadimage);";
            $qry = $this->db->prepare($sql);
            
        //    \System\DbHandler::setValuesToNull($data,['active','publish_date','unpublish_date','lead_image']);
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('createdby', \System\UserHandler::getUserId(),  \PDO::PARAM_INT);
            $paramCont->addParam('active', isset($data['active'])?1:0,  \PDO::PARAM_INT);
            $paramCont->addParam('now',dth::getNowTimestamp(),\PDO::PARAM_INT);
            $paramCont->addParam('publishdate', dth::getTimestamp($data['publish_date'],'YYYY-MM-DD'),  \PDO::PARAM_INT);
            $paramCont->addParam('unpublishdate', dth::getTimestamp($data['unpublish_date'],'YYYY-MM-DD'),  \PDO::PARAM_INT);
            $paramCont->addParam('leadimage', $data['lead_image'],  \PDO::PARAM_STR);
            
            $paramCont->setEmptyValuesToNull(['active','publishdate','unpublishdate','leadimage']);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                $contentID = $this->db->lastInsertId();
                if($this->saveContentLang($contentID, $data)){
                    return $contentID;
                }
                return false;
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }
    
    public function saveContentLang($contentId,$ld){
        try {
            $paramCont = new \System\ParameterContainer();
            $paramCont->addParam('cid', $contentId, \PDO::PARAM_INT);
            
            $langs = \System\LangHandler::getLangs('ID');
            $defLang = \System\LangHandler::getDefaultLang();
            $insertableRowsSqls = [];
            
                $updateStrings = [
                        'enabled = VALUES(enabled)',
                        'title = VALUES(title)',
                        'sef = VALUES(sef)',
                        'keywords = VALUES(keywords)',
                        'lead = VALUES(lead)',
                        'content = VALUES(content)',
                    ];
                foreach ($langs as $langid) {
                    $paramCont->addParam('langid' . $langid, $langid, \PDO::PARAM_INT);
                    $paramCont->addParam('enabled' . $langid, (isset($ld['enabled'][$langid]) || $langid == $defLang)? 1 : 0, \PDO::PARAM_INT);
                    $paramCont->addParam('title' . $langid, isset($ld['title'][$langid])?$ld['title'][$langid] : null, \PDO::PARAM_STR);
                    $paramCont->addParam('sef' . $langid, isset($ld['sef'][$langid])?$ld['sef'][$langid] : null, \PDO::PARAM_STR);
                    $paramCont->addParam('keywords' . $langid, isset($ld['keywords'][$langid])?$ld['keywords'][$langid] : null, \PDO::PARAM_STR);
                    $paramCont->addParam('lead' . $langid, isset($ld['lead'][$langid])?$ld['lead'][$langid] : null, \PDO::PARAM_STR);
                    $paramCont->addParam('content' . $langid, isset($ld['content'][$langid])?$ld['content'][$langid] : null, \PDO::PARAM_STR);
                    
                    $insertableRowsSqls[$langid] = "(
                            :langid$langid,
                            :cid,
                            :enabled$langid,
                            :title$langid,
                            :sef$langid,
                            :keywords$langid,
                            :lead$langid,
                            :content$langid
                        )";
}
            
            $sql = 'INSERT INTO `content_lang` (lang_id,content_id,enabled,title,sef,keywords,lead,content)
                    VALUES ' . implode(',', $insertableRowsSqls) . '
                    ON DUPLICATE KEY UPDATE ' . implode(',', $updateStrings);
            
            $qry = $this->db->prepare($sql);
            $paramCont->setEmptyValuesToNull();
            $paramCont->bindAll($qry);
            $qry->execute();
            
            return true;
            
        } catch (\PDOException $e) {
           // var_dump($e->getMessage());
            return false;
        }
    }
    
    public function getDataToForm($cid) {
        try {
            $sql = "SELECT * FROM content WHERE id = :cid;";
            $qry = $this->db->prepare($sql);
            
            $qry->bindValue('cid', $cid, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                $data = $qry->fetch(\PDO::FETCH_ASSOC);
                $sql_lang = "SELECT * FROM content_lang WHERE content_id = :cid";
                $qry_l = $this->db->prepare($sql_lang);
                $qry_l->bindValue('cid', $cid, \PDO::PARAM_INT);
                $qry_l->execute();
                $ld = $qry_l->fetchAll(\PDO::FETCH_ASSOC);
                $langData = [];
                
                foreach ($ld as $value) {
                    $lng = $value['lang_id'];
                    foreach ($value as $fieldName => $v) {
                        if(isset($langData[$fieldName])){
                            $langData[$fieldName][$lng] = $v;
                        } else {
                            $langData[$fieldName] = [$lng => $v];
                        }
                    }
                }
                
                return array_merge($data, $langData);
            } else {
                return false;
            }
        } catch (PDOException $e) {
          //  var_dump($e->getMessage());
            return false;
        }
    }

    public function update($id, $data) {
        try {
            $sql = "UPDATE `content` SET
                    active = :active,
                    modified_by = :modby,
                    modified_date = :now,
                    publish_date = :publishdate,
                    unpublish_date = :unpublishdate,
                    lead_image = :leadimage
                    WHERE id = :id";
            $qry = $this->db->prepare($sql);
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('id', $id,  \PDO::PARAM_INT);
            $paramCont->addParam('modby', \System\UserHandler::getUserId(),  \PDO::PARAM_INT);
            $paramCont->addParam('active', isset($data['active'])?1:0,  \PDO::PARAM_INT);
            $paramCont->addParam('now',dth::getNowTimestamp(),\PDO::PARAM_INT);
            $paramCont->addParam('publishdate', dth::getTimestamp($data['publish_date'],'Y-m-d'),  \PDO::PARAM_INT);
            $paramCont->addParam('unpublishdate', dth::getTimestamp($data['unpublish_date'],'Y-m-d'),  \PDO::PARAM_INT);
            $paramCont->addParam('leadimage', $data['lead_image'],  \PDO::PARAM_STR);
            
            $paramCont->setEmptyValuesToNull(['active','publishdate','unpublishdate','leadimage']);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                return $this->saveContentLang($id, $data);
            } else {
                return false;
            }
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
    
    public function delete($ids, $logical = true) {
        try {
            if(!is_array($ids)){
                $ids = [$ids];
            }
            
            $paramCont = new \System\ParameterContainer();
            
            $paramCont->addParam('uid', \System\UserHandler::getUserId(),  \PDO::PARAM_INT);
            $paramCont->addParam('now',dth::getNowTimestamp(),\PDO::PARAM_INT);
            
            $idSqlArr = [];
            $i = 0;
            foreach ($ids as $id) {
                $paramCont->addParam('id_' . $i, $id,  \PDO::PARAM_INT);
                $idSqlArr[] = ':id_' . $i++;
            }
            
            $sql = ($logical)?
                    "UPDATE `content` SET
                    deleted_date = :now,
                    deleted_by = :uid
                    WHERE id IN (" . implode(',',$idSqlArr) . ");" :
                    "DELETE FROM `content`
                    WHERE id IN (" . implode(',',$idSqlArr) . ");" ;
            
            $qry = $this->db->prepare($sql);
            $paramCont->bindAll($qry);
            
            $qry->execute();
            
            if($qry->rowCount() == count($ids)){
                return true;
            } else {
                return false;
            }
        } catch (PDOException $e) {
         //   var_dump($e->getMessage());
            return false;
        }
    }
    
        
    public function getContentBySef($sef,$lang) {
        try {
            $sql = "SELECT c.id, c.lead_image, c.category_id, c.created_by, IFNULL(c.publish_date,c.created_date) as date,
                    cl.title, cl.keywords, cl.lead, cl.content
                    FROM `content` c
                    INNER JOIN content_lang cl ON cl.content_id = c.id AND cl.enabled = 1
                    WHERE cl.sef = :sef
                    AND cl.lang_id = :lang
                    AND cl.enabled = 1
                    AND c.active = 1
                    AND c.deleted_by IS NULL
                    AND (c.publish_date IS NULL OR c.publish_date < :now)
                    AND (c.unpublish_date IS NULL OR c.unpublish_date > :now)";
            
            $qry = $this->db->prepare($sql);
            $qry->bindValue('sef', $sef, \PDO::PARAM_STR);
            $qry->bindValue('now', dth::getNowTimestamp(),\PDO::PARAM_INT);
            $qry->bindValue('lang', $lang, \PDO::PARAM_INT);
            
            $qry->execute();
            
            if($qry->rowCount() == 1){
                return $qry->fetch(\PDO::FETCH_ASSOC);
            } else {
                return false;
            }
        } catch (PDOException $e) {
           // var_dump($e->getMessage());
            return false;
        }
    }
}

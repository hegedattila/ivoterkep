<?php
namespace Modules\content\Controller\FrontEnd;

class contentController extends \System\AbstractClasses\abstractController {
    private $db;
    
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Modules\content\Model\contentTable;
        }
        return $this->db;
    }
    
    public function showAction() {
        $sef = $this->getParam(['routeParams',-1],['moduleRouteParams','sef'],['moduleParams','sef']);
        $table = $this->getTable();
        $list = $table->getContentBySef($sef, 1);
        return $list['content'];
    }
}

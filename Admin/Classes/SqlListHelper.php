<?php

namespace Admin\Classes;
class SqlListHelper {
    private $limit;
    private $page = 0;
    private $search = [];
    private $sort = 'ASC';
    private $sortby = null;
    private $parameters = [];
    private $fields = [];

    public function __construct($params,$fields = []) {
        if(is_array($fields) && count($fields) > 0){
            $this->fields = $fields;
        }
        if(isset($params['page'])){
            $this->page = (int)$params['page'];
        }
        if(isset($params['pageLength'])){
            $this->limit = (int)$params['pageLength'];
        }
        if(isset($params['search'])){
            $this->search = $params['search'];
        }
        if(isset($params['sort'])){
            $this->sort = $params['sort'];
        }
        if(isset($params['sortby']) && in_array($params['sortby'], $this->fields)){
            $this->sortby = $params['sortby'];
        }
    }
    
    public function getSql($count, $alreadyWhere = false ){
        $sql = '';
        if(is_array($this->search) && count($this->search) > 0){
            $i = 0;
            foreach ($this->search as $key => $val) {
                if($val != '' && in_array($key, $this->fields)){
                    if(!$alreadyWhere && $i == 0){
                        $sql .= ' WHERE ';
                    } else {
                        $sql .= ' AND ';
                    }
                    $sql .=  $key . ' LIKE :s_val_' . $i;
                    $this->parameters['s_val_' . $i] = '%' . $val . '%';
                    $i++;
                }
            }
        }
        if(isset($this->sortby) && !$count){
            $srt = ($this->sort == 'ASC')?'ASC':'DESC';
            $sql .= ' ORDER BY ' . $this->sortby . ' ' . $srt;
        }
        if(is_numeric($this->limit) && !$count){
            $sql .= ' LIMIT ' . (int)$this->limit;
            if(is_numeric($this->page)){
                $sql .= ' OFFSET ' . (int)($this->page * $this->limit);
            }
        }
        return $sql;
    }
    
    public function getParams() {
        return $this->parameters;
    }
    
}

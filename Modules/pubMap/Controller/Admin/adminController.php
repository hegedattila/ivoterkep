<?php
namespace Modules\pubMap\Controller\Admin;
use System\Translator as tr;

class adminController extends \System\AbstractClasses\abstractController{
    private $db;
    
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Modules\pubMap\Model\pubTable;
        }
        return $this->db;
    }
    
    public function listAction(){
        $this->setHeaderDataType('JSON');
        
        $params = $this->getParam('POSTParams');
        $pageData = \Admin\Classes\ListHandler::getPageinfo($params, $this->getTable()->getList($params,TRUE));
        $data = $this->getTable()->getList(array_merge($params, $pageData));
        
        $setButtons = function($origData){
            return [
                    [
                        'icoClass' => 'fa fa-times',
                        'url' => 'content/admin/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm'),
                        'tooltip' => tr::translateGlob('common', 'delete')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'content/admin/form/' . $origData['id'],
                        'tooltip' => tr::translateGlob('common', 'edit')
                    ],
                ];
        };
        $submenu = [
            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'content/admin/form/add'],
        ];
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'content', 'contents', 'id', $setButtons);
        $listData['massbuttons'] = [
            [
            'text' => tr::translateGlob('common', 'deleteSelected'),
            'confirm' => tr::translateGlob('common', 'confirm'),
            'url' => 'content/admin/delete'
            ]
        ];
        
        return json_encode(['LIST'=>$listData, 'SUBMENU' => $submenu]);
    }
    
    public function addFormAction(){
//        $this->setHeaderDataType('JSON');
//        return json_encode(['VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
//        $this->setHeaderDataType('JSON');
//        return json_encode([ 'MESSAGE'=>$msg, 'VIEW'=>$view->getContent() ]);
    }
    
    public function addAction(){
//        $this->setHeaderDataType('JSON');
//        return json_encode(['INVALIDINPUTS'=>$invalidFormInputs, 'MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function editAction(){
//        $this->setHeaderDataType('JSON');
//        return json_encode(['INVALIDINPUTS'=>$invalidFormInputs, 'MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function deleteAction(){
//        $this->setHeaderDataType('JSON');
//        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
}

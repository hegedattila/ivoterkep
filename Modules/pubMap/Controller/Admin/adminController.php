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
                        'url' => 'pubMap/admin/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm'),
                        'tooltip' => tr::translateGlob('common', 'delete')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'pubMap/admin/form/' . $origData['id'],
                        'tooltip' => tr::translateGlob('common', 'edit')
                    ],
                ];
        };
        $submenu = [
            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'pubMap/admin/form/add'],
        ];
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'pubMap', 'pubs', 'id', $setButtons);
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
        $this->setHeaderDataType('JSON');
        $form = new \Modules\pubMap\Form\pubForm('/____/pubMap/admin/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setModuleView('pubMap','pubFormView');
        $view->renderView();
        return json_encode(['VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $view = new \System\Renderer();
        $id = $this->getParam(['moduleRouteParams','id']);
        if(is_numeric($id)){
            $data = $this->getTable()->getDataToForm($id);
            if($data){
                $form = new \Modules\content\Form\contentForm('/____/pubMap/admin/save/' . $id);
                $form->setValues( $data );
                $view->setData('form', $form);
                $view->setModuleView('content','contentFormView');
                $view->renderView();
            } else {
                $msg = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId','color'=>'red'];
        }
        return json_encode([ 'MESSAGE'=>$msg, 'VIEW'=>$view->getContent() ]);
    }
    
    public function addAction(){
        $this->setHeaderDataType('JSON');
        $message = ['msg'=>'Az action (addAction) nincs létrehozva.. kérlek, tedd meg ;)','color'=>'red'];
        return json_encode(['INVALIDINPUTS'=>null, 'MESSAGE'=>$message, 'REDIRECT'=>null]);
    }
        
    public function editAction(){
        $this->setHeaderDataType('JSON');
        $message = ['msg'=>'Az action (editAction) nincs létrehozva.. kérlek, tedd meg ;)','color'=>'red'];
        return json_encode(['INVALIDINPUTS'=>null, 'MESSAGE'=>$message, 'REDIRECT'=>null]);
    }
        
    public function deleteAction(){
        $this->setHeaderDataType('JSON');
        $message = ['msg'=>'Az action (deleteAction) nincs létrehozva.. kérlek, tedd meg ;)','color'=>'red'];
        return json_encode(['INVALIDINPUTS'=>null, 'MESSAGE'=>$message, 'REDIRECT'=>null]);
    }
}

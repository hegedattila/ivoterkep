<?php
namespace Admin\Controller\usergroup;
use System\Translator as tr;

class usergroupController extends \System\AbstractClasses\abstractController{
    private $ugdb;
    
    private function getUGTable(){
        if(!isset($this->ugdb)){
            $this->ugdb = new \Admin\Model\usergroup\usergroupTable;
        }
        return $this->ugdb;
    }
    
    public function listAction(){
        $this->setHeaderDataType('JSON');
        
        $params = $this->getParam('POSTParams');
        
        $pageData = \Admin\Classes\ListHandler::getPageinfo($params, $this->getUGTable()->getList($params,TRUE));
        
        $data = $this->getUGTable()->getList(array_merge($params, $pageData));
        
        $setButtons = function($origData){
            return [
                    [
                        'icoClass' => 'fa fa-times',
                        'url' => 'admin/usergroup/delUg/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm'),
                        'tooltip' => tr::translateGlob('common', 'delete')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'admin/usergroup/form/' . $origData['id'],
                        'tooltip' => tr::translateGlob('common', 'edit')
                    ]
                ];
        };
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'usergrps', 'id', $setButtons);
        $submenu = [
            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'admin/usergroup/form/add'],
        ];
        $listData['massbuttons'] = [
            [
                'text' => tr::translateGlob('common', 'deleteSelected'),
                'confirm' => tr::translateGlob('common', 'confirm'),
                'url' => 'admin/usergroup/delUg'
            ],
        ];
        $listData['pageInform'] = $pageData;
        return json_encode(['LIST'=>$listData, 'SUBMENU' => $submenu]);
    }
    
    public function addFormAction(){
        $this->setHeaderDataType('JSON');
        $form = new \Admin\Form\usergroup\ugroupForm('/____/admin/usergroup/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setAdminView('usergroup/ugForm');
        $view->renderView();
        return json_encode([ 'VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $view = new \System\Renderer();
        $id = $this->getParam(['moduleRouteParams','id']);
        if(is_numeric($id)){
            $form = new \Admin\Form\usergroup\ugroupForm('/____/admin/usergroup/save/' . $id);
            $data = $this->getUGTable()->getDataToForm($id);
            if($data != false){
                $form->setValues( $data );
                $view->setData('form', $form);
                $view->setAdminView('usergroup/ugForm');
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
        $form = new \Admin\Form\usergroup\ugroupForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $dbResult = $this->getUGTable()->addUg( $formData );
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/usergroup'];
            } else {
                $msg = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'InvalidForm','color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function editAction(){
        $this->setHeaderDataType('JSON');
        $form = new \Admin\Form\usergroup\ugroupForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $id = $this->getParam(['moduleRouteParams','id']);
            if(is_numeric($id)){
                $dbResult = $this->getUGTable()->editUg( $formData, $id );
            } else {
                $msg = ['msg'=>'noId','color'=>'red'];
            }
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/usergroup'];
            } else {
                $msg = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'InvalidForm','color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function deleteAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $redir = null;
        $id = $this->getParam(['moduleRouteParams','id'],['POSTParams','list']);
        if(isset($id)){
            $dbResult = $this->getUGTable()->delUg($id);
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet', 'color'=>'green'];
                $redir = ['url'=>'admin/usergroup'];
            } else {
                $msg = ['msg'=>'DB Hiba', 'color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId', 'color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
    
}

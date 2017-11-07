<?php
namespace Admin\Controller\users;
use System\Translator as tr;

class userController extends \System\AbstractClasses\abstractController{
    private $udb;
    
    private function getUTable(){
        if(!isset($this->udb)){
            $this->udb = new \Admin\Model\users\userTable;
        }
        return $this->udb;
    }
    
    public function listAction(){
        $this->setHeaderDataType('JSON');
        
        $params = $this->getParam('POSTParams');
        $pageData = \Admin\Classes\ListHandler::getPageinfo($params, $this->getUTable()->getList($params,TRUE));
        $data = $this->getUTable()->getList(array_merge($params, $pageData));
        
        $setButtons = function($origData){
            return [
                    [
                        'icoClass' => 'fa fa-times',
                        'url' => 'admin/user/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'admin/user/form/' . $origData['id'],
                    ],
                ];
        };
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'users', 'id', $setButtons);
        $listData['massbuttons'] = [
            [
            'text' => 'Kijelöltek törlése',
            'confirm' => tr::translateGlob('common', 'confirm'),
            'url' => 'admin/user/delete'
            ]
        ];
        $listData['pageInform'] = $pageData;
        return json_encode(['LIST'=>$listData]);
    }
        
//    public function formAction(){
//        $this->setHeaderDataType('JSON');
//        $msg = null;
//        $id = $this->getParam('id', null);
//        if(is_numeric($id)){
//            $form = new \Admin\Form\user\userForm('/____/admin/user/save/' . $id);
//            $data = $this->getUTable()->getDataToForm($id);
//            if(isset($data) && $data != false){
//                $form->setValues( $data );
//            } else {
//                $msg = ['msg'=>'DB Hiba','color'=>'red'];
//            }
//        } else {
//            $msg = ['msg'=>'noId','color'=>'red'];
//        }
//        $view = new \System\Renderer();
//        $view->setData('form', $form);
//        $view->setAdminView('user/userForm');
//        $view->renderView();
//        return json_encode([ 'MESSAGE'=>$msg, 'VIEW'=>$view->getContent() ]);
//    }
    
//    public function saveAction(){
//        $this->setHeaderDataType('JSON');
//        $msg = null;
//        $redir = null;
//        $id = $this->getParam('id', null);
//        if(is_numeric($id)){
//            $form = new \Admin\Form\user\userForm();
//            $formData = $this->getParam('post');
//            $form->setValues($formData);
//            if($form->validateForm() == true){
//                $dbResult = $this->getUTable()->editUser( $formData, $id );
//                if($dbResult) {
//                    $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
//                    $redir = ['url'=>'admin/user/form/' . $id];
//                } else {
//                    $msg = ['msg'=>'DB Hiba','color'=>'red'];
//                }
//            } else {
//                $msg = ['msg'=>'InvalidForm','color'=>'red'];
//            }
//        } else {
//            $msg = ['msg'=>'noId','color'=>'red'];
//        }
//        
//        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
//    }
            
    public function deleteAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $redir = null;
        $id = $this->getParam(['moduleRouteParams','id'],['POSTParams','list']);
        if(isset($id)){
            $dbResult = $this->getUTable()->delUser($id);
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet', 'color'=>'green'];
                $redir = ['url'=>'admin/user'];
            } else {
                $msg = ['msg'=>'DB Hiba', 'color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId', 'color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
}

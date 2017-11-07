<?php
namespace Admin\Controller\route;
use System\Translator as tr;

class routeController extends \System\AbstractClasses\abstractController{
    
    private $db;
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Admin\Model\route\routeTable;
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
                        'url' => 'admin/route/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'admin/route/form/' . $origData['id'],
                    ],
                ];
        };
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'routes', 'id', $setButtons);
        $submenu = [
            ['label' => 'Új hozzáadása', 'icon' => 'plus-circle', 'action' => 'admin/route/form/add'],
        ];
        $listData['pageInform'] = $pageData;
        return json_encode(['LIST'=>$listData, 'SUBMENU' => $submenu]);
    }
    
    public function viewAction(){
        $this->setHeaderDataType('JSON');
        $view = new \System\Renderer();
        $view->setAdminView('route/routes');
        $view->renderView();
        $submenu = [
            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'admin/route/form/add'],
        ];
        return json_encode([ 'VIEW'=>$view->getContent(), 'SUBMENU' => $submenu]);
    }
        
    public function getListAction(){
        $this->setHeaderDataType('JSON');
        $routes = $this->getTable()->getList();
        return json_encode($routes);
    }
   
    public function addFormAction(){
        $this->setHeaderDataType('JSON');
        $templates = $this->getTable()->getTemplates();
        $form = new \Admin\Form\route\routeForm($templates, '/____/admin/route/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setAdminView('route/form');
        $view->renderView();
        return json_encode([ 'VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $view = new \System\Renderer();
        $id = $this->getParam(['moduleRouteParams','id']);
        if( is_numeric($id) ){
            $templates = $this->getTable()->getTemplates();
            $form = new \Admin\Form\route\routeForm($templates, '/____/admin/route/save/' . $id);
            $data = $this->getTable()->getDataToForm($id);
            if($data != false){
                $form->setValues( $data );
                $view->setData('form', $form);
                $view->setAdminView('route/form');
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
        $templates = $this->getTable()->getTemplates();
        $form = new \Admin\Form\route\routeForm($templates, null);
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $dbResult = $this->getTable()->save( $formData );
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/route'];
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
        $templates = $this->getTable()->getTemplates();
        $form = new \Admin\Form\route\routeForm($templates, null);
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $id = $this->getParam(['moduleRouteParams','id']);
            if( is_numeric($id) ){
                $dbResult = $this->getTable()->save( $formData, $id );
            } else {
                $msg = ['msg'=>'noId','color'=>'red'];
            }
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/route'];
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
        $id = $this->getParam(['moduleRouteParams','id']);
        if(isset($id)){
            $dbResult = $this->getTable()->delete($id);
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet', 'color'=>'green'];
                $redir = ['url'=>'admin/route'];
            } else {
                $msg = ['msg'=>'DB Hiba', 'color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId', 'color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
    
}

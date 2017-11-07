<?php
namespace Admin\Controller\permission;
class permissionController extends \System\AbstractClasses\abstractController{
    
    private $permdb;
    private function getPermTable(){
        if(!isset($this->permdb)){
            $this->permdb = new \Admin\Model\permission\permissionTable;
        }
        return $this->permdb;
    }
    
    public function listAction(){
        $this->setHeaderDataType('JSON');
        
        $params = $this->getParam('POSTParams');
        
        $pageData = \Admin\Classes\ListHandler::getPageinfo($params, $this->getPermTable()->getList($params,TRUE));
        
        $data = $this->getPermTable()->getList(array_merge($params, $pageData));
        
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'permissions', 'id', null);
        $listData['pageInform'] = $pageData;
        return json_encode(['LIST' => $listData, 'MESSAGE' => ['msg'=>'Sikeres művelet','color'=>'green']]);
    }
    
    public function permToGroupFormAction() {
        $perms = $this->getPermTable()->getPermissionsToForm();
        $ugroups = $this->getPermTable()->getUGroupsToForm();
        $view = new \System\Renderer();
        $view->setAdminView('permission/permToGroupForm');
        $view->setData('perms', $perms);
        $view->setData('groups', $ugroups);
        $view->renderView();
        return $view->getContent();
    }
    
    public function getPermissionsToGroupAction(){
        $this->setHeaderDataType('JSON');
        $perms = $this->getPermTable()->getPermissionsGroupsToForm();
        return json_encode($perms);
    }    
    public function setPermissionToGroupAction(){
        $this->setHeaderDataType('JSON');
        $data = $this->getParam('POSTParams');
        return $this->getPermTable()->setPermissionToGroup(
                $data['perm'],
                $data['group'],
                $data['action']
                );
    }
    
}

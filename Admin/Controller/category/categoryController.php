<?php
namespace Admin\Controller\module;
use System\Translator as tr;

class contentController extends \System\AbstractClasses\abstractController{
    private $db;
    
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Admin\Model\category\categoryTable;
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
                        'url' => 'admin/category/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm'),
                        'tooltip' => tr::translateGlob('common', 'delete')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'admin/category/form/' . $origData['id'],
                        'tooltip' => tr::translateGlob('common', 'edit')
                    ],
                ];
        };
        $submenu = [
            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'admin/category/form/add'],
        ];
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'category', 'id', $setButtons);
        $listData['massbuttons'] = [
            [
            'text' => tr::translateGlob('common', 'deleteSelected'),
            'confirm' => tr::translateGlob('common', 'confirm'),
            'url' => 'admin/category/delete'
            ]
        ];
        
        return json_encode(['LIST'=>$listData, 'SUBMENU' => $submenu]);
    }
    
    public function addFormAction(){
        $this->setHeaderDataType('JSON');
        $langs = \System\LangHandler::getLangs();
        $defLang = \System\LangHandler::getDefaultLang();
        $form = new \Modules\content\Form\contentForm('/____/content/admin/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setData('langs', $langs);
        $view->setData('defaultLang', $defLang);
        $view->setModuleView('content','contentFormView');
        $view->renderView();
        return json_encode(['VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $view = new \System\Renderer();
        $id = $this->getParam(['moduleRouteParams','id']);
        if(is_numeric($id)){
            $form = new \Modules\content\Form\contentForm('' . $id);
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
        $form = new \Modules\content\Form\contentForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
    //    var_dump($this->getParam(),$_FILES);
        $msg = null;
        $redir = null;
        $invalidFormInputs = null;
        $dbResult = false;
        if($form->validateForm()){
//            $dbResult = $this->getTable()->add( $formData );
//            if($dbResult) {
//                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
//              //  $redir = ['url'=>'admin/usergroup'];
//            } else {
//                $msg = ['msg'=>'DB Hiba','color'=>'red'];
//            }
        } else {
            $msg = ['msg'=>'InvalidForm','color'=>'red'];
            $invalidFormInputs = $form->getInvalidElements();
        }
        
        return json_encode(['INVALIDINPUTS'=>$invalidFormInputs, 'MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function editAction(){
        $this->setHeaderDataType('JSON');
        $form = new \Admin\Form\usergroup\ugroupForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm()){
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

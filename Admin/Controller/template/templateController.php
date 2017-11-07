<?php
namespace Admin\Controller\template;
use System\Translator as tr;

class templateController extends \System\AbstractClasses\abstractController{
    
    private $db;
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Admin\Model\template\templateTable;
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
                        'url' => 'admin/template/delete/' . $origData['id'],
                        'confirm' => tr::translateGlob('common', 'confirm')
                    ],
                    [
                        'icoClass' => 'fa fa-pencil',
                        'url' => 'admin/template/form/' . $origData['id'],
                    ],
                ];
        };
        $listData = \Admin\Classes\ListHandler::prepareList($data, 'admin', 'templates', 'id', $setButtons);
        
        $submenu = [
            [
                'label' => 'New',
                'icon' => 'plus-circle',
                'action' => 'admin/template/form/add'
                ],
        ];
        
        $listData['pageInform'] = $pageData;
        return json_encode(['LIST'=>$listData, 'SUBMENU' => $submenu]);
    }
    
//    public function viewAction(){
//        $this->setHeaderDataType('JSON');
//        $view = new \System\Renderer();
//        $view->setAdminView('route/routes');
//        $view->renderView();
//        $submenu = [
//            ['label' => 'New', 'icon' => 'plus-circle', 'action' => 'admin/route/form/add'],
//        ];
//        return json_encode([ 'VIEW'=>$view->getContent(), 'SUBMENU' => $submenu]);
//    }
//    
    public function addFormAction(){
        $this->setHeaderDataType('JSON');
        $lays = $this->getTable()->getLayouts();
        $lFileNames = $this->getTable()->getLayoutFilenames();
        $form = new \Admin\Form\template\templateForm($lays, '/____/admin/template/save/add');
        $view = new \System\Renderer();
        $view->setData('form', $form);
        $view->setData('filenames', $lFileNames);
        $view->setAdminView('template/form');
        $view->renderView();
        return json_encode([ 'VIEW'=>$view->getContent() ]);
    }
    
    public function editFormAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $view = new \System\Renderer();
        $id = $this->getParam(['moduleRouteParams','id']);
        if( is_numeric($id) ){
            $lays = $this->getTable()->getLayouts();
            $form = new \Admin\Form\template\templateForm($lays, '/____/admin/template/save/' . $id);
            $data = $this->getTable()->getDataToForm($id);
            if($data != false){
                $form->setValues( $data );
                $view->setData('form', $form);
                $view->setAdminView('template/form');
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
        $lays = $this->getTable()->getLayouts();
        $form = new \Admin\Form\template\templateForm($lays);
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $dbResult = $this->getTable()->save( $formData );
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/template'];
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
        $lays = $this->getTable()->getLayouts();
        $form = new \Admin\Form\template\templateForm($lays);
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $dbResult = false;
        if($form->validateForm() == true){
            $id = $this->getParam(['moduleRouteParams','id']);
            if( is_numeric($id) ){
                $dbResult = $this->getTable()->save($formData, $id);
            } else {
                $msg = ['msg'=>'noId','color'=>'red'];
            }
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'admin/template'];
            } else {
                $msg = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'InvalidForm','color'=>'red'];
        }
        
        return json_encode(['MESSAGE' => $msg, 'REDIRECT' => $redir]);
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
                $redir = ['url'=>'admin/template'];
            } else {
                $msg = ['msg'=>'DB Hiba', 'color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId', 'color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
            
    public function viewToFormAction(){
        $templateId = $this->getParam(['POSTParams','tplid']);
        
        if(!is_numeric($templateId)) {
            return 'No tid';
        }
        $file = $this->getTable()->getLayoutFilename($templateId);
        if(!$file) {
            return 'No file';
        }
        
        $view = new \System\Renderer(null,true);
        $view->setView($file);
        $view->renderView();
        $content = $view->getContent();
        if(isset($content) && $content != ''){
            $dom = new \DOMDocument;
            $dom->loadHTML($content);
            foreach(iterator_to_array($dom->getElementsByTagName('script')) as $node) {
                $node->parentNode->removeChild($node);
            }
            return $dom->saveHTML();
        } else {
            return 'No HTML!';
        }
    }
    
}

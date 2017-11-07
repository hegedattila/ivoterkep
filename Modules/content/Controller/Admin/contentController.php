<?php
namespace Modules\content\Controller\Admin;
use System\Translator as tr;

class contentController extends \System\AbstractClasses\abstractController{
    private $db;
    
    private function getTable(){
        if(!isset($this->db)){
            $this->db = new \Modules\content\Model\contentTable;
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
            $data = $this->getTable()->getDataToForm($id);
            if($data){
                $form = new \Modules\content\Form\contentForm('/____/content/admin/save/' . $id);
                $form->setValues( $data );
                $view->setData('langs', \System\LangHandler::getLangs());
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
        $form = new \Modules\content\Form\contentForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        $msg = [];
        $redir = null;
        $invalidFormInputs = null;
        $newId = NULL;
        if($form->validateForm()){
            $formData['lead_image'] = null;
            $uploader = new \System\UploadHandler('content_leadimage', 'lead_image');
            if($uploader->upload()){
                $uploaded = $uploader->getSavedFilenames('lead_image');
                if(isset($uploaded['lim']) && is_string($uploaded['lim'])){
                    $formData['lead_image'] = $uploaded['lim'];
                }
            } else {
                $msg[] = ['msg' => 'Egy vagy több képet nem sikerült feltölteni:<br>'.
                    $uploader->getMessage('lead_image'),'color' => 'red'];
            }
            $newId = $this->getTable()->add( $formData );
            if($newId) {
                $msg[] = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'content/admin/form/' . $newId];
            } else {
                $msg[] = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg[] = ['msg'=>'InvalidForm','color'=>'red'];
            $invalidFormInputs = $form->getInvalidElements();
        }
        return json_encode(['INVALIDINPUTS'=>$invalidFormInputs, 'MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function editAction(){
        $this->setHeaderDataType('JSON');
        $form = new \Modules\content\Form\contentForm();
        $formData = $this->getParam('POSTParams');
        $cont_id = $this->getParam(['moduleRouteParams','id']);
        $form->setValues($formData);
        $msg = null;
        $redir = null;
        $invalidFormInputs = null;
        $dbResult = false;
        if($form->validateForm()){
            $formData['lead_image'] = null;
            $uploader = new \System\UploadHandler('content_leadimage', 'lead_image');
            if($uploader->upload()){
                $uploaded = $uploader->getSavedFilenames('lead_image');
                if(isset($uploaded['lim']) && is_string($uploaded['lim'])){
                    $formData['lead_image'] = $uploaded['lim'];
                }
            } else {
                $msg[] = ['msg' => 'Egy vagy több képet nem sikerült feltölteni:<br>'.
                    $uploader->getMessage('lead_image'),'color' => 'red'];
            }
            $dbResult = $this->getTable()->update( $cont_id, $formData );
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet','color'=>'green'];
                $redir = ['url'=>'content/admin'];
            } else {
                $msg = ['msg'=>'DB Hiba','color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'InvalidForm','color'=>'red'];
            $invalidFormInputs = $form->getInvalidElements();
        }
        return json_encode(['INVALIDINPUTS'=>$invalidFormInputs, 'MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
        
    public function deleteAction(){
        $this->setHeaderDataType('JSON');
        $msg = null;
        $redir = null;
        $id = $this->getParam(['moduleRouteParams','id'],['POSTParams','list']);
        if(isset($id)){
            $dbResult = $this->getTable()->delete($id);
            if($dbResult) {
                $msg = ['msg'=>'Sikeres művelet', 'color'=>'green'];
                $redir = ['url'=>'content/admin'];
            } else {
                $msg = ['msg'=>'DB Hiba', 'color'=>'red'];
            }
        } else {
            $msg = ['msg'=>'noId', 'color'=>'red'];
        }
        
        return json_encode(['MESSAGE'=>$msg, 'REDIRECT'=>$redir]);
    }
    
    // tinymce upload function
    public function tmceUploadAction() { //TODO
        var_dump(1243);
    }
    
    public function tplFormAction() {
    }
    
}

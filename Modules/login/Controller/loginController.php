<?php
namespace Modules\login\Controller;
use System\Renderer;

use Modules\login\Form\loginForm;

class loginController extends \System\AbstractClasses\abstractController{
    public function showLoginFormAction(){
        $form = new loginForm($this->getParam(['moduleParams','formAction']));
        $view = new Renderer();
        $view->setModuleView('login', 'form');
        $view->setData('form', $form);
        $view->renderView();
        return $view->getContent();
    }
    
    public function showLogoutAction(){
        $view = new Renderer();
        $view->setModuleView('login', 'logout');
        $view->setData('logoutUrl', $this->getParam(['moduleParams','formAction']));
        $view->renderView();
        return $view->getContent();
    }
    
    public function loginAction(){
        $form = new loginForm();
        $formData = $this->getParam('POSTParams');
        $form->setValues($formData);
        if($form->validateForm()){
            $coder = \System\ConfigLoader::getConfigPhp('loginConfig', 'passGen');
            $codedPass = $coder($formData['password']);
            $db = new \Modules\login\Model\loginTable;
            $uid = $db->checkPass($formData['username'], $codedPass);
            if(isset($uid) && \System\SessionHandler::regSn($uid)){
                header("Refresh:1;");
                return 'OK';
            } else {
                return 'Wrong Pass';
            }
        }
        return 'HIBA';
    }
    
    public function logoutAction(){
        \System\SessionHandler::destroySn();
    }
    
}
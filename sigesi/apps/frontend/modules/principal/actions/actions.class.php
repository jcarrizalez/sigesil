<?php

/**
 * principal actions.
 *
 * @package    pruebaSigesi
 * @subpackage principal
 * @author     Your name here
 * @version    SVN: $Id: actions.class.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class principalActions extends sfActions {

    /**
     * Executes index action
     *
     * @param sfRequest $request A request object
     */
    public function executeIndex(sfWebRequest $request) {
        /* Esta accion se comenta ya que la genera el symfony por defecto y funciona para el redireccionado
         * $this->forward('default', 'module');
         */
        //$this->redirect('principal/hola');
    }

}

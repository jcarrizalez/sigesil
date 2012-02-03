<?php

/**
 * silos actions.
 *
 * @package    sigesi
 * @subpackage silos
 * @author     Your name here
 * @version    SVN: $Id: actions.class.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class silosActions extends sfActions
{
  public function executeIndex(sfWebRequest $request)
  {
    $this->si_siloss = Doctrine_Core::getTable('SiSilos')
      ->createQuery('a')
      ->execute();
  }

  public function executeNew(sfWebRequest $request)
  {
    $this->form = new SiSilosForm();
  }

  public function executeCreate(sfWebRequest $request)
  {
    $this->forward404Unless($request->isMethod(sfRequest::POST));

    $this->form = new SiSilosForm();

    $this->processForm($request, $this->form);

    $this->setTemplate('new');
  }

  public function executeEdit(sfWebRequest $request)
  {
    $this->forward404Unless($si_silos = Doctrine_Core::getTable('SiSilos')->find(array($request->getParameter('id'))), sprintf('Object si_silos does not exist (%s).', $request->getParameter('id')));
    $this->form = new SiSilosForm($si_silos);
  }

  public function executeUpdate(sfWebRequest $request)
  {
    $this->forward404Unless($request->isMethod(sfRequest::POST) || $request->isMethod(sfRequest::PUT));
    $this->forward404Unless($si_silos = Doctrine_Core::getTable('SiSilos')->find(array($request->getParameter('id'))), sprintf('Object si_silos does not exist (%s).', $request->getParameter('id')));
    $this->form = new SiSilosForm($si_silos);

    $this->processForm($request, $this->form);

    $this->setTemplate('edit');
  }

  public function executeDelete(sfWebRequest $request)
  {
    $request->checkCSRFProtection();

    $this->forward404Unless($si_silos = Doctrine_Core::getTable('SiSilos')->find(array($request->getParameter('id'))), sprintf('Object si_silos does not exist (%s).', $request->getParameter('id')));
    $si_silos->delete();

    $this->redirect('silos/index');
  }

  protected function processForm(sfWebRequest $request, sfForm $form)
  {
    $form->bind($request->getParameter($form->getName()), $request->getFiles($form->getName()));
    if ($form->isValid())
    {
      $si_silos = $form->save();

      $this->redirect('silos/edit?id='.$si_silos->getId());
    }
  }
}

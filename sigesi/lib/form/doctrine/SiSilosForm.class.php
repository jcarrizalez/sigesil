<?php

/**
 * SiSilos form.
 *
 * @package    sigesi
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormTemplate.php 23810 2009-11-12 11:07:44Z Kris.Wallsmith $
 */
class SiSilosForm extends BaseSiSilosForm
{
  public function configure()
  {
      $this->getWidget('id_centro_acopio')->addOption('method', 'getNombre')->addOption('add_empty', 'Seleccione');
  }
}

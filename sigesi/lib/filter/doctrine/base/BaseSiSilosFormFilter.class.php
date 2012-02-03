<?php

/**
 * SiSilos filter form base class.
 *
 * @package    sigesi
 * @subpackage filter
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormFilterGeneratedTemplate.php 29570 2010-05-21 14:49:47Z Kris.Wallsmith $
 */
abstract class BaseSiSilosFormFilter extends BaseFormFilterDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id_centro_acopio' => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('SiCentroAcopio'), 'add_empty' => true)),
      'nombre'           => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'ubicacion'        => new sfWidgetFormFilterInput(),
    ));

    $this->setValidators(array(
      'id_centro_acopio' => new sfValidatorDoctrineChoice(array('required' => false, 'model' => $this->getRelatedModelName('SiCentroAcopio'), 'column' => 'id')),
      'nombre'           => new sfValidatorPass(array('required' => false)),
      'ubicacion'        => new sfValidatorPass(array('required' => false)),
    ));

    $this->widgetSchema->setNameFormat('si_silos_filters[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'SiSilos';
  }

  public function getFields()
  {
    return array(
      'id'               => 'Number',
      'id_centro_acopio' => 'ForeignKey',
      'nombre'           => 'Text',
      'ubicacion'        => 'Text',
    );
  }
}

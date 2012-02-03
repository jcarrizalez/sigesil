<?php

/**
 * SiCentroAcopio filter form base class.
 *
 * @package    sigesi
 * @subpackage filter
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormFilterGeneratedTemplate.php 29570 2010-05-21 14:49:47Z Kris.Wallsmith $
 */
abstract class BaseSiCentroAcopioFormFilter extends BaseFormFilterDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'nombre'          => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'rif'             => new sfWidgetFormFilterInput(array('with_empty' => false)),
      'telefono'        => new sfWidgetFormFilterInput(),
      'email'           => new sfWidgetFormFilterInput(),
      'ubicacion'       => new sfWidgetFormFilterInput(),
      'coordenadas'     => new sfWidgetFormFilterInput(),
      'id_sap'          => new sfWidgetFormFilterInput(),
      'id_organizacion' => new sfWidgetFormFilterInput(),
    ));

    $this->setValidators(array(
      'nombre'          => new sfValidatorPass(array('required' => false)),
      'rif'             => new sfValidatorPass(array('required' => false)),
      'telefono'        => new sfValidatorPass(array('required' => false)),
      'email'           => new sfValidatorPass(array('required' => false)),
      'ubicacion'       => new sfValidatorPass(array('required' => false)),
      'coordenadas'     => new sfValidatorPass(array('required' => false)),
      'id_sap'          => new sfValidatorPass(array('required' => false)),
      'id_organizacion' => new sfValidatorPass(array('required' => false)),
    ));

    $this->widgetSchema->setNameFormat('si_centro_acopio_filters[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'SiCentroAcopio';
  }

  public function getFields()
  {
    return array(
      'id'              => 'Number',
      'nombre'          => 'Text',
      'rif'             => 'Text',
      'telefono'        => 'Text',
      'email'           => 'Text',
      'ubicacion'       => 'Text',
      'coordenadas'     => 'Text',
      'id_sap'          => 'Text',
      'id_organizacion' => 'Text',
    );
  }
}

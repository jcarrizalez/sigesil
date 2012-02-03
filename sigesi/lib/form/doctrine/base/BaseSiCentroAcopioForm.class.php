<?php

/**
 * SiCentroAcopio form base class.
 *
 * @method SiCentroAcopio getObject() Returns the current form's model object
 *
 * @package    sigesi
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseSiCentroAcopioForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'              => new sfWidgetFormInputHidden(),
      'nombre'          => new sfWidgetFormInputText(),
      'rif'             => new sfWidgetFormInputText(),
      'telefono'        => new sfWidgetFormInputText(),
      'email'           => new sfWidgetFormInputText(),
      'ubicacion'       => new sfWidgetFormInputText(),
      'coordenadas'     => new sfWidgetFormInputText(),
      'id_sap'          => new sfWidgetFormInputText(),
      'id_organizacion' => new sfWidgetFormInputText(),
    ));

    $this->setValidators(array(
      'id'              => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'nombre'          => new sfValidatorString(array('max_length' => 255)),
      'rif'             => new sfValidatorString(array('max_length' => 255)),
      'telefono'        => new sfValidatorString(array('max_length' => 255, 'required' => false)),
      'email'           => new sfValidatorString(array('max_length' => 255, 'required' => false)),
      'ubicacion'       => new sfValidatorString(array('max_length' => 255, 'required' => false)),
      'coordenadas'     => new sfValidatorString(array('max_length' => 255, 'required' => false)),
      'id_sap'          => new sfValidatorString(array('max_length' => 255, 'required' => false)),
      'id_organizacion' => new sfValidatorString(array('max_length' => 255, 'required' => false)),
    ));

    $this->widgetSchema->setNameFormat('si_centro_acopio[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'SiCentroAcopio';
  }

}

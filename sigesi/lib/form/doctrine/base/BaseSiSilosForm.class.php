<?php

/**
 * SiSilos form base class.
 *
 * @method SiSilos getObject() Returns the current form's model object
 *
 * @package    sigesi
 * @subpackage form
 * @author     Your name here
 * @version    SVN: $Id: sfDoctrineFormGeneratedTemplate.php 29553 2010-05-20 14:33:00Z Kris.Wallsmith $
 */
abstract class BaseSiSilosForm extends BaseFormDoctrine
{
  public function setup()
  {
    $this->setWidgets(array(
      'id'               => new sfWidgetFormInputHidden(),
      'id_centro_acopio' => new sfWidgetFormDoctrineChoice(array('model' => $this->getRelatedModelName('SiCentroAcopio'), 'add_empty' => false)),
      'nombre'           => new sfWidgetFormInputText(),
      'ubicacion'        => new sfWidgetFormInputText(),
    ));

    $this->setValidators(array(
      'id'               => new sfValidatorChoice(array('choices' => array($this->getObject()->get('id')), 'empty_value' => $this->getObject()->get('id'), 'required' => false)),
      'id_centro_acopio' => new sfValidatorDoctrineChoice(array('model' => $this->getRelatedModelName('SiCentroAcopio'))),
      'nombre'           => new sfValidatorString(array('max_length' => 255)),
      'ubicacion'        => new sfValidatorString(array('max_length' => 3, 'required' => false)),
    ));

    $this->widgetSchema->setNameFormat('si_silos[%s]');

    $this->errorSchema = new sfValidatorErrorSchema($this->validatorSchema);

    $this->setupInheritance();

    parent::setup();
  }

  public function getModelName()
  {
    return 'SiSilos';
  }

}

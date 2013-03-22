<?php
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');

    $user = new Usuario();
    if ($_REQUEST['ac'] == 'save') {
        $user->id = $_SESSION['s_id'];
        $GPC['Usuario']['contrasena'] = sha1($GPC['Usuario']['contrasena']);
        $user->save($GPC['Usuario']);
        $mensaje = 'Datos Actualizados !';
    }

    $usuarioInfo = $user->find(array('id' => $_SESSION['s_id']));
    //Validation of the form data
    $validator = new Validator('formUsuario');
    $validator->printIncludes();

    $validator->setRules('Usuario.nombre', array('required' => array('value' => true, 'message' => 'Requerido'), 'minlength' => array('value' => 2, 'message' => 'M&iacute;nimo 2 Caracteres')));
    $validator->setRules('Usuario.apellido', array('required' => array('value' => true, 'message' => 'Requerido'), 'minlength' => array('value' => 2, 'message' => 'M&iacute;nimo 2 Caracteres')));
    $validator->setRules('Usuario.edad', array('required' => array('value' => true, 'message' => 'Requerido'), 'maxlength' => array('value' => 2, 'message' => 'M&aacute;ximo 2 Caracteres')));
    $validator->setRules('Usuario.sexo', array('required' => array('value' => 1, 'message' => 'Seleccione')));

    $validator->setRules('contrasenaant', array('required' => array('value' => true, 'message' => 'Requerido'), 'minlength' => array('value' => 5, 'message' => 'M&iacute;nimo 5 Caracteres')));
    $validator->setRules('Usuario.contrasena', array('equalTo' => array('value' => '"#contrasenaant"', 'message' => 'Especif&iacute;que la misma contrase&ntilde;a')));
    //$validator->setRules('User.question', array('required' => array('value' => true, 'message' => $lang['txtAlertQuestion']), 'minlength' => array('value' => 5, 'message' => $lang['txtAlertMin5Len'])));
    //$validator->setRules('User.answer', array('required' => array('value' => true, 'message' => $lang['txtAlertAnswer']), 'minlength' => array('value' => 5, 'message' => $lang['txtAlertMin5Len'])));

    $validator->printScript();
?>
    <script type="text/javascript">
        $(document).ready(function(){
            result = true;
            if(!result)
                $('#btnSave').attr('disabled', 'disabled');
            else
                $('#btnSave').removeAttr('disabled');	
        });
    </script>
    <div id="titulo">
        <span>Mi Informaci&oacute;n</span>
    </div>
    <form action="?ac=save" method="post" id="formUsuario">
        <br>
        <table width="100%" cellspacing="0" cellpadding="0" border="0" >
            <?php if($mensaje != null){ ?>
            <tr>
                <td colspan="3" align="center" height="30" valign="top"><strong><span class="etiquetas"><?php echo $mensaje?></span></strong></td>
            </tr>
            <?php
                    unset($mensaje);
                }
            ?>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Nombres</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('Usuario.nombre', $usuarioInfo[0]['nombre'], array('class' => 'camposTexto')) ?></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Apellidos</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62"><?php echo $html->input('Usuario.apellido', $usuarioInfo[0]['apellido'], array('class' => 'camposTexto')) ?></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">C&eacute;dula</span></strong></td>
                <td width="3%" align="center" class="requerido"></td>
                <td width="62%"><span style="color: #000000; font-family: arial,helvetica,sans-serif; font-size: 12px;"><?php echo $usuarioInfo[0]['cedula']; ?></span></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Edad</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('Usuario.edad', $usuarioInfo[0]['edad'], array('class' => 'camposTexto')) ?></td>
            </tr>
            <?php
                $sexoList = array(''=>'Seleccione', 'F'=>'Femenino', 'M'=>'Masculino');
            ?>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Sexo</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->select('Usuario.sexo',array('options'=>$sexoList,'selected' => $usuarioInfo[0]['sexo'])); ?></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Contrasena</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('contrasenaant', '', array('type' => 'password', 'class' => 'camposTexto')) ?></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas">Confirmar Contrasena</span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('Usuario.contrasena', '', array('type' => 'password', 'class' => 'camposTexto')) ?></td>
            </tr>
            <!--<tr>
                <td width="35%" align="right"><strong><span class="etiquetas"><?php echo $lang['txtSecurityQuestion'] ?></span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('Usuario.question', $usuarioInfo[0]['question'], array('class' => 'camposTexto')) ?></td>
            </tr>
            <tr>
                <td width="35%" align="right"><strong><span class="etiquetas"><?php echo $lang['txtAnswer'] ?></span></strong></td>
                <td width="3%" align="center" class="requerido">*</td>
                <td width="62%"><?php echo $html->input('Usuario.answer', $usuarioInfo[0]['answer'], array('class' => 'camposTexto')) ?></td>
            </tr>-->
        </table>
        <div id="titulo">
        </div>
        <span style="color: #F00; width: 100%;"><br/>* Campos Requeridos</span>
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td height="40" align="center"><input type="submit" value="Guardar" id="btnSave" /></td>
                </tr>
            </table>
            <?php
                echo $html->input('Usuario.id', $usuarioInfo[0]['id'], array('type' => 'hidden'));
            ?>
    </form>
<?php require('../lib/common/footer.php'); ?>
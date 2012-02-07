<?
require_once('../lib/core.lib.php');

$usuarios = new User();
$html = new Html;
$listSexo = array('F' => 'Femenino', 'M' => 'Masculino');

switch ($GPC['ac']) {
    case 'save':
        $sep_fecha = explode("-", $GPC['Paciente']['fecha_nacimiento']);
        $GPC['Paciente']['fecha_nacimiento'] = $sep_fecha[2] . "-" . $sep_fecha[1] . "-" . $sep_fecha[0];
        $usuarios->save($GPC['Paciente']);
        $usuarios->guardarPerfilUsuario($usuarios->id, PACIENTE);
        $_SESSION['msg'] = 'completado';
        header('location: pacientes_lista.php');
        break;
    case 'editar':
        $idUsuario = $GPC['id'];
        $usuarioInfo = $usuarios->find(array('id' => $idUsuario));
        $sep_fecha = explode("-", $usuarioInfo[0]['fecha_nacimiento']);
        $fecha_nacimiento = $sep_fecha[2] . "-" . $sep_fecha[1] . "-" . $sep_fecha[0];
        $edad = $general->calculaEdad($usuarioInfo[0]['fecha_nacimiento']);
        break;
    case 'editado':
        $sep_fecha = explode("-", $GPC['Paciente']['fecha_nacimiento']);
        $GPC['Paciente']['fecha_nacimiento'] = $sep_fecha[2] . "-" . $sep_fecha[1] . "-" . $sep_fecha[0];
        $GPC['Paciente']['id'] = $GPC['idUsuario'];
        $usuarios->save($GPC['Paciente']);
        $_SESSION['msg'] = 'editado';
        header('location: pacientes_lista.php');
        break;
}

require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Paciente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Paciente.apellido', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Paciente.cedula', array(
    'required' => array('value' => true, 'message' => 'Requerido'),
    'number' => array('value' => true, 'message' => 'Ingrese solo Numeros'),
    'minlength' => array('value' => 6, 'message' => 'Minimo 6 Digitos'),
    'maxlength' => array('value' => 8, 'message' => 'Maximo 8 Digitos')
));
$validator->setRules('Paciente.sexo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Paciente.direccion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Paciente.fecha_nacimiento', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function calculaEdad(){
        var sep_fecha = $('#Paciente\\[fecha_nacimiento\\]').val().split("-");
        fechaActual = new Date();
        dia = fechaActual.getDate();
        mes = fechaActual.getMonth()+1;
        ano = fechaActual.getFullYear();
        
        ano_diff = ano - sep_fecha[2];
        mes_diff = mes - sep_fecha[1];
        dia_diff = dia - sep_fecha[0];
        
        if(dia_diff < 0 && mes_diff < 0)
            ano_diff--;
        
        $('#edad').val(ano_diff);
    }
</script>
<div id="titulo_principal">

</div>
<table id="table_login" width="95%">
    <tr>
        <td class="top_left" width="29" height="34"></td>
        <td class="top"></td>
        <td class="top_right" width="37" height="34"></td>
    </tr>
    <tr>
        <td class="left"></td>
        <td class="center">
            <? if ($GPC['ac'] != 'editar') { ?>
                <form id="form1" name="form1" action="?ac=save" method="post" enctype="multipart/form-data">
                <? } else { ?>
                    <form id="form1" name="form1" action="?ac=editado" method="post" enctype="multipart/form-data">
                    <? } ?>
                    <table id="table_login2" border="0" width="100%">
                        <tr>
                            <td class="titulos">
                                REGISTRO DE PACIENTES
                                <img src="<?= DOMAIN_ROOT ?>images/paciente_agregar.png" width="60" height="60" alt="lista_paciente" style="vertical-align: middle;" />
                            </td>
                        </tr>
                        <tr>
                            <td><hr class="linea_espacio"/></td>
                        </tr>
                        <tr>
                            <td>
                                <table id="tabla1" border="0" align="center">
                                    <tr>
                                        <td>Nombres: </td>
                                        <td><?= $html->input('Paciente.nombre', $usuarioInfo[0]['nombre'], array('type' => 'text', 'class' => 'inputText')); ?></td>
                                    </tr>
                                    <tr>
                                        <td>Apellidos: </td>
                                        <td><?= $html->input('Paciente.apellido', $usuarioInfo[0]['apellido'], array('type' => 'text', 'class' => 'inputText')); ?></td>
                                    </tr>
                                    <tr>
                                        <td>C&eacute;dula: </td>
                                        <td><?= $html->input('Paciente.cedula', $usuarioInfo[0]['cedula'], array('type' => 'text', 'class' => 'inputText')); ?></td>
                                    </tr>
                                    <tr>
                                        <td>Sexo: </td>
                                        <td><?= $html->select('Paciente.sexo', array('options' => $listSexo, 'selected' => $usuarioInfo[0]['sexo'], 'default' => 'Seleccione', 'class' => 'inputText')); ?></td>
                                    </tr>
                                    <tr>
                                        <td>Fecha de Nacimiento: </td>
                                        <td>
                                            <?= $html->input('Paciente.fecha_nacimiento', $fecha_nacimiento, array('type' => 'text', 'class' => 'inputText', 'readOnly' => 'true')); ?><img src="../images/icons/calendar.png" id="start_date_trigger" width="18" height="18" style="cursor:pointer; vertical-align: middle" />
                                            <script>
                                                Calendar.setup({
                                                    trigger    : "start_date_trigger",
                                                    inputField : "Paciente[fecha_nacimiento]",
                                                    selection  : Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_nacimiento)); ?>),
                                                    dateFormat : "%d-%m-%Y",
                                                    onSelect   : function() { this.hide(); calculaEdad(); }
                                                });
                                            </script>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Edad: </td>
                                        <td><?= $html->input('edad', $edad, array('type' => 'text', 'class' => 'inputText', 'readOnly' => 'true')); ?></td>
                                    </tr>
                                    <tr>
                                        <td>Direcci&oacute;n: </td>
                                        <td><?= $html->input('Paciente.direccion', $usuarioInfo[0]['direccion'], array('type' => 'text', 'class' => 'inputText')); ?></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td><hr class="linea_espacio"/></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td align="center">
                                <?
                                if ($GPC['ac'] != 'editar') {
                                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit'));
                                } else {
                                    echo $html->input('idUsuario', $usuarioInfo[0]['id'], array('type' => 'hidden'));
                                    echo $html->input('Modificar', 'Modificar', array('type' => 'submit'));
                                }
                                ?>
                                <?= $html->input('Cancelar', 'Cancelar', array('type' => 'reset')); ?>
                            </td>
                        </tr>
                    </table>
                </form>
        </td>
        <td class="right"></td>
    </tr>
    <tr>
        <td class="bottom_left" width="29" height="33"></td>
        <td class="bottom"></td>
        <td class="bottom_right" width="37" height="33"></td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
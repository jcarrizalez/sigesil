<?
require_once('../lib/core.lib.php');

$programa = new Programa();
$cosecha = new Cosecha();

$dataPrograma = $programa->find(array('id' => $GPC['idP']), '', '*', '', '');
$dataCosecha = $cosecha->find(array('id_programa' => $GPC['idP']), '', 'MAX(codigo) codigo', '', '');
if($GPC['ac'] != 'editar'){
    $dataCosecha[0]['codigo']++;
}

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['codigo1']) && !empty($GPC['nombre1'])) {
            $GPC['Cosecha']['codigo'] = $GPC["codigo1"];
            $GPC['Cosecha']['nombre'] = $GPC["nombre1"];
            $GPC['Cosecha']['proyectado'] = $GPC["proyectado1"];
            $GPC['Cosecha']['area_siembra'] = $GPC["area_siembra1"];
            $GPC['Cosecha']['fecha_inicio'] = $GPC["fecha_inicio1"];
            $GPC['Cosecha']['fecha_fin'] = $GPC["fecha_fin1"];
            $GPC['Cosecha']['estatus'] = 't';
            $cosecha->save($GPC['Cosecha']);
        }
        if (!empty($cosecha->id)) {
            header("location: programa_listado.php?msg=exitoso");
            die();
        } else {
            header("location: programa_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoCosecha = $cosecha->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('codigo1', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('nombre1', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
    
    function validarFecha(id, valor){
        fechaRecibida = valor.split('-');
        fechaRecibida = fechaRecibida[2]+fechaRecibida[1]+fechaRecibida[0];
        j = id.substr(id.length-1);
        $(".fechas").each(function(){
            fechaComparar = $(this).val().split('-');
            fechaComparar = fechaComparar[2]+fechaComparar[1]+fechaComparar[0];
            if(id != $(this).attr('id')){
                if($(this).attr('id') == 'Programa[fecha_inicio]' && fechaRecibida < fechaComparar){
                    $('#'+id).val('');
                    alert("Fecha Invalida, es menor a la del inicio del Programa");
                    return false;
                }else if($(this).attr('id') == 'Programa[fecha_fin]' && fechaRecibida > fechaComparar){
                    $('#'+id).val('');
                    alert("Fecha Invalida, es mayor a la del fin del Programa");
                    return false;
                }else if((id == 'fecha_inicio'+j && $(this).attr('id') == 'fecha_fin'+j) && (fechaRecibida >= fechaComparar)){
                    $('#'+id).val('');
                    alert('La fecha debe ser menor a la del fin de la Cosecha');
                    return false;
                }else if((id == 'fecha_fin'+j && $(this).attr('id') == 'fecha_inicio'+j) && (fechaRecibida <= fechaComparar)){
                    $('#'+id).val('');
                    alert('La fecha debe ser mayor a la del inicio de la Cosecha');
                    return false;
                }
            }
        });
    }
    
    $(document).ready(function(){        
        
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('idP', $GPC['idP'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cosecha.id', $GPC['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cosecha.id_programa', $dataPrograma[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cosecha.id_cultivo', $dataPrograma[0]['id_cultivo'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        COSECHA<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td>Fecha de Inicio del Programa</td>
            <td><?= $html->input('Programa.fecha_inicio', $general->date_sql_screen($dataPrograma[0]['fecha_inicio'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Fecha de Fin del Programa</td>
            <td><?= $html->input('Programa.fecha_fin', $general->date_sql_screen($dataPrograma[0]['fecha_fin'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?></td>
        </tr>
    </table>
    <fieldset id="cosecha_unica">
        <legend>Datos de la Cosecha</legend>
        <table align="center" border="0" width="100%">
            <tr>
                <td>
                    <table align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><span class="msj_rojo">* </span>C&oacute;digo</td>
                            <td rowspan="6">&nbsp;&nbsp;</td>
                            <td><?= $html->input('codigo1', $dataCosecha[0]['codigo'], array('type' => 'text', 'class' => 'inputGrilla codigo_cul', 'readOnly' => true)); ?></td>
                        </tr>
                        <tr>
                            <td><span class="msj_rojo">* </span>Nombre</td>
                            <td><?= $html->input('nombre1', $infoCosecha[0]['nombre'], array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Proyectado</td>
                            <td><?= $html->input('proyectado1', $infoCosecha[0]['proyectado'], array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Area Siembra</td>
                            <td><?= $html->input('area_siembra1', $infoCosecha[0]['area_siembra'], array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Fecha Inicio</td>
                            <td>
                                <?= $html->input('fecha_inicio1', $general->date_sql_screen($infoCosecha[0]['fecha_inicio'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                                <img src="../images/calendario.png" id="finicio1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "finicio1",
                                        inputField : "fecha_inicio1",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime)); ?>),
                                        onSelect   : function() { validarFecha('fecha_inicio1',$('#fecha_inicio1').val()); this.hide() }
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha Fin</td>
                            <td>
                                <?= $html->input('fecha_fin1', $general->date_sql_screen($infoCosecha[0]['fecha_fin'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                                <img src="../images/calendario.png" id="ffin1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "ffin1",
                                        inputField : "fecha_fin1",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime)); ?>),
                                        onSelect   : function() { validarFecha('fecha_fin1',$('#fecha_fin1').val()); this.hide() }
                                    });
                                </script>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
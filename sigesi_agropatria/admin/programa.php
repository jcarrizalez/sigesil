<?
require_once('../lib/core.lib.php');

$programa = new Programa();
$cosecha = new Cosecha();
$cultivo = new Cultivo();

$estatus = array('t' => 'Activo', 'f' => 'Inactivo');
$listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Programa']['codigo']) && !empty($GPC['Programa']['nombre']) && !empty($GPC['Programa']['estatus'])) {
            $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $programa->_begin_tool();
            $programa->save($GPC['Programa']);
            $programaID = $programa->id;

            if (!empty($programaID) && !empty($GPC['codigo1']) && !empty($GPC['id_cultivo'])) {
                for ($i = 1; $i <= $GPC['numeroCosecha']; $i++) {
                    if($GPC['nombre'.$i] != ''){
                        $GPC['Cosecha']['id_programa'] = $programaID;
                        $GPC['Cosecha']['id_cultivo'] = $GPC['Programa']['id_cultivo'];
                        $GPC['Cosecha']['codigo'] = $GPC["codigo$i"];
                        $GPC['Cosecha']['nombre'] = $GPC["nombre$i"];
                        $GPC['Cosecha']['proyectado'] = $GPC["proyectado$i"];
                        $GPC['Cosecha']['area_siembra'] = $GPC["area_siembra$i"];
                        $GPC['Cosecha']['fecha_inicio'] = $GPC["fecha_inicio$i"];
                        $GPC['Cosecha']['fecha_fin'] = $GPC["fecha_fin$i"];
                        $GPC['Cosecha']['estatus'] = 't';
                        $cosecha->save($GPC['Cosecha']);
                        if (empty($cosecha->id))
                            break;
                        $cosecha->id = null;
                    }
                }
            }
        }
        if (!empty($programaID)) {
            $programa->_commit_tool();
            header("location: programa_listado.php?msg=exitoso");
            die();
        } else {
            header("location: programa_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoPrograma = $programa->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Programa.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.fecha_inicio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.fecha_fin', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('codigo1', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('nombre1', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
    
    function calculaAno(){
        fInicio = $('#Programa\\[fecha_inicio\\]').val();
        
        fechaActual = new Date();
        diaActual=fechaActual.getDate();
        diaActual = (diaActual<10) ? '0'+diaActual : diaActual;
        mesActual= fechaActual.getMonth()+1;
        mesActual = (mesActual<10) ? '0'+mesActual : mesActual;
        anioActual=fechaActual.getFullYear();
        fFin = diaActual+'-'+mesActual+'-'+anioActual;
        var fechaIni=fInicio.split('-');
        var fechaFin=fFin.split('-');
        var fechainicial=fechaIni[2]+fechaIni[1]+fechaIni[0];
        var fechafinal=fechaFin[2]+fechaFin[1]+fechaFin[0];
        if(parseInt(fechainicial) < parseInt(fechafinal)){
            alert("Fecha de Inicio Invalida");
            $('#Programa\\[fecha_inicio\\]').val('');
            $('#Programa\\[fecha_fin\\]').val('');
            limpiarFechas();
        }else{
            milisegundos=parseInt(365*24*3600*1000);
            var fecha = fInicio.split("-"); 
            fecha = new Date(fecha[2],fecha[1]-1,fecha[0]);
            dia=fecha.getDate();
            mes=fecha.getMonth()+1;
            anio=fecha.getFullYear();
            dia = (dia<10) ? '0'+dia : dia;
            mes = (mes<10) ? '0'+mes : mes;

            tiempo=fecha.getTime();
            total=fecha.setTime(parseInt(tiempo+milisegundos));
            dia=fecha.getDate();
            mes=fecha.getMonth()+1;
            anio=fecha.getFullYear();
            dia = (dia<10) ? '0'+dia : dia;
            mes = (mes<10) ? '0'+mes : mes;
            $('#Programa\\[fecha_fin\\]').val(dia+"-"+mes+"-"+anio);
            limpiarFechas();
        }
    }
    
    function limpiarFechas(){
        for(i=1; i<=$('#numeroCosecha').val(); i++){
            $('#fecha_inicio'+i).val('');
            $('#fecha_fin'+i).val('');
        }
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
    
    function verificaCodigo(){
        cultivo = $('#Programa\\[id_cultivo\\]').val();
        fecha = $('#Programa\\[fecha_inicio\\]').val();
        if(cultivo != '' && fecha != '')
            $('#validar_codigo').load('../ajax/detalle_programa.php?ac=validar&codigo='+cultivo+'&fecha='+fecha);
    }
    
    $(document).ready(function(){        
        $('#Programa\\[id_cultivo\\]').live('change', function(){
            if($(this).val() != ''){
                var cultivo = parseInt($(this).val());
                if(cultivo < 10)
                    cultivo = '0'+cultivo;
                //
                fecha = $('#Programa\\[fecha_inicio\\]').val();
                if(fecha != '')
                    $('#validar_codigo').load('../ajax/detalle_programa.php?ac=validar&codigo='+cultivo+'&fecha='+fecha);
                
                for(i=1; i<=$('#numeroCosecha').val(); i++){
                    $('#codigo'+i).val('<?= date('Y') ?>'+cultivo+i);
                }
            }else{
                $('#Programa\\[codigo\\]').val('');
                for(i=1; i<=$('#numeroCosecha').val(); i++){
                    $('#codigo'+i).val('');
                }
            }
        });
        
        $('#Agregar').click(function(){
            if($('#Programa\\[id_cultivo\\]').val() == ''){
                alert('Seleccione un Cultivo');
            }else if($('#Programa\\[id_cultivo\\]').val() != '' && $('#Programa\\[fecha_inicio\\]').val() == ''){
                alert('Seleccione la Fecha de Inicio del Programa');
            }else{
                var codigo_cosecha = parseInt($('#codigo1').val())+parseInt($('#numeroCosecha').val());
                $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())+1);
                var nro = parseInt($('#numeroCosecha').val());
                if(nro <= <?= COSECHAS_PROGRAMA ?>){
                    var nombre = "multiple"+nro;
                    var otraCosecha = "<fieldset id='"+nombre+"'></fieldset>";
                    nombre = '#'+nombre;
                    $('#nuevaCosecha').append(otraCosecha);
                    $(nombre).load('../ajax/detalle_programa.php?ac=agregar&nro='+nro+'&codigo='+codigo_cosecha);
                }else{
                    $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())-1);
                    alert('Solo se admiten ('+<?= COSECHAS_PROGRAMA ?>+') Cosechas por Programa');
                }
            }
        });

        $('#Guardar').click(function(){
            fechaActual = "<? echo date("d-m-Y"); ?>";
            for(j=1;j<=$('#numeroCosecha').val();j++){
                if(j > 1 && ($('#Cosecha'+j+'\\[codigo\\]').val() == '') && ($('#Cosecha'+j+'\\[id_cultivo\\]').val() == '')){
                    alert('Complete la Informacion de la Cosecha #'+j+' o Eliminela');
                    return false;
                }

                if($('#Cosecha'+j+'\\[fecha_inicio\\]').val() != '' || $('#Cosecha'+j+'\\[fecha_fin\\]').val() != ''){
                    if($('#Cosecha'+j+'\\[fecha_inicio\\]').val() < fechaActual){
                        alert('La Fecha de Inicio no puede ser menor a la Actual');
                        return false;
                    }else if($('#Cosecha'+j+'\\[fecha_fin\\]').val() <= $('#Cosecha'+j+'\\[fecha_inicio\\]').val()){
                        alert('La Fecha Fin no puede ser menor o igual a la Fecha de Inicio');
                        return false;
                    }
                }
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Programa.id', $infoPrograma[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('numeroCosecha', 1, array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        PROGRAMA<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Programa</legend>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><span class="msj_rojo">* </span>C&oacute;digo</td>
                <td rowspan="7">&nbsp;&nbsp;</td>
                <td id="validar_codigo"><? echo $html->input('Programa.codigo', $infoPrograma[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                if($GPC['ac'] == 'editar'){
                    echo $html->input('Programa.id_cultivo', $infoPrograma[0]['id_cultivo'], array('type' => 'hidden'));
                }else{
            ?>
            <tr>
                <td><span class="msj_rojo">* </span>Cultivo</td>
                <td><? echo $html->select('Programa.id_cultivo', array('options' => $listaCultivos, 'selected' => $infoPrograma[0]['id_cultivo'], 'default' => ' Seleccione ', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <? } ?>
            <tr>
                <td><span class="msj_rojo">* </span>Nombre</td>
                <td><? echo $html->input('Programa.nombre', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Estatus</td>
                <td><? echo $html->select('Programa.estatus', array('options' => $estatus, 'selected' => $infoPrograma[0]['estatus'], 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tr>
                <td>Observaci&oacute;n</td>
                <td><textarea name="Programa[observacion]" cols="25" rows="2" id="Programa[observacion]"><?=$infoPrograma[0]['observacion']?></textarea></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Fecha Inicio</td>
                <td>
                    <?= $html->input('Programa.fecha_inicio', $general->date_sql_screen($infoPrograma[0]['fecha_inicio'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                    <img src="../images/calendario.png" id="finiciop" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "finiciop",
                            inputField : "Programa[fecha_inicio]",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoPrograma[0]['fecha_inicio'])); ?>),
                            onSelect   : function() { calculaAno(); verificaCodigo(); this.hide() }
                        });
                    </script>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Fecha Fin</td>
                <td><?= $html->input('Programa.fecha_fin', $general->date_sql_screen($infoPrograma[0]['fecha_fin'], '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?></td>
            </tr>
        </table>
    </fieldset>
    <? if($GPC['ac'] != 'editar'){ ?>
    <div id="botones2">
        <? echo $html->input('Agregar', 'Agregar Cosecha', array('type' => 'button')); ?>
    </div>
    <fieldset id="cosecha_unica">
        <legend>Datos de la Cosecha #1</legend>
        <table align="center" border="0" width="100%">
            <tr>
                <td>
                    <table align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><span class="msj_rojo">* </span>C&oacute;digo</td>
                            <td rowspan="6">&nbsp;&nbsp;</td>
                            <td><?= $html->input('codigo1', '', array('type' => 'text', 'class' => 'inputGrilla codigo_cul', 'readOnly' => true)); ?></td>
                        </tr>
                        <tr>
                            <td><span class="msj_rojo">* </span>Nombre</td>
                            <td><?= $html->input('nombre1', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Proyectado</td>
                            <td><?= $html->input('proyectado1', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Area Siembra</td>
                            <td><?= $html->input('area_siembra1', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Fecha Inicio</td>
                            <td>
                                <?= $html->input('fecha_inicio1', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
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
                                <?= $html->input('fecha_fin1', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
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
    <div id="nuevaCosecha"></div>
    <? } ?>
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
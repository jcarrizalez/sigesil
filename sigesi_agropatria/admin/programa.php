<?
require_once('../lib/core.lib.php');

$programa = new Programa();
$cosecha = new Cosecha();
$cultivo = new Cultivo();

$estatus = array('t' => 'Activo', 'f' => 'Inactivo');
$listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Programa']['codigo']) && !empty($GPC['Programa']['nombre']) && !empty($GPC['Programa']['estatus']) && !empty($GPC['Cosecha1']['codigo']) && !empty($GPC['Cosecha1']['id_cultivo'])) {
            $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $programa->_begin_tool();
            $programa->save($GPC['Programa']);
            $programaID = $programa->id;

            if (!empty($programaID)) {
                for ($i = 1; $i <= $GPC['numeroCosecha']; $i++) {
                    $total = "Cosecha" . $i;
                    $GPC[$total]['id_programa'] = $programaID;
                    $GPC[$total]['estatus'] = 't';
                    $cosecha->save($GPC[$total]);
                    if (empty($cosecha->id))
                        break;
                    $idCosecha[] = $cosecha->id;
                    $cosecha->id = null;
                }
            }
        }
        if (!empty($programaID) && ($GPC['numeroCosecha'] == count($idCosecha))) {
            $programa->_commit_tool();
            header("location: programa_listado.php?msg=exitoso");
            die();
        } else {
            header("location: programa_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoCA = $programa->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Programa.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.fecha_inicio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.fecha_fin', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha1.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
    
    function limpiarFechas(){
        for(i=1; i<=$('#numeroCosecha').val(); i++){
            $('#Cosecha'+i+'\\[fecha_inicio\\]').val('');
            $('#Cosecha'+i+'\\[fecha_fin\\]').val('');
        }
    }
    
    function validarFecha(id, valor){
        fechaRecibida = valor.split('-');
        fechaRecibida = fechaRecibida[2]+fechaRecibida[1]+fechaRecibida[0];
        $(".fechas").each(function(){
            fechaComparar = $(this).val().split('-');
            fechaComparar = fechaComparar[2]+fechaComparar[1]+fechaComparar[0];
            if(id != $(this).attr('id')){
                if($(this).attr('id') == 'Programa[fecha_inicio]' && fechaRecibida < fechaComparar){
                    alert("Fecha Invalida Menor a Inicio Programa");
                    return false;
                }else if($(this).attr('id') == 'Programa[fecha_fin]' && fechaRecibida > fechaComparar){
                    alert("Fecha Invalida Mayor a Fin Programa");
                    return false;
                }else if(!isNaN(fechaComparar)){
                    if(($(this).attr('id') != 'Programa[fecha_inicio]' && $(this).attr('id') != 'Programa[fecha_fin]') && fechaRecibida < fechaComparar){
                        alert(fechaComparar);
                        //alert("Fecha Invalida Menor a Otra Cosecha");
                        return false;
                    }
                }
            }
        });
        /*fechaProgramaI = $('#Programa\\[fecha_inicio\\]').val().split('-');
        fechaProgramaI = fechaProgramaI[2]+fechaProgramaI[1]+fechaProgramaI[0];
        fechaProgramaF = $('#Programa\\[fecha_fin\\]').val().split('-');
        fechaProgramaF = fechaProgramaF[2]+fechaProgramaF[1]+fechaProgramaF[0];
        
        for(i=1; i<=$('#numeroCosecha').val(); i++){
            if(id != i){
                fechaCompararI = $('#Cosecha'+i+'\\[fecha_inicio\\]').val().split('-');
                fechaCompararI = fechaCompararI[2]+fechaCompararI[1]+fechaCompararI[0];
                fechaCompararF = $('#Cosecha'+i+'\\[fecha_fin\\]').val().split('-');
                fechaCompararF = fechaCompararF[2]+fechaCompararF[1]+fechaCompararF[0];
                alert('Compara');
                return false;
            }
        }*/
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
    
    $(document).ready(function(){
        $('#id_cultivo').live('change', function(){
            if($(this).val() != ''){
                var cultivo = parseInt($(this).val());
                if(cultivo < 10)
                    cultivo = '0'+cultivo;
                $('#Programa\\[codigo\\]').val('<?= date('Y') ?>'+cultivo);
                for(i=1; i<=$('#numeroCosecha').val(); i++){
                    $('#Cosecha'+i+'\\[codigo\\]').val('<?= date('Y') ?>'+cultivo+i);
                }
            }else{
                $('#Programa\\[codigo\\]').val('');
                for(i=1; i<=$('#numeroCosecha').val(); i++){
                    $('#Cosecha'+i+'\\[codigo\\]').val('');
                }
            }
        });
        
        $('#Agregar').click(function(){
            if($('#id_cultivo').val() == ''){
                alert('Seleccione un Cultivo');
            }else if($('#id_cultivo').val() != '' && $('#Programa\\[fecha_inicio\\]').val() == ''){
                alert('Seleccione la Fecha de Inicio del Programa');
            }else{
                var codigo_cosecha = parseInt($('#Cosecha1\\[codigo\\]').val())+parseInt($('#numeroCosecha').val());
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
    <? echo $html->input('Programa.id', $infoCA[0]['id'], array('type' => 'hidden')); ?>
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
                <td><? echo $html->input('Programa.codigo', '', array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Cultivo</td>
                <td><? echo $html->select('id_cultivo', array('options' => $listaCultivos, 'default' => ' Seleccione ', 'class' => 'inputGrilla')) ?></td>
            </tr>
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
                <td><textarea name="Programa[observacion]" cols="20" rows="2" id="Programa[observacion]"></textarea></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Fecha Inicio</td>
                <td>
                    <?= $html->input('Programa.fecha_inicio', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                    <img src="../images/calendario.png" id="finiciop" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "finiciop",
                            inputField : "Programa[fecha_inicio]",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime)); ?>),
                            onSelect   : function() { calculaAno(); this.hide() }
                        });
                    </script>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Fecha Fin</td>
                <td><?= $html->input('Programa.fecha_fin', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?></td>
            </tr>
        </table>
    </fieldset>
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
                            <td><?= $html->input('Cosecha1.codigo', '', array('type' => 'text', 'class' => 'inputGrilla codigo_cul', 'readOnly' => true)); ?></td>
                        </tr>
                        <tr>
                            <td>Nombre</td>
                            <td><?= $html->input('Cosecha1.nombre', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Proyectado</td>
                            <td><?= $html->input('Cosecha1.proyectado', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Area Siembra</td>
                            <td><?= $html->input('Cosecha1.area_siembra', '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                        </tr>
                        <tr>
                            <td>Fecha Inicio</td>
                            <td>
                                <?= $html->input('Cosecha1.fecha_inicio', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                                <img src="../images/calendario.png" id="finicio1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "finicio1",
                                        inputField : "Cosecha1[fecha_inicio]",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime)); ?>),
                                        onSelect   : function() { validarFecha('Cosecha1[fecha_inicio]',$('#Cosecha1\\[fecha_inicio\\]').val()); this.hide() }
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha Fin</td>
                            <td>
                                <?= $html->input('Cosecha1.fecha_fin', '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => 'readOnly')); ?>
                                <img src="../images/calendario.png" id="ffin1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "ffin1",
                                        inputField : "Cosecha1[fecha_fin]",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime)); ?>),
                                        onSelect   : function() { validarFecha('Cosecha1[fecha_fin]',$('#Cosecha1\\[fecha_fin\\]').val()); this.hide() }
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
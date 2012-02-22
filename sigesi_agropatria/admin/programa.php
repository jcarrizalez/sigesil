<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    
    $estatus = array('t' => 'Activo', 'f' => 'Inactivo');
    $listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Programa']['codigo']) && !empty($GPC['Programa']['nombre']) && !empty($GPC['Programa']['estatus']) && !empty($GPC['Cosecha1']['nombre']) && !empty($GPC['Cosecha1']['id_cultivo'])){
                $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $programa->_begin_tool();
                
                $programa->save($GPC['Programa']);
                $programaID = $programa->id;
                
                if(!empty($programaID)){
                    for($i=1;$i<=$GPC['numeroCosecha'];$i++){
                        $total = "Cosecha".$i;
                        $GPC[$total]['id_programa'] = $programaID;
                        $GPC[$total]['estatus'] = 't';
                        $cosecha->save($GPC[$total]);
                        if(empty($cosecha->id))
                            break;
                        $idCosecha[] = $cosecha->id;
                        $cosecha->id = null;
                    }
                }
                
                if(!empty($programaID) && ($GPC['numeroCosecha'] == count($idCosecha))){
                    //SI TODO BIEN GUARDO
                    $programa->_commit_tool();
                    header("location: programa_listado.php?msg=exitoso");
                    die();
                }else{
                    //SI ALGO SALIO MAL, DEVUELVO TODAS LAS TRANSACCIONES
                    header("location: programa_listado.php?msg=error");
                    die();
                }
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
$validator->setRules('Cosecha1.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha1.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
    
    
    $(document).ready(function(){
        $('#Agregar').click(function(){
            $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())+1);
            filaId = $('#numeroCosecha').val();
            if(filaId<= <?=COSECHAS_PROGRAMA?>){
                var infoCosecha = "<fieldset id='cosecha_"+filaId+"'><legend class='titulo_leyenda'>Datos de la Cosecha #"+filaId+" <img src='../images/eliminar2.png' width='16' height='16' title='Eliminar' style='cursor: pointer;' onclick='eliminarFila("+filaId+");'></legend><table align='center' width='100%'><tr><td><table align='center' cellpadding='0' cellspacing='0'>";
                infoCosecha +="<tr><td><span class='msj_rojo'>* </span>C&oacute;digo: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[codigo]' id='Cosecha"+filaId+"[codigo]'></td></tr>";
                infoCosecha +="<tr><td>Nombre: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[nombre]' id='Cosecha"+filaId+"[nombre]'></td></tr>";
                infoCosecha +="<tr><td><span class='msj_rojo'>* </span>Cultivo: </td><td><select class='inputGrilla' name='Cosecha"+filaId+"[id_cultivo]' id='Cosecha"+filaId+"[id_cultivo]'><option value=''> Seleccione </option>";
                var array_js = new Array();
	        <?php
                    foreach($listaCultivos as $indice=>$valor){
                        echo "array_js[$indice] = '$valor';\n";
                    }
	        ?>
                for(var i in array_js)
                {
                    infoCosecha +="<option value="+i+">"+array_js[i]+"</option>";
                }
                infoCosecha +="</select></td></tr>";
                infoCosecha +="<tr><td>Proyectado: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[proyectado]' id='Cosecha"+filaId+"[proyectado]'></td></tr>";
                infoCosecha +="<tr><td>Area Siembra: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[area_siembra]' id='Cosecha"+filaId+"[area_siembra]'></td></tr>";
                infoCosecha +="<tr><td>Fecha Inicio: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[fecha_inicio]' id='Cosecha"+filaId+"[fecha_inicio]'>&nbsp;&nbsp;<img src='../images/calendario.png' id='finicio"+filaId+"' width='16' height='16' style='cursor:pointer' />";
                infoCosecha +="<script>Calendar.setup({trigger    : 'finicio"+filaId+"',inputField : 'Cosecha"+filaId+"[fecha_inicio]',dateFormat: '%d-%m-%Y',onSelect   : function() { this.hide() }});<\/script>";
                infoCosecha +="</td></tr>";
                infoCosecha +="<tr><td>Fecha Fin: </td><td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+"[fecha_fin]' id='Cosecha"+filaId+"[fecha_fin]'>&nbsp;&nbsp;<img src='../images/calendario.png' id='ffin"+filaId+"' width='16' height='16' style='cursor:pointer' />";
                infoCosecha +="<script>Calendar.setup({trigger    : 'ffin"+filaId+"',inputField : 'Cosecha"+filaId+"[fecha_fin]',dateFormat: '%d-%m-%Y',onSelect   : function() { this.hide() }});<\/script>";
                infoCosecha +="</td></tr>";
                infoCosecha += "</table></td></tr></table></fieldset>";
                $("#nuevaCosecha").append(infoCosecha);
            }else{
                $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())-1);
                alert('Solo se admiten ('+<?=COSECHAS_PROGRAMA?>+') Cosechas por Programa');
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
    
    function eliminarFila(fila){
        $("#cosecha_"+fila).remove();	
        $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())-1);
            return false;
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Programa.id', $infoCA[0]['id'], array('type' => 'hidden'));?>
    <? echo $html->input('numeroCosecha', 1, array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO PROGRAMA<br/><hr/>
    </div>
    <fieldset>
        <legend class="titulo_leyenda">Datos del Programa</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>C&oacute;digo: </td>
                <td><? echo $html->input('Programa.codigo', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->input('Programa.nombre', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Estatus: </td>
                <td><? echo $html->select('Programa.estatus',array('options'=>$estatus, 'selected' => $infoPrograma[0]['estatus'], 'default' => 'Seleccione'))?></td>
            </tr>
            <tr>
                <td>Observaci&oacute;n: </td>
                <td><textarea name="Programa[observacion]" cols="20" rows="2" id="Programa[observacion]"></textarea></td>
            </tr>
        </table>
    </fieldset>
    <div id="botones">
        <? echo $html->input('Agregar', 'Agregar Cosecha', array('type' => 'button')); ?>
    </div>
    <fieldset>
        <legend class="titulo_leyenda">Datos de la Cosecha #1</legend>
        <table align="center" border="0" width="100%">
            <tr>
                <td>
                <table align="center" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td><span class="msj_rojo">* </span>C&oacute;digo: </td>
                            <td><?=$html->input('Cosecha1.codigo', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                        </tr>
                        <tr>
                            <td>Nombre: </td>
                            <td><?=$html->input('Cosecha1.nombre', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                        </tr>
                        <tr>
                            <td><span class="msj_rojo">* </span>Cultivo: </td>
                            <td><? echo $html->select('Cosecha1.id_cultivo',array('options'=>$listaCultivos, 'default'=>' Seleccione ', 'class' => 'inputGrilla'))?></td>
                        </tr>
                        <tr>
                            <td>Proyectado: </td>
                            <td><?=$html->input('Cosecha1.proyectado', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                        </tr>
                        <tr>
                            <td>Area Siembra: </td>
                            <td><?=$html->input('Cosecha1.area_siembra', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                        </tr>
                        <tr>
                            <td>Fecha Inicio: </td>
                            <td>
                                <?=$html->input('Cosecha1.fecha_inicio', '', array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => 'readOnly'));?>
                                <img src="../images/calendario.png" id="finicio1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "finicio1",
                                        inputField : "Cosecha1[fecha_inicio]",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime));?>),
                                        onSelect   : function() { this.hide() }
                                    });
                                </script>
                            </td>
                        </tr>
                        <tr>
                            <td>Fecha Fin: </td>
                            <td>
                                <?=$html->input('Cosecha1.fecha_fin', '', array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => 'readOnly'));?>
                                <img src="../images/calendario.png" id="ffin1" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "ffin1",
                                        inputField : "Cosecha1[fecha_fin]",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime));?>),
                                        onSelect   : function() { this.hide() }
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
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
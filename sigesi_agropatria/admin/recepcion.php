<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA, null, null, null, null, null, null);
    $listadoAgencias = array(1 => 'Agencia 1');
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch($GPC['ac']){
        case 'guardar':
            /*$GPC['Guia']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Guia']['id_cosecha'] = $GPC['id_cosecha'];
            //PASAR EL ID DEL CULTIVO $GPC['Guia']['id_cultivo'] = $GPC['id_cultivo'];
            $GPC['Guia']['id_usuario'] = $_SESSION['s_id'];
            
            $recepcion = new Recepcion();
            $recepcion->guardarGuia($GPC['Guia']);
            $recepcion->_begin_tool();*/
            
            /*if(!empty($id)){
                header("location: recepcion_listado.php?msg=exitoso");
                die();
            }else{
                header("location: recepcion_listado.php?msg=error");
                die();
            }*/
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.numero_guia', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.id_agencia', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.fecha_emision', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.kilogramos', array('required' => array('value' => true, 'message' => 'Requerido'), 'number' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'recepcion_listado.php';
    }
    
    $(document).ready(function(){
        $('#id_cosecha').change(function(){
            if($(this).val() != '')
                $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad&idCo='+$(this).val());
            else{
                $('#nrocosecha').html('');
                $('#nrocosecha').append('Entrada Nro: ');
            }
        });
    
        $('#Buscar').click(function(){
            window.location = 'recepcion.php?ac=buscar';
        });
        
        $('.radioElige').click(function(){
            $('#dataproductor').css('visibility', 'visible');
            $('#infoproductor').load('../ajax/detalle_usuario.php?ac=productor&valor='+$(this).val());
        });
        
        $('#Guardar').click(function(){
            //if($('#Guia\\[fecha_recepcion\\]').val() < )
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? //echo $html->input('Recepcion.id', $infoRec[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVA RECEPCI&Oacute;N<br/><hr/>
    </div>
    <table align="center" border="0" width="100%">
        <tr>
            <td colspan="2" id="nrocosecha">Entrada Nro: </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha: </td>
            <td><? echo $html->select('id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Gu&iacute;a</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Gu&iacute;a: </td>
                <td>
                    <?
                        echo $html->input('Guia.numero_guia', $infoGuia[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos'));
                        echo $html->link('<img src="../images/buscar.png" width="16" height="16" title=Buscar Guia>', 'recepcion.php?ac=buscarGuia');
                    ?>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Agencia Origen: </td>
                <td><? echo $html->select('Guia.id_agencia', array('options' => $listadoAgencias, 'selected' => $infoGuia[0]['id_agencia'], 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
                <td>
                    <? echo $html->input('Guia.fecha_emision', $infoGuia[0]['fecha_emision'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
                    <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "femision",
                            inputField : "Guia[fecha_emision]",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fecha_fact_optime));?>),
                            onSelect   : function() { this.hide() }
                        });
                    </script>
                </td>
            </tr>
            <tr>
                <td>N&uacute;mero de Contrato: </td>
                <td><? echo $html->input('Guia.contrato', $infoGuia[0]['contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <!--tr>
                <td>Disponible a Recibir: </td>
                <td><? echo $html->input('Guia.direccion', $infoGuia[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Cultivo: </td>
                <td><? echo $html->input('Guia.id_cultivo', $infoGuia[0]['id_cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr-->
            <tr>
                <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a: </td>
                <td><? echo $html->input('Guia.kilogramos', $infoGuia[0]['kilogramos'], array('type' => 'text', 'class' => 'estilo_campos')); ?> (Kgrs)</td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Productor</legend>
        <table align="center">
            <tr>
                <td>Buscar por: </td>
                <td>
                    <?
                        echo "C&eacute;dula ".$html->input('cedularif', '1', array('type' => 'radio', 'class' => 'radioElige'));
                        echo "RIF ".$html->input('cedularif', '2', array('type' => 'radio', 'class' => 'radioElige'));
                        //echo $html->input('Guia.cr_productor', $infoGuia[0]['cr_productor'], array('type' => 'text', 'class' => 'estilo_campos'));
                        //echo $html->link('<img src="../images/buscar.png" width="16" height="16" title=Buscar Guia>', 'recepcion.php?ac=buscarPro');
                    ?>
                </td>
            </tr>
            <tbody id="dataproductor" style="visibility: hidden;">
                <tr>
                    <td>&nbsp;</td>
                    <td id="infoproductor"></td>
                </tr>
            </tbody>
            <tr>
                <td>Productor Asociado: </td>
                <td><? echo $html->input('Guia.cedula_asociado', $infoGuia[0]['cedula_asociado'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Veh&iacute;culo</legend>
        <table align="center">
            <tr>
                <td>Placa Veh&iacute;culo: </td>
                <td><? echo $html->input('Vehiculo.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Marca: </td>
                <td><? echo $html->input('Vehiculo.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Placa Remolque: </td>
                <td><? echo $html->input('Vehiculo.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>C&eacute;dula Chofer: </td>
                <td><? echo $html->input('Vehiculo.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Recepci&oacute;n</legend>
        <table align="center">
            <tr>
                <td>Centro Receptor: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Fecha de Recepci&oacute;n: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Hora Recepci&oacute;n: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Carril de Muestreo: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
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
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $msg = null;
    $msg2 = null;
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
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
            $GPC['Guia']['fecha_rec'] = 'now()';
            
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
        case 'buscar':
            if(!empty($GPC['numero_guia'])){
                $guia = new Guia();
                $infoGuia = $guia->find(array('numero_guia' => $GPC['numero_guia']), '', '*', '');
                $msg = (empty($infoGuia)) ? 'El Nro de Gu&iacute;a no existe, se proceder&aacute; a registrar' : '';
                $infoGuia[0]['numero_guia'] = $GPC['numero_guia'];
            }

            if(!empty($GPC['cr_pro'])){
                $productor = new Productor();
                $infoProductor = $productor->find(array('ced_rif' => $GPC['cr_pro']), '', '*', '');
                $msg2 = (empty($infoProductor)) ? 'El Productor no existe, se proceder&aacute; a registrar' : '';
                $infoProductor[0]['ced_rif'] = substr($GPC['cr_pro'],1);
                $infoProductor[0]['nacion'] = substr($GPC['cr_pro'],0,1);
            }
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.numero_guia', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Guia.fecha_emision', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.kilogramos', array('required' => array('value' => true, 'message' => 'Requerido'), 'number' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Productor.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Productor.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Productor.telefono', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Productor.email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
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
    
        $('.btnBuscar').click(function(){
            var guia = parseInt($('#Guia\\[numero_guia\\]').val());
            var cr = $('#Productor\\[ced_rif\\]').val();
            if(isNaN(guia))
                guia = '';            
            if(isNaN(cr))
                cr = '';
            else
                cr = $('#nacion').val()+cr;
            
            window.location = 'recepcion.php?ac=buscar&numero_guia='+guia+"&cr_pro="+cr;
        });
        
        $('#Guardar').click(function(){
            //if($('#Guia\\[fecha_recepcion\\]').val() < '')
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
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
                <th colspan="2" align="center"><?=$msg?></th>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Gu&iacute;a: </td>
                <td>
                    <?
                        echo $html->input('Guia.numero_guia', $infoGuia[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos'));
                        echo $html->link('<img class="btnBuscar" src="../images/buscar.png" width="16" height="16" title=Buscar Guia>');
                    ?>
                </td>
            </tr>
            <!--tr>
                <td><span class="msj_rojo">* </span>Agencia Origen: </td>
                <td><? echo $html->select('Guia.id_agencia', array('options' => $listadoAgencias, 'selected' => $infoGuia[0]['id_agencia'], 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr-->
            <tr>
                <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
                <td>
                    <? echo $html->input('Guia.fecha_emision', $general->date_sql_screen($infoGuia[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
                    <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "femision",
                            inputField : "Guia[fecha_emision]",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
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
                <td>Cultivo: </td>
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
                <th colspan="2" align="center"><?=$msg2?></th>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif: </td>
                <td>
                    <?
                        echo $html->select('nacion', array('options'=>$listaCR, 'selected' => $infoProductor[0]['nacion']));
                        echo "&nbsp;".$html->input('Productor.ced_rif', $infoProductor[0]['ced_rif'], array('type' => 'text', 'class' => 'crproductor'));
                        echo $html->link('<img class="btnBuscar" src="../images/buscar.png" width="16" height="16" title=Buscar Productor>');
                    ?>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Nombres y Apellidos: </td>
                <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Tel&eacute;fono: </td>
                <td><? echo $html->input('Productor.telefono', $infoProductor[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Email: </td>
                <td><? echo $html->input('Productor.email', $infoProductor[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Productor Asociado: </td>
                <td><? echo $html->input('Productor.cedula_asociado', $infoProductor[0]['cedula_asociado'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Asociado</legend>
        <table align="center">
            <tr>
                <th colspan="2" align="center"><?=$msg3?></th>
            </tr>
            <tr>
                <td>C&eacute;dula/Rif: </td>
                <td>
                    <?
                        echo $html->select('nacion2', array('options'=>$listaCR, 'selected' => $infoProductor[0]['nacion']));
                        echo "&nbsp;".$html->input('Asociado.ced_rif', $infoProductor[0]['ced_rif'], array('type' => 'text', 'class' => 'crproductor'));
                        echo $html->link('<img class="btnBuscar" src="../images/buscar.png" width="16" height="16" title=Buscar Productor>');
                    ?>
                </td>
            </tr>
            <tr>
                <td>Nombres y Apellidos: </td>
                <td><? echo $html->input('Asociado.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Tel&eacute;fono: </td>
                <td><? echo $html->input('Asociado.telefono', $infoProductor[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Email: </td>
                <td><? echo $html->input('Asociado.email', $infoProductor[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Productor Asociado: </td>
                <td><? echo $html->input('Asociado.cedula_asociado', $infoProductor[0]['cedula_asociado'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <!--fieldset>
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
    </fieldset-->
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
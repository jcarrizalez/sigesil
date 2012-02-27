<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $listaCantM = array(1 => 1, 2 => 2, 3 => 3);
    $listaCarriles = array(1 => 1, 2 => 2);
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA, null, null, null, null, null, null);
    $listadoAgencias = array(1 => 'Agencia 1');
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch($GPC['ac']){
        case 'guardar':
            $recepcion = new Recepcion();
            $guia = new Guia();
            $productor = new Productor();
            $asociado = new Asociado();
            $vehiculo = new Vehiculo();
            
            $GPC['Guia']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Guia']['estatus'] = 'A';
            $GPC['Guia']['cedula_chofer'] = $GPC['nacion3'].$GPC['Guia']['cedula_chofer'];
            $GPC['Recepcion']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Recepcion']['estatus_rec'] = 'A';
            $GPC['Recepcion']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Recepcion']['id_silo'] = 2;
            $recepcion->_begin_tool();
            
            $guia->save($GPC['Guia']);
            $idGuia = $guia->id;
            $productor->save($GPC['Productor']);
            $idProductor = $productor->id;
            if(!empty($GPC['Asociado']['ced_rif']) && !empty($GPC['Asociado']['nombre']) ){
                $GPC['Asociado']['id_productor'] = $idProductor;
                $asociado->save($GPC['Asociado']);
                $idAsociado = $asociado->id;
            }
            $vehiculo->save($GPC['Vehiculo']);
            $idVehiculo = $vehiculo->id;
            $GPC['Recepcion']['id_productor'] = $idProductor;
            $GPC['Recepcion']['id_guia'] = $idGuia;
            if(!empty($idAsociado)){
                $GPC['Recepcion']['id_asociado'] = $idAsociado;
            }
            $recepcion->save($GPC['Recepcion']);
            $idRecepcion = $recepcion->id;
            
            if(!empty($idGuia) && !empty($idProductor) && !empty($idVehiculo) && !empty($idRecepcion)){
                $recepcion->_commit_tool();
                header("location: recepcion.php?msg=exitoso");
                die();
            }else{
                header("location: recepcion.php?msg=error");
                die();
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
$validator->setRules('Asociado.ced_rif', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Guia.cedula_chofer', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Guia.nombre_chofer', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.placa', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.placa_remolques', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Recepcion.carril', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Recepcion.cant_muestras', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'recepcion_listado.php';
    }
    
    $(document).ready(function(){
        $('#Recepcion\\[id_cosecha\\]').change(function(){
            if($(this).val() != '')
                $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad&idCo='+$(this).val());
            else{
                $('#nrocosecha').html('');
                $('#nrocosecha').append('Entrada Nro: ');
            }
        });
    
        $('#buscarGuia').click(function(){
            var guia = $('#Guia\\[numero_guia\\]').val();
            if(guia != '')
                $('#guia').load('../ajax/recepcion_detalle.php?ac=guia&numero_guia='+guia);
            else
                alert('Nro de Guia Invalida');
        });
        
        $('#buscarPro').click(function(){
            var cedPro = $('#Productor\\[ced_rif\\]').val();
            if(cedPro == '' || isNaN(cedPro))
                alert('Cedula/Rif Invalida');
            else{
                cedPro = $('#nacion').val()+$('#Productor\\[ced_rif\\]').val();
                $('#productor').load('../ajax/recepcion_detalle.php?ac=productor&cp='+cedPro);
            }
        });
        
        $('#buscarAso').click(function(){
            var cedAso = $('#Asociado\\[ced_rif\\]').val();
            if(cedAso == '' || isNaN(cedAso))
                alert('Cedula/Rif Invalida');
            else{
                cedAso = $('#nacion2').val()+$('#Asociado\\[ced_rif\\]').val();
                $('#asociado').load('../ajax/recepcion_detalle.php?ac=asociado&cp='+cedAso);
            }
        });
        
        $('#buscarCho').click(function(){
            var cedCho = $('#Guia\\[cedula_chofer\\]').val();
            if(cedCho == '' || isNaN(cedCho))
                alert('Cedula Invalida');
            else{
                cedCho = $('#nacion3').val()+$('#Guia\\[cedula_chofer\\]').val();
                $('#chofer').load('../ajax/recepcion_detalle.php?ac=chofer&cp='+cedCho);
            }
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
    <div id="mensajes">
        <?
            switch($GPC['msg']){
                case 'exitoso':
                    echo "<span class='msj_verde'>Registro Guardado !</span>";
                break;
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <table align="center" border="0" width="100%">
        <tr>
            <td colspan="2" id="nrocosecha">Entrada Nro: </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha: </td>
            <td><? echo $html->select('Recepcion.id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Gu&iacute;a</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Gu&iacute;a: </td>
                <td>
                    <?
                        echo $html->input('Guia.numero_guia', '', array('type' => 'text', 'class' => 'estilo_campos'));
                        echo $html->link('<img id="buscarGuia" src="../images/buscar.png" width="16" height="16" title=Buscar Guia>');
                    ?>
                </td>
            </tr>
            <!--tr>
                <td><span class="msj_rojo">* </span>Agencia Origen: </td>
                <td><? echo $html->select('Guia.id_agencia', array('options' => $listadoAgencias, 'selected' => $infoGuia[0]['id_agencia'], 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr-->
            <tbody id="guia">
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
            </tbody>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Productor</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif: </td>
                <td>
                    <?
                        echo $html->select('nacion', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Productor.ced_rif', $infoProductor[0]['cedula_pro'], array('type' => 'text', 'class' => 'crproductor'));
                        echo $html->link('<img id="buscarPro" src="../images/buscar.png" width="16" height="16" title=Buscar Productor>');
                    ?>
                </td>
            </tr>
            <tbody id="productor">
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono: </td>
                    <td><? echo $html->input('Productor.telefono', $infoProductor[0]['telefono_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><? echo $html->input('Productor.email', $infoProductor[0]['email_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Asociado</legend>
        <table align="center">
            <tr>
                <td>C&eacute;dula/Rif: </td>
                <td>
                    <?
                        echo $html->select('nacion2', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Asociado.ced_rif', $infoAsociado[0]['cedula_aso'], array('type' => 'text', 'class' => 'crproductor'));
                        echo $html->link('<img id="buscarAso" src="../images/buscar.png" width="16" height="16" title=Buscar Productor>');
                    ?>
                </td>
            </tr>
            <tbody id="asociado">
                <tr>
                    <td>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Asociado.nombre', $infoAsociado[0]['nombre_aso'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono: </td>
                    <td><? echo $html->input('Asociado.telefono', $infoAsociado[0]['telefono_aso'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Veh&iacute;culo</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula Chofer: </td>
                <td>
                    <?
                        echo $html->select('nacion3', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Guia.cedula_chofer', $infoVehiculo[0]['cedula_chofer'], array('type' => 'text', 'class' => 'crproductor'));
                        echo $html->link('<img id="buscarCho" src="../images/buscar.png" width="16" height="16" title=Buscar Productor>');
                    ?>
                </td>
            </tr>
            <tbody id="chofer">
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Guia.nombre_chofer', $infoVehiculo[0]['nombre_chofer'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tr>
                <td><span class="msj_rojo">* </span>Placa Veh&iacute;culo: </td>
                <td><? echo $html->input('Vehiculo.placa', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Marca: </td>
                <td><? echo $html->input('Vehiculo.marca', $infoVehiculo[0]['marca'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Placa Remolque: </td>
                <td><? echo $html->input('Vehiculo.placa_remolques', $infoVehiculo[0]['remolque'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Recepci&oacute;n</legend>
        <table align="center">
            <tr>
                <td>Fecha de Recepci&oacute;n: </td>
                <td><? echo $html->input('Recepcion.fecha_recepcion', date('d-m-Y'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Carril de Muestreo: </td>
                <td><? echo $html->select('Recepcion.carril', array('options'=>$listaCarriles, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Cant. Muestras</td>
                <td><? echo $html->select('Recepcion.cant_muestras', array('options'=>$listaCantM, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
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
<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $listaCantM = array(1 => 1, 2 => 2);
    /*PARA TRABAJAR CON 3 MUESTRAS
    $listaCantM = array(1 => 1, 2 => 2, 3 => 3);*/
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
            $chofer = new Chofer();
            
            $GPC['Guia']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Guia']['estatus'] = 'P';
            $GPC['Chofer']['id_org'] = $_SESSION['s_org_id'];
            $GPC['Chofer']['ced_rif'] = $GPC['nacion3'].$GPC['Chofer']['ced_rif'];
            $GPC['Chofer']['estatus'] = 't';
            //$GPC['Guia']['cedula_chofer'] = $GPC['nacion3'].$GPC['Guia']['cedula_chofer'];
            $GPC['Productor']['ced_rif'] = $GPC['nacion'].$GPC['Productor']['ced_rif'];
            $GPC['Asociado']['ced_rif'] = $GPC['nacion2'].$GPC['Asociado']['ced_rif'];
            $GPC['Recepcion']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Recepcion']['estatus_rec'] = 1;
            $GPC['Recepcion']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Recepcion']['id_silo'] = 2;
            $GPC['Recepcion']['fecha_recepcion'] = 'now()';
            
            $recepcion->_begin_tool();
            
            $guia->save($GPC['Guia']);
            $idGuia = $guia->id;
            
            if($GPC['cantguia'] >= 1){
                for($j=1; $j<=$GPC['cantguia']; $j++){
                    $idSubGuia = $guia->guardarSubGuias($idGuia, $GPC["subguia_$j"], $GPC["subguiaFecha_$j"]);
                }
            }
            
            $productor->save($GPC['Productor']);
            $idProductor = $productor->id;
            if(!empty($GPC['Asociado']['ced_rif']) && !empty($GPC['Asociado']['nombre'])){
                $GPC['Asociado']['id_productor'] = $idProductor;
                $asociado->save($GPC['Asociado']);
                $idAsociado = $asociado->id;
            }
            $aso = (!empty($idAsociado)) ? 't' : 'f';
            $cosecha->guardarProductorCosecha($GPC['Recepcion']['id_cosecha'], $idCA, $idProductor, $aso);
            $chofer->save($GPC['Chofer']);
            $idChofer = $chofer->id;
            $vehiculo->save($GPC['Vehiculo']);
            $idVehiculo = $vehiculo->id;
            $GPC['Recepcion']['id_productor'] = $idProductor;
            $GPC['Recepcion']['id_guia'] = $idGuia;
            $GPC['Recepcion']['id_vehiculo'] = $idVehiculo;
            $GPC['Recepcion']['id_chofer'] = $idChofer;
            if(!empty($idAsociado)){
                $GPC['Recepcion']['id_asociado'] = $idAsociado;
            }
            $recepcion->save($GPC['Recepcion']);
            $idRecepcion = $recepcion->id;
            
            if(!empty($idGuia) && !empty($idProductor) && !empty($idChofer) && !empty($idVehiculo) && !empty($idRecepcion)){
                $recepcion->_commit_tool();
                header("location: ".DOMAIN_ROOT."/reportes/imprimir_recepcion.php?id_rec=$idRecepcion");
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
//$validator->setRules('Recepcion.id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.numero', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'recepcion.php';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        /*$('#Recepcion\\[id_cosecha\\]').change(function(){
            if($(this).val() != '')
                $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad&idCo='+$(this).val());
            else{
                $('#nrocosecha').html('');
                $('#nrocosecha').append('Entrada Nro: ');
            }
        });*/
    
        $('#Orden\\[numero\\]').change(function(){
            var orden = $(this).val();
            if(orden != '')
                $('#orden').load('../ajax/detalle_despacho.php?ac=orden&numero='+orden);
            else
                $('#Orden\\[numero\\]').val('');
        });
        
        $('#Cliente\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion').val();
            var ced = $('#Cliente\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#orden').load('../ajax/detalle_despacho.php?ac=cliente&cp='+ced);
            }
        });
        
        $('#Chofer\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion2').val();
            var ced = $('#Chofer\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#orden').load('../ajax/detalle_despacho.php?ac=chofer&cp='+ced);
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        DESPACHO<br/><hr/>
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
    <!--table align="center" border="0" width="100%">
        <tr>
            <td colspan="2" id="nrocosecha">Entrada Nro: </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha: </td>
            <td><? echo $html->select('Recepcion.id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table-->
    <fieldset>
        <legend>Datos de la Orden</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                <td>
                    <? echo $html->input('Orden.numero', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?>
                </td>
            </tr>
            <tbody id="orden">
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', '', array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos</td>
                    <td><? echo $html->input('Cliente.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono</td>
                    <td><? echo $html->input('Cliente.telefono', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Cultivo</td>
                    <td><? echo $html->input('Orden.telefono', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Despacho</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Chofer</td>
                <td>
                    <?
                        echo $html->select('nacion2', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Chofer.ced_rif', $infoProductor[0]['cedula_pro'], array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                    ?>
                </td>
            </tr>
            <tbody id="productor">
                <tr>
                    <td><span class="msj_rojo">* </span>Placa Veh&iacute;culo</td>
                    <td><? echo $html->input('Vehiculo.placa', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Placas Remolque</td>
                    <td><? echo $html->input('Vehiculo.placa_remolques', $infoVehiculo[0]['remolque'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>C&oacute;digo del Transporte</td>
                    <td><? echo $html->input('Vehiculo.placa_remolques', $infoVehiculo[0]['remolque'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Orden de Carga 1</td>
                    <td><? echo $html->input('Orden.numero1', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
                </tr>
                <tr>
                    <td>Kilogramos</td>
                    <td><? echo $html->input('Orden.kg1', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
                </tr>
                <tr>
                    <td>Orden de Carga 2</td>
                    <td><? echo $html->input('Orden.numero2', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
                </tr>
                <tr>
                    <td>Kilogramos</td>
                    <td><? echo $html->input('Orden.kg2', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
                </tr>
                <tr>
                    <td>Punto de Entrega</td>
                    <td><? echo $html->input('Orden.ptoEntrega', $infoProductor[0]['email_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
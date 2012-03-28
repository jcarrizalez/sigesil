<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $transporte = new Transporte();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoT = $transporte->find(array('id_centro_acopio' => $idCA), '', array('id', 'nombre'), 'list', 'nombre');
    $listadoT['9999'] = 'Otro';
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    $listadoAgencias = array(1 => 'Agencia 1');
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch($GPC['ac']){
        case 'guardar':
            $cliente = new Cliente();
            $orden = new Orden();
            $chofer = new Chofer();
            $vehiculo = new Vehiculo();
            $despacho = new Despacho();
            $transporte = new Transporte();
            $ptoEntrega = new PuntosEntrega();
            
            $dataCosecha = $cosecha->find(array('id' => $GPC['Despacho']['id_cosecha']));

            $despacho->_begin_tool();
            
            $GPC['Cliente']['id_org'] = $_SESSION['s_org_id'];
            $GPC['Cliente']['ced_rif'] = $GPC['nacion'].$GPC['Cliente']['ced_rif'];
            $cliente->save($GPC['Cliente']);
            $idCliente = $cliente->id;
            
            $GPC['PtoEntrega']['id_cliente'] = $idCliente;
            $ptoEntrega->save($GPC['PtoEntrega']);
            $idPtoEntrega = $ptoEntrega->id;
            
            $GPC['Orden']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Orden']['id_cliente'] = $idCliente;
            $GPC['Orden']['id_cultivo'] = $dataCosecha[0]['id_cultivo'];
            $GPC['Orden']['id_punto_entrega'] = $idPtoEntrega;
            $GPC['Orden']['estatus'] = 'P';
            $orden->save($GPC['Orden']);
            $idOrden = $orden->id;
            
            for($i=1;$i<=2;$i++){
                if(!empty($GPC["subOrden$i"])){
                    $orden->guardarSubOrden($idOrden, $GPC["subOrden$i"], null, null, $GPC["subOrdenkg$i"]);
                }
            }
            
            $GPC['Chofer']['ced_rif'] = $GPC['nacion2'].$GPC['Chofer']['ced_rif'];
            $GPC['Chofer']['estatus'] = 't';
            $chofer->save($GPC['Chofer']);
            $idChofer = $chofer->id;
            
            $camion = $vehiculo->find(array('placa' => $GPC['Vehiculo']['placa']));
            if(empty($camion))
                $vehiculo->save($GPC['Vehiculo']);
            
            $idVehiculo = (!empty($vehiculo->id)) ? $vehiculo->id : $camion[0]['id'];
            
            /* ASI SE UTILIZARÁ PARA GUARDAR LOS TRANSPORTES CUANDO SE MONTE EL DROPDOWN
             * if($GPC['Transporte']['id_transporte'] == '9999'){
                $transporte->save($GPC['Transporte']);
                $idTransporte = (!empty($transporte->id)) ? $transporte->id : $GPC['Transporte']['id'];
            }*/
            $GPC['Transporte']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $transporte->save($GPC['Transporte']);
            $idTransporte = $transporte->id;
            
            $GPC['Despacho']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Despacho']['id_orden'] = $idOrden;
            $GPC['Despacho']['id_cliente'] = $idCliente;
            $GPC['Despacho']['id_chofer'] = $idChofer;
            $GPC['Despacho']['id_vehiculo'] = $idVehiculo;
            $GPC['Despacho']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Despacho']['id_transporte'] = $idTransporte;
            $GPC['Despacho']['id_punto_entrega'] = $idPtoEntrega;
            $GPC['Despacho']['fecha_des'] = 'now()';
            //MODIFICAR PARA QUE TOME EL SILO CORRESPONDIENTE
            $GPC['Despacho']['id_silo'] = 2;
            $GPC['Despacho']['estatus'] = 1;

            $despacho->save($GPC['Despacho']);
            $idDespacho = $despacho->id;
            
            if(!empty($idOrden) && !empty($idCliente) && !empty($ptoEntrega) && !empty($idChofer) && !empty($idVehiculo) && !empty($idTransporte) && !empty($idDespacho)){
                $despacho->_commit_tool();
                header("location: despacho.php?msg=exitoso");
                die();
            }else{
                header("location: despacho.php?msg=error");
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
$validator->setRules('Orden.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Vehiculo.placa', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'despacho.php';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#Despacho\\[id_cosecha\\]').change(function(){
            if($(this).val() != '')
                $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad2&idCo='+$(this).val());
            else{
                $('#nrocosecha').html('');
                $('#nrocosecha').append('Salida Nro: ');
            }
        });
    
        $('#Orden\\[numero_orden\\]').change(function(){
            var orden = $(this).val();
            if(orden != '' && $('#Despacho\\[id_cosecha\\]').val() != '')
                $('#orden').load('../ajax/detalle_despacho.php?ac=orden&numero='+orden);
            else{
                $('#Orden\\[numero_orden\\]').val('');
                alert('Seleccione primero una Cosecha');
            }
        });
        
        $('#Cliente\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion').val();
            var ced = $('#Cliente\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#orden').load('../ajax/detalle_despacho.php?ac=cliente&cp='+ced);
                //PARA CAPTURAR LOS PTOS DE ENTREGA
                //$('#ptosEntrega').load('../ajax/detalle_despacho.php?ac=cliente&cp='+ced);
            }
        });
    
        $('#Chofer\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion2').val();
            var ced = $('#Chofer\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#chofer').load('../ajax/detalle_despacho.php?ac=chofer&cp='+ced);
            }
        });
        
        $('#Transporte\\[id\\]').change(function(){
            if($(this).val() == '9999')
                $('#otroTransporte').load('../ajax/detalle_despacho.php?ac=transporte');
            else
                $('#otroTransporte').html('');
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
    <table align="center" border="0" width="100%">
        <tr>
            <td colspan="2" id="nrocosecha">Salida Nro: </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha: </td>
            <td><? echo $html->select('Despacho.id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Orden</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                <td>
                    <? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?>
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
                <!--tr>
                    <td><span class="msj_rojo">* </span>Cultivo</td>
                    <td><? echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'default' => 'Seleccione', 'class' => 'estilo_campos'))?></td>
                </tr-->
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
            <tbody id="chofer">
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre del Chofer</td>
                    <td><? echo $html->input('Chofer.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tr>
                <td><span class="msj_rojo">* </span>Placa Veh&iacute;culo</td>
                <td><? echo $html->input('Vehiculo.placa', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Placas Remolque</td>
                <td><? echo $html->input('Vehiculo.placa_remolques', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>C&oacute;digo del Transporte</td>
                <td><? echo $html->select('Transporte.id',array('options'=>$listadoT, 'default' => 'Seleccione', 'class' => 'estilo_campos'))?></td>
            </tr>
            <tbody id="otroTransporte"></tbody>
            <tr>
                <td>Orden de Carga 1</td>
                <td><? echo $html->input('subOrden1', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
            </tr>
            <tr>
                <td>Kilogramos</td>
                <td><? echo $html->input('subOrdenkg1', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
            </tr>
            <tr>
                <td>Orden de Carga 2</td>
                <td><? echo $html->input('subOrden2', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
            </tr>
            <tr>
                <td>Kilogramos</td>
                <td><? echo $html->input('subOrdenkg2', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
            </tr>
            <tbody id="ptosEntrega">
                <tr>
                    <td><span class="msj_rojo">* </span>Punto de Entrega</td>
                    <td>
                        <?
                            //echo $html->select('Orden.id_punto_entrega',array('default' => 'Seleccione', 'class' => 'estilo_campos'))
                            echo $html->input('PtoEntrega.nombre', '', array('type' => 'text', 'class' => 'estilo_campos'));
                        ?>
                    </td>
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
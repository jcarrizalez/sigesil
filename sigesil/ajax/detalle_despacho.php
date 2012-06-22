<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    $cultivo = new Cultivo();
    $idCA = $_SESSION['s_ca_id'];
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');

    $listadoCultivos = $cultivo->cultivoPrograma($idCA);

    foreach($listadoCultivos as $valor){
        $listadoC[$valor['id']] = "(".trim($valor['codigo']).") ".$valor['nombre'];
    }
    
    switch ($GPC['ac']){
        case 'buscarOrden':
            $orden = new Orden();
            $dataOrden = $orden->find(array('numero_orden' => $GPC['num']));
            if(empty($dataOrden)){
                ?>
                    <tr>
                        <td><span class="msj_rojo">* </span>Nro Orden </td>
                        <td><? echo $html->input('Orden.numero_orden', $GPC['num'], array('type' => 'text', 'length' => '8', 'class' => 'estilo_campos positive')); ?></td>
                    </tr>
                <?
            }else{
                ?>
                    <tr>
                        <td><span class="msj_rojo">* </span>Nro Orden </td>
                        <td><? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '8', 'class' => 'estilo_campos positive')); ?></td>
                    </tr>
                    <tr>
                        <th colspan="2" align="center">El Nro de Orden ya Existe !</th>
                    </tr>
                <?
            }
        break;
        case 'orden':
            $orden = new Orden();
            
            $infoOrden = $orden->ordenCliente('', $GPC['numero']);
            if(!empty($infoOrden)){
                $infoSubOrden = $orden->cantDespachada($infoOrden[0]['id']);
                $infoSubOrden[0]['total'] = (!empty($infoSubOrden[0]['total'])) ? $infoSubOrden[0]['total']/1000 : 0;
                $disponible = ($infoOrden[0]['toneladas'] - $infoSubOrden[0]['total']);
            }
            
            if(empty($infoOrden)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', $GPC['numero'], array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?>
                        <? echo $html->input('Cliente.nombre', '', array('type' => 'hidden')); ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">El Nro de Orden no Existe !</th>
                </tr>
            <?
            }elseif(!empty($infoOrden) && $infoOrden[0]['estatus'] == 'P'){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Orden Procesada</th>
                    <? echo $html->input('Cliente.nombre', '', array('type' => 'hidden')); ?>
                </tr>
            <?
            }elseif(!empty($infoOrden) && $infoOrden[0]['estatus'] == 'N' && $disponible > 0){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <?
                            echo $html->input('Orden.numero_orden', $GPC['numero'], array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive'));
                            echo $html->input('Despacho.id_orden', $infoOrden[0]['id'], array('type' => 'hidden'));
                            echo $html->input('Despacho.id_cultivo', $infoOrden[0]['id_cultivo'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->input('Cliente.ced_rif', $infoOrden[0]['ced_rif'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true));
                            echo $html->input('Despacho.id_cliente', $infoOrden[0]['id_cliente'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos</td>
                    <td><? echo $html->input('Cliente.nombre', $infoOrden[0]['cliente_nombre'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono</td>
                    <td><? echo $html->input('Cliente.telefono', $infoOrden[0]['cliente_telefono'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Toneladas de la Orden</td>
                    <td><? echo $html->input('toneladas', $infoOrden[0]['toneladas'], array('type' => 'text', 'class' => 'estilo_campos positive', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Toneladas Despachadas</td>
                    <td><? echo $html->input('despachado', $general->formato_numero($infoSubOrden[0]['total'], 2), array('type' => 'text', 'class' => 'estilo_campos positive', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Toneladas Disponibles</td>
                    <td><? echo $html->input('disponible', $general->formato_numero($disponible, 2), array('type' => 'text', 'class' => 'estilo_campos positive', 'readOnly' => true)); ?></td>
                </tr>
                <script type="text/javascript">
                    $(document).ready(function(){
                        ced = $('#Cliente\\[ced_rif\\]').val();
                        $('#ptosEntrega').load('../ajax/detalle_despacho.php?ac=pto&cp='+ced);
                    });
                </script>
            <?
            }elseif(!empty($infoOrden) && $infoOrden[0]['estatus'] == 'N' && $disponible <= 0){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', $GPC['numero'], array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?>
                        <? echo $html->input('Cliente.nombre', '', array('type' => 'hidden')); ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Esta Orden ya fue despachada Completamente !</th>
                </tr>
            <?
            }
        break;
        case 'otroTransporte':
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre Transporte</td>
                    <td><? echo $html->input('Transporte.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
        break;
        case 'otroPto':
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre Punto de Entrega</td>
                    <td><? echo $html->input('PtoEntrega.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
        break;
        case 'otraPlaca':
            $vehiculo = new Vehiculo();
            $infoVehiculo = $vehiculo->find(array('placa' => strtoupper($GPC['placa'])));
            if(!empty($infoVehiculo)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Placa Veh&iacute;culo</td>
                    <td>
                        <?
                            echo $html->input('Vehiculo.placa', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'estilo_campos'));
                            echo $html->input('Vehiculo.id', $infoVehiculo[0]['id'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Marca Veh&iacute;culo</td>
                    <td><? echo $html->input('Vehiculo.marca', $infoVehiculo[0]['marca'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
                </tr>
            <?
            }else{
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Placa Veh&iacute;culo</td>
                    <td>
                        <?
                            echo $html->input('Vehiculo.placa', $GPC['placa'], array('type' => 'text', 'class' => 'estilo_campos'));
                            echo $html->link('<img src="../images/agregar.png" width="16" height="16" title=Agregar>', "javascript:abrirPopup('nuevoV')");
                            echo $html->input('Vehiculo.id', '', array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Veh&iacute;culo Nuevo !</th>
                </tr>
            <?
            }
        break;
        case 'chofer':
            $chofer = new Chofer();
            
            $infoChofer = $chofer->find(array('ced_rif' => $GPC['cp']));
            if(!empty($infoChofer)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Chofer</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR, 'selected' => substr($GPC['cp'], 0, 1)));
                            echo "&nbsp;".$html->input('Chofer.ced_rif', substr($GPC['cp'], 1), array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width: 150px'));
                            echo $html->input('Despacho.id_chofer', $infoChofer[0]['id'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre del Chofer</td>
                    <td><? echo $html->input('Chofer.nombre', $infoChofer[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
                </tr>
            <?
            }else{
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Chofer</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR, 'selected' => substr($GPC['cp'], 0, 1)));
                            echo "&nbsp;".$html->input('Chofer.ced_rif', substr($GPC['cp'], 1), array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width: 150px'));
                            echo $html->link('<img src="../images/agregar.png" width="16" height="16" title=Agregar>', "javascript:abrirPopup('nuevoC')");
                            echo $html->input('Chofer.nombre', '', array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Chofer No Registrado</th>
                </tr>
            <?
            }
        break;
        case 'pto':
            $cliente = new Cliente();
            $ptoEntrega = new PuntosEntrega();
            
            $infoCliente = $cliente->find(array('ced_rif' => $GPC['cp']));
            if(!empty($infoCliente))
                $listaPtos = $ptoEntrega->find(array('id_cliente' => $infoCliente[0]['id']), '', array('id', 'nombre'), 'list', 'nombre');
            
            $listaPtos['99999'] = 'Otro';
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Punto de Entrega</td>
                    <td>
                        <? echo $html->select('PtoEntrega.id',array('options' => $listaPtos, 'default' => 'Seleccione', 'class' => 'estilo_campos otro')); ?>
                    </td>
                </tr>
            <?
        break;
        case 'clienteOrden':
            $cliente = new Cliente();
            $infoCliente = $cliente->find(array('ced_rif' => $GPC['cp']));
            if(empty($infoCliente)){
                $infoCliente[0]['ced_rif'] = $GPC['cp'];
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($infoCliente[0]['ced_rif'], 0,1)));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width: 151px'));
                            echo $html->link('<img src="../images/agregar.png" width="16" height="16" title=Agregar>', "javascript:abrirPopup()");
                            echo $html->input('Cliente.nombre', '', array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Cliente No Registrado</th>
                </tr>
            <?
            }else{
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($infoCliente[0]['ced_rif'], 0,1)));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '8', 'class' => 'positive', 'style' => 'width: 151px'));
                            echo $html->input('Orden.id_cliente', trim($infoCliente[0]['id']), array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre </td>
                    <td><? echo $html->input('Cliente.nombre', trim($infoCliente[0]['nombre']), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
            }
        break;
        case 'numeroOrden':
            if(!empty($GPC['orden']) && !empty($GPC['co']) && !empty($GPC['to']) && !empty($GPC['fe'])){
                $ca = substr($GPC['orden'], 2);
                $cu = substr($GPC['orden'], 2, 2);
                $fechaE = split('-', $GPC['fe']);
                $codigo = $fechaE[0]+11+$fechaE[1]+$fechaE[2]-1570+$GPC['orden']+$GPC['to']+15+$cu;
                if($GPC['co'] != $codigo){
                    echo "<tr><td align='center' colspan='2' class='msj_rojo'>C&oacute;digo de Verificaci&oacute;n Incorrecto</td></tr>";
                    ?>
                    <script type="text/javascript">
                        $('#Guardar').attr('disabled', true);
                    </script>
                    <?
                }else{
                    echo "<tr><td align='center' colspan='2' class='msj_verde'>C&oacute;digo de Verificaci&oacute;n Correcto</td></tr>";
                    ?>
                    <script type="text/javascript">
                        $('#Guardar').removeAttr('disabled');
                    </script>
                    <?
                }
            }
        break;
    }
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('.positive').numeric();
    });
</script>
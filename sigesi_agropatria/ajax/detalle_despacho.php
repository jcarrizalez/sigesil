<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    $cultivo = new Cultivo();
    $idCA = $_SESSION['s_ca_id'];

    $listadoCultivos = $cultivo->cultivoPrograma($idCA);

    foreach($listadoCultivos as $valor){
        $listadoC[$valor['id']] = "(".trim($valor['codigo']).") ".$valor['nombre'];
    }
    
    switch ($GPC['ac']){
        case 'orden':
            $orden = new Orden();
            
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            
            $infoOrden = $orden->ordenCliente('', $GPC['numero']);
            $infoSubOrden = $orden->cantDespachada($infoOrden[0]['id']);
            $disponible = $infoOrden[0]['toneladas'] - $infoSubOrden[0]['total'];
            $infoSubOrden[0]['total'] = (!empty($infoSubOrden[0]['total'])) ? $infoSubOrden[0]['total'] : 0;
            
            if(empty($infoOrden)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', $GPC['numero'], array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?>
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
                        <? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?>
                    </td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Orden Procesada</th>
                    <? echo $html->input('Cliente.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?>
                </tr>
            <?
            }elseif(!empty($infoOrden) || $infoOrden[0]['estatus'] == 'N'){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', $GPC['numero'], array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->input('Cliente.ced_rif', $infoOrden[0]['ced_rif'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true));
                            echo $html->input('Orden.id_cliente', $infoOrden[0]['id_cliente'], array('type' => 'hidden'));
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
                    <td><? echo $html->input('toneladas', $infoOrden[0]['toneladas'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Despachado</td>
                    <td><? echo $html->input('despachado', $infoSubOrden[0]['total'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
                </tr>
                <tr>
                    <td>Disponible</td>
                    <td><? echo $html->input('disponible', $disponible, array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
                </tr>
            <?
            }
        break;
        case 'cliente':
            $cliente = new Cliente();
            
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            
            $infoCliente = $cliente->find(array('ced_rif' => $GPC['cp']));
            if(empty($infoCliente)){
                $clienteNuevo = true;
                $infoCliente[0]['ced_rif'] = $GPC['cp'];
            }else
                $clienteNuevo = false;
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($infoCliente[0]['ced_rif'], 0,1)));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos</td>
                    <td><? echo $html->input('Cliente.nombre', $infoCliente[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono</td>
                    <td><? echo $html->input('Cliente.telefono', $infoCliente[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <!--tr>
                    <td><span class="msj_rojo">* </span>Cultivo</td>
                    <td><? echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'default' => 'Seleccione', 'class' => 'estilo_campos'))?></td>
                </tr-->
            <?
                if($clienteNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Cliente Nuevo, se proceder&aacute; a almacenar</th>
                    </tr>
                    <?
                }
        break;
        case 'transporte':
            ?>
                <tr>
                    <td>Nombre del Transporte</td>
                    <td><? echo $html->input('Transporte.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
        break;
        case 'chofer':
            $chofer = new Chofer();
            
            $infoChofer = $chofer->find(array('ced_rif' => $GPC['cp']));
            $choferNuevo = (empty($infoChofer)) ? true : false;
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre del Chofer</td>
                    <td><? echo $html->input('Chofer.nombre', $infoChofer[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
                if($choferNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Chofer Nuevo, se proceder&aacute; a almacenar</th>
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
                        <? echo $html->select('Orden.id_punto_entrega',array('options' => $listaPtos, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?>
                    </td>
                </tr>
            <?
        break;
        case 'clienteOrden':
            $cliente = new Cliente();
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            $infoCliente = $cliente->find(array('ced_rif' => $GPC['cp']));
            if(empty($infoCliente)){
                $infoCliente[0]['ced_rif'] = $GPC['cp'];
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($infoCliente[0]['ced_rif'], 0,1)));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '8', 'class' => 'integer', 'style' => 'width: 151px'));
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
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '8', 'class' => 'integer', 'style' => 'width: 151px'));
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
        $('.integer').numeric();
    });
</script>
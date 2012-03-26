<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'orden':
            $orden = new Orden();
            
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            $infoOrden = $orden->ordenCliente($GPC['numero']);
            if(!empty($infoOrden) && $infoOrden[0]['estatus'] == 'P'){
            ?>
                <tr>
                    <th colspan="2" align="center">Orden Procesada</th>
                    <? echo $html->input('Guia.fecha_emision', '', array('type' => 'hidden')); ?>
                </tr>
            <?
            }elseif(empty($infoOrden) || $infoOrden[0]['estatus'] == 'N'){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options' => $listaCR, 'selected' => substr($infoOrden[0]['ced_rif'], 0,1)));
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr($infoOrden[0]['ced_rif'], 1), array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos</td>
                    <td><? echo $html->input('Cliente.nombre', $infoOrden[0]['cliente_nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono</td>
                    <td><? echo $html->input('Cliente.telefono', $infoOrden[0]['cliente_telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Cultivo</td>
                    <td><? echo $html->input('Orden.id_cultivo', $infoOrden[0]['id_cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Orden Nueva, se proceder&aacute; a almacenar</th>
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
                            echo "&nbsp;".$html->input('Cliente.ced_rif', substr($infoCliente[0]['ced_rif'], 1), array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
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
                <tr>
                    <td>Cultivo</td>
                    <td><? echo $html->input('Orden.id_cultivo', $infoCliente[0]['id_cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
                if($clienteNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Cliente Nuevo, se proceder&aacute; a almacenar</th>
                    </tr>
                    <?
                }
        break;
    }
?>
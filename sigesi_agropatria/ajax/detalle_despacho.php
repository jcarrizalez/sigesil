<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'orden':
            $guia = new Guia();
            $listaCantM = array(1 => 1, 2 => 2, 3 => 3);
            $infoGuia = $guia->find(array('numero_guia' => $GPC['numero_guia']), null, '*');
            if(!empty($infoGuia) && $infoGuia[0]['estatus'] == 'P'){
            ?>
                <tr>
                    <th colspan="2" align="center">Gu&iacute;a Procesada</th>
                    <? echo $html->input('Guia.fecha_emision', '', array('type' => 'hidden')); ?>
                </tr>
            <?
            }elseif(empty($infoGuia) || $infoGuia[0]['estatus'] == 'N'){
            ?>
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
                <?
            }
        break;
    }
?>
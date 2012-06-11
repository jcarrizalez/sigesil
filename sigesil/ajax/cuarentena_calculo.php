<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'cal':
            if((!empty($GPC['id_producto'])) && (!is_null($GPC['toneladas']))){
                $Productos=new Producto();
                $infoProducto = $Productos->find(array('id' => $GPC['id_producto']));
                $total=$infoProducto[0]['dosis'] * $GPC['toneladas'];
                echo $html->input('Cuarentena.cant_producto',$total,array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor'));                
            }
        break;
    }
?>

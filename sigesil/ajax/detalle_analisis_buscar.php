<?php
    require_once('../lib/core.lib.php');
    
    if(!empty($GPC['numero']) && !empty($GPC['fecha'])){
        if ($_SESSION['s_mov']=='rec') {
            $movimiento = new Recepcion();
            $fechaMov="to_char(fecha_recepcion, 'yyyy-mm-dd')";
        }
        else if ($_SESSION['s_mov']=='des') {
                $movimiento = new Despacho();
                $fechaMov='fecha_des';
        }
       $infoMovimiento= $movimiento->buscar($GPC['numero'], $general->fecha_normal_sql($GPC['fecha'],'es'));                
        if (!empty($infoMovimiento))
            header("location: ".DOMAIN_ROOT."reportes/imprimir_recepcion.php?id_rec=".$infoMovimiento[0]['id']);
    }
?>

<?php
    require_once('../lib/core.lib.php');    
    if(!empty($GPC['numero']) && !empty($GPC['fecha'])){
        if ($_SESSION['s_mov']=='rec')
            $movimiento = new Recepcion();
        else if ($_SESSION['s_mov']=='des')
                $movimiento = new Despacho();        
        $infoMovimiento= $movimiento->find(array('numero' => $GPC['numero'],'fecha' => $general->fecha_normal_sql($GPC['fecha'])));
//        if (empty($infoMovimiento[0]['id']))
//            echo $html->input('indice', $infoMovimiento[0]['id'], array('type' => 'text'));
            echo $html->input('idRec', 'pepe', array('type' => 'text'));
    }
?>

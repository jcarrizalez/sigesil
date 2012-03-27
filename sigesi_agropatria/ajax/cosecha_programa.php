<?php
    require_once('../lib/core.lib.php');
    $cosecha = new Cosecha();
    
    switch ($GPC['ac']){
        case 'programa':
            if(!empty($GPC['id'])){
                $listadoC = $cosecha->buscarCosechaP('', $GPC['id']);
                foreach($listadoC as $valor){
                    $listaC[$valor['id']] = $valor['codigo'];
                }
                
                echo $html->select('Recepcion.id_cosecha',array('options'=>$listaC, 'default' => 'Seleccione'));
            }else{
                echo $html->select('Recepcion.id_cosecha',array('default' => 'Seleccione'));
            }
        break;
        case 'cantidad':
            if(!empty($GPC['idCo'])){
                $recepcion = new Recepcion();
                $cantRecepcion = $recepcion->recepcionesDia($_SESSION['s_ca_id'], $GPC['idCo']);
                $numeroRecepcion = ++$cantRecepcion[0]['total'];
                echo "Entrada Nro: ".$numeroRecepcion;
                echo $html->input('Recepcion.numero', $numeroRecepcion, array('type' => 'hidden', 'class' => 'estilo_campos'));
            }
        break;
        case 'cantidad2':
            if(!empty($GPC['idCo'])){
                $despacho = new Despacho();
                $cantSalida = $despacho->despachosDia($_SESSION['s_ca_id'], $GPC['idCo']);
                $numeroSalida = ++$cantSalida[0]['total'];
                echo "Salida Nro: ".$numeroSalida;
                echo $html->input('Despacho.numero', $numeroSalida, array('type' => 'hidden', 'class' => 'estilo_campos'));
            }
        break;
    }
?>

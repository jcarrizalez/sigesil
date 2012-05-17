<?php

    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    $productor = new Productor();
    $movimiento = new Recepcion();
    $vehiculo = new Vehiculo();
    
    switch ($GPC['ac']) {
        case 'cosecha':
            $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
            echo $html->select('Recepcion_codigo', array('options' => $listaCo, 'class' => 'estilo_campos'));
        break;
        case 'productor':
            if (!empty($GPC['cosecha'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $listaProductor = $cosecha->buscarCosechaProductor($idCosecha);
                    foreach($listaProductor as $dataPro)
                        $listaP[$dataPro['ced_productor']]=$dataPro['productor'];
                    echo $html->select('Recepcion.productor', array('options' => $listaP, 'class' => 'estilo_campos'));
                }                
            }
        break;
        case 'asociacion':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP'])) {
                if (is_numeric($GPC['cosecha'])) {                
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=(is_numeric($GPC['cedRifP'])) ? $GPC['cedRifP']: '';            
                    $listAsociacion = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP);
                    foreach($listAsociacion as $datAon)
                        $listAon[$datAon['ced_asociacion']]=$datAon['asociacion'];
                    if (!empty($listAon))
                        echo $html->select('Recepcion.asociacion', array('options' => $listAon, 'class' => 'estilo_campos'));
                 }
            }
        break;
        case 'asociado':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP']) && !empty($GPC['cedRifAon']) && !empty($GPC['cedRifAdo'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=($GPC['cedRifP']=='undefined') ? $GPC['cedRifP']: null;
                    $cedRifAon=($GPC['cedRifAon']=='undefined') ? $GPC['cedRifAon']: null;
                    $listAsociado = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP, $cedRifAon);
                    foreach($listAsociado as $datAdo)
                        $listAdo[$datAdo['ced_asociacion']]=$datAdo['asociacion'];
                    if (!empty($listAdo))
                        echo $html->select('Recepcion.asociacion', array('options' => $listAdo, 'class' => 'estilo_campos'));
                }
            }
        break;
        case 'recepcion':
            if (!empty($GPC['numero']) && !empty($GPC['fecha']) && !empty($GPC['tipo'])) {
                //$infoMov=$movimiento->listadoRecepcion(null, $idCa, $idCo, null, $GPC['numero'], null, $GPC['fecha'], $GPC['fecha']);                
                $infoMov=$movimiento->listadoRecepcion(null, null, null, null, $GPC['numero'], null, $general->fecha_normal_sql($GPC['fecha']), $GPC['fecha']);
                $numero=$infoMov[0]['numero'];
                echo $html->input('', "ENTRADA OCUPADA!!!", array('type' => 'text'));

//                if ($GPC['tipo']=='n')
//                    if (!empty($numero)) 
//                        echo $html->input('numero_msg', "ENTRADA OCUPADA!!!", array('type' => 'text'));
//                    else
//                        echo $html->input('numero_msg', "ENTRADA DISPONIBLE!!!", array('type' => 'text'));
//                else
//                    if (!empty($numero)) 
//                        echo $html->input('numero_msg', "ENTRADA OCUPADA!!!", array('type' => 'text'));
//                    else
//                        echo $html->input('numero_msg', "ENTRADA DISPONIBLE!!!", array('type' => 'text'));
            }
        break;
        case 'vehiculo':
            if (!empty($GPC['placa'])) {
                $infoVehiculo=$vehiculo->buscar(trim($GPC['placa']));
                $idVehiculo=$infoVehiculo[0]['id'];
                if (empty($idVehiculo)) 
                    echo "<span>EL VEHICULO NO EXISTE!!!</span>";
                else 
                    echo "<span>".$infoVehiculo[0]['marca'].' '.$infoVehiculo[0]['color']."</span>";
            }
        break;
    }
?>
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
                    echo $html->select('Recepcion.ced_productor', array('options' => $listaP, 'default' => 'Seleccione', 'class' => 'estilo_campos'));
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
                    //$listAon['null']='Seleccione';
                    if (!empty($listAon))
                        echo $html->select('Recepcion.ced_asociacion', array('options' => $listAon, 'default' => 'Seleccione',  'class' => 'estilo_campos'));
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
                    $listAdo['null']='Seleccione';
                    if (!empty($listAdo))
                        echo $html->select('Recepcion.ced_asociacion', array('options' => $listAdo, 'default' => 'Seleccione', 'class' => 'estilo_campos'));
                }
            }
        break;
        case 'recepcion':
            if (!empty($GPC['numero']) && !empty($GPC['fecha']) && !empty($GPC['tipo']) && !empty($GPC['ca'])  && !empty($GPC['co']) && !empty($GPC['id'])) {
                //$infoMov=$movimiento->listadoRecepcion(null, $GPC['ca'], $GPC['co'], null, $GPC['numero'], null, null, null, null, null, $idPro, null, null, null, null, null, null, $general->fecha_normal_sql($GPC['fecha']));
                $infoMov=$movimiento->listadoRecepcion(null, $GPC['ca'], null, null, $GPC['numero'], null, null, null, null, null, null, null, null, null, null, null, null, date("Y-m-d", strtotime($GPC['fecha'])));
                //debug::pr($infoMov, true);
                if (!empty($infoMov)) {
                    if ($GPC['tipo']=='n')
                        echo $html->input('msg', "ENTRADA OCUPADA", array('type' => 'text', 'style' => 'display: block'));
                } else {
                    echo $html->input('msg', "ENTRADA DISPONIBLE!!!", array('type' => 'text', 'style' => 'display: block'));
                }
                
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
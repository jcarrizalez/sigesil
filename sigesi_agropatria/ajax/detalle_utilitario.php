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
            echo $html->select('Recepcion_codigo', array('options' => $listaCo, 'class' => 'crproductor'));
        break;
        case 'productor':
            if (!empty($GPC['cosecha'])) {
                $listaProductor = $cosecha->buscarCosechaProductor($GPC['cosecha']);
                foreach($listaProductor as $clave=>$valor)
                    $listaP[$clave]=$valor;
                
                //echo $html->select('Recepcion.productor', array('options' => $listaP, 'class' => 'crproductor'));
            }
        break;
        case 'asociacion':
            if (!empty($GPC['cedRif'])) {
                $infoAsociacion = $cosecha->buscarCosechaProductor($GPC['cosecha'], $GPC['cedRifP'], $GPC['cedRif']);
                if (!empty($infoAsociacion)) 
                    echo "<span>".$infoAsociacion[0]['asociacion']."</span>";
                else
                    echo "<span>LA ASOCACION NO EXISTE!!!</span>";
            }
        break;
        case 'asociado':
            if (!empty($GPC['cedRif'])) {
                $infoAsociado = $cosecha->buscarCosechaProductor($GPC['cosecha'], $GPC['cedRifP'], $GPC['cedRifAon'], $GPC['cedRif']);
                if (!empty($infoAsociado))
                    echo "<span>".$infoAsociado[0]['asociado']."</span>";
                else
                    echo "<span>EL ASOCACIADO NO EXISTE!!!</span>";
            }
        break;
        case 'recepcion':
            if (!empty($GPC['numero']) && !empty($GPC['fecha']) && !empty($GPC['tipo'])) {
                //$infoMov=$movimiento->listadoRecepcion(null, $idCa, $idCo, null, $GPC['numero'], null, $GPC['fecha'], $GPC['fecha']);                
                $infoMov=$movimiento->listadoRecepcion(null, null, null, null, $GPC['numero'], null, $general->fecha_normal_sql($GPC['fecha']), $GPC['fecha']);
                $numero=$infoMov[0]['numero'];

                if ($GPC['tipo']=='n')
                    if (!empty($numero)) 
                        echo "<span>ENTRADA OCUPADA!!!</span>";
                    else
                        echo "<span>ENTRADA DISPONIBLE!!!</span>";
                else
                    if (!empty($numero))
                            echo "<span>LA RECEPCION EXISTE!!!</span>";
                    else
                        echo "<span>ENTRADA DISPONIBLE!!!</span>";
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
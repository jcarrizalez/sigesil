<?php

    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    $productor = new Productor();
    $movimiento = new Recepcion();
    
    switch ($GPC['ac']) {
        case 'cosecha':
            if (!empty($GPC['codigo'])) {
                $infoCosecha=$cosecha->find(array('codigo' => $GPC['codigo']));
                $idCosecha=$infoCosecha[0]['id'];
                if (!empty($idCosecha)) {
                    $idCultivo=$infoCosecha[0]['id_cultivo'];
                    $infoCultivo=$cultivo->find(array('id' => $idCultivo));
                    echo "<span>".$infoCultivo[0]['nombre']."</span>";  
                } else
                    echo "<span>LA COSECHA NO EXISTE!!!</span>";
            }
        break;
        case 'productor':
            if (!empty($GPC['cedRif'])) {
                $infoProductor = $cosecha->buscarCosechaProductor($GPC['cosecha'], $GPC['cedRif']);
                if (!empty($infoProductor)) 
                    echo "<span>".$infoProductor[0]['productor']."</span>";
                else
                    echo "<span>EL PRODUCTOR NO EXISTE!!!</span>";
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
            if (!empty($GPC['numero']) && !empty($GPC['fecha'])) {
                $infoMov=$movimiento->find(array('numero' => $GPC['numero'], 'fecha_recepcion' => $general->fecha_normal_sql($GPC['fecha'])));
                $numero=$infoMov[0]['numero'];
                if (empty($numero)) 
                    echo "<span>ENTRADA DISPONIBLE</span>";
                else
                    echo "<span>ENTRADA DISPONIBLE!!!</span>";
            }
        break;
        case 'vehiculo':
            if (!empty($GPC['placa'])) {
                echo "<span>error</span>";
            }
        break;
    }
?>

<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
    $Rec=new Recepcion();
    $Pro=new Productor();
    $Co=new Cosecha();
    $Cul=new Cultivo();
    $Aso=new Asociado();
    $Veh=new Vehiculo();
    
    if (empty($GPC['id']))  {
        die();
    }       
    $infoRec = $Rec->find(array('id' => $GPC['id']));    
    $infoPro = $Pro->find(array('id' => $infoRec[0]['id_productor']));
    $infoCo = $Co->find(array('id' => $infoRec[0]['id_cosecha']));    
    $infoAso = $Aso->find(array('id' => $infoRec[0]['id_asociado']));    
    $infoVehiculo = $Veh->find(array('id' => $infoRec[0]['id_vehiculo']));

//    
//    echo '<br>';print_r($infoRec[0]);echo '</br>';
//    
//    echo '<br>';print_r($infoPro[0]);echo '</br>';
?>
<div id="titulo_reporte">
    BOLETA DE RECHAZO
</div>
<table id="tabla_reporte" border="0" width="100%">
    <tr>
        <td>PROPIEDAD DE: </td>
        <td><?echo $infoPro[0]['nombre']; ?></td>
    </tr>
    <tr>
        <td>PRODUCTOR: </td>
        <td><?echo $infoAso[0]['nombre']; ?></td>
    </tr>
    <tr>
        <td>Vehiculo: </td>
        <td><?echo $infoAso[0]['nombre']; ?></td>
    </tr>
</table>
<?    
    require_once("../lib/common/footer_reportes.php");
?>
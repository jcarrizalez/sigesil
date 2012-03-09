<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
       
    if (empty($GPC['id']))  {
        die();
    }       
    
    $Rec=new Recepcion();
    
    $Rechazo=$Rec->listadoRechazo($GPC['id'], 7);
//    debug::pr($listadoRechazo);
    
//    $infoRec = $Rec->find(array('id' => $GPC['id']));    
//    $infoPro = $Pro->find(array('id' => $infoRec[0]['id_productor']));
//    $infoCo = $Co->find(array('id' => $infoRec[0]['id_cosecha']));    
//    $infoAso = $Aso->find(array('id' => $infoRec[0]['id_asociado']));    
//    $infoVehiculo = $Veh->find(array('id' => $infoRec[0]['id_vehiculo']));

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
        <td width="200px">PROPIEDAD DE: </td>        
        <td align="left" width="120px"><?echo $Rechazo[0]['ced_rif_pro']; ?></td>
        <td align="left"><?echo $Rechazo[0]['nom_pro']; ?></td>
    </tr>
    <tr>
        <td>PRODUCTO: </td>
        <td align="left"><?echo $Rechazo[0]['nom_cul']; ?></td>
    </tr>
    <tr>
        <td>CHOFER: </td>
        <td><?echo $Rechazo[0]['nombre_chofer']; ?></td>
    </tr>
    <tr>
        <td>VEHICULO PLACA: </td>
        <td><?echo $Rechazo[0]['placa']; ?></td>
    </tr>
</table>
<br>
<p>MOTIVO DEL RECHAZO
<?    
    require_once("../lib/common/footer_reportes.php");
?>
<!--select rec.numero,
                    rec.fecha_recepcion,
                    rec.carril,
                    rec.estatus_rec,
                    pro.ced_rif as ced_rif_pro,
                    pro.nombre as nom_pro,
                    aso.ced_rif as ced_rif_aso,
                    aso.nombre as nom_aso,
		    guia.cedula_chofer,      
		    guia.nombre_chofer,
		    veh.placa,
		    cul.nombre as nom_cul 		    
                    from si_recepcion rec                     
                    inner join si_productor pro 
                    on rec.id_productor=pro.id 
                    inner join si_asociado aso
                    on rec.id_productor=pro.id 
                    inner join si_guiarec guia
                    on rec.id_guia=guia.id
                    inner join si_vehiculos veh
                    on rec.id_vehiculo=veh.id
                    inner join si_cosecha cos
                    on rec.id_cosecha=cos.id
                    inner join si_cultivo cul
                    on cos.id_cultivo=cul.id
                    where '1'-->
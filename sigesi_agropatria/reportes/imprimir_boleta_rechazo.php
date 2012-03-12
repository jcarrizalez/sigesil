<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
       
//    if (empty($GPC['id']))  {
//        die();
//    }       
    
    $Rec=new Recepcion();
    
    $Rechazo=$Rec->listadoRechazo($GPC['id'], 7);
    if(empty($Rechazo)){
        header('location: ../admin/analisis_recepcion?msg=error');      
    }

?>
<div id="titulo_reporte">
    BOLETA DE RECHAZO
</div>
<table id="tabla_reporte" border="0" width="100%">
    <tr>
        <td align="right" width=200px">PROPIEDAD DE: </td>        
        <td align="left" width="120px"><?echo $Rechazo[0]['ced_rif_pro']; ?></td>
        <td align="left"><?echo $Rechazo[0]['nom_pro']; ?></td>
    </tr>
    <tr>
        <td align="right">PRODUCTO: </td>
        <td align="left" colspan="3"><?echo $Rechazo[0]['nom_cul']; ?></td>
    </tr>
    <tr>
        <td align="right">CHOFER: </td>
        <td colspan="2"><?echo $Rechazo[0]['nombre_chofer']; ?></td>
    </tr>
    <tr>
        <td align="right">VEHICULO PLACA: </td>
        <td colspan="2"><?echo $Rechazo[0]['placa']; ?></td>
    </tr>
</table>
<br/>
<p>MOTIVO DEL RECHAZO
<br/>
<p><?echo $etiqueta['M_BoletaRechazo']; ?>
<?    
    require_once("../lib/common/footer_reportes.php");
//    $curl_handle=curl_init();
//    curl_setopt($curl_handle,CURLOPT_URL,DOMAIN_ROOT.'reportes/imprimir_boleta_rechazo.php?id=2');
//    $buffer = curl_exec($curl_handle);
//    curl_close($curl_handle);  
//    if (empty($buffer))
//    {
//        print "Sorry, example.com are a bunch of poopy-heads.<p>";
//    }
//    else
//    {
//        print $buffer;
//    } 
?>

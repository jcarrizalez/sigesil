<?php
    require_once("../lib/core.lib.php");
    include("../lib/class/mpdf/mpdf.php");
    
    switch ($GPC['reporte']){
        case 'boleta_recepcion':
            $url = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec='.$GPC['id'];
        break;
        case 'boleta_rechazo':
            $imprimir = DOMAIN_ROOT."reportes/imprimir_boleta_rechazo.php?id=". $GPC['id']."&es_rechazado=".$GPC['es_rechazado'];
            //$url = DOMAIN_ROOT.'reportes/imprimir_boleta_rechazo.php?id=16&lab=C&es_rechazado=0_0:2_1:13_1:';
        break;
    }    
    $imprimir = file_get_contents($url);
    echo $imprimir;
    $mpdf=new mPDF();  
    $stylesheet = file_get_contents(DOMAIN_ROOT.'css/reportes.css');
    $mpdf->WriteHTML($stylesheet,1);
    $mpdf->WriteHTML($imprimir);
    $archivo=$GPC['reporte'].time().'.pdf';
    $mpdf->Output($archivo,'F');
    //exit;
    $impresora="HP-LaserJet-p2015dn_Sistemas2";
    exec("lpr -P $impresora $archivo");
    //exec("lpr $archivo");
    exec("rm $archivo");
?>
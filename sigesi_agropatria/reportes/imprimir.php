<?php
    require_once("../lib/core.lib.php");
    include("../lib/class/mpdf/mpdf.php");
    
    switch ($GPC['reporte']){
        case 'boleta_recepcion':
            //$imprimir = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec='.$GPC['id'];
            $imprimir = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec=14';
        break;
    }
    /*$ch = curl_init($imprimir);
    $fp = fopen("sigesil.html", "w");
    curl_setopt($ch, CURLOPT_FILE, $fp);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_exec($ch);
    curl_close($ch);
    fclose($fp);*/
    $imprimir = file_get_contents($imprimir);
    
    $mpdf=new mPDF();
    //$mpdf->SetDisplayMode('fullpage');
    $stylesheet = file_get_contents(DOMAIN_ROOT.'css/reportes.css');
    $mpdf->WriteHTML($stylesheet,1);
    $mpdf->WriteHTML($imprimir);
    $mpdf->Output('recepcion.pdf','F');
    exit;
    //exec("lpr -P HP-LaserJet-p1606dn sigesil.html");
?>
<script type="text/javascript">
    history.back();
</script>
<?php
    require_once("../lib/core.lib.php");
    
    switch ($GPC['reporte']){
        case 'boleta_recepcion':
            $imprimir = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec='.$GPC['id'];
            //$imprimir = DOMAIN_ROOT.'pages/index.php';
            //die($imprimir);
        break;
    }    
    
    $ch = curl_init($imprimir);
    $fp = fopen("sigesil", "w");
    curl_setopt($ch, CURLOPT_FILE, $fp);
    curl_setopt($ch, CURLOPT_HEADER, 0);
    curl_exec($ch);
    curl_close($ch);
    fclose($fp);
    
    exec("lpr sigesil");
?>
<script type="text/javascript">
    history.back();
</script>
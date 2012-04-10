<?php
    require_once("../lib/core.lib.php");
    include("../lib/class/mpdf/mpdf.php");
    
    switch ($GPC['reporte']){
        case 'boleta_recepcion':
            $url = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec='.$GPC['id_rec'];
        break;
        case 'boleta_rechazo':
            $imprimir = DOMAIN_ROOT."reportes/imprimir_boleta_rechazo.php?id=". $GPC['id']."&es_rechazado=".$GPC['es_rechazado'];
        break;
    }    
    $imprimir = file_get_contents($url);
    $mpdf=new mPDF();  
    $stylesheet = file_get_contents(DOMAIN_ROOT.'css/reportes.css');
    $mpdf->WriteHTML($stylesheet,1);
    $mpdf->WriteHTML($imprimir);
    $archivo=$GPC['reporte'].time().'.pdf';
    $mpdf->Output($archivo,'F');

    /* SENTENCIA PARA IMPRESION INDICANDO LA IMPRESORA A TRAVES DEL PARAMETRO -P DEL LPR
     * $parametros="-P HP-LaserJet-p1606dn";
     * exec("lpr $parametros $archivo");
     */
    
    exec("lpr $archivo");
    
    exec("rm $archivo");
    
    if(!empty($GPC['redir'])){
        $GPC['redir'] = (!empty($_SESSION['s_mov']) && !empty($_SESSION['s_lab'])) ? $GPC['redir'].'?mov='.$_SESSION['s_mov'].'&lab='.$_SESSION['s_lab'] : $GPC['redir'];
        header('location: '.DOMAIN_ROOT.'admin/'.$GPC['redir'].'.php');
    }
?>
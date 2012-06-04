<?php
    require_once("../lib/core.lib.php");
    include("../lib/class/mpdf/mpdf.php");
    
    switch ($GPC['reporte']){
        case 'boleta_recepcion':
            $url = DOMAIN_ROOT.'reportes/imprimir_recepcion.php?id_rec='.$GPC['id_rec'].'&ca='.$GPC['ca'].'&reimprimir='.$GPC['re'];
        break;
        case 'boleta_rechazo':
            $url = DOMAIN_ROOT."reportes/imprimir_boleta_rechazo.php?id=". $GPC['id']."&es_rechazado=".$GPC['es_rechazado'];
        break;
        case 'boleta_liquidacion':
            $url = DOMAIN_ROOT.'reportes/imprimir_boleta_liquidacion.php?id_rec='.$GPC['id_rec'].'&mov='.$GPC['mov'].'&reimprimir'.$GPC['re'];
        break;
        case 'boleta_tipifica':
            $url = DOMAIN_ROOT.'reportes/imprimir_boleta_tipificacion.php?id_rec='.$GPC['id_rec'];
        break;
    }
    
    $imprimir = file_get_contents($url);
    if(empty($GPC['re'])){
        $impresora = new Impresora();
        $detalleImpresora = $impresora->buscarImpresora(null, $_SESSION['s_ca_id'], $GPC['status']);
        
        $mpdf=new mPDF('c');
        $mpdf->SetDisplayMode('fullpage');
        $mpdf->SetTopMargin(0);
        $stylesheet = file_get_contents(DOMAIN_ROOT.'css/reportes.css');
        $mpdf->WriteHTML($stylesheet,1);
        $mpdf->WriteHTML($imprimir);
        $archivo=$GPC['reporte'].time().'.pdf';
        $mpdf->Output($archivo,'F');

        //SENTENCIA PARA IMPRESION INDICANDO LA IMPRESORA A TRAVES DEL PARAMETRO -P DEL LPR
        $nombreImpresora = $detalleImpresora[0]['nombre'];
        $parametros = (!empty($detalleImpresora[0]['parametros'])) ? $detalleImpresora[0]['parametros'] : '';
        exec("lpr -P $nombreImpresora $parametros $archivo");

        //exec("lpr $archivo");
        exec("rm $archivo");

        if(!empty($GPC['redir'])){
            if(!empty($_SESSION['s_mov']) && !empty($_SESSION['s_lab']))
                $redir = $GPC['redir'].'.php?mov='.$_SESSION['s_mov'].'&lab='.$_SESSION['s_lab'];
            elseif(!empty($GPC['mov']))
                $redir = $GPC['redir'].'.php?mov='.$GPC['mov'];
            else{
                $redir = $GPC['redir'].'.php';            
            }
            header("location: ".DOMAIN_ROOT."admin/$redir");
            die();
        }
    }else
        echo $imprimir;
?>
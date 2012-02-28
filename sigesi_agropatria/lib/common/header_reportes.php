<?php
    require_once("../lib/core.lib.php");
    //include("../lib/class/mpdf/mpdf.php");
    $analisis = new AnalisisCultivo();
?>
<html>
    <head>
        <title><?=SYSTEM_NAME?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="<?=DOMAIN_ROOT?>images/favicon.ico" rel="shortcut icon" />
        <link href="<?=DOMAIN_ROOT?>css/reportes.css" rel="stylesheet" type="text/css" />
        <?
        $javascript->includeFile('jquery/jquery-1.7.1.min.js');
        $javascript->includeFile('jquery/jquery.validate.js');
        ?>
    </head>
    <body>
        <div id="principal_reporte">
            <div id="cabecera_empresa">
                <?=$_SESSION["s_org_nombre"]." - SILOS ".$_SESSION["s_ca_nombre"]?>
            </div>
            <div id="cabecera_fecha">
                Fecha: <?=date("d/m/Y")?><br/>
                Hora: <?=date("h:i a")?>
            </div>
            <div id="cuerpo_reporte">
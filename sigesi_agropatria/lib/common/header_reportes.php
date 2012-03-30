<?php
    require_once("../lib/core.lib.php");
    //include("../lib/class/mpdf/mpdf.php");
?>
<html>
    <head>
        <title><?=SYSTEM_NAME?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="<?=DOMAIN_ROOT?>images/favicon.ico" rel="shortcut icon" />
        <!--link href="<?=DOMAIN_ROOT?>css/reportes.css" rel="stylesheet" type="text/css" /-->
    </head>
    <body>
        <div id="principal_reporte">
            <table border="0" width="800">
                <tr>
                    <td width="300"><?=$_SESSION["s_org_nombre"]." - SILOS ".$_SESSION["s_ca_nombre"]?></td>
                    <td align="right">Fecha: <?=date("d/m/Y")?></td>
                </tr>
                <tr>
                    <td align="right" colspan="2">Hora: <?=date("h:i a")?></td>
                </tr>
            </table>
<?php
    require_once("../lib/core.lib.php");
    $centroAcopio = new CentroAcopio();
    $data = $centroAcopio->buscarCA($GPC["ca"]);
?>
<html>
    <head>
        <title><?php echo SYSTEM_NAME?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <!--link href="<?php echo DOMAIN_ROOT?>images/favicon.ico" rel="shortcut icon" /-->
        <link href="<?php echo DOMAIN_ROOT?>css/reportes.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <div id="principal_reporte">
            <table border="0" width="800">
                <tr>
                    <td width="300"><?php echo $data[0]['nombre_org']." - SILOS ".$data[0]["nombre"]?></td>
                    <td align="right">FECHA DE IMPRESI&Oacute;N: <?php echo date("d/m/Y")?></td>
                </tr>
                <tr>
                    <td align="right" colspan="2">HORA DE IMPRESI&Oacute;N: <?php echo date("h:i a")?></td>
                </tr>
            </table>

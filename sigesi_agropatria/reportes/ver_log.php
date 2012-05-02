<?php
require_once('../lib/core.lib.php');

$objlogs = new cls_logs();
$id_log = $GPC['id_log'];
$objlogs->get_log_id($id_log);
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title><?php echo SYSTEM_NAME ?></title>
        <link href="<?=DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
        <script language="javascript">
            function closeMessage(){
                ventana = window.self;
                ventana.opener = window.self;
                ventana.close();
            }
        </script>
    </head>
    <body>
        <div id="titulo_modulo">
            REPORTE DE USO<br/><input name="submit" type="submit" onclick="closeMessage()" value="<?="Cerrar"?>" /><hr/>
        </div>
        <table align="center" width="95%">
            <tr>
                <td width="25%" align="right" ><strong><?php echo "Informaci&oacute;n del Usuario" ?>:</strong></td>
                <td width="1%">&nbsp;</td>
                <td width="74%" ><?php echo $objlogs->data['usuario_info'] ?></td>
            </tr>
            <tr>
                <td align="right" ><strong><?php echo "Centro de Acopio" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['centro_acopio'] ?></td>
            </tr>
            <!--tr>
                <td align="right" ><strong><?php echo "Correo Eletr&oacute;nico" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['usuario_email'] ?></td>
            </tr-->
            <tr>
                <td align="right" ><strong><?php echo "Sesi&oacute;n" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['session_id'] ?></td>
            </tr>
            <tr>
                <td align="right" ><strong><?php echo "Direcci&oacute;n IP" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['direccion_ip'] ?></td>
            </tr>
            <tr>
                <td align="right" ><strong><?php echo "Tablas" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['en_tablas'] ?></td>
            </tr>
            <tr>
                <td width="25%" align="right" ><strong><?php echo "Fecha" ?>:</strong></td>
                <td width="1%">&nbsp;</td>
                <td width="74%" ><?php echo $general->date_sql_screen($objlogs->data['en_fecha'], '', 'es', '-') ?></td>
            </tr>
            <tr valign="top">
                <td align="right" ><strong><?php echo "Comentarios" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><div style="width:90%; height:"><?php echo ($objlogs->data['comentario']) ? $objlogs->data['comentario'] : 'N/A' ?></div></td>
            </tr>
            <tr valign="top">
                <td align="right" ><strong><?php echo "Datos Nuevos" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><div style="width:90%"><?php echo $objlogs->data['data_nueva'] ?></div></td>
            </tr>
            <tr valign="top">
                <td align="right" ><strong><?php echo "Consulta" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><div style="width:90%"><?php echo $objlogs->data['sentencia_sql'] ?></div></td>
            </tr>
            <tr valign="top">
                <td align="right" ><strong><?php echo "Informaci&oacute;n del Navegador" ?>:</strong></td>
                <td>&nbsp;</td>
                <td ><?php echo $objlogs->data['navegador'] ?></td>
            </tr>
        </table>
    </body>
</html>
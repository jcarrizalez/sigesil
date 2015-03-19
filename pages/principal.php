<?php
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
?>
<div id="titulo_principal">
    <?php echo $sexo." al Sistema de Gesti&oacute;n de Silos<br/> (".SYSTEM_NAME.")" ?>
</div>
<table id="principal" align="center">
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <th width="1">C&oacute;digo: </th>
        <td><?php echo $codigoCA;?></td>
    </tr>
    <tr>
        <th width="1">Centro de Acopio: </th>
        <td><?php echo $nombreCA;?></td>
    </tr>
    <tr>
        <th width="150">Usuario: </th>
        <td><?php echo strtoupper($usuario);?></td>
    </tr>
    <tr>
        <th>Nombre: </th>
        <td><?php echo $nombre_completo;?></td>
    </tr>
    <tr>
        <th>Perfil: </th>
        <td><?php echo $perfil;?></td>
    </tr>
</table>
<?php require('../lib/common/footer.php'); ?>
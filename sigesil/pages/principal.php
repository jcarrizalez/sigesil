<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
?>
<div id="titulo_principal">
    <?=$sexo." al Sistema de Gesti&oacute;n de Silos<br/> (".SYSTEM_NAME.")" ?>
</div>
<table id="principal" align="center">
    <tr><td colspan="2">&nbsp;</td></tr>
    <tr>
        <th width="1">C&oacute;digo: </th>
        <td><?=$codigoCA;?></td>
    </tr>
    <tr>
        <th width="1">Centro de Acopio: </th>
        <td><?=$nombreCA;?></td>
    </tr>
    <tr>
        <th width="150">Usuario: </th>
        <td><?=strtoupper($usuario);?></td>
    </tr>
    <tr>
        <th>Nombre: </th>
        <td><?=$nombre_completo;?></td>
    </tr>
    <tr>
        <th>Perfil: </th>
        <td><?=$perfil;?></td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
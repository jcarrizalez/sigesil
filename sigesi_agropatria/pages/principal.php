<?
require_once('../lib/core.lib.php');
require('../lib/common/header.php');

$usuario = $_SESSION['s_cedula'];
$nombre_completo = $_SESSION['s_nombre'] . " " . $_SESSION['s_apellido'];
$perfil_usuario = $_SESSION['s_profile_id'];

switch ($perfil_usuario) {
    case ADMINISTRADOR:
        $perfil = " Administrador";
        break;
}

$sexo = ($_SESSION['s_sexo'] == "F") ? "Bienvenida " : "Bienvenido ";
?>
<div id="titulo_principal">
    <?=$sexo." al Sistema de Gesti&oacute;n de Silos<br/> (".SYSTEM_NAME.")" ?>
</div>
<table id="principal" align="center">
    <tr><td>&nbsp;</td></tr>
    <tr>
        <th width="1">Usuario: </th>
        <td><?=$usuario;?></td>
    </tr>
    <tr>
        <th>Nombres/Apellidos: </th>
        <td><?=$nombre_completo;?></td>
    </tr>
    <tr>
        <th>Perfil: </th>
        <td><?=$perfil;?></td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
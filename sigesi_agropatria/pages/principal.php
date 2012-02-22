<?
require_once('../lib/core.lib.php');
require('../lib/common/header.php');

$nombreCA = $_SESSION['s_ca_nombre'];
$codigoCA = $_SESSION['s_ca_codigo'];
$usuario = $_SESSION['s_usuario'];
$nombre_completo = $_SESSION['s_nombre'] . " " . $_SESSION['s_apellido'];
$perfil_usuario = $_SESSION['s_perfil_id'];

/*
define('GERENTEG',1);
define('GERENTES',2);
define('ADMINISTRADOR',3);
define('CALIDAD',4);
define('ROMANERO',5);
define('RECEPCION',6);
define('DESPACHO',7);
 */

switch ($perfil_usuario) {
    case GERENTEG:
        $perfil = " GERENTE GENERAL";
    break;
    case GERENTES:
        $perfil = " GERENTE DE SILO";
    break;
    case ADMINISTRADOR:
        $perfil = " ADMINISTRADOR";
    break;
    case CALIDAD:
        $perfil = " CALIDAD";
    break;
    case ROMANERO:
        $perfil = " ROMANERO";
    break;
    case RECEPCION:
        $perfil = " RECEPCION";
    break;
    case DESPACHO:
        $perfil = " DESPACHO";
    break;
}

$sexo = ($_SESSION['s_sexo'] == "F") ? "Bienvenida " : "Bienvenido ";
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
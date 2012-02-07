<?
require_once('../lib/core.lib.php');
require('../lib/common/header.php');

$nombre_completo = $_SESSION['s_nombre'] . " " . $_SESSION['s_apellido'];
$perfil_usuario = $_SESSION['s_profile_id'];

switch ($perfil_usuario) {
    case ADMINISTRADOR:
        $perfil = " (Administrador)";
        break;
}

$sexo = ($_SESSION['s_sexo'] == "F") ? "Bienvenida " : "Bienvenido ";
?>
<div id="titulo_principal">

</div>
<table id="table_login" class="tabla1" width="95%">
    <tr>
        <td class="top_left" width="29" height="34"></td>
        <td class="top"></td>
        <td class="top_right" width="37" height="34"></td>
    </tr>
    <tr>
        <td class="left"></td>
        <td class="center">
            <div id="div_main">
                <div id="div_title"><span><?= $general->fechaPhp(); ?></span></div>
                <div class="titulos">
                    <?= $sexo . $nombre_completo . $perfil; ?>
                    <img src="<?= DOMAIN_ROOT ?>images/doctor.png" width="60" height="60" alt="lista_paciente" style="vertical-align: middle;" />
                </div>
                <div id="div_content">
                    <table border="0" align="center">
                        <tr><td colspan="4">&nbsp;</td></tr>
                        <tr>
                            <td colspan="4" class="titulos">&Uacute;LTIMAS CONSULTAS</td>
                        </tr>
                        <tr>
                            <th class="subTitulos" width="1%">C&eacute;dula</th>
                            <th class="subTitulos" width="10%">Nombres</th>
                            <th class="subTitulos" width="10%">Apellidos</th>
                            <th class="subTitulos" width="4%">&Uacute;ltima Consulta</th>
                        </tr>
                        <?
                        for ($i = 1; $i <= 10; $i++) {
                            $classname = $general->get_classfila($i);
                            ?>
                            <tr class="<?= $classname ?>">
                                <td align="center"><?= $cedula = 18264064 + $i; ?></td>
                                <td class="margen_izq"><?= 'Jesus E ' . $i ?></td>
                                <td class="margen_izq"><?= 'Rodriguez V. ' . $i ?></td>
                                <td align="center"><?= date('d')+$i; echo date('-m-Y') ?></td>
                            </tr>
                        <? } ?>
                    </table>
                </div>
            </div>
        </td>
        <td class="right"></td>
    </tr>
    <tr>
        <td class="bottom_left" width="29" height="33"></td>
        <td class="bottom"></td>
        <td class="bottom_right" width="37" height="33"></td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
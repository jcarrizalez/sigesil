<?
require_once('../lib/core.lib.php');
require('../lib/common/header.php');

$usuarios = New User();
$listSexo = array('F' => 'Femenino', 'M' => 'Masculino');

$cedula = $GPC['cedula'];
$nombre = $GPC['nombre'];
$sexoFiltro = $GPC['sexo'];
$page_size = MAX_RESULTS_PAG;
$start_record = ($GPC['pg']) ? (($GPC['pg'] * $page_size) - $page_size) : 0;

$listaPacientes = $usuarios->obtenerDetalleUsuarios(null, PACIENTE, $cedula, 'CONVERT(u.cedula, signed)', $start_record, $page_size, $nombre, $sexoFiltro, ADMINISTRADOR);

$total_registros = $usuarios->total_verdadero;
$objpaginator = new paginator($total_registros, $page_size);
?>
<script type="text/javascript">
    function search(url){
        var type =$("#company_type_id").attr('value');
        var country =$("#contry_select").attr('value');
        var name =$("#name_s").attr('value');
        window.location=url+"?type="+type+"&country_id="+country+"&name_s="+name;
    }
    function limpiar_lista(url){
        window.location=url;
    }
    function agregar_paciente(url){
        window.location=url;
    }
</script>
<div id="titulo_principal">

</div>
<table id="table_login2" width="95%">
    <tr>
        <td class="top_left" width="29" height="34"></td>
        <td class="top"></td>
        <td class="top_right" width="37" height="34"></td>
    </tr>
    <tr>
        <td class="left"></td>
        <td class="center">
            <table id="table_login2" border="0" width="100%">
                <tr>
                    <td class="titulos">
                        LISTADO DE PACIENTES
                        <img src="<?= DOMAIN_ROOT ?>images/paciente_lista.png" width="60" height="60" alt="lista_paciente" style="vertical-align: middle;" />
                    </td>
                </tr>
                <tr>
                    <td><hr class="linea_espacio"/></td>
                </tr>
                <tr>
                    <td align="right" >
                        <form action="pacientes_lista.php" method="get">
                            <table id="table_login" width="100%" cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td width="100" align="left">C&eacute;dula:</td>
                                    <td colspan="2" align="left"><?= $html->input('cedula', $cedula, array('class' => 'inputText')) ?></td>
                                </tr>
                                <tr>
                                    <td align="left">Nombre/Apellido:</td>
                                    <td colspan="2" align="left"><?= $html->input('nombre', $nombre, array('class' => 'inputText')) ?></td>
                                </tr>
                                <tr>
                                    <td align="left">Sexo:</td>
                                    <td align="left">
                                        <?= $html->select('sexo', array('options' => $listSexo, 'selected' => $sexoFiltro, 'default' => 'Seleccione', 'class' => 'inputText')); ?>
                                        <?= $html->input('buscar', 'Buscar', array('type' => 'submit')) ?>
                                        <?= $html->input('limpiar', 'Limpiar', array('type' => 'button', 'onClick' => "limpiar_lista('pacientes_lista.php');")) ?>
                                    </td>
                                    <td align="right">
                                        <?= $html->input('agregar', 'Agregar Paciente', array('type' => 'button', 'onClick' => "agregar_paciente('pacientes_registrar.php');")) ?>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td><hr class="linea_espacio"/></td>
                </tr>
                <tr>
                    <td>
                        <? if ($_SESSION['msg'] == 'completado') { ?>
                            <p class="textoRequerido">Paciente Registrado !</p>
                        <? } elseif ($_SESSION['msg'] == 'editado') { ?>
                            <p class="textoRequerido">Datos del Paciente Actualizados !</p>
                        <? } unset($_SESSION['msg']); ?>
                        <table id="tabla1" border="0" align="center">
                            <tr>
                                <td colspan="6" style="padding-bottom: 5px;">
                                    <?
                                    $objpaginator->print_page_counter('Pag', 'de');
                                    echo "&nbsp;&nbsp;";
                                    $objpaginator->print_paginator();
                                    ?>
                                </td>
                            </tr>
                            <tr>
                                <th class="subTitulos" width="1%">C&eacute;dula</th>
                                <th class="subTitulos" width="10%">Nombres</th>
                                <th class="subTitulos" width="10%">Apellidos</th>
                                <th class="subTitulos" width="1%">Sexo</th>
                                <th class="subTitulos" width="4%">Fecha Nac</th>
                                <th class="subTitulos" width="1%">Edad</th>
                                <th class="subTitulos" width="1%">Editar</th>
                            </tr>
                            <?
                            $i = 0;
                            foreach ($listaPacientes as $lista) {
                                $classname = $general->get_classfila($i);
                                $sexo = $usuarios->mostrarSexo($lista['sexo']);
                                $edad = $general->calculaEdad($lista['fecha_nacimiento']);
                                ?>
                                <tr class="<?= $classname ?>">
                                    <td align="center"><?= $lista['cedula'] ?></td>
                                    <td class="margen_izq"><?= $lista['nombre'] ?></td>
                                    <td class="margen_izq"><?= $lista['apellido'] ?></td>
                                    <td align="center"><?= $sexo ?></td>
                                    <td align="center"><?= $lista['fecha_nacimiento'] ?></td>
                                    <td align="center"><?= $edad ?></td>
                                    <td align="center"><?= $html->link('<img src="../images/icons/editar.png" width="16" height="16" title="Editar">', 'pacientes_registrar.php?ac=editar&id=' . $lista['id']); ?></td>
                                </tr>
                                <?
                                $i++;
                            }
                            ?>
                            <tr>
                                <td colspan="6" style="padding-top: 5px;">
                                    <?
                                    $objpaginator->print_page_counter('Pag', 'de');
                                    echo "&nbsp;&nbsp;";
                                    $objpaginator->print_paginator();
                                    ?>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
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
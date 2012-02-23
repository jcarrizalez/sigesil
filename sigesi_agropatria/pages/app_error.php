<?
require_once('../lib/core.lib.php');

$error_code = $GPC['code'];

$obj_dbtools = new cls_dbtools;
$obj_dbtools->get_SQL_error($error_code);
$arr_tree = unserialize($obj_dbtools->SQL_error['apperror_text']);

require('../lib/common/header_externo.php');
?>
<? if($_SESSION['s_perfil_id'] != GERENTEG && $_SESSION['s_perfil_id'] != GERENTES){ ?>
<div id="div_error">
    <p id="text_error">
        Una condicion inesperada a ocurrido. Nuestro equipo de soporte t&eacute;cnico ha sido notificado. Por favor regrese luego e intente nuevamente.
        <br/><br/>
        <a href="cerrar_sesion.php" title="Inicio"><strong>INICIO</strong></a>
    </p>
</div>
<? }else{ ?>
<div id="div_error2">
    <p id="text_error2">
        Una condicion inesperada a ocurrido. Nuestro equipo de soporte t&eacute;cnico ha sido notificado. Por favor regrese luego e intente nuevamente.
        <?
        if (($_SESSION['s_perfil_id'] == GERENTEG || $_SESSION['s_perfil_id'] == GERENTES) && (DEBUG && DEBUG != 0)) {
            echo "<br /><br /><a href=\"#\" onClick=\"document.getElementById('detalle_error').style.display='block';\"  ><strong>Mostrar Error</strong></a>";
        }
        ?>
    </p>
    <div class="detalle_error" id="detalle_error">
        <div id="info_query">
            <?
            if (($_SESSION['s_perfil_id'] == GERENTEG || $_SESSION['s_perfil_id'] == GERENTES) && (DEBUG && DEBUG != 0)) {
                for ($i = 0, $max = count($arr_tree); $i < $max; $i++) {
                    ?>
                    <div class="err_child">
                        <?
                        echo "Archivo: " . $arr_tree[$i]['file'] . " <strong>in line " . $arr_tree[$i]['line'] . "</strong><br />";
                        echo "Clase: " . $arr_tree[$i]['class'] . "<br />";
                        echo "Funci&oacute;n:" . $arr_tree[$i]['function'];
                    }
                    for ($i = 0, $max = count($arr_tree); $i < $max; $i++) {
                        ?>
                    </div>	
                    <?
                }
                echo "<br/><strong>Query:</strong><br>" . $arr_tree[0]['query'] . "<br />";
                //echo "<strong>Error #: </strong>" . $arr_tree[0]['mysql_errno'] . "<br />";
                echo "<strong>Descripci&oacute;n del Error: </strong>" . $arr_tree[0]['mysql_error'] . "<br />";
            }
            ?>
        </div>
    </div>
</div>

<?
    }
require('../lib/common/footer.php');
?>
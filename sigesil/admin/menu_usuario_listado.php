<?
    require_once('../lib/core.lib.php');
    
    $usuario = new Usuario();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    $listadoUsuarios = $usuario->obtenerTodosUsuarios('', $idCA, '', '', '', 'ca.codigo, u.nombre');

    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        MENU USUARIOS<br/><hr/>
    </div>
    <div id="mensajes">
        <?
            switch($GPC['msg']){
                case 'exitoso':
                    echo "<span class='msj_verde'>Registro Guardado !</span>";
                break;
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <? if($_SESSION['s_perfil_id'] == GERENTEG || $_SESSION['s_perfil_id'] == GERENTES){ ?>
    <div id="botones">
        <?
            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
        ?>
    </div>
    <? } ?><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoUsuarios as $dataUsuario){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?="(".$dataUsuario['codigo_ca'].") ".$dataUsuario['nombre_ca']?></td>
            <? } ?>
            <td><?=$dataUsuario['nombre']?></td>
            <td><?=$dataUsuario['apellido']?></td>
            <td><?=$dataUsuario['usuario']?></td>
            <td><?=$dataUsuario['perfil']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'menu_usuario.php?ac=editar&id='.$dataUsuario['id'].'&perfil='.$dataUsuario['id_perfil']);
                    //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'usuarios_listado.php?ac=eliminar&id='.$dataUsuario['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
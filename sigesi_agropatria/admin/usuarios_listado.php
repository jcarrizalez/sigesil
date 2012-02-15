<?
    require_once('../lib/core.lib.php');
    
    $usuario = new Usuario();
    $listadoUsuarios = $usuario->obtenerTodosUsuarios('', '', '', '', '', 'u.nombre');
    
    if($GPC['ac'] == 'estatus'){
        $id = $GPC['id'];
        $status = $GPC['cambiar'];
        $usuario->desactivarUsuario($id, $status);
        header('location: usuarios_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function cambiarStatus(){
        if(confirm('¿Desea cambiar de estatus a este Usuario?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'usuario.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE USUARIOS<br/><hr/>
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
            echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
        ?>
    </div>
    <? } ?>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Usuario</th>
            <th>Email</th>
            <th>Estatus</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoUsuarios as $dataUsuario){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataUsuario['nombre']?></td>
            <td align="center"><?=$dataUsuario['apellido']?></td>
            <td align="center"><?=$dataUsuario['usuario']?></td>
            <td align="center"><?=$dataUsuario['email']?></td>
            <td align="center">
                <?
                    if($dataUsuario['estatus'] == 't'){
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>', 'usuarios_listado.php?ac=estatus&id='.$dataUsuario['id'].'&cambiar=f', array('onclick' => 'return cambiarStatus();'));
                    }else{
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>', 'usuarios_listado.php?ac=estatus&id='.$dataUsuario['id'].'&cambiar=t', array('onclick' => 'return cambiarStatus();'));
                    }
                ?>
            </td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'usuario.php?ac=editar&id='.$dataUsuario['id']);
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
<?php
    require_once('../lib/core.lib.php');
    
    $usuario = new Usuario();
    $centro_acopio = new CentroAcopio();
    $perfil = new Perfil();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    $listaPerfiles = $perfil->find('', '', array('id', 'nombre_perfil'), 'list', 'id');
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $perfil = (!empty($GPC['id_perfil'])) ? $GPC['id_perfil'] : '';
    $listadoUsuarios = $usuario->obtenerTodosUsuarios('', $idCA, '', $perfil, '', 'ca.codigo, u.nombre');

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
        <?php
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
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%" border="0">
                <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?php echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos')); ?>
                    </td>
                </tr>
                <?php } ?>
                <tr>
                    <td>Perfil:</td>
                    <td colspan="2">
                        <?php echo $html->select('id_perfil',array('options'=>$listaPerfiles, 'selected' => $GPC['id_perfil'], 'default' => 'Todos')); ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="3">
                        <?php
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <?php } ?>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoUsuarios as $dataUsuario){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?php echo "(".$dataUsuario['codigo_ca'].") ".$dataUsuario['nombre_ca']?></td>
            <?php } ?>
            <td><?php echo $dataUsuario['nombre']?></td>
            <td><?php echo $dataUsuario['apellido']?></td>
            <td><?php echo $dataUsuario['usuario']?></td>
            <td><?php echo $dataUsuario['perfil']?></td>
            <td align="center">
                <?php
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'menu_usuario.php?ac=editar&id='.$dataUsuario['id'].'&perfil='.$dataUsuario['id_perfil']);
                    //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'usuarios_listado.php?ac=eliminar&id='.$dataUsuario['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
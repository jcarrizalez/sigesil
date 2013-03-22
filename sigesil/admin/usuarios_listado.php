<?php
    require_once('../lib/core.lib.php');
    
    $usuario = new Usuario();
    $centro_acopio = new CentroAcopio();
    $perfil = new Perfil();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    $listaPerfiles = $perfil->find('', '', array('id', 'nombre_perfil'), 'list', 'id');
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $perfil = (!empty($GPC['id_perfil'])) ? $GPC['id_perfil'] : '';
    
    $listadoUsuarios = $usuario->obtenerTodosUsuarios('', $idCA, '', $perfil, '', 'ca.codigo, u.nombre', '', $porPagina, $inicio);
    $total_registros = $usuario->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
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
        USUARIOS<br/><hr/>
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
                            $general->crearAcciones($acciones, '', 1);
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <?php } ?>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>Usuario</th>
            <th>Perfil</th>
            <th>Estatus</th>
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
                    if($dataUsuario['estatus'] == 't'){
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>');
                    }else{
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>');
                    }
                ?>
            </td>
            <td align="center">
                <?php
                    $urls = array(1 => 'usuario.php?ac=editar&id='.$dataUsuario['id'], 'usuarios_listado.php?ac=eliminar&id='.$dataUsuario['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?php
    require('../lib/common/footer.php');
?>
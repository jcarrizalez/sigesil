<?php
    require_once('../lib/core.lib.php');
    
    $usuario = new Usuario();
    $menu = new Menu();
    
    switch($GPC['ac']){
        case 'guardar':
            $total = 0;
            $menu->eliminarMenuUsuario($GPC['usuario_id'], $GPC['perfil_id']);
            for($i=0;$i<count($GPC['padre']);$i++){
                $idMenu = $menu->asignarMenuUsuario($GPC['padre'][$i], $GPC['usuario_id'], $GPC['perfil_id']);
                foreach($GPC['hijo_'.$GPC['padre'][$i]] as $valor){
                    
                    $nuevo = (isset($GPC['accion_'.$valor]['nuevo'])) ? $GPC['accion_'.$valor]['nuevo'] : 0 ;
                    $modificar = (isset($GPC['accion_'.$valor]['modificar'])) ? $GPC['accion_'.$valor]['modificar'] : 0 ;
                    $eliminar = (isset($GPC['accion_'.$valor]['eliminar'])) ? $GPC['accion_'.$valor]['eliminar'] : 0 ;
                    $imprimir = (isset($GPC['accion_'.$valor]['imprimir'])) ? $GPC['accion_'.$valor]['imprimir'] : 0 ;
                    
                    $idMenu = $menu->asignarMenuUsuario($valor, $GPC['usuario_id'], $nuevo, $modificar, $eliminar, $imprimir);
                    if(empty($idMenu))
                        $total++;
                }
            }
            
            header('Location: menu_usuario_listado.php?msg=exitoso');
            die();
        break;
        case 'editar':
            $infoUsuario = $usuario->obtenerDetalleUsuarios($GPC['id']);
            $opcionesMenu = $menu->find(array('estatus' => 't'), '', array('id', 'nombre', 'id_padre'), '', 'id_padre, orden');
            $menuUsuarioOpc = $menu->menuPorUsuario($GPC['id']);
            foreach($menuUsuarioOpc as $valor){
                $menuUsuario[] = $valor['id'];
                $acciones[$valor['id']]['nuevo'] = $valor['nuevo'];
                $acciones[$valor['id']]['modificar'] = $valor['modificar'];
                $acciones[$valor['id']]['eliminar'] = $valor['eliminar'];
                $acciones[$valor['id']]['imprimir'] = $valor['imprimir'];
            }
        break;
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Cancelar').click(function(){
           window.location = 'menu_usuario_listado.php';
        });
        
        $('.marcarHijos').click(function(){
            var id = $(this).attr('id').split('_');
            if($(this).is(':checked'))
                $('.marcar_'+id[1]+':checkbox:not(:checked)').attr('checked', 'checked');
            else
                $('.marcar_'+id[1]+':checkbox:checked').removeAttr('checked');
        });
        
        $('.desmarPadre').click(function(){
           var idp = $(this).attr('id').split('_');
           var cont = 0;
           $('.marcar_'+idp[1]).each(function(){
               if($(this).is(':checked'))
                   cont++;
           });
           
           if(cont != 0)
               $('#padre_'+idp[1]+':checkbox:not(:checked)').attr('checked', 'checked');
           else
               $('#padre_'+idp[1]+':checkbox:checked').removeAttr('checked');
        });
    });
</script>
    <div id="titulo_modulo">
        ASIGNAR MENU<br/><hr/>
    </div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php
        echo $html->input('usuario_id', $infoUsuario[0]['id'], array('type' => 'hidden'));
        echo $html->input('perfil_id', $GPC['perfil'], array('type' => 'hidden'));
    ?>
    <fieldset>
        <legend>Datos del Usuario</legend>
        <table align="center" border="0">
            <tr>
                <td>Cedula</td>
                <td><?php echo $html->input('ced_rif', $infoUsuario[0]['cedula'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Nombre</td>
                <td><?php echo $html->input('nombre', $infoUsuario[0]['nombre']." ".$infoUsuario[0]['apellido'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Centro de Acopio</td>
                <td><?php echo $html->input('ced_rif', $infoUsuario[0]['codigo_ca']." ".$infoUsuario[0]['nombre_ca'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Perfil</td>
                <td><?php echo $html->input('ced_rif', $infoUsuario[0]['nombre_perfil'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Menu</legend>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <?php
                foreach($opcionesMenu as $padre){
                    if($padre['id_padre'] == 0){
                        $asignarP = (in_array($padre['id'], $menuUsuario)) ? 'checked = "check"' : '';
            ?>
            <tr>
                <td><input name="padre[]" id="padre_<?php echo $padre['id']?>" type="checkbox" <?php echo $asignarP?> class="marcarHijos" value="<?php echo $padre['id']?>"></td>
                <td style="font-weight: bold;"><?php echo $etiqueta[$padre['nombre']]?></td>
                <td align="center"><img src="../images/agregar.png" alt="Agregar" title="Agregar" width="16" height="16" /></td>
                <td align="center"><img src="../images/editar.png" alt="Editar" title="Editar" width="16" height="16" /></td>
                <td align="center"><img src="../images/eliminar2.png" alt="Eliminar" title="Eliminar" width="16" height="16" /></td>
                <td align="center"><img src="../images/imprimir.png" alt="Imprimir" title="Imprimir" width="16" height="16" /></td>
            </tr>
            <?php
                        foreach($opcionesMenu as $hijo){
                            if($hijo['id_padre'] == $padre['id']){
                                $asignarH = (in_array($hijo['id'], $menuUsuario)) ? 'checked = "check"' : '';
                                $verifn = ($acciones[$hijo['id']]['nuevo'] == 1) ? 'checked = "check"' : '';
                                $verifm = ($acciones[$hijo['id']]['modificar'] == 1) ? 'checked = "check"' : '';
                                $verife = ($acciones[$hijo['id']]['eliminar'] == 1) ? 'checked = "check"' : '';
                                $verifi = ($acciones[$hijo['id']]['imprimir'] == 1) ? 'checked = "check"' : '';
            ?>
            <tr>
                <td align="right" width="40"><input name="hijo_<?php echo $padre['id']?>[]" id="hijo_<?php echo $padre['id']?>" type="checkbox" <?php echo $asignarH?> class="marcar_<?php echo $padre['id']?> desmarPadre" value="<?php echo $hijo['id']?>"></td>
                <td><?php echo $etiqueta[$hijo['nombre']]?></td>
                <td align="center">
                <?php if(in_array($padre['id'], array(1,4))){ ?>
                <input name="accion_<?php echo $hijo['id']?>[nuevo]" id ="accion_<?php echo $hijo['id']?>" type="checkbox" <?php echo $verifn?> class="" value="1" />
                <?php } ?>
                </td>
                <td align="center">
                <?php if(in_array($padre['id'], array(1,2,4))){ ?>
                <input name="accion_<?php echo $hijo['id']?>[modificar]" id ="accion_<?php echo $hijo['id']?>" type="checkbox" <?php echo $verifm?> class="" value="1" />
                <?php } ?>
                </td>
                <td align="center">
                <?php if(in_array($padre['id'], array(1,4))){ ?>
                <input name="accion_<?php echo $hijo['id']?>[eliminar]" id ="accion_<?php echo $hijo['id']?>" type="checkbox" <?php echo $verife?> class="" value="1" />
                <?php } ?>
                </td>
                <td align="center">
                <?php if(in_array($padre['id'], array(3))){ ?>
                <input name="accion_<?php echo $hijo['id']?>[imprimir]" id ="accion_<?php echo $hijo['id']?>" type="checkbox" <?php echo $verifi?> class="" value="1" />
                <?php } ?>
                </td>
            </tr>
            <?php
                            }
                        }
                        ?><tr><td>&nbsp;</td></tr><?php
                    }
                }
            ?>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <?php echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <?php echo $html->input('Cancelar', 'Cancelar', array('type' => 'button')); ?>
            </td>
        </tr>
    </table>
</form>
<?php
    require('../lib/common/footer.php');
?>
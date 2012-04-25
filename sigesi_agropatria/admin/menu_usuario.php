<?
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
                    $idMenu = $menu->asignarMenuUsuario($valor, $GPC['usuario_id'], $GPC['perfil_id']);
                    if(empty($idMenu))
                        $total++;
                }
            }
            
            header('Location: menu_usuario_listado.php?msg=exitoso');
            die();
        break;
        case 'editar':
            $infoUsuario = $usuario->obtenerDetalleUsuarios($GPC['id']);
            $menuPadre = $menu->find(array('id_padre' => 0), '', array('id', 'nombre', 'id_padre'), '', 'orden');
            $menuHijo = $menu->find('', '', array('id', 'nombre', 'id_padre'), '', 'id_padre, orden');
            $menuUsuarioOpc = $menu->menuPorUsuario($GPC['perfil'], $GPC['id']);
            foreach($menuUsuarioOpc as $valor){
                $menuUsuario[] = $valor['id'];
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
    <?
        echo $html->input('usuario_id', $infoUsuario[0]['id'], array('type' => 'hidden'));
        echo $html->input('perfil_id', $GPC['perfil'], array('type' => 'hidden'));
    ?>
    <fieldset>
        <legend>Datos del Usuario</legend>
        <table align="center" border="0">
            <tr>
                <td>Cedula</td>
                <td><? echo $html->input('ced_rif', $infoUsuario[0]['cedula'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Nombre</td>
                <td><? echo $html->input('nombre', $infoUsuario[0]['nombre']." ".$infoUsuario[0]['apellido'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Centro de Acopio</td>
                <td><? echo $html->input('ced_rif', $infoUsuario[0]['codigo_ca']." ".$infoUsuario[0]['nombre_ca'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Perfil</td>
                <td><? echo $html->input('ced_rif', $infoUsuario[0]['nombre_perfil'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Menu</legend>
        <table align="center" border="0">
            <?
                foreach($menuPadre as $padre){
                    $asignarP = (in_array($padre['id'], $menuUsuario)) ? 'checked = "check"' : '';
            ?>
            <tr>
                <td><input name="padre[]" id="padre_<?=$padre['id']?>" type="checkbox" <?=$asignarP?> class="marcarHijos" value="<?=$padre['id']?>"></td>
                <td style="font-weight: bold;"><?=$etiqueta[$padre['nombre']]?></td>
            </tr>
            <?
                    foreach($menuHijo as $hijo){
                        if($hijo['id_padre'] != 0 && $hijo['id_padre'] == $padre['id']){
                            $asignarH = (in_array($hijo['id'], $menuUsuario)) ? 'checked = "check"' : '';
                            $idPadre = $padre['id'];
            ?>
            <tr>
                <td align="right" width="50"><input name="hijo_<?=$padre['id']?>[]" id="hijo_<?=$padre['id']?>" type="checkbox" <?=$asignarH?> class="marcar_<?=$padre['id']?> desmarPadre" value="<?=$hijo['id']?>"></td>
                <td><?=$etiqueta[$hijo['nombre']]?></td>
            </tr>
            <?
                        }
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
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'button')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
    
    $usuario = new Usuario();
    $menu = new Menu();
    
    switch($GPC['ac']){
        case 'guardar':
            
        break;
        case 'editar':
            $infoUsuario = $usuario->obtenerDetalleUsuarios($GPC['id']);
            $menuPadre = $menu->find(array('id_padre' => 0), '', array('id', 'nombre', 'id_padre'), '', 'orden');
            $menuHijo = $menu->find('', '', array('id', 'nombre', 'id_padre'), '', 'id_padre, orden');
            $menuUsuarioOpc = $menu->menuPorUsuario($GPC['id']);
            //Debug::pr($menuUsuarioOpc);
            foreach($menuUsuarioOpc as $valor){
                $menuUsuario[] = $valor['id'];
            }
        break;
    }

?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Cancelar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ASIGNAR MENU<br/><hr/>
    </div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('usuario_id', $infoUsuario[0]['id'], array('type' => 'hidden')); ?>
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
                    $asignar = (in_array($padre['id'], $menuUsuario)) ? 'check' : '';
            ?>
            <tr>
                <td><? echo $html->input('padre', $padre['id'], array('type' => 'checkbox', 'checked' => $asignar)); ?></td>
                <td style="font-weight: bold;"><?=$etiqueta[$padre['nombre']]?></td>
            </tr>
            <?
                    foreach($menuHijo as $hijo){
                        if($hijo['id_padre'] != 0 && $hijo['id_padre'] == $padre['id']){
                            $asignar = (in_array($hijo['id'], $menuUsuario)) ? 'check' : '';
            ?>
            <tr>
                <td align="right" width="50"><? echo $html->input('hijo', $hijo['id'], array('type' => 'checkbox', 'checked' => $asignar)); ?></td>
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
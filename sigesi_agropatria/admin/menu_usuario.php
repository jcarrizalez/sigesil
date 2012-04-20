<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
    
    $usuario = new Usuario();
    $menu = new Menu();
    
    switch($GPC['ac']){
        case 'editar':
            $infoUsuario = $usuario->obtenerDetalleUsuarios($GPC['id']);
            debug::pr($infoUsuario);
        break;
        case 'guardar':
            
        break;
    }

?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ASIGNAR MENU<br/><hr/>
    </div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <fieldset>
        <legend>Datos del Usuario</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>Nombre</td>
                <td><? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos integer')); ?></td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
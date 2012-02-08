<?
    require_once('../lib/core.lib.php');
    
    $centro_acopio = new CentroAcopio();
    $obj_general = new General();
    $listadoCA = $centro_acopio->find('', null, array('id','nombre','rif','telefono','email','ubicacion'), null, 'id ASC');
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $centro_acopio->eliminarCA($id);
        header('location: centros_acopio_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Centro de Acopio?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'centros_acopio.php';
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE CENTROS DE ACOPIO<br/><hr/>
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
    <? if($_SESSION['s_perfil_id'] == ADMINISTRADOR){ ?>
    <div id="botones">
        <? echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    </div>
    <? } ?>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Nombre</th>
            <th>RIF</th>
            <th>Tel&eacute;fono</th>
            <th>Email</th>
            <th>Ubicaci&oacute;n</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoCA as $dataCA){
            $clase = $obj_general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td><?=$dataCA['nombre']?></td>
            <td align="center"><?=$dataCA['rif']?></td>
            <td align="center"><?=$dataCA['telefono']?></td>
            <td align="center"><?=$dataCA['email']?></td>
            <td><?=$dataCA['ubicacion']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'centros_acopio.php?ac=editar&id='.$dataCA['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'centros_acopio_listado.php?ac=eliminar&id='.$dataCA['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
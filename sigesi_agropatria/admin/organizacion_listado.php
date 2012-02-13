<?
    require_once('../lib/core.lib.php');
    
    $org = new Organizacion();
    
    $listadoOrg = $org->find('', null, '*', '', 'id');
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $org->eliminarOrg($id);
        header('location: organizacion_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar esta Organizacion?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'organizacion.php';
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE ORGANIZACIONES<br/><hr/>
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
    <div id="botones">
        <? echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Nombre</th>
            <th>RIF</th>
            <th>Tel&eacute;fono</th>
            <th>Email</th>
            <th>Pais</th>
            <th>Estado</th>
            <th>Municipio</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoOrg as $dataOrg){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataOrg['nombre']?></td>
            <td><?=$dataOrg['rif']?></td>
            <td><?=$dataOrg['telefono']?></td>
            <td align="center"><?=$dataOrg['email']?></td>
            <td align="center"><?=$dataOrg['pais']?></td>
            <td align="center"><?=$dataOrg['estado']?></td>
            <td align="center"><?=$dataOrg['municipio']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'organizacion.php?ac=editar&id='.$dataOrg['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'organizacion_listado.php?ac=eliminar&id='.$dataOrg['id'], array('onclick' => 'return eliminar();'));
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
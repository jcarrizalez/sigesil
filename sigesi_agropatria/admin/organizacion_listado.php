<?
    require_once('../lib/core.lib.php');
    
    $org = new Organizacion();
    
    $listadoOrg = $org->detalleOrganizacion();
    
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
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ORGANIZACIONES<br/><hr/>
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
    <div id="filtro">
        <table width="100%">
            <tr id="botones">
                <td colspan="3">
                    <?
                        $general->crearAcciones($acciones, '', 1);
                        echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                    ?>
                </td>
            </tr>
        </table>
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>C&oacute;digo</th>
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
            <td align="center"><?=$dataOrg['codigo']?></td>
            <td align="center"><?=$dataOrg['nombre']?></td>
            <td><?=$dataOrg['rif']?></td>
            <td><?=$dataOrg['telefono']?></td>
            <td align="center"><?=$dataOrg['email']?></td>
            <td align="center"><?=$dataOrg['pais']?></td>
            <td align="center"><?=$dataOrg['estado']?></td>
            <td align="center"><?=$dataOrg['municipio']?></td>
            <td align="center">
                <?
                    $urls = array(1 => "organizacion.php?ac=editar&id=".$dataOrg['id'], "organizacion_listado.php?ac=eliminar&id=".$dataOrg['id']);
                    $general->crearAcciones($acciones, $urls);
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
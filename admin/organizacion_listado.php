<?php
    require_once('../lib/core.lib.php');
    
    $org = new Organizacion();
    
    $listadoOrg = $org->detalleOrganizacion();
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $org->eliminarOrg($id, $GPC['estatus']);
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
        <table width="100%">
            <tr id="botones">
                <td colspan="3">
                    <?php
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
        <?php
            $i=0;
            foreach($listadoOrg as $dataOrg){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <td align="center"><?php echo $dataOrg['codigo']?></td>
            <td align="center"><?php echo $dataOrg['nombre']?></td>
            <td><?php echo $dataOrg['rif']?></td>
            <td><?php echo $dataOrg['telefono']?></td>
            <td align="center"><?php echo $dataOrg['email']?></td>
            <td align="center"><?php echo $dataOrg['pais']?></td>
            <td align="center"><?php echo $dataOrg['estado']?></td>
            <td align="center"><?php echo $dataOrg['municipio']?></td>
            <td align="center">
                <?php
                    $urls = array(1 => "organizacion.php?ac=editar&id=".$dataOrg['id'], "organizacion_listado.php?ac=eliminar&id=".$dataOrg['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
<?php
    require_once('../lib/core.lib.php');
    
    $tipocultivo = new TipoCultivo();
    
    /*$id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : null;*/
    
    $listadoTipoCultivo = $tipocultivo->find('', null, '*', null, 'id ASC');
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $tipocultivo->eliminarTipoCultivo($id);
        header('location: tipo_cultivo_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Tipo de Cultivo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'tipo_cultivo.php';
        });
    });
</script>
    <div id="titulo_modulo">
        TIPOS DE CULTIVOS<br/><hr/>
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
    <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
    <div id="botones">
        <?php echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    </div>
    <?php } ?>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th width="40%">Nombre</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoTipoCultivo as $dataTipoCultivo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <td><?php echo $dataTipoCultivo['nombre']?></td>
            <td align="center">
                <?php
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'tipo_cultivo.php?ac=editar&id='.$dataTipoCultivo['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'tipo_cultivo_listado.php?ac=eliminar&id='.$dataTipoCultivo['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
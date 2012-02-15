<?
    require_once('../lib/core.lib.php');
    
    $cultivo = new Cultivo();
    
    $id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : null;
    $tipo = (!empty($GPC['tipo'])) ? $GPC['tipo'] : null;
    
    $listadoCultivos = $cultivo->find('', null, '*', '', 'id');
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $cultivo->eliminarCultivo($id);
        header('location: cultivo_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Cultivo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'cultivo.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE CULTIVOS<br/><hr/>
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
    <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
        <? echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    <? } ?>
        <? echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();')); ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>C&oacute;digo</th>
            <th>Nombre</th>
            <th>Ciclo</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoCultivos as $dataCultivo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataCultivo['codigo']?></td>
            <td><?=$dataCultivo['nombre']?></td>
            <td><?=$dataCultivo['ciclo']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'cultivo.php?ac=editar&id='.$dataCultivo['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'cultivo_listado.php?ac=eliminar&id='.$dataCultivo['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
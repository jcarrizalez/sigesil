<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    
    $id = (!empty($GPC['id_programa'])) ? $GPC['id_programa'] : null;
    
    if($_SESSION['s_perfil_id'] == GERENTE)
        $id_CA = $_SESSION['s_ca_id'];
    else
        $id_CA = (!empty($GPC['id_centro_acopio'])) ? $GPC['id_centro_acopio'] : null;
    
    $listadoProgramas = $programa->buscarProgramaCA($id, $id_CA);
    
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
        if(confirm('¿Desea Eliminar este Programa?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'programa.php';
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE PROGRAMAS<br/><hr/>
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
    <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
    <div id="botones">
        <? echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    </div>
    <? } ?>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Centro de Acopio</th>
            <th>Programa Nro</th>
            <th>Programa</th>
            <th>Creado</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoProgramas as $dataPrograma){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td><?=$dataPrograma['ca_nombre']?></td>
            <td align="center"><?=$dataPrograma['numero']?></td>
            <td align="center"><?=$dataPrograma['nombre']?></td>
            <td align="center"><?=$dataPrograma['creado']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'programa.php?ac=editar&id='.$dataPrograma['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'programa_listado.php?ac=eliminar&id='.$dataPrograma['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
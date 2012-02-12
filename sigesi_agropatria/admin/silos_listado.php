<?
    require_once('../lib/core.lib.php');
    
    $silos = new Silos();
    
    $id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : $_SESSION['s_ca_id'];
    
    $listadoSilos = $silos->listadoSilos($id, $idCA);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $silos->eliminarSilo($id);
        header('location: silos_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Silo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'silos.php';
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE SILOS<br/><hr/>
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
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Nombre</th>
            <th>Coordenadas</th>
            <th>N&uacute;mero</th>
            <th>Capacidad (Kg)</th>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <th>Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($listadoSilos as $dataSilo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$dataSilo['nombre_ca']?></td>
            <? } ?>
            <td><?=$dataSilo['nombre']?></td>
            <td><?=$dataSilo['coordenada']?></td>
            <td align="center"><?=$dataSilo['numero']?></td>
            <td align="center"><?=$dataSilo['capacidad']?></td>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'silos.php?ac=editar&id='.$dataSilo['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'silos_listado.php?ac=eliminar&id='.$dataSilo['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
            <? } ?>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
<?
    require_once('../lib/core.lib.php');
    
    $productor = new Productor();
    
    $id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : $_SESSION['s_ca_id'];
    
    $listadoProductores=$productor->listadoProductores();    
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $silos->eliminarProductor($id);
        header('location: productor_listado.php');
        die();
    }


    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Productor?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'productor.php';
        });
    });
</script>
    <div id="titulo_modulo">
        PRODUCTORES<br/><hr/>
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
    <? //if($_SESSION['s_perfil_id'] == GERENTEG){ ?>    
    <div id="botones">
        <? echo $html->input('Nuevo', 'Nuevo', array('type' => 'button')); ?>
    </div>
    <? //} ?><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">            
            <th>Centro Acopio</th>
            <th>Codigo</th>
            <th>Nombre</th>
            <th>RIF</th>
            <th>Telefono</th>           
            <? //if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <th>Acci&oacute;n</th>
            <? //} ?>
        </tr>
        <?
            $i=0;
            foreach($listadoProductores as $dataProductor){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">            
            <td><?=$dataProductor['nombre_ca']?></td>
            <td><?=$dataProductor['codigo']?></td>
            <td><?=$dataProductor['nombre']?></td>
            <td><?=$dataProductor['RIF']?></td>
            <td><?=$dataProductor['Telefono']?></td>            
            <? //if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'productor.php?ac=editar&id='.$dataProductor['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'productor_listado.php?ac=eliminar&id='.$dataProductor['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
        </tr>
        <? $i++; } 
         //} ?>
        <tr>            
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
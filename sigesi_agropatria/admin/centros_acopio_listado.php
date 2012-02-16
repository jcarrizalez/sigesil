<?
    require_once('../lib/core.lib.php');
    
    $centro_acopio = new CentroAcopio();
    $silos = new Silos();
    
    $listadoCA = $centro_acopio->buscarCA();
    
    if($GPC['ac'] == 'estatus'){
        $almacen = new Almacen();
        $usuarios = new Usuario();
        $idCA = $GPC['id'];
        $status = $GPC['cambiar'];
        $centro_acopio->desactivarCA($idCA, $status);
        $almacen->desactivarAL('',$idCA, $status);
        $silos->desactivarSI('',$idCA, $status);
        $usuarios->desactivarUsuariosCA($idCA, $status);
        header('location: centros_acopio_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function cambiarStatus(){
        if(confirm('¿Desea cambiar de estatus a este Centro de Acopio?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'centros_acopio.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
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
    <div id="filtro">
        <!--form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data"-->
            <table width="100%">
                <tr id="botones">
                    <td colspan="3">
                        <?
                            if($_SESSION['s_perfil_id'] == GERENTEG){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        <!--/form-->
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Codigo</th>
            <th>Orgnanizaci&oacute;n</th>
            <th>Nombre</th>
            <th>Tel&eacute;fono</th>
            <th>Email</th>
            <th>Silos</th>
            <th>Estatus</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoCA as $dataCA){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataCA['codigo']?></td>
            <td><?=$dataCA['nombre_org']?></td>
            <td><?=$dataCA['nombre']?></td>
            <td align="center"><?=$dataCA['telefono']?></td>
            <td align="center"><?=$dataCA['email']?></td>
            <?
                $cant = $silos->cantidadSilosCA($dataCA['id']);
                if($cant[0]['totalsilos'] == 0){
            ?>
            <td align="center">0</td>
            <? }else{ ?>
            <td align="center">
                <? echo $html->link($cant[0]['totalsilos'], 'silos_listado.php?id_ca='.$dataCA['id']); ?>
            </td>
            <? } ?>
            <td align="center">
                <?
                    if($dataCA['estatus'] == 't'){
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>', 'centros_acopio_listado.php?ac=estatus&id='.$dataCA['id'].'&cambiar=f', array('onclick' => 'return cambiarStatus();'));
                    }else{
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>', 'centros_acopio_listado.php?ac=estatus&id='.$dataCA['id'].'&cambiar=t', array('onclick' => 'return cambiarStatus();'));
                    }
                ?>
            </td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'centros_acopio.php?ac=editar&id_ca='.$dataCA['id']);
                    //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'centros_acopio_listado.php?ac=eliminar&id='.$dataCA['id'], array('onclick' => 'return eliminar();'));
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
<?
    require_once('../lib/core.lib.php');
    
    $centro_acopio = new CentroAcopio();
    $silos = new Silos();
    
    $listadoCA = $centro_acopio->buscarCA();
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
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
        CENTROS DE ACOPIO<br/><hr/>
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
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>');
                    }else{
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>');
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
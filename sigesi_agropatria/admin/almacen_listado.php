<?
    require_once('../lib/core.lib.php');
    
    $centro_acopio = new CentroAcopio();
    $almacen = new Almacen();
    $silos = new Silos();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $centrosA = $centro_acopio->buscarCA($idCA);
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'nombre');
    unset($listaCA[1]);
    
    /*if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $almacen->eliminarSilo(1,$id);
        header('location: almacen_listado.php');
        die();
    }*/
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function muestraAL(id){
        var idmes='tbodyPN_'+id;
        var imgmes='imgmes_'+id;
        var stylevalues = document.getElementById(idmes).style;

        if(stylevalues.display == 'none'){
            stylevalues.display = '';
            document.getElementById(imgmes).src="../images/menos.png";
        } else {
            stylevalues.display = 'none';
            document.getElementById(imgmes).src="../images/mas.png";
        }
    }
    
    function eliminar(){
        if(confirm('¿Desea Eliminar este Almacen?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'almacen.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ALMACENES<br/><hr/>
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
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%">
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Seleccione'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr id="botones">
                    <td colspan="3">
                        <?
                            if($_SESSION['s_perfil_id'] == GERENTES){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>&nbsp;</th>
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Nombre</th>
            <th>Pa&iacute;s</th>
            <th>Estado</th>
            <th>Municipio</th>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <th>Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($centrosA as $ca){
                $clase = $general->obtenerClaseFila($i);
                $listadoAlmacenes = $almacen->buscarAL('', '', $ca['id']);
        ?>
        <tr class="<?=$clase?>">
            <td align="right" width="1">
                <a href="javascript:muestraAL('<?php echo $i?>')"><img src="../images/mas.png" width="16" height="16" id="imgmes_<?php echo $i?>" /></a>
            </td>
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$ca['nombre']?></td>
            <? } ?>
            <td align="center">-</td>
            <td align="center">-</td>
            <td align="center">-</td>
            <td align="center">-</td>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <td align="center">-</td>
            <? } ?>
        </tr>
        <tbody id="tbodyPN_<?php echo $i?>" style="display:none">
            <? foreach($listadoAlmacenes as $dataAlmacen) { ?>
            <tr>
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <td colspan="2">&nbsp;</td>
                <? }else{ ?>
                <td>&nbsp;</td>
                <? } ?>
                <td><?=$dataAlmacen['nombre']?></td>
                <td align="center"><?=$dataAlmacen['pais']?></td>
                <td align="center"><?=$dataAlmacen['estado']?></td>
                <td align="center"><?=$dataAlmacen['municipio']?></td>
                <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
                <td align="center">
                    <?
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'almacen.php?ac=editar&id='.$dataAlmacen['id']);
                        //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'almacen_listado.php?ac=eliminar&id='.$dataAlmacen['id'], array('onclick' => 'return eliminar();'));
                    ?>
                </td>
                <? } ?>
            </tr>
            <? } ?>
        </tbody>
        <?
            $i++;
            }
        ?>
        <tr>
            
            <td colspan="5">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
<script type="text/javascript">
    
</script>
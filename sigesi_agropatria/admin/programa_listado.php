<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    
    $id = (!empty($GPC['id_programa'])) ? $GPC['id_programa'] : null;
    
    if($_SESSION['s_perfil_id'] == GERENTES)
        $id_CA = $_SESSION['s_ca_id'];
    else
        $id_CA = (!empty($GPC['id_centro_acopio'])) ? $GPC['id_centro_acopio'] : null;
    
    $listadoProgramas = $programa->buscarProgramaCA($id, $id_CA);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $programa->eliminarPR($id);
        header('location: programa_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function muestraPR(id){
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
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'programa.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        PROGRAMAS<br/><hr/>
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
                            if($_SESSION['s_perfil_id'] == GERENTES){
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
            <th>&nbsp;</th>
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <th>Centro de Acopio</th>
            <? } ?>
            <th>Nro</th>
            <th>Nombre</th>
            <th>Proyectado</th>
            <th>Area Siembra</th>
            <th>Fecha Inicio</th>
            <th>Fecha Fin</th>
            <!--th>Acci&oacute;n</th-->
        </tr>
        <?
            $i=0;
            foreach($listadoProgramas as $dataPrograma){
                $clase = $general->obtenerClaseFila($i);
                $listadoCosechas = $cosecha->buscarCosechaP('', $dataPrograma['id']);
        ?>
        <tr class="<?=$clase?>">
            <td align="right" width="1">
                <a href="javascript:muestraPR('<?php echo $i?>')"><img src="../images/mas.png" width="16" height="16" id="imgmes_<?php echo $i?>" /></a>
            </td>
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <td><?=$dataPrograma['ca_nombre']?></td>
            <? } ?>
            <td align="center"><?=$dataPrograma['numero']?></td>
            <td><?=$dataPrograma['nombre']?></td>
            <td align="center">-</td>
            <td align="center">-</td>
            <td align="center">-</td>
            <td align="center">-</td>
            <!--td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'programa.php?ac=editar&id='.$dataPrograma['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'programa_listado.php?ac=eliminar&id='.$dataPrograma['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td-->
        </tr>
        <tbody id="tbodyPN_<?php echo $i?>" style="display:none">
            <?
                $j=0;
                foreach($listadoCosechas as $dataCosecha){
                    $clase = $general->obtenerSubClaseFila($j);
            ?>
            <tr class="terceraclase">
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <td colspan="3">&nbsp;</td>
                <? }else{ ?>
                <td colspan="2">&nbsp;</td>
                <? } ?>
                <td><?=$dataCosecha['nombre_cosecha']?></td>
                <td><?=$dataCosecha['proyectado']?></td>
                <td><?=$dataCosecha['area_siembra']?></td>
                <td align="center"><?=$dataCosecha['fecha_inicio']?></td>
                <td align="center"><?=$dataCosecha['fecha_fin']?></td>
                <?/* if($_SESSION['s_perfil_id'] == GERENTES){ ?>
                <td align="center">
                    <?
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'almacen.php?ac=editar&id='.$dataCosecha['id']);
                        //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'almacen_listado.php?ac=eliminar&id='.$dataCosecha['id'], array('onclick' => 'return eliminar();'));
                    ?>
                </td>
                <? } */?>
            </tr>
            <?
                $j++;
                }
            ?>
        </tbody>
        <?
            $i++;
            }
        ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
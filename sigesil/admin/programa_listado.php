<?php
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    
    $id = (!empty($GPC['id_programa'])) ? $GPC['id_programa'] : null;
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $id_CA = (!empty($GPC['id_centro_acopio'])) ? $GPC['id_centro_acopio'] : null;
    else
        $id_CA = $_SESSION['s_ca_id'];
    
    $listadoProgramas = $programa->buscarProgramaCA($id, $id_CA);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $programa->desactivarPr($id, $GPC['estatus']);
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
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        PROGRAMAS<br/><hr/>
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
            <th>&nbsp;</th>
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <th>Centro de Acopio</th>
            <?php } ?>
            <th>C&oacute;digo</th>
            <th>Nombre</th>
            <th>Proyectado</th>
            <th>Area Siembra</th>
            <th>Fecha Inicio</th>
            <th>Fecha Fin</th>
            <th>Estatus</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoProgramas as $dataPrograma){
                $clase = $general->obtenerClaseFila($i);
                $listadoCosechas = $cosecha->buscarCosechaP('', $dataPrograma['id']);
        ?>
        <tr class="<?php echo $clase?>">
            <td align="right" width="1">
                <a href="javascript:muestraPR('<?php echo $i?>')"><img src="../images/mas.png" width="16" height="16" id="imgmes_<?php echo $i?>" /></a>
            </td>
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <td><?php echo $dataPrograma['ca_nombre']?></td>
            <?php } ?>
            <td align="center"><?php echo $dataPrograma['codigo']?></td>
            <td><?php echo $dataPrograma['nombre']?></td>
            <td align="center">-</td>
            <td align="center">-</td>
            <td align="center"><?php echo $general->date_sql_screen($dataPrograma['fecha_inicio'], '', 'es', '-')?></td>
            <td align="center"><?php echo $general->date_sql_screen($dataPrograma['fecha_fin'], '', 'es', '-')?></td>
            <td align="center">
                <?php
                    if($dataPrograma['estatus'] == 't')
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>');
                    else
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>');
                ?>
            </td>
            <td align="center">
                <?php
                    $urls = array(1 => 'programa.php?ac=editar&id='.$dataPrograma['id'], 'programa_listado.php?ac=eliminar&id='.$dataPrograma['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <tbody id="tbodyPN_<?php echo $i?>" style="display:none">
            <?php
                $j=0;
                foreach($listadoCosechas as $dataCosecha){
            ?>
            <tr class="terceraclase">
                <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <td colspan="2">&nbsp;</td>
                <?php }else{ ?>
                <td>&nbsp;</td>
                <?php } ?>
                <td align="center"><?php echo $dataCosecha['codigo']?></td>
                <td><?php echo $dataCosecha['nombre_cosecha']?></td>
                <td align="center"><?php echo $dataCosecha['proyectado']?></td>
                <td align="center"><?php echo $dataCosecha['area_siembra']?></td>
                <td align="center"><?php echo $general->date_sql_screen($dataCosecha['fecha_inicio'], '', 'es', '-')?></td>
                <td align="center"><?php echo $general->date_sql_screen($dataCosecha['fecha_fin'], '', 'es', '-')?></td>
                <td align="center">
                    <?php
                        if($dataCosecha['estatus'] == 't')
                            echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>');
                        else
                            echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>');
                    ?>
                </td>
                <td align="center">
                    <?php
                        $urls = array(1 => 'cosecha.php?ac=editar&idP='.$dataPrograma['id'].'&id='.$dataCosecha['id']);
                        $acciones[0]['eliminar'] = 0;
                        $general->crearAcciones($acciones, $urls);
                        $acciones[0]['eliminar'] = 1;
                    ?>
                </td>
            </tr>
            <?php
                $j++;
                }
            ?>
        </tbody>
        <?php
            $i++;
            }
        ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
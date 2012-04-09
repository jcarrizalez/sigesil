<?
    require_once('../lib/core.lib.php');
    
    $ordenes = new Orden();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listadoOrdenes = $ordenes->buscarOrden('', $idCA, '', '', $numOrden);
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'ordenes.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ORDENES<br/><hr/>
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
            <th>Nombre</th>
            <th>Cultivo</th>
            <th>Nro Orden</th>
            <th>Fecha Emisi&oacute;n</th>
            <th>Toneladas</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoOrdenes as $dataOr){
                $dataOr['id_cultivo'] = ($dataOr['id_cultivo'] < 10) ? '0'.$dataOr['id_cultivo'] : $dataOr['id_cultivo'];
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataOr['codigo']?></td>
            <td><?=$dataOr['nombre_ca']?></td>
            <td align="center"><?=$dataOr['id_cultivo']?></td>
            <td align="center"><?=$dataOr['numero_orden']?></td>
            <td align="center"><?=$dataOr['fecha_emision']?></td>
            <td align="center"><?=$general->date_sql_screen($dataOr['toneladas'], '', 'es', '-')?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'ordenes.php?ac=editar&id='.$dataOr['id']);
                    //echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'centros_acopio_listado.php?ac=eliminar&id='.$dataOr['id'], array('onclick' => 'return eliminar();'));
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
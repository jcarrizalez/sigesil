<?
    require_once('../lib/core.lib.php');
    
    $ordenes = new Orden();
    $centro_acopio = new CentroAcopio();
    $objCultivo = new Cultivo();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $idCultivo = (!empty($GPC['id_cultivo'])) ? $GPC['id_cultivo'] : '';
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $listadoCultivos = $objCultivo->buscarCultivo();
    foreach($listadoCultivos as $valor){
        $listadoC[$valor['id']] = "(".$valor['codigo'].") ".$valor['nombre'];
    }
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoOrdenes = $ordenes->buscarOrden('', $idCA, '', $idCultivo, $numOrden, $porPagina, $inicio);
    
    $total_registros = $ordenes->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $ordenes->desactivarOr($id, $GPC['estatus']);
        header('location: ordenes_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar esta Orden?'))
            return true;
        else
            return false;
    }
    
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
        ORDENES DE DESPACHO<br/><hr/>
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
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <tr>
                    <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                    <td>Centro de Acopio</td>
                    <td><? echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $idCA, 'default' => 'Todos', 'class' => 'estilo_campos2')); ?></td>
                    <? } ?>
                </tr>
                <tr>
                    <td width="130">Cultivo</td>
                    <td><? echo $html->select('id_cultivo',array('options'=>$listadoC, 'selected' => $idCultivo, 'default' => 'Todos', 'class' => 'estilo_campos2'))?></td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <?
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            $general->crearAcciones($acciones, '', 1);
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>C&eacute;dula/Rif</th>
            <th>Cliente</th>
            <th>Cultivo</th>
            <th>Nro Orden</th>
            <th>Verificaci&oacute;n</th>
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
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td align="center"><?="(".$dataOr['codigo'].") ".$dataOr['nombre_ca']?></td>
            <? } ?>
            <td align="center"><?=$dataOr['ced_cliente']?></td>
            <td align="center"><?=$dataOr['nombre_cliente']?></td>
            <td align="center"><?=$dataOr['id_cultivo']?></td>
            <td align="center"><?=$dataOr['numero_orden']?></td>
            <td align="center"><?=$dataOr['cod_verificacion']?></td>
            <td align="center"><?=$general->date_sql_screen($dataOr['fecha_emision'], '', 'es', '-')?></td>
            <td align="center"><?=$dataOr['toneladas']?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'ordenes.php?ac=editar&id='.$dataOr['id'], 'ordenes_listado.php?ac=eliminar&id='.$dataOr['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?
    require('../lib/common/footer.php');
?>
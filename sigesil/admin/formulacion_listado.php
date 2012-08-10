<?
    require_once('../lib/core.lib.php');
    
    $formulas = new Formulas();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTES)
        $id_CA = $_SESSION['s_ca_id'];
    else
        $id_CA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
        
    $codigo = (!empty($GPC['codigo'])) ? $GPC['codigo'] : null;
    $listaMov = array(1 => 'Recepci&oacute;n', 2 => 'Despacho');
    
    $mov = (!empty($GPC['id_mov'])) ? $GPC['id_mov'] : '';
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    $formulas->listaFormulas($id_CA, $codigo, '', $porPagina, $inicio, $mov);
    
    $total_registros = $formulas->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $formulas->desactivarFor($id, $GPC['estatus']);
        header('location: formulacion_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar esta Formula?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'formulacion.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        F&Oacute;RMULAS<br/><hr/>
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
                    <td width="110">Centro de Acopio</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr>
                    <td width="110">Tipo de Movimiento</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_mov',array('options'=>$listaMov, 'selected' => $GPC['id_mov'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="3">
                        <?
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
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
            <th>Centro Acopio</th>
            <? } ?>
            <th>Cultivo</th>
            <th width="1">C&oacute;digo</th>
            <th>Formula</th>
            <th>Condici&oacute;n</th>
            <th>Tipo</th>
            <th width="1">Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($formulas->listaF as $dataFormula){
                $clase = $general->obtenerClaseFila($i);
                switch($dataFormula['id_mov']){
                    case 1:
                        $tipo = 'Recepci&oacute;n';
                    break;
                    case 2:
                        $tipo = 'Despacho';
                    break;
                    case 3:
                        $tipo = 'Basica';
                    break;
                }
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$dataFormula['nombre_ca']?></td>
            <? } ?>
            <td align="center"><?=$dataFormula['codigo_cultivo']?></td>
            <td align="center"><?=$dataFormula['codigo']?></td>
            <td><?=$dataFormula['formula']?></td>
            <td align="center"><?=$dataFormula['condicion']?></td>
            <td align="center"><?=$tipo?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'formulacion.php?ac=editar&id='.$dataFormula['id'], 'formulacion_listado.php?ac=eliminar&id='.$dataFormula['id'].'&estatus=f');
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="3">&nbsp;</td>
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
<?
    require_once('../lib/core.lib.php');
    
    $tolcarom = new Tolcarom();
    $centro_acopio = new CentroAcopio();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    $listaTipo = array(1 => 'Tolva', 2 => 'Carril', 3 => 'Romana');
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $tipo = (!empty($GPC['tipo'])) ? $GPC['tipo'] : '';
    
    $listadoTolcarom = $tolcarom->buscarTolcarom('', $idCA, '', $tipo, '', $porPagina, $inicio);
    
    $total_registros = $tolcarom->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'tolcarom.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        TOLVAS, CARRILES Y ROMANAS<br/><hr/>
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
            <table width="100%" border="0">
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <? echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos')); ?>
                    </td>
                </tr>
                <? } ?>
                <tr>
                    <td width="110">Tipo:</td>
                    <td colspan="2">
                        <? echo $html->select('tipo',array('options'=>$listaTipo, 'selected' => $GPC['tipo'], 'default' => 'Todos')); ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="3">
                        <?
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
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
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Parametros</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoTolcarom as $dataTolcarom){
                $clase = $general->obtenerClaseFila($i);
                switch($dataTolcarom['tipo']){
                    case 1:
                        $tipo = 'TOLVA';
                    break;
                    case 2:
                        $tipo = 'CARRIL';
                    break;
                    case 3:
                        $tipo = 'ROMANA';
                    break;
                }
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$dataTolcarom['centro_acopio']?></td>
            <? } ?>
            <td><?=$dataTolcarom['nombre']?></td>
            <td><?=$tipo?></td>
            <td><?=$dataTolcarom['parametros']?></td>
            <td align="center">
                <? echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'tolcarom.php?ac=editar&id='.$dataTolcarom['id']); ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<? require('../lib/common/footer.php'); ?>
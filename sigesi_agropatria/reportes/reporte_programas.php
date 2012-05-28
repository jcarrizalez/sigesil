<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $codigo = (!empty($GPC['codigo'])) ? $GPC['codigo'] : '';
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoProgramas = $programa->buscarProgramaCA(null, $idCA, $codigo, null, $nombre, $porPagina, $inicio);
    
    $total_registros = $programa->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        REPORTE PROGRAMAS<br/><hr/>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos', 'class' => 'estilo_campos'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr>
                    <td>Codigo</td>
                    <td><? echo $html->input('codigo', $codigo, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                    <td>Nombre</td>
                    <td><? echo $html->input('nombre', $nombre, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            //echo $html->input('ac', 'Excel', array('type' => 'submit'));
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
            <th>Codigo</th>
            <th>Nombre</th>
            <th>Fecha Inicio</th>
            <th>Fecha Fin</th>
        </tr>
        <?
            $i=0;
            foreach($listadoProgramas as $dataPrograma){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?="(".$dataPrograma['ca_codigo'].") ".$dataPrograma['ca_nombre']?></td>
            <? } ?>
            <td align="center"><?=$dataPrograma['codigo']?></td>
            <td><?=$dataPrograma['nombre']?></td>
            <td align="center"><?=$general->date_sql_screen($dataPrograma['fecha_inicio'], '', 'es', '-')?></td>
            <td align="center"><?=$general->date_sql_screen($dataPrograma['fecha_fin'], '', 'es', '-')?></td>
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
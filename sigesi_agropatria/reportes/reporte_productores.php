<?
    require_once('../lib/core.lib.php');
    
    $productor = new Productor();
    $div_pol = new DivPol();
    
    $cedrif = (!empty($GPC['ced'])) ? $GPC['ced'] : '';
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';
    $estado = (!empty($GPC['id_estado'])) ? $GPC['id_estado'] : '';
    $municipio = (!empty($GPC['id_municipio'])) ? $GPC['id_municipio'] : '';
    
    $estados = $div_pol->obtenerEstado();
    foreach ($estados as $campo => $valor) {
        $listaE[$valor['id']] = $valor['nombre'];
    }
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoProductor = $productor->listadoProductores(null, null, $cedrif, $nombre, $estado, $municipio, $porPagina, $inicio);
    
    $total_registros = $productor->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){        
        $('#Regresar').click(function(){
           history.back();
        });
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
    <div id="titulo_modulo">
        REPORTE CULTIVOS<br/><hr/>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <tr>
                    <td>C&eacute;dula/Rif</td>
                    <td><? echo $html->input('ced', $cedrif, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                    <td>Nombre</td>
                    <td><? echo $html->input('nombre', $nombre, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Estado</td>
                    <td><? echo $html->select('id_estado', array('options' => $listaE, 'selected' => $estado, 'default' => 'Todos', 'class' => 'estilo_campos')) ?></td>
                    <td>Municipio</td>
                    <td>
                        <div id="mcpo">
                            <? echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $municipio, 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                        </div>
                    </td>
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
            <th>C&eacute;dula/Rif</th>
            <th>Nombre</th>
            <th>Estado</th>
            <th>Municipio</th>
        </tr>
        <?
            $i=0;
            foreach($listadoProductor as $dataProductor){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataProductor['ced_rif']?></td>
            <td><?=$dataProductor['nombre']?></td>
            <td><?=$dataProductor['estado']?></td>
            <td><?=$dataProductor['municipio']?></td>
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
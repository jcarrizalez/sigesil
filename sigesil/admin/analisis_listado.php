<?
    require_once('../lib/core.lib.php');
    
    $analisis = new Analisis();
    $listaTipo = array(1 => 'Cuantitativo', 2 => 'Cualitativo', 3 => 'Boleano');
    
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : null;
    $tipo = (!empty($GPC['tipo'])) ? $GPC['tipo'] : null;
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoAnalisis = $analisis->listaAnalisis(null, $tipo, $nombre, $codigo, null, null, $porPagina, $inicio);
    
    $total_registros = $analisis->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'analisis.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        ANALISIS<br/><hr/>
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
                <tr>
                    <td width="60">Nombre</td>
                    <td>
                        <? echo $html->input('nombre', $GPC['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?>
                    </td>
                </tr>
                <tr>
                    <td>Tipo</td>
                    <td>
                        <? echo $html->select('tipo', array('options'=>$listaTipo, 'default' => 'Seleccione', 'selected' => $GPC['tipo'], 'class' => 'estilo_campos')); ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <?
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            $general->crearAcciones($acciones, '', 1);
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button'));
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
            <th>C&oacute;digo</th>
            <th>Nombre</th>
            <th>Tipo</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoAnalisis as $dataAnalisis){
                $clase = $general->obtenerClaseFila($i);
                switch($dataAnalisis['tipo_analisis']){
                    case 1:
                        $tipo = 'CUANTITATIVO';
                    break;
                    case 2:
                        $tipo = 'CUALITATIVO';
                    break;
                    case 3:
                        $tipo = 'BOLEANO';
                    break;
                }
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataAnalisis['codigo']?></td>
            <td><?=$dataAnalisis['nombre']?></td>
            <td align="center"><?=$tipo?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'analisis.php?ac=editar&id='.$dataAnalisis['id']);
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
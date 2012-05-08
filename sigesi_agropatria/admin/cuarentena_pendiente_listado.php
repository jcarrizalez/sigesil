<?php
require_once('../lib/core.lib.php');

$recepcion = new Recepcion();
    
$porPagina = MAX_RESULTS_PAG;
$inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
$estatus='';

$listadoRecepcion = $recepcion->listadoRecepcion('', $idCa,'','', '', $estatus, '', '', $porPagina, $inicio);

$total_registros = $recepcion->total_verdadero;
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
    CUARENTENAS PENDIENTES<hr/>    
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
            <tr id="botones">
                <td colspan="2">
                    <?
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
            <th>Centro de Acopio</th>
            <th>Nro</th>
            <th>Cultivo</th>
            <th>Fecha</th>
            <th>Estatus</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoRecepcion as $dataRecepcion){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataRecepcion['ca_codigo']+' '+$dataRecepcion['centro_acopio']?></td>
            <td align="center"><?=$dataRecepcion['numero']?></td>
            <td align="center"><?=$dataRecepcion['cultivo_nombre']?></td>
            <td align="center"><?=$dataRecepcion['creado']?></td>
            <td align="center"><?=$dataRecepcion['estatus_rec']?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'cuarentena_pendiente.php?ac=editar&id='.$dataRecepcion['id']);
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
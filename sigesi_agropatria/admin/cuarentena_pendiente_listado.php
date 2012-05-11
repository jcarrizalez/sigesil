<?php
    require_once('../lib/core.lib.php');

    $recepcion = new Recepcion();
    $cosecha = new Cosecha();

    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    $estatus=2;
    
    $idCosecha='';
    $numEntrada='';
    
    if ($GPC['ac']=='Buscar') {
        $idCosecha=(!empty($GPC['idCosecha'])) ? $GPC['idCosecha'] : '';
        $numEntrada=(!empty($GPC['numEntrada'])) ? $GPC['numEntrada'] : '';
    }
    
    $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCo[1]);
    
    $listadoRecepcion = $recepcion->listadoRecepcion('', $idCa, $idCosecha,'', $numEntrada, $estatus, '', '', $porPagina, $inicio);

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
    <form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">
        <? echo $html->input('ac', 'Buscar', array('type' => 'hidden'));?>
        <table width="100%">            
            <tr>
                <td width="110">Cultivo</td>                
                <td colspan="2">
                    <?
                        echo $html->select('idCosecha',array('options'=>$listaCo, 'selected' => $GPC['idCosecha'], 'default' => 'Seleccione'));
                    ?>
                </td>
            </tr>
            <tr>
                <td width="110">Numero</td>
                <td>
                <?= $html->input('numEntrada', $numEntrada, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => $soloLectura, 'class' => 'cuadricula positive')); 
                    echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                ?></td>
            </tr>
            <tr id="botones">
                <td colspan="3">
                    <?
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
            <td align="center"><?=$dataRecepcion['ca_codigo'].' - '.$dataRecepcion['centro_acopio'];?></td>
            <td align="center"><?=$dataRecepcion['numero']?></td>
            <td align="left"><?=$dataRecepcion['cultivo_codigo'].' - '.$dataRecepcion['cultivo_nombre']?></td>
            <td align="center"><?=$general->date_sql_screen($dataRecepcion['creado'], '', $lang="es", $sep="-")?></td>
            <td align="center"><?
            //=$dataRecepcion['estatus_rec']
            echo '<img src="../images/cuarentena.png" width="16" height="16" title=Cuarentena>';            
            ?></td>
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
<?php
    require_once('../lib/core.lib.php');    

    $movimiento = new Despacho();
    $cultivo = new Cultivo();
       
    $idCa = (!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id'] : null;
    $listadoEstatus = array('1' => '(1) Romana Vacio', '2' => '(2) Laboratorio Central', '3' => '(3) Rechazado', '4' => '(4) Rechazado', '5' => '(5) Des','6' => '(6) Romana Vacio', '7' => '(7) Rechazo Central', '9' => '(9) Recibido',  '11' => '(11) Ctna Aprobado',  '12' => '(12) Ctna Rechazado');
    $estatus = (!empty($GPC['estatus'])) ? "'".$GPC['estatus']."'" : null;
    $fdesde = (!empty($GPC['fecha_inicio'])) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : '';
    $fhasta = (!empty($GPC['fecha_fin'])) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : '';
    $numSalida=(!empty($GPC['numSalida'])) ? $GPC['numSalida']: null;
    $idCu=(!empty($GPC['cultivo'])) ? $GPC['cultivo']: null;
    $listaCu = $cultivo->find('', '', array('id', 'nombre'), 'list', 'id');
    
//    if (!empty($numEntrada) && (!empty($fdesde) || !empty($fhasta))) {
//        if (empty($fdesde))
//            $fdesde=$fhasta;
//        elseif (empty($fhasta))
//            $fhasta=$fdesde;
    
        $listadoMov=$movimiento->listadoDespacho(null, $idCa, $idCu, null, $numSalida, $estatus, null, null, $porPagina, $inicio, null, null, null, null, null, null, $fdesde, $fhasta);
        $total_registros = $despacho->total_verdadero;
        $paginador = new paginator($total_registros, $porPagina);
//    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<div id="titulo_modulo">    
    UTILITARIO - DESPACHO<hr/>
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
            <table width="100%" border="0">
                <tr>
                    <td width="1">Desde </td>
                    <td width="200">
                        <? echo $html->input('fecha_inicio', $general->date_sql_screen($fdesde, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fdesde" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fdesde",
                                inputField : "fecha_inicio",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_inicio']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td width="1">Hasta </td>
                    <td>
                        <? echo $html->input('fecha_fin', $general->date_sql_screen($fhasta, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fhasta" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fhasta",
                                inputField : "fecha_fin",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_fin']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td width="60">Cultivo</td>
                    <td>
                        <? echo $html->select('cultivo',array('options'=>$listaCu, 'selected' => $GPC['cultivo'], 'default' => 'Todas'));?>
                    </td>
                    <td>Numero</td>
                    <td><?=$html->input('numSalida', $numSalida, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => $soloLectura, 'class' => 'crproductor positive'));?> </td>
                </tr>
                <tr>
                    <td width="60">Estatus</td>
                    <td colspan="2">
                        <?
                            echo $html->select('estatus',array('options'=>$listadoEstatus, 'selected' => $GPC['estatus'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="4">
                        <? 
                        echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();')); 
                        ?>
                    </td>
                </tr>
            </table>
            <? echo $html->input('mov', $GPC['mov'], array('type' => 'hidden')); ?>
        </form>
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Centro de Acopio</th>        
            <th width="90">Nro Entrada</th>
            <th>Cultivo</th>
            <th>Guia</th>
            <th>Fecha Recepci&oacute;n</th>
            <th width="1">Acci&oacute;n</th>        
        </tr>
    <?
        $i=0;
        foreach($listadoMov as $dataMov) {
            $clase = $general->obtenerClaseFila($i);
            $numero = "R".$dataMov['numero']."-".$general->date_sql_screen($dataMov['fecha_recepcion'], '', 'es', '');
    ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataMov['ca_codigo']." - ".$dataMov['centro_acopio']?></td>
            <td align="center"><?=$numero?></td>
            <td align="center"><?="(".trim($dataMov['cultivo_codigo']).") ".$dataMov['cultivo_nombre']?></td>
            <td align="center"><?=$dataMov['numero_guia']?></td>
            <td align="center"><?=$general->date_sql_screen($dataMov['fecha_recepcion'], '', 'es', '-')?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'utilitario_despacho.php?ac=editar&id='.$dataMov['id']);
                    $general->crearAcciones($acciones, $urls);
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

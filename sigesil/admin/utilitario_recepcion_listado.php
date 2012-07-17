<?php
    require_once('../lib/core.lib.php');
    
    $movimiento = new Recepcion();
    $cultivo = new Cultivo();
    $cosecha = new Cosecha();
    
    $idCA = $_SESSION['s_ca_id'];
    $listadoEstatus = array('1' => '(1) Laboratorio Central', '2' => '(2) Curentena Admon', '3' => '(3) Romana Lleno', '4' => '(4) Tolvas', '5' => '(5) Ctna Tolva','6' => '(6) Romana Vacio', '7' => '(7) Rechazo Central', '9' => '(9) Recibido',  '11' => '(11) Ctna Aprobado',  '12' => '(12) Ctna Rechazado');
    $estatus = (!empty($GPC['estatus'])) ? "'".$GPC['estatus']."'" : null;
    $fdesde = (!empty($GPC['fecha_inicio'])) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : '';
    $fhasta = (!empty($GPC['fecha_fin'])) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : '';
    $numEntrada=(!empty($GPC['numEntrada'])) ? $GPC['numEntrada']: null;
    $idCo=(!empty($GPC['cosecha'])) ? $GPC['cosecha']: null;
    
    $listadoCosecha=$cosecha->infoCosechaCultivo($idCA, $idCo, null, null, null, null, null);
    $idCo=$listadoCosecha[0]['cosecha_id'];

    foreach($listadoCosecha as $dataCosecha) {
        $listadoC[$dataCosecha['cosecha_id']]=$dataCosecha['cultivo_nombre'];
    }

    if (!empty($numEntrada) && (!empty($fdesde) || !empty($fhasta))) {
        if (!empty($fdesde)) {
            $fhasta=$fdesde;
        } elseif (!empty($fhasta)) {
            $fdesde=$fhasta;
        }
        $GPC['fecha_inicio']=$fdesde;
        $GPC['fecha_fin']=$fhasta;
        $listadoMov = $movimiento->listadoRecepcion(null, $idCA, $idCo, null, $numEntrada, $estatus, null, null, $porPagina, $inicio, null, null, null, null, null, null, null, null, $fdesde, $fhasta);

        $total_registros = $despacho->total_verdadero;
        $paginador = new paginator($total_registros, $porPagina);
    }

    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<div id="titulo_modulo">    
    UTILITARIO - RECEPCI&Oacute;N<hr/>
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
                    <td width="60">Cosecha</td>
                    <td>
                        <? echo $html->select('cosecha',array('options'=>$listadoC, 'selected' => $GPC['cosecha'], 'default' => 'Todas'));?>
                    </td>
                    <td>Numero</td>
                    <td><?=$html->input('numEntrada', $numEntrada, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => $soloLectura, 'class' => 'crproductor positive'));?> </td>
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
                <? //echo $html->link('<img src="../images/peso1.png" width="16" height="16" title=Pesar>', 'romana.php?ac=pesar&id='.$dataMov['id'].'&mov='.$GPC['mov']); ?>
                <?
                    $urls = array(1 => 'utilitario_recepcion.php?ac=editar&id='.$dataMov['id']);
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

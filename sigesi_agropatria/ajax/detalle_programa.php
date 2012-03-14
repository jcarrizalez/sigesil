<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'agregar':
            if(!empty($GPC['nro'])){
            ?>
                <legend class='titulo_leyenda'>Datos de la Cosecha #<?=$GPC['nro']?></legend>
                <table align='center' width='100%'>
                    <tr>
                        <td>
                            <table align='center' cellpadding='0' cellspacing='0'>
                                <tr>
                                    <td><span class='msj_rojo'>* </span>C&oacute;digo</td>
                                    <td rowspan="7">&nbsp;&nbsp;</td>
                                    <td><? echo $html->input("Cosecha".$GPC['nro'].".codigo", $GPC['codigo'], array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => true)); ?></td>
                                </tr>
                                <tr>
                                    <td>Nombre</td>
                                    <td><? echo $html->input("Cosecha".$GPC['nro'].".nombre", '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                                </tr>
                                <tr>
                                    <td>Proyectado</td>
                                    <td><? echo $html->input("Cosecha".$GPC['nro'].".proyectado", '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                                </tr>
                                <tr>
                                    <td>Area Siembra</td>
                                    <td><? echo $html->input("Cosecha".$GPC['nro'].".area_siembra", '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                                </tr>
                                <tr>
                                    <td>Fecha Inicio</td>
                                    <td>
                                        <? echo $html->input("Cosecha".$GPC['nro'].".fecha_inicio", '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?>&nbsp;&nbsp;
                                        <img src='../images/calendario.png' id="finicio<?=$GPC['nro']?>" width='16' height='16' style='cursor:pointer' />
                                        <script>
                                            Calendar.setup({
                                                trigger    : "finicio<?=$GPC['nro']?>",
                                                inputField : "Cosecha<?=$GPC['nro']?>[fecha_inicio]",
                                                dateFormat: "%d-%m-%Y",
                                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                                onSelect   : function() { validarFecha("Cosecha<?=$GPC['nro']?>[fecha_inicio]",$('#Cosecha1\\[fecha_inicio\\]').val()); this.hide() }
                                            });
                                        </script>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fecha Fin</td>
                                    <td>
                                        <? echo $html->input("Cosecha".$GPC['nro'].".fecha_fin", '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?>&nbsp;&nbsp;
                                        <img src='../images/calendario.png' id="ffin<?=$GPC['nro']?>" width='16' height='16' style='cursor:pointer' />
                                        <script>
                                            Calendar.setup({
                                                trigger    : "ffin<?=$GPC['nro']?>",
                                                inputField : "Cosecha<?=$GPC['nro']?>[fecha_fin]",
                                                dateFormat: "%d-%m-%Y",
                                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                                onSelect   : function() { validarFecha("Cosecha<?=$GPC['nro']?>[fecha_fin]",$('#Cosecha1\\[fecha_fin\\]').val()); this.hide() }
                                            });
                                        </script>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            <?
            }
        break;
    }
?>
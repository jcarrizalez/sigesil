<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    if (empty($GPC['id_rec'])) {
        header('location: ../admin/romana_listado.php?mov='.$GPC['mov']);
        die();
    }
        
    $id_rec = $GPC['id_rec'];
    $recepcion = new Recepcion();
    $despacho = new Despacho();
    
    if($GPC['mov'] == 'rec'){
        $subguias = new Guia();
        $dataMovimiento = $recepcion->listadoRecepcion($id_rec);
        $dataSubGuias = $subguias->buscarSubGuias($dataMovimiento[0]['id_guia']);
    }else{
        $subOrdenes = new Orden();
        $dataMovimiento = $despacho->listadoDespacho($id_rec);
        $dataSubOrdenes = $subOrdenes->buscarSubOrden($dataMovimiento[0]['id_orden']);
    }
    
    $pesoBruto = $dataMovimiento[0]['peso_01l']+$dataMovimiento[0]['peso_02l'];
    $pesoTara = $dataMovimiento[0]['peso_01v']+$dataMovimiento[0]['peso_02v'];
    $pesoNeto = ($pesoBruto-$pesoTara);
    
    if(!empty($dataMovimiento[0]['id']) && ($dataMovimiento[0]['estatus_rec'] == 9) || $dataMovimiento[0]['estatus'] == 5){
        if(!empty($GPC['reimprimir'])){
?>
<script type="text/javascript">
    window.print();
</script>
<? } ?>
<table id="tabla_reporte" border="0" width="800">
    <?
        if($GPC['mov'] == 'rec'){
            $numero = "R".$dataMovimiento[0]['numero']."-".$general->date_sql_screen($dataMovimiento[0]['fecha_recepcion'], '', 'es', '');
    ?>
    <tr>
        <td id="titulo_reporte" colspan="6">CONSTANCIA DE RECEPCI&Oacute;N</td>
    </tr>
    <tr>
        <td colspan="6">GUIA INSAI: <?=$dataMovimiento[0]['numero_guia']?></td>
    </tr>
    <tr>
        <td width="150">ENTRADA Nro:</td>
        <td><?=$numero?></td>
        <td align="right">FECHA:</td>
        <td><?=$general->date_sql_screen($dataMovimiento[0]['modificado'],'','es','-')?></td>
        <td align="right">SUBGUIAS:</td>
        <td>
            <?
                foreach($dataSubGuias as $valor){
                    $guiastotal .= $valor['subguia']. " - ";
                }
                    echo substr($guiastotal, 0, -2);
            ?>
        </td>
    </tr>
    <tr>
        <td>COSECHA:</td>
        <td colspan="5"><?=$dataMovimiento[0]['cosecha_codigo']. " - " .$dataMovimiento[0]['cultivo_nombre']?></td>
    </tr>
    <tr>
        <td>PROPIEDAD DE:</td>
        <td colspan="5"><?=$dataMovimiento[0]['ced_productor']?></td>
    </tr>
    <tr>
        <td>NOMBRE:</td>
        <td colspan="5"><?=$dataMovimiento[0]['productor_nombre']?></td>
    </tr>
    <tr>
        <td>ASOCIADO:</td>
        <td colspan="5"><?=$dataMovimiento[0]['ced_asociado']. " " .$dataMovimiento[0]['asociado_nombre']?></td>
    </tr>
    <tr>
        <td>PRODUCTO:</td>
        <td colspan="5"><?=$dataMovimiento[0]['cultivo_codigo']. " " .$dataMovimiento[0]['cultivo_nombre']?></td>
    </tr>
    <tr>
        <td>CHOFER:</td>
        <td colspan="5"><?=$dataMovimiento[0]['ced_chofer']. " NOMBRE: " .$dataMovimiento[0]['chofer_nombre']?></td>
    </tr>
    <tr>
        <td>
            VEHICULO PLACAS:
        </td>
        <td colspan="5">
            <?
                $placa = $dataMovimiento[0]['placa'];
                $placa .= (!empty($dataMovimiento[0]['placa_remolques'])) ? " / ".$dataMovimiento[0]['placa_remolques'] : "";
                echo $placa;
            ?>
        </td>
    </tr>
    <?
        }else{
            $numero = "D".$dataMovimiento[0]['numero']."-".$general->date_sql_screen($dataMovimiento[0]['fecha_des'], '', 'es', '');
    ?>
    <tr>
        <td id="titulo_reporte" colspan="6">GU&Iacute;A DE DESPACHO</td>
    </tr>
    <tr>
        <td width="150">DESPACHO Nro:</td>
        <td><?=$numero?></td>
        <td align="right">PRODUCTO:</td>
        <td><?=$dataMovimiento[0]['cultivo_codigo']. " " .$dataMovimiento[0]['cultivo_nombre']?></td>
    </tr>
    <tr>
        <td>CLIENTE:</td>
        <td colspan="3"><?=$dataMovimiento[0]['ced_cliente']. " " .$dataMovimiento[0]['cliente_nombre']?></td>
    </tr>
    <tr>
        <td>ORDEN DE COMPRA:</td>
        <td><?=$dataMovimiento[0]['numero_guia']?></td>
        <td align="right">ORDEN DE CARGA:</td>
        <td>
            <?
                foreach($dataSubOrdenes as $valor){
                    $ordenestotal .= $valor['numero_orden']. " - ";
                }
                    echo substr($ordenestotal, 0, -2);
            ?>
        </td>
    </tr>
    <tr>
        <td>CHOFER:</td>
        <td colspan="3"><?=$dataMovimiento[0]['ced_chofer']. " NOMBRE: " .$dataMovimiento[0]['chofer_nombre']?></td>
    </tr>
    <tr>
        <td>
            VEHICULO PLACAS:
        </td>
        <td colspan="5">
            <?
                $placa = $dataMovimiento[0]['placa'];
                $placa .= (!empty($dataMovimiento[0]['placa_remolques'])) ? " / ".$dataMovimiento[0]['placa_remolques'] : "";
                echo $placa;
            ?>
        </td>
    </tr>
    <tr>
        <td>PUNTO DE ENTREGA:</td>
        <td colspan="3"><?=$dataMovimiento[0]['pto_entrega']?></td>
    </tr>
    <? } ?>
</table>
<table border="0" width="800" style="padding-top: 20px;">
    <? if($dataMovimiento[0]['cultivo_codigo'] != 12){ ?>
    <tr>
        <td width="20">&nbsp;</td>
        <td>PESO BRUTO TOTAL Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoBruto * 1000) / 1000, 3);?></td>
        <td width="20">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>PESO DEL VEHICULO Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoTara * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <? if($GPC['mov'] == 'rec'){ ?>
        <td>PESO NETO RECIBIDO Kgrs</td>
        <? }else{ ?>
        <td>NETO DESPACHADO Kgrs</td>
        <? } ?>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoNeto * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR HUMEDAD: <?=$general->formato_numero($dataMovimiento[0]['humedad'], 3);?>% Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad_des'] * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR IMPUREZAS: <?=$general->formato_numero($dataMovimiento[0]['impureza'], 3);?>% Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des'] * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <? if($GPC['mov'] == 'rec'){ ?>
        <td>PESO NETO A LIQUIDAR Kgrs</td>
        <? }else{ ?>
        <td>NETO ACONDICIONADO Kgrs</td>
        <? } ?>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon'] * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <?
        }else{
            if(!empty($dataMovimiento[0]['peso_02l'])){
    ?>
    <tr>
        <td colspan="3">&nbsp;</td>
        <td>MOTRIZ</td>
        <td>REMOLQUE</td>
        <td>&nbsp;</td>
    </tr>
    <?
            }
    ?>
    <tr>
        <td width="20">&nbsp;</td>
        <td>PESO BRUTO TOTAL Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoBruto * 1000) / 1000, 3);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_01l'] * 1000) / 1000, 3);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_02l'] * 1000) / 1000, 3);?></td>
        <? } ?>
        <td width="20">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>PESO DEL VEHICULO Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoTara * 1000) / 1000, 3);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_01v'] * 1000) / 1000, 3);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_02v'] * 1000) / 1000, 3);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <? if($GPC['mov'] == 'rec'){ ?>
        <td>PESO NETO RECIBIDO Kgrs</td>
        <? }else{ ?>
        <td>NETO DESPACHADO Kgrs</td>
        <? } ?>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoNeto * 1000) / 1000, 3);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round(($dataMovimiento[0]['peso_01l']-$dataMovimiento[0]['peso_01v']) * 1000) / 1000, 3);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round(($dataMovimiento[0]['peso_02l']-$dataMovimiento[0]['peso_02v']) * 1000) / 1000, 3);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <?
            if(empty($dataMovimiento[0]['peso_02l'])){
                $humedad = $general->formato_numero($dataMovimiento[0]['humedad'], 3)."%";
                $impureza = $general->formato_numero($dataMovimiento[0]['impureza'], 3)."%";
            }else{
                $humedad = $general->formato_numero($dataMovimiento[0]['humedad'], 3)."% &nbsp;&nbsp;&nbsp; M2%";
                $impureza = $general->formato_numero($dataMovimiento[0]['impureza'], 3)."% &nbsp;&nbsp;&nbsp; M2%";
            }
        ?>
        <td>DESC. POR HUMEDAD: <?=$humedad;?></td>
        <td>----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad_des'] * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR IMPUREZAS: <?=$impureza;?></td>
        <td>----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des'] * 1000) / 1000, 3);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="4">FRANQUICIA: 14.000</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESCUENTO:</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des'] * 1000) / 1000, 3);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round(0 * 1000) / 1000, 3);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round(0 * 1000) / 1000, 3);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <? if($GPC['mov'] == 'rec'){ ?>
        <td>PESO NETO A LIQUIDAR Kgrs</td>
        <? }else{ ?>
        <td>NETO ACONDICIONADO Kgrs</td>
        <? } ?>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon'] * 1000) / 1000, 3);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?='PNA M1'//$general->formato_numero(round(0 * 1000) / 1000, 3);?></td>
        <td width="1" align="right"><?='PNA M2'//$general->formato_numero(round(0 * 1000) / 1000, 3);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <? } ?>
</table>
<table border="0" width="800" style="padding-top: 35px;" class="centrar">
    <tr align="center">
        <td><?=str_repeat('_',30)?></td>
        <td><?=str_repeat('_',30)?></td>
        <td><?=str_repeat('_',30)?></td>
    </tr>
    <tr align="center">
        <td>Fiscal</td>
        <td>Analista</td>
        <td>Productor/Conductor</td>
    </tr>
</table>
<?
    }else{
        header('location: ../admin/recepcion.php');
        die();
    }
    require_once("../lib/common/footer_reportes.php");
?>
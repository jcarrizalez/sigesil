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
    
    if(!empty($dataMovimiento[0]['id']) && (in_array($dataMovimiento[0]['estatus_rec'], array(14,9))) || $dataMovimiento[0]['estatus'] == 5){
        if(!empty($GPC['reimprimir'])){
?>
<script type="text/javascript">
    window.print();
    window.close();
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
        <? if(!empty($dataSubGuias)){ ?>
        <td align="right">SUBGUIAS:</td>
        <td>
            <?
                foreach($dataSubGuias as $valor){
                    $guiastotal .= $valor['subguia']. " - ";
                }
                    echo substr($guiastotal, 0, -2);
            ?>
        </td>
        <? } ?>
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
    <? if(!empty($dataMovimiento[0]['ced_asociacion'])){ ?>
    <tr>
        <td>ASOCIACI&Oacute;N:</td>
        <td colspan="5"><?=$dataMovimiento[0]['ced_asociacion']. " " .$dataMovimiento[0]['asociacion_nombre']?></td>
    </tr>
    <?    
        }
        if(!empty($dataMovimiento[0]['ced_asociado'])){
    ?>
    <tr>
        <td>ASOCIADO:</td>
        <td colspan="5"><?=$dataMovimiento[0]['ced_asociado']. " " .$dataMovimiento[0]['asociado_nombre']?></td>
    </tr>
    <? } ?>
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
    <? if($GPC['mov'] == 'rec'){ ?>
    <tr>
        <td width="20">&nbsp;</td>
        <td>PESO BRUTO TOTAL Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoBruto), 2);?></td>
        <td width="20">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>PESO DEL VEHICULO Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoTara), 2);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>PESO NETO RECIBIDO Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoNeto), 2);?></td>
        <td>&nbsp;</td>
    </tr>
    <? if(!in_array($dataMovimiento[0]['cultivo_codigo'], array(10,12))){ ?>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR HUMEDAD: <?=$general->formato_numero($dataMovimiento[0]['humedad'], 2);?>% Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad_des']), 2);?></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR IMPUREZAS: <?=$general->formato_numero($dataMovimiento[0]['impureza'], 2);?>% Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des']), 2);?></td>
        <td>&nbsp;</td>
    </tr>
    <? }else{ ?>
    <tr>
        <td>&nbsp;</td>
        <td>HUMEDAD: <?=$general->formato_numero($dataMovimiento[0]['humedad'], 2);?>%</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>IMPUREZA: <?=$general->formato_numero($dataMovimiento[0]['impureza'], 2);?>%</td>
    </tr>
    <? } ?>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
    <? if(!empty($dataMovimiento[0]['peso_acon'])){ ?>
    <tr>
        <td>&nbsp;</td>
        <td>PESO ACONDICIONADO Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon']), 2);?></td>
        <td>&nbsp;</td>
    </tr>
    <? } ?>
    <tr>
        <td>&nbsp;</td>
        <td>PESO ACONDICIONADO A LIQUIDAR Kgrs</td>
        <td align="right">----------------------------------------------------------------------------------------></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon_liq']), 2);?></td>
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
        <td width="1" align="right"><?=$general->formato_numero(round($pesoBruto), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_01l']), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_02l']), 2);?></td>
        <? } ?>
        <td width="20">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>PESO DEL VEHICULO Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoTara), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_01v']), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_02v']), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>NETO DESPACHADO Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($pesoNeto), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round(($dataMovimiento[0]['peso_01l']-$dataMovimiento[0]['peso_01v'])), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round(($dataMovimiento[0]['peso_02l']-$dataMovimiento[0]['peso_02v'])), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <?
        if(empty($dataMovimiento[0]['peso_02l'])){
            $humedad = $general->formato_numero($dataMovimiento[0]['humedad'], 2)."%";
            $impureza = $general->formato_numero($dataMovimiento[0]['impureza'], 2)."%";
        }else{
            $humedad = $general->formato_numero($dataMovimiento[0]['humedad'], 2)."% &nbsp;&nbsp;&nbsp; ".$general->formato_numero($dataMovimiento[0]['humedad2'], 2)."%";
            $impureza = $general->formato_numero($dataMovimiento[0]['impureza'], 2)."% &nbsp;&nbsp;&nbsp; ".$general->formato_numero($dataMovimiento[0]['impureza2'], 2)."%";
        }
        if(!in_array($dataMovimiento[0]['cultivo_codigo'], array(10,12))){
    ?>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR HUMEDAD: <?=$general->formato_numero($humedad, 2);?>% Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad']), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad_des']), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['humedad_des2']), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. POR IMPUREZAS: <?=$general->formato_numero($impureza, 2);?>% Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza']), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des']), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['impureza_des2']), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <?
        }else{
            if($dataMovimiento[0]['humedad'] + $dataMovimiento[0]['impureza'] >= 14)
                $descuento = $pesoNeto - $dataMovimiento[0]['peso_acon'];
            else
                $descuento = 0;
    ?>
    <tr>
        <td>&nbsp;</td>
        <td>DESC. HUM|IMP Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <?
            if(empty($dataMovimiento[0]['peso_02l'])){
                if($dataMovimiento[0]['humedad2'] + $dataMovimiento[0]['impureza2'] >= 14)
                    $descuento2 = $pesoNeto - $dataMovimiento[0]['peso_acon2'];
                else
                    $descuento2 = 0;
        ?>
        <td width="1" align="right"><?=$general->formato_numero(round($descuento), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($descuento), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($descuento2), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="3">HUMEDAD: <?=$humedad?><br/>IMPUREZA: <?=$impureza?></td>
    </tr>
    <? } ?>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
    <? /*if(!empty($dataMovimiento[0]['peso_acon'])){ ?>
    <tr>
        <td>&nbsp;</td>
        <td>PESO ACONDICIONADO Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon']), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon']), 2);?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon2']), 2);?></td>
        <? } ?>
        <td>&nbsp;</td>
    </tr>
    <? }*/ ?>
    <tr>
        <td>&nbsp;</td>
        <td>PESO ACONDICIONADO Kgrs</td>
        <td>----------------------------------------------------------------------------------------></td>
        <? if(empty($dataMovimiento[0]['peso_02l'])){ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon_liq']), 2);?></td>
        <? }else{ ?>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon_liq']), 2)?></td>
        <td width="1" align="right"><?=$general->formato_numero(round($dataMovimiento[0]['peso_acon_liq2']), 2)?></td>
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
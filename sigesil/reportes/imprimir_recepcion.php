<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
        
    $id_rec = $GPC['id_rec'];
    $ca = $GPC['ca'];
    $vacio = ($GPC['vacio']) ? true : false;
    $labR = (!empty($GPC['lab'])) ? "'".$GPC['lab']."'" : '';
    $labAc=($GPC['lab']=='P') ? "'A'": "'A','C'";
    
    $recepcion = new Recepcion();
    $despacho = new Despacho();
    $AnalisisRes = new Analisis();
    
    if($GPC['mov'] == 'rec'){
        $dataRecepcion = $recepcion->listadoAnalisis($ca, null, $id_rec);
        $numero = "ENTRADA NRO: &nbsp;R".$dataRecepcion[0]['numero']."-".$general->date_sql_screen($dataRecepcion[0]['fecha_recepcion'], '', 'es', '');
        if(!$vacio)
            $data = $AnalisisRes->listadoResultados($id_rec, null, null, null, $labR);
    }else{
        $dataRecepcion = $despacho->listadoAnalisisD($ca, $id_rec);
        $numero = "SALIDA NRO: &nbsp;D".$dataRecepcion[0]['numero']."-".$general->date_sql_screen($dataRecepcion[0]['fecha_recepcion'], '', 'es', '');
        if(!$vacio)
            $data = $AnalisisRes->listadoResultados(null, $id_rec, null, null, $labR);
    }
    
    $listadoAnalisis = $AnalisisRes->buscarAC(null, $dataRecepcion[0]['id_cultivo'], $ca, $labAc);
    
    if(!empty($dataRecepcion[0]['id_rec'])) {
        if(!empty($GPC['reimprimir'])){
?>
<script type="text/javascript">
    window.print();
    window.close();
</script>
<?php } ?>
<table id="tabla_reporte" border="0" width="800">
    <tr>
        <td id="titulo_reporte">RESULTADOS DE ANALISIS</td>
    </tr>
    <tr>
        <td><?php echo $numero?></td>
    </tr>
    <tr>
        <td>
            FECHA DE ENTRADA: &nbsp;<?php echo $general->date_sql_screen($dataRecepcion[0]['fecha_recepcion'],'','es','-')?>&nbsp;&nbsp;&nbsp;
            HORA DE ENTRADA:&nbsp;<?php echo $general->hora_sql_normal($dataRecepcion[0]['fecha_recepcion'])?></td>
    </tr>
    <tr>
        <td>CARRIL DE MUESTREO:&nbsp;<?php echo $dataRecepcion[0]['carril']?></td>
    </tr>
    <tr>
        <td>CULTIVO:&nbsp;<?php echo "( ".$dataRecepcion[0]['codigo_cul'].") ".$dataRecepcion[0]['nombre_cul']?></td>
    </tr>
</table>
<table id="tabla_reporte2" width="800" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <th style="border-top: #000000 1px dashed; border-bottom: #000000 1px dashed;">C&Oacute;DIGO</th>
        <th align="left" style="border-top: #000000 1px dashed; border-bottom: #000000 1px dashed;">DESCRIPCION</th>
        <?php for($i=1;$i<=$dataRecepcion[0]['cant_muestras'];$i++){ ?>
        <th style="border-top: #000000 1px dashed; border-bottom: #000000 1px dashed;">MUESTRA <?php echo $i?></th>
        <?php } ?>
    </tr>
    <?php $j = 0; foreach ($listadoAnalisis as $dataAnalisis) { ?>
    <tr>
        <td align="center" id="reporte_fila_separar"><?php echo $dataAnalisis['codigo'] ?></td>
        <td id="reporte_fila_separar"><?php echo $dataAnalisis['nombre'] ?></td>
        <?php for($i=1;$i<=$dataRecepcion[0]['cant_muestras'];$i++){ ?>            
        <td align="center" id="reporte_fila_separar"><div style="border-bottom: #000000 1px solid; width: 100px; text-align: center;"><?php echo $data[$j]['muestra'.$i] = (!empty($data[$j]['muestra'.$i])) ? trim($data[$j]['muestra'.$i]) : $general->caracter(35, '&nbsp;'); ?></div></td>
        <?php } ?>
    </tr>
    <?php $j++; } ?>
    
</table>
<?php
    }else{
        header('location: ../pages/principal.php');
        die();
    }
    require_once("../lib/common/footer_reportes.php");
?>

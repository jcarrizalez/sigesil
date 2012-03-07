<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
    if (empty($GPC['id_rec'])) {
        die('Error');
    }
        
    $id_rec = $GPC['id_rec'];
    $recepcion = new Recepcion();
    $analisisCul = new AnalisisCultivo();
    $AnalisisRes = new Analisis();
    
    //$recepcion->find(array('id'=>$id_rec));
    $dataRecepcion = $recepcion->listadoAnalisis(null, null, $id_rec);
    $listadoAnalisis = $analisisCul->buscarAC(null, $dataRecepcion[0]['id_cultivo'], $idORG);
    $data = $AnalisisRes->listadoResultados($id_rec);

//    echo 'Recepcion';
//    debug::pr($dataRecepcion);
//    
//    echo 'Analisis por Cultivo';
//    debug::pr($listadoAnalisis);
//    
//    echo 'Analisis Resultados';
//    debug::pr($data);
////    echo '<br>';
////    echo print_r($data);
////    echo '</br>';
//    die();
?>
<script type="text/javascript">
    $(document).ready(function(){
        window.print();
        history.back();
        //window.location = '<?=DOMAIN_ROOT?>admin/recepcion.php';
    });
</script>
<div id="titulo_reporte">
    RESULTADOS DE ANALISIS
</div>
<table id="tabla_reporte" border="0" width="100%">
    <tr>
        <td>Entrada Nro: &nbsp;<?=$dataRecepcion[0]['numero']?></td>
    </tr>
    <tr>
        <td>
            Fecha de Entrada: &nbsp;<?=$general->date_sql_screen($dataRecepcion[0]['fecha_recepcion'],'','es','-')?>&nbsp;&nbsp;&nbsp;
            Hora de Entrada:&nbsp;<?=$general->hora_sql_normal($dataRecepcion[0]['fecha_recepcion'])?></td>
    </tr>
    <tr>
        <td>Carril de Muestreo:&nbsp;<?=$dataRecepcion[0]['carril']?></td>
    </tr>
    <tr>
        <td>Cultivo:&nbsp;<?="( ".$dataRecepcion[0]['codigo_cul'].") ".$dataRecepcion[0]['nombre_cul']?></td>
    </tr>
</table>
<table id="tabla_reporte2" width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <th>C&Oacute;DIGO</th>
        <th align="left">DESCRIPCION</th>
        <? for($i=1;$i<=$dataRecepcion[0]['cant_muestras'];$i++){ ?>
        <th>MUESTRA <?=$i?></th>
        <? } ?>
    </tr>
    <? $j = 0; foreach ($listadoAnalisis as $dataAnalisis) { ?>
    <tr id="reporte_fila_separar">
        <td align="center"><?=$dataAnalisis['codigo'] ?></td>
        <td><?=$dataAnalisis['nombre'] ?></td>
        <? for($i=1;$i<=$dataRecepcion[0]['cant_muestras'];$i++){ ?>            
        <td align="center"><? 
            echo $html->input('muestra'.$j.'[]', trim($data[$j]['muestra'.$i]), array('type' => 'text', 'class' => 'reporte_input'));         
        ?></td>
        <? } ?>
    </tr>
    <? $j++; } ?>
    
</table>
<?    
    require_once("../lib/common/footer_reportes.php");
    /*$mpdf=new mPDF();
    $mpdf->WriteHTML($cadena);
    $mpdf->Output('recepcion.pdf','F');
    exit;*/
?>
<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
        
    $Rec=new Recepcion();    
    $analisis=new Analisis();    
    $rechazados=array();
    $nombreMuestra=array(1=>'MOTRIZ', 2=>'REMOLQUE', 3=>'AMBOS');
    
    if (!empty($GPC['id']) && !empty($GPC['es_rechazado'])) {
        $estatus="'".$GPC['estatus']."'";
        $Rechazo=$Rec->listadoRecepcion($GPC['id'], $_SESSION['s_ca_id'], null, null, null,null);     
        $listA=$analisis->listaAnalisis();        
        $s_rechazado = split(':', $GPC['es_rechazado']);
        $i=0;       
        foreach($s_rechazado as $celda) {
            $id_rechazado = split('_', $celda);            
            foreach($listA as $dataAnalisis) {                
                //if ($dataAnalisis['codigo']==$id_rechazado[0]) {
                if ($dataAnalisis['id']==$id_rechazado[0]) {
                    //$listaR=$analisis->listadoResultados($GPC['id'], null,null, "'".$dataAnalisis['codigo']."'");
                    $listaR=$analisis->listadoResultados($GPC['id'], null, "'".$dataAnalisis['id']."'");
                    $rechazados[$i]['nombre']=$dataAnalisis['nombre'];
                    $rechazados[$i]['muestra']=$listaR[0]['muestra'.$id_rechazado[1]];
                    $rechazados[$i]['codigo']=$dataAnalisis['codigo'];
                    $i++;
                }
            }
        }
    $Muestra1=(strpos($GPC['es_rechazado'],'_1:') > 0) ? 1: 0; //Se cambia el rechazado por el aceptado en Muestra1
    $Muestra2=(strpos($GPC['es_rechazado'],'_2:') > 0) ? 2: 0; //Se cambia el rechazado por el aceptado en Muestra2
    if (($Muestra1==0) && ($Muestra2==0)) 
        $Muestra=0;
    elseif ($Muestra1==0) 
        $Muestra=2; 
    elseif ($Muestra2==0) 
        $Muestra=1;
    else 
        $Muestra=3;
    }
    else {
        header("location: ../admin/analisis_resultado_listado.php?msg=error");
        die();
    }
?>
<script type="text/javascript">
window.onload=function() {
    window.print();
    window.location = '<?php echo DOMAIN_ROOT?>admin/analisis_resultado_listado.php?msg=exitoso';
}
</script>
<table id="tabla_reporte" border="0" width="800">
    <tr>
        <td id="titulo_reporte" colspan="3">BOLETA DE RECHAZO</td>
    </tr>
    <tr>
        <td width="200">ENTRADA Nro:</td>
        <td colspan="2">
        <?php
            echo "R".$Rechazo[0]['numero']."-".$general->date_sql_screen($Rechazo[0]['fecha_recepcion'], '', 'es', '');
        ?>
        </td>
    </tr>
    <tr>
        <td width="200">PROPIEDAD DE:</td>        
        <td colspan="2" width="120"><?echo $Rechazo[0]['ced_productor']." ".$Rechazo[0]['productor_nombre']; ?></td>
    </tr>
    <?php if(!empty($Rechazo[0]['ced_asociacion'])){ ?>
    <tr>
        <td width="200">ASOCIACI&Oacute;N:</td>        
        <td width="120"><?echo $Rechazo[0]['ced_asociacion']." ".$Rechazo[0]['asociacion_nombre']; ?></td>
    </tr>
    <?php    
        }
        if(!empty($dataMovimiento[0]['ced_asociado'])){
    ?>
    <tr>
        <td width="200">ASOCIACIADO:</td>
        <td width="120"><?echo $Rechazo[0]['ced_asociado']." ".$Rechazo[0]['asociado_nombre']; ?></td>
    </tr>
    <?php    
        }
    ?>
    <tr>
        <td>PRODUCTO: </td>
        <td colspan="2"><?echo $Rechazo[0]['cultivo_nombre']; ?></td>
    </tr>
    <tr>
        <td>CHOFER: </td>
        <td colspan="2" ><?echo $Rechazo[0]['ced_chofer']." ".$Rechazo[0]['chofer_nombre']; ?></td>
    </tr>
    <tr>
        <td>VEHICULO PLACA: </td>
        <td colspan="2"><?echo $Rechazo[0]['placa']; ?></td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>            
    </tr>
    <tr>
        <td colspan="3">MOTIVO DEL RECHAZO</td>
    </tr>
    <tr>
        <td><?echo 'MUESTRA'; ?></td>
        <td colspan="2"><?echo $nombreMuestra[$Muestra]; ?></td>     
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
    </tr>
    <tr>
        <td colspan="3"><?echo $etiqueta['M_BoletaRechazo']; ?></td>
    </tr>
    <tr>
        <td colspan="3">&nbsp;</td>
    </tr>
<?php 
foreach($rechazados as $dataRechazado) {     
    ?>    
    <tr>    
        <td colspan="2"><?php echo $dataRechazado['codigo'].' - '.$dataRechazado['nombre']; ?></td>
        <td><?php echo $dataRechazado['muestra']; ?></td>
    </tr>
    <?php
    }
?>    
</table>
<table border="0" width="800" style="padding-top: 35px;" class="centrar">
    <tr align="center">
        <td colspan="2"><?php echo str_repeat('_',30)?></td>
        <td><?php echo str_repeat('_',30)?></td>
    </tr>
    <tr align="center">
        <td colspan="2">Fiscal</td>
        <td>Productor/Conductor</td>
    </tr>
</table>
<?php
    require_once("../lib/common/footer_reportes.php");    
?>

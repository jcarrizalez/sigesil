<?php
    require_once("../lib/core.lib.php");
    require_once("../lib/common/header_reportes.php");
    //include("../lib/class/mpdf/mpdf.php");
       
    $Rec=new Recepcion();
    $analisis=new Analisis();    
    $rechazados=array();
    
    if (!empty($GPC['id']) && !empty($_SESSION['s_ca_id']) && !empty($GPC['es_rechazado'])) {
        $estatus="'".$GPC['estatus']."'";
        $Rechazo=$Rec->listadoRecepcion($GPC['id'], $_SESSION['s_ca_id'], null, null, null,null);     
        $listA=$analisis->listaAnalisis();        
        $s_rechazado = split(':', $GPC['es_rechazado']);
        $i=0;       
        foreach($s_rechazado as $celda) {
            $id_rechazado = split('_', $celda);            
            foreach($listA as $dataAnalisis) {                                
                if ($dataAnalisis['codigo']==$id_rechazado[0]) {
                    $listaR=$analisis->listadoResultados($GPC['id'], null,null, $dataAnalisis['codigo']);                    
                    $rechazados[$i]['nombre']=$dataAnalisis['nombre'];
                    $rechazados[$i]['muestra']=$listaR[0]['muestra'.$id_rechazado[1]];
                    $rechazados[$i]['codigo']=$dataAnalisis['codigo'];
                    $i++;
                }
            }
        }               
    }
    else {
        header("location: ../admin/analisis_resultado_listado.php?msg=error&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
        die();
    }
?>
<script type="text/javascript">
    $(document).ready(function(){
        window.print();
        window.location = '<?=DOMAIN_ROOT?>/admin/analisis_resultado_listado.php?msg=exitoso&mov=<?=$_SESSION["s_mov"]?>&lab=<?=$_SESSION["s_lab"]?>';        
    });
</script>
<div id="titulo_reporte">
    BOLETA DE RECHAZO
</div>
<table id="tabla_reporte" border="0" width="100%">
    <tr>
        <td colspan="3"></td>            
    </tr>
    <tr>
        <td align="right" width=200px">PROPIEDAD DE: </td>        
        <td align="left" width="120px"><?echo $Rechazo[0]['ced_productor']; ?></td>
        <td align="left"><?echo $Rechazo[0]['productor_nombre']; ?></td>
    </tr>
    <tr>
        <td align="right">PRODUCTO: </td>
        <td align="left" colspan="3"><?echo $Rechazo[0]['cultivo_nombre']; ?></td>
    </tr>
    <tr>
        <td align="right">CHOFER: </td>
        <td colspan=><?echo $Rechazo[0]['ced_chofer']; ?></td>
        <td colspan=><?echo $Rechazo[0]['chofer_nombre']; ?></td>
    </tr>
    <tr>
        <td align="right">VEHICULO PLACA: </td>
        <td colspan="2"><?echo $Rechazo[0]['placa']; ?></td>
    </tr>
    <tr>
        <td colspan="2"></td>            
    </tr>
    <tr>
        <td colspan="3">MOTIVO DEL RECHAZO</td>
    </tr>
    <tr>
        <td colspan="3"></td>            
    </tr>
    <tr>
        <td colspan="3"><?echo $etiqueta['M_BoletaRechazo']; ?></td>
    </tr>
    <tr>
        <td colspan="3"></td>            
    </tr>
<? 
foreach($rechazados as $dataRechazado) {     
    ?>    
    <tr>    
    <td align="right"><?=$dataRechazado['codigo']; ?></td>
    <td><?=$dataRechazado['nombre']; ?></td>
    <td><?=$dataRechazado['muestra']; ?></td>
    </tr>
    <?
    }
?>    
</table>
<?    
    require_once("../lib/common/footer_reportes.php");
//    $curl_handle=curl_init();
//    curl_setopt($curl_handle,CURLOPT_URL,DOMAIN_ROOT.'reportes/imprimir_boleta_rechazo.php?id=2');
//    $buffer = curl_exec($curl_handle);
//    curl_close($curl_handle);  
//    if (empty($buffer))
//    {
//        print "Sorry, example.com are a bunch of poopy-heads.<p>";
//    }
//    else
//    {
//        print $buffer;
//    } 
?>

<?php
require_once("../lib/core.lib.php");
require_once("../lib/common/header_reportes.php");

$recepcion = new Recepcion();
$recultipo = new Recultipo();

if(!empty($GPC['id_rec'])) {    
    $listaT = $recultipo->find(array('id_recepcion' => $GPC['id_rec']));    
    $listaR=$recepcion->listadoRecepcion($listaT[0]['id_recepcion'], $listaT[0]['id_centro_acopio']);
}
else {
    header("location: admin/analisis_resultado_listado.php?msg=error");
    die();
}
$tipificacion = new Recultipo();

?>
<script type="text/javascript">
window.onload=function() {
    window.print();
    window.location = '<?php echo DOMAIN_ROOT?>admin/analisis_resultado_listado.php?msg=exitoso';
}
</script>
<div id="titulo_reporte">
    BOLETA DE TIPIFICACION 
</div>
<br>
<table id="tabla_reporte" border="0" width="100%">
    <tr>
        <td width="200px">N&Uacute;MERO</td>
        <td width="150px">
            <?php echo $listaR[0]['numero']; ?>
        </td>
    </tr>
    <tr>
        <td >FECHA</td>
        <td><?php echo $general->date_sql_screen($listaR[0]['fecha_recepcion'], '', 'es', '-'); ?></td>
    </tr>
    <tr>
        <td >CHOFER</td>
        <td><?php echo $listaR[0]['ced_chofer']; ?></td>
        <td><?php echo $listaR[0]['chofer_nombre']; ?></td>
    </tr>
    <tr>
        <td >VEHICULOS PLACAS</td>
        <td><?php echo $listaR[0]['placa']; ?></td>
        <td><?php echo $listaR[0]['placa_remolque']; ?></td>
    </tr>
    <tr>
        <td>TOLVA DE DESCARGA</td>
        <td><?php echo $listaR[0]['tolva']; ?></td>
        <td><?php echo $listaT[0]['tipo']; ?></td>
    </tr>
</table>
<table border="0" width="800" style="padding-top: 35px;" class="centrar">
    <tr align="center">
        <td><?php echo str_repeat('_',30)?></td>
        <td><?php echo str_repeat('_',30)?></td>
        <td><?php echo str_repeat('_',30)?></td>
    </tr>
    <tr align="center">
        <td>Fiscal</td>
        <td>Analista</td>
        <td>Productor/Conductor</td>
    </tr>
</table>
<?php    
    require_once("../lib/common/footer_reportes.php");
?>
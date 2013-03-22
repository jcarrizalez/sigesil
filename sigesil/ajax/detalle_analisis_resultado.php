<?php
require_once('../lib/core.lib.php');

$analisis= new Analisis();

$analisis->buscarAC('', $IdCultivo, $idCA, $laboratorio=null);

if ($GPC['tipo_mov']=='R') {
    $recepcion = new Recepcion();
    $estatus='1';
    $listadoM=$recepcion->find(array('estatus_rec' => $estatus));
}

if ($GPC['tipo_mov']=='D') {
    $despacho= new Despacho();
    $estatus='1';
    $listadoM=$despacho->find(array('estatus' => $estatus));
}

?>
<table align="center" width="100%">
    <tr align="center" class="titulos_tabla">            
        <th>Centro de Acopio</th>            
        <th>Nro</th>
        <th>Cultivo</th> 
        <th>Fecha</th>            
        <th>Acci&oacute;n</th>
        <th>Estatus</th>
    </tr>    
    <?php    
    $i=0;
    foreach($listadoM as $mov) {
        $infoCA=$centroAcopio->buscarCA($mov['id_centro_acopio']);
        $infoCosecha=$cosecha->find(array('id' => $mov['id_cosecha']));
        $id_cultivo=$infoCosecha[0]['id_cultivo'];
        $infoCultivo=$cultivo->find(array('id' => $id_cultivo));
        $clase = $general->obtenerClaseFila($i); 
    ?>
    <tr class="<?php echo $clase?>">
        <td><?php echo $infoCA[0]['codigo'].' - '.$infoCA[0]['nombre']; ?></td>
        <td><?php echo $mov['numero']; ?></td>
        <td><?php echo $infoCultivo[0]['codigo'].' - '.$infoCultivo[0]['nombre']; ?></td>
        <td>
        <?php 
        if ($GPC['tipo_mov']=='R')
            echo $general->date_sql_screen($mov['fecha_recepcion']);
        if ($GPC['tipo_mov']=='D')
            echo $general->date_sql_screen($mov['fecha_des']);
        ?>
        </td>
    </tr>
    <?php    
    $i++;
    }
    ?>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
</table>
?>



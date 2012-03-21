<?php
require_once('../lib/core.lib.php');

$centroAcopio=new CentroAcopio();
$cosecha=new Cosecha();
$cultivo=new Cultivo();
$analisis=new Analisis();

$_SESSION['s_mov']=$GPC['mov'];
$_SESSION['s_lab']=$GPC['lab'];

$listaLab = array('C' => 'Lab. Central', 'P' => 'Lab. Planta');

$listaMov = array('rec' => 'RECEPCI&Oacute;N', 'des' => 'DESPACHO');
$listaAccion = array('P' => 'Imprimir');
$fecha_mov=date('d-m-Y');
$idCA=$_SESSION['s_ca_id'];

if ($GPC['mov']=='rec') {
    $recepcion = new Recepcion();
    $estatus="'1','2'";
//    $listadoM=$recepcion->find(array('estatus_rec' => $estatus));   
    //$listadoAnalisis=$recepcion->listadoAnalisis($idCA, null, null, $estatus);
    $listadoM=$recepcion->listadoRecepcion(null, $idCA, null, null, null, $estatus);
}

if ($GPC['mov']=='des') {
    $despacho= new Despacho();
    $estatus='1';
    $listadoM=$despacho->listadoAnalisis($idCA, null, null, $estatus);
    //$listadoM=$despacho->find(array('estatus' => $estatus));
}

require('../lib/common/header.php');
require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#Procesar').click(function(){
            if ($('#lab').val()=='') {
                return;
            } 
            
            if ($('#mov').val()=='') {
                return;
            } 

            if ($('#accion').val()=='') {
                return;
            }
//            if ($('#numero').val()=='') {
//                return;
//            }

//            if ($('#accion').val()=='B') {
//                $('#resultados').load('../ajax/detalle_analisis_resultado.php?lab='+$('#lab').val()+'&mov='+$('#mov').val()+'&accion='+$('#accion').val()+'&id_centro_acopio='+<?=$idCA; ?>);
//            }
        });
        
        //$('.imprimir').css('display','none');
        
        $('#Regresar').click(function(){
           history.back();
        });       
    });
</script>

<div id="mensajes">
    <?
        switch($GPC['msg']){
            case 'exitoso':
                echo "<span class='msj_verde'>Registro Guardado !</span>";
            break;
            case 'error':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
            break;//            $infoCA=$centroAcopio->buscarCA($dataMov['id_centro_acopio']);
//            $infoCosecha=$cosecha->find(array('id' => $dataMov['id_cosecha']));
//            $id_cultivo=$infoCosecha[0]['id_cultivo'];
//            $infoCultivo=$cultivo->find(array('id' => $id_cultivo));
        }
    ?>
</div>
<div id="titulo_modulo">    
    RESULTADOS DE ANALISIS - <? echo $listaMov[$GPC['mov']]; ?><br/><hr/>    
</div> 
<table align="center" width="100%" border="0">
    <tr align="right">
        <td >Fecha:</td>                
        <td><? echo $html->input('fecha', $fecha_mov, array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?>
            <img src="../images/calendario.png" id="fmov" width="16" height="16" style="cursor:pointer" >&nbsp;
            <script>
                Calendar.setup({
                    trigger    : "fmov",
                    inputField : "fecha",
                    dateFormat: "%d-%m-%Y",
                    selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha'])); ?>),
                    onSelect   : function() { this.hide() }
                });
            </script>
        </td>
        <td>N&uacute;mero:</td>
        <td><? echo $html->input('numero', $GPC['numero'], array('type' => 'text', 'class'=>'cuadricula positive')); ?>&nbsp;</td>        
        <td><? echo $html->select('accion', array('options' => $listaAccion, 'selected' => $GPC['accion'], 'default' => 'Seleccione', 'class' => 'crproductor'));?></td>
    </tr>                 
    <tr>
        <td align="right" colspan="6">
            <? echo $html->input('Regresar', 'Regresar', array('type' => 'button')); ?>
        </td>
    </tr>
    <tr>
        <td colspan="6">&nbsp;</td>
    </tr>
</table>
<table align="center" width="100%">
    <tr align="center" class="titulos_tabla">            
        <th>Centro de Acopio</th>            
        <th>Nro</th>
        <th>Cultivo</th> 
        <th>Fecha</th>
        <th>Estatus</th>
        <th>Acci&oacute;n</th>
    </tr>    
    <?    
    $i=0;
    foreach($listadoM as $dataMov) {
        $clase = $general->obtenerClaseFila($i); 
    ?>
    <tr class="<?=$clase?>">
        <td><?= $dataMov['ca_codigo'].' - '.$dataMov['centro_acopio']; ?></td>
        <td><?= $dataMov['numero']; ?></td>
        <td><?= $dataMov['cultivo_codigo'].' - '.$dataMov['cultivo_nombre']; ?></td>
        <td>
        <? 
        if ($GPC['mov']=='rec')
            echo $general->date_sql_screen($dataMov['fecha_recepcion']);
        if ($GPC['mov']=='des')
            echo $general->date_sql_screen($dataMov['fecha_des']);
        ?>
        </td>
        <td align="center">
        <?
        switch ($GPC['mov']) {
            case 'rec':
                switch ($dataMov['estatus_rec']) {
                    case '1':
                        echo '<img src="../images/reloj.png" width="16" height="16" title=Espera />';
                        break;
                    case '2':
                        echo '<img src="../images/cuarentena.png" width="16" height="16" title=Cuarentena />';
                        break;
                }
                break;
        }

        ?>
        </td>
        <td align="center">
        <? 
        switch ($GPC['mov']) {
            case 'rec':
                switch ($dataMov['estatus_rec']) {
                    case '1':
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Nuevo>', 'analisis_resultado.php?ac=nuevo&id='.$dataMov['id'].'&cant_muestras='.$dataMov['cant_muestras'].'&id_cosecha='.$dataMov['id_cosecha']); 
                        break;
                    case '2':
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'cuarentena.php?ac=editar&id='.$dataMov['id']); 
                        break;
                }
                break;
        }
        ?>
        </td>
    </tr>
    <?    
    $i++;
    }
    ?>
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>
</table>

<?
    require('../lib/common/footer.php');
?>
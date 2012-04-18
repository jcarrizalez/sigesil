<?php
require_once('../lib/core.lib.php');

$centroAcopio=new CentroAcopio();
$cosecha=new Cosecha();
$cultivo=new Cultivo();
$analisis=new Analisis();

$listaLab = array('C' => 'Lab. Central', 'P' => 'Lab. Planta');
$listaMov = array('rec' => 'RECEPCI&Oacute;N', 'des' => 'DESPACHO');
$listaAccion = array('B' => 'Buscar');
$fecha_mov=date('d-m-Y');
$idCA=$_SESSION['s_ca_id'];

if (!empty($GPC['mov']))
    $_SESSION['s_mov']=$GPC['mov'];
else 
    $GPC['mov']=$_SESSION['s_mov'];

if (!empty($GPC['lab']))
    $_SESSION['s_lab']=$GPC['lab'];
else
    $GPC['lab']=$_SESSION['s_lab'];

switch ($GPC['mov']) {
    case 'rec':
        $recepcion = new Recepcion();
        $estatus=($_SESSION['s_lab']=='C')? "'1','2'": "'4','5'";        
        $listadoM=$recepcion->listadoRecepcion(null, $idCA, null, null, null, $estatus);
        break;
    case 'des':
        $despacho= new Despacho();
        $estatus="'2'";
        $listadoM=$despacho->listadoDespacho(null, $idCA, null, null, null, $estatus);
        break;
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

            if ($('#Accion').val()=='') {
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
        $('#Accion').change(function(){            
            if ($(this).val()=='') 
                $('#verAccion').css('display','none');            
            else
                $('#verAccion').css('display','block');
            
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
        
        $('#Imprimir').click(function(){
           popupImpresion = window.open('../reportes/imprimir_boleta_rechazo.php', '', 'width=1, height=1, scrollbars=NO');
           popupImpresion.close();
        });
        
        $('#Buscar').click(function(){
            if ($('#Accion').val()=='B') {
                //alert('../ajax/detalle_analisis_buscar.php?codigo='+$('#numero').val()+'&fecha='+$('#fecha').val());
                 $('#idRec').load('../ajax/detalle_analisis_buscar.php?numero='+$('#numero').val()+'&fecha='+$('#fecha').val());                 
            }            
        });
    });
</script>


<div id="titulo_modulo">    
    RESULTADOS DE ANALISIS - <? echo $listaMov[$GPC['mov']]; ?><hr/>    
</div> 
<div id="mensajes">
    <?    
        switch($GPC['msg']){
            case 'exitoso':
                echo "<span class='msj_verde'>Registro Guardado !</span>";
            break;
            case 'error':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
            break;
        }
    ?>
</div>
<div id="idRec" style="display: none"></div>
<table align="center" width="100%" border="0" style="padding-top: 20px">
    <tr>
        <td align="right" >
            <? //echo $html->select('Accion', array('options' => $listaAccion, 'selected' => $GPC['accion'], 'default' => 'Seleccione', 'class' => 'crproductor'));?>
            <? echo $html->input('Regresar', 'Regresar', array('type' => 'button')); ?>
            <? //echo $html->input('Imprimir', 'Imprimir', array('type' => 'button')); ?>
        </td>
    </tr>
    <tr align="center" id="verAccion" align="right" style="display: none">
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
        <td><? echo $html->input('numero', $GPC['numero'], array('type' => 'text', 'class'=>'cuadricula positive')); ?>&nbsp;
        <img src="../images/imprimir.png" id="Buscar" width="16" height="16" style="cursor:pointer" ></td>
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
            echo $general->date_sql_screen($dataMov['fecha_recepcion'],'','es','-');
        if ($GPC['mov']=='des')
            echo $general->date_sql_screen($dataMov['fecha_des'],'','es','-');
        ?>
        </td>
        <td align="center">
        <?
        switch ($GPC['mov']) {
            case 'rec':
                switch ($dataMov['estatus_rec']) {
                    case '1':
                    case '4':
                        echo '<img src="../images/reloj.png" width="16" height="16" title=Espera />';
                        break;
                    case '2':
                        echo '<img src="../images/cuarentena.png" width="16" height="16" title=Cuarentena />';
                        break;
                }
                break;
            case 'des':
                switch ($dataMov['estatus']) {
                    case '2':
                        echo '<img src="../images/reloj.png" width="16" height="16" title=Espera />';
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
                    case '4':
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Nuevo>', 'analisis_resultado.php?ac=nuevo&id='.$dataMov['id'].'&cant_muestras='.$dataMov['cant_muestras'].'&id_cosecha='.$dataMov['id_cosecha']); 
                        break;
                    case '2':
                    case '6':
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'cuarentena.php?ac=editar&id='.$dataMov['id']); 
                    break;                
                }
            case 'des':
                switch ($dataMov['estatus']) {
                    case '2':                    
                        echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Nuevo>', 'analisis_resultado.php?ac=nuevo&id='.$dataMov['id'].'&cant_muestras='.$dataMov['cant_muestras'].'&id_cosecha='.$dataMov['id_cosecha']); 
                        break;             
                }                
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
<?    require('../lib/common/footer.php');
?>

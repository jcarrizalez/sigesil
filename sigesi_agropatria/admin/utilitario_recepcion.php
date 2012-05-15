<?php
    require_once('../lib/core.lib.php');

    $movimiento = new Recepcion();
    /*$cosecha = new Cosecha();
    $vehiculo = new Vehiculo();
    $cultivo = new Cultivo();
    $carril = new Tolcarom();
    $productor = new Productor();*/
    $carril = new Tolcarom();
    
    $idCA=(!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id']: null;
    
    $listadoE = array('1' => '(1) Lab.Central', '2' => '(2) Ctna Lab.Central', '3' => '(3) Romana Lleno', '4' => '(4) Tolvas', '5' => '(5) Ctna Tolva','6' => '(6) Romana Vacio', '7' => '(7) Rechazo Central', '9' => '(9) Recibido',  '11' => '(11) Ctna Lab. Central - Apro.',  '12' => '(12) Ctna Lab. Central-Rech');
    
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['id'])) {
                $infoMov=$movimiento->listadoRecepcion($GPC['id']);
                $listaCarril=$carril->listaTolcarom($idCA, "'2'");
                foreach($listadoE as $clave=>$valor) {
                    if ($clave <= $infoMov[0]['estatus_rec'])
                        $listadoEstatus[$clave]=$valor;
                }
            }
            if (empty($id)) {
                header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
                die();
            }
            break;
        case 'guardar':
            if (!empty($GPC['id'])) {
                $infoMov=$movimiento->find(array('id' => $GPC['id']));
                $id=$infoMov[0]['id'];
            }
        default:
            header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
            die();
            break;
    }
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    function cancelar(){
        window.location = '<?=DOMAIN_ROOT?>admin/utilitario_recepcion_listado.php';
    }
    
    $(document).ready(function(){
        $('.positive').numeric();        
        
        $('#Recepcion_codigo').change(function(){
            $('#cultivo_nombre').load('../ajax/detalle_utilitario.php?ac=cosecha&codigo='+$('#Recepcion_codigo').val());
        });
        
        $('#Recepcion_productor').change(function(){
            $('#productor_nombre').load('../ajax/detalle_utilitario.php?ac=productor&cosecha='+$('#id_cosecha').val()+'&cedRif='+$('#Recepcion_productor').val());
        });
        
        $('#Recepcion_asociacion').change(function(){
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#id_cosecha').val()+'&cedRifP='+$('#Recepcion_productor').val()+'&cedRif='+$('#Recepcion_asociacion').val());
        });
        
        $('#Recepcion_asociado').change(function(){
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#id_cosecha').val()+'&cedRifP='+$('#Recepcion_productor').val()+'&cedRifAon='+$('#Recepcion_asociacion').val()+'&cedRif='+$('#Recepcion_asociado').val());
        });
        
        $('#Recepcion\\[numero\\]').change(function(){
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=n");
        });
        
        $('#Recepcion\\[fecha_recepcion\\]').change(function(){
            $('#fecha_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&fecha='+$('#Recepcion\\[fecha_recepcion\\]').val()+"&numero="+$('#Recepcion\\[numero\\]').val()+"&tipo=f");
        });
        
        $('#Recepcion_placa').change(function(){
            $('#vehiculo_descrip').load('../ajax/detalle_utilitario.php?ac=vehiculo&placa='+$('#Recepcion_placa').val());
        });
    });
</script>
<div id="titulo_modulo">
    UTILITARIO - RECEPCION<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <fieldset id="cosecha_unica">
        <legend>Datos de la Recepcion</legend>
    <table align="center" border="0">
        <tr>
            <td>Cosecha</td>
            <td>
            <? echo $html->input('Recepcion_codigo', $infoMov[0]['cosecha_codigo'], array('type' => 'text', 'class' => 'crproductor')); ?>
            </td>
            <td width="230px">
                <div id='cultivo_nombre'>
                <span><? echo $infoMov[0]['cultivo_nombre'];?></span>
                </div>
            </td>
        </tr>
        <tr>
            <td>Productor</td>
            <td>
            <? echo $html->input('Recepcion_productor', $infoMov[0]['ced_productor'], array('type' => 'text', 'class' => 'crproductor')); ?>
            </td>
            <td id="productor_nombre" width="250px"><? echo $infoMov[0]['productor_nombre']; ?></td>
        </tr>
        <tr>
            <td>Asociacion</td>
            <td>
            <? echo $html->input('Recepcion_asociacion', $infoMov[0]['ced_asociacion'], array('type' => 'text', 'class' => 'crproductor')); ?>
            </td>
            <td id="asociacion_nombre" width="250px"><? echo $infoMov[0]['asociacion_nombre']; ?></td>
        </tr>
        <tr>
            <td>Asociado</td>
            <td>
            <? echo $html->input('Recepcion_asociado', $infoMov[0]['ced_asociado'], array('type' => 'text', 'class' => 'crproductor')); ?>
            <td id="asociado_nombre" width="250px"><? echo $infoMov[0]['asociado_nombre']; ?></td>
        </tr>
        <tr>
            <td>Nro Entrada</td>
            <td><? echo $html->input('Recepcion.numero', $infoMov[0]['numero'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
            <td width="230x">
                <div id="numero_msg">                  
                </div>
            </td>
        </tr>
        <tr>
            <td>Fecha de Recepcion</td>
            <td><? echo $html->input('Recepcion.fecha_recepcion', $general->date_sql_screen($infoMov[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor')); ?>
                <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                <script>
                    Calendar.setup({
                        trigger    : "femision",
                        inputField : "Recepcion[fecha_recepcion]",
                        dateFormat: "%d-%m-%Y",
                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoMov[0]['Recepcion[fecha_recepcion]']));?>),
                        onSelect   : function() { this.hide() }
                    });
                </script>
            </td>
            <td width="230px">
                <div id="fecha_msg">                  
                </div>
            </td>
        </tr>
        <tr>
            <td>Placa del Vehiculo</td>
            <td><? echo $html->input('Recepcion_placa', $infoMov[0]['placa'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
            <td width="230px">
                <div id="vehiculo_descrip">
                    <span><? echo $infoVeh[0]['marca'].' '.$infoMov[0]['color']; ?></span>
                </div>
            </td>
        </tr>
        <tr>
            <td>Peso lleno 1</td>
            <td><? echo $html->input('Recepcion.peso_01l', $infoMov[0]['peso_01l'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vacio 1</td>
            <td><? echo $html->input('Recepcion.peso_01v', $infoMov[0]['peso_01v'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso lleno 2</td>
            <td><? echo $html->input('Recepcion.peso_02l', $infoMov[0]['peso_02l'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vacio 2</td>
            <td><? echo $html->input('Recepcion.peso_02v', $infoMov[0]['peso_02v'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Desc Humedad</td>
            <td><? echo $html->input('Recepcion.humedad_des', $infoMov[0]['humedad_des'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Desc Impureza</td>
            <td><? echo $html->input('Recepcion.impureza_des', $infoMov[0]['impureza_des'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Nro Carril</td>
            <td><? echo $html->input('Recepcion.carril', $infoMov[0]['carril'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
        </tr>
        <tr>
            <td>Estatus</td>
            <td><? echo $html->select('Recepcion.estatus_rec',array('options'=>$listadoEstatus, 'selected' => $infoMov[0]['estatus_rec'], 'default' => 'Seleccione'));?></td>
            <td><? //echo $html->input('Recepcion.estatus_rec', $infoMov[0]['estatus_rec'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
        </tr>
    </table>
    <? echo $html->input('id_cosecha', $infoMov[0]['id_co'], array('type' => 'hidden')); ?>
    </fieldset>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">            
            <td colspan="3">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>        
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
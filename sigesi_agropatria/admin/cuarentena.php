<?
require_once('../lib/core.lib.php');

$Ctna = new Cuarentena();
$Cultivos = new Cultivo();
$Rec = new Recepcion();
$Vehiculos = new Vehiculo();
$Guias = new Guia();
$Plagas = new Plaga();
$Productos = new Producto();
$usuario = new Usuario();


$listaCultivos = $Cultivos->find('', null, array('id', 'nombre'), 'list', 'id');
$listaPlagas = $Plagas->find('', null, array('id', 'nombre'), 'list', 'id');
$listaProductos = $Productos->find('', null, "id, nombre || ' (' || presentacion || ')' as nombre", 'list', 'id');
$laboratorio = array(2 => '40tna. lab');

$id=(!empty($GPC['id'])) ? $GPC['id']: $GPC['Cuarentena']['id']; 

switch ($GPC['ac']) {
    case 'editar':
//        if (!empty($id)) {
            $infoCtna = $Ctna->find(array('id_recepcion' => $id));
            if ($infoCtna->id) {
                header("location: analisis_recepcion_listado.php?msg=error");
                die();
            }
            $infoRecepcion = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
            $infoVehiculo = $Vehiculos->find(array('id' => $infoRecepcion[0]['id_vehiculo']));
            $infoGuia = $Guias->find(array('id' => $infoRecepcion[0]['id_guia']));
//        }
//        else 
//            header("location: analisis_recepcion_listado.php?msg=error");
        break;
    case 'guardar': 
        if (!empty($id)) {
            $infoCtna = $Ctna->find(array('id_recepcion' => $id));
            $id_cuarentena=$infoCtna[0]['id'];
            if ($infoCtna->id) {
                header("location: analisis_recepcion_listado.php?msg=error");
                die();
            }            
            $Ctna->_begin_tool();
            $GPC['Cuarentena']['id']=$id_cuarentena;
            $GPC['Cuarentena']['fecha_mov']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_mov'],'es');
            $GPC['Cuarentena']['fecha_cultivo']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_cultivo'],'es');
            $GPC['Cuarentena']['fecha_lib']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_lib'],'es');
            $GPC['Cuarentena']['estatus']='2'; //Se fija el estatus 2 la primera vez que se registra
            $Ctna->save($GPC['Cuarentena']);
            $Ctna->_commit_tool();
            if ($Ctna->id) {                
                header("location: analisis_recepcion_listado.php?msg=exitoso");
                die();
            }
            else {
                $Ctna->_rollback_tool();
                header("location: analisis_recepcion_listado.php?msg=error");
                die();
                }
        }
        else  {
            header("location: analisis_recepcion_listado.php?msg=error");
            die();
            }
        break;
}
require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

//$validator = new Validator('form1');
//$validator->printIncludes();
//$validator->setRules('Almacen.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
//
//$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'analisis_recepcion_listado.php';
    }
    
    function sumarFecha(fecha1, fecha2) {        
        parte1=fecha1.split('-');
        parte2=fecha1.split('-');
        for(var i = 0; i < parte1.length; i++) {            
            parte1[i] = parseInt(parte1[i], 10);            
            parte2[i] = parseInt(parte2[i], 10);
        }
        var fechaTotal1=new Date(parte1[2], parte1[1]-1, parte1[0]);
        var fechaTotal2=new Date(parte2[2], parte2[1]-1, parte2[0]);
        
        return fechaTotal1+fechaTotal2;        
    }
  
    $(document).ready(function(){ 
        $('#Cuarentena\\[hora_trab\\]').change(function() {            
            var horatotal=new Date()

            var fecha1= new Date();
            if ($('#Cuarentena\\[hora_trab\\]').val()=='') {
                return;
            }           
            fecha_cultivo= $('#Cuarentena\\[fecha_cultivo\\]').val();
            Fecha1=fecha_cultivo.split('-');
            Dia=isNaN(parseInt(Fecha1[0])) ? 0: parseInt(Fecha1[0]);            
            Mes=isNaN(parseInt(Fecha1[1])) ? 0: parseInt(Fecha1[1]-1);
            Ano=isNaN(parseInt(Fecha1[2])) ? 0: parseInt(Fecha1[2]);            
            horatotal.setDate(Dia);
            horatotal.setMonth(Mes);
            horatotal.setFullYear(Ano);
            hora_trab= $('#Cuarentena\\[hora_trab\\]').val();
            Hora1=hora_trab.split(':');
            Min1=Hora1[1].split(' ');            
            h=isNaN(parseInt(Hora1[0])) ? 0: parseInt(Hora1[0]);
            m=isNaN(parseInt(Min1[0])) ? 0: parseInt(Min1[0]);
            p=(Min1[1]=='am') ? 0: 12;
            meridiano=Min1[1];            
            h=h+40;
            horatotal.setHours(h);
            horatotal.setMinutes(m);
            horatotal.setSeconds(0);            
            horaF=(horatotal.getHours() < 10) ? '0'+horatotal.getHours(): ''+horatotal.getHours();
            minF=(horatotal.getMinutes() < 10) ? '0'+horatotal.getMinutes(): ''+horatotal.getMinutes();
            diaF=(horatotal.getDate()<10) ? '0'+horatotal.getDate(): horatotal.getDate();
            mesF=(Mes < 10) ? '0'+(horatotal.getMonth()+1): ''+(horatotal.getMonth()+1);
            //alert('diaF: '+diaF+' Dia: '+Dia);
            $('#Cuarentena\\[fecha_lib\\]').val(diaF+'-'+mesF+'-'+horatotal.getFullYear());
            $('#Cuarentena\\[hora_lib\\]').val(horaF+':'+minF+' '+meridiano);
        });

        $('#Cuarentena\\[hora_trab\\]').timepicker({
            ampm: true,
            timeOnlyTitle: "Seleccione Hora",
            timeText: "Tiempo",
            hourText: "Hora",
            minuteText: "Minuto",
            secondText: "Segundo",
            millisecText: "Milisegundo",
            currentText: "Ahora",
            closeText: "Cerrar"
        });   
        
//        $('#Cuarentena\\[fecha_lib\\]').AnyTime.picker(
//            { format: "%H:%i", labelTitle: "Hora",
//            labelHour: "Hora", labelMinute: "Minuto" } );
        
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('.calcular_dosis').change(function() {
            id_producto=$('#Cuarentena\\[id_producto\\]').val();
            toneladas=$('#Cuarentena\\[toneladas\\]').val();
            if (id_producto!='' && toneladas!='')  {
                $('#calculo').load('../ajax/cuarentena_calculo.php?ac=cal&id_producto='+id_producto+'&toneladas='+toneladas);
            }
        });
        
    });
    
    function verificar_fecha(){
        if ($('#Cuarentena\\[fecha_mov\\]').val()=='')
            return;
        
        sFechaMov=$('#Cuarentena\\[fecha_mov\\]').val();
        var aFechaMov = sFechaMov.split("-");
        diaMov=aFechaMov[0];
        mesMov=aFechaMov[1];
        anoMov=aFechaMov[2];
        var fechaMov = new Date(anoMov, mesMov, diaMov);

        if ($('#Cuarentena\\[fecha_cultivo\\]').val()=='')
            return;
        
        sFechaCul=$('#Cuarentena\\[fecha_cultivo\\]').val();
        var aFechaCul = sFechaCul.split("-");
        diaCul=aFechaCul[0];
        mesCul=aFechaCul[1];
        anoCul=aFechaCul[2];
        var fechaCul = new Date(anoCul, mesCul, diaCul);
        if (fechaMov.getTime()>fechaCul.getTime()) {            
            $('#Cuarentena\\[fecha_cultivo\\]').val(sFechaMov);
        }
        $('#Cuarentena\\[hora_trab\\]').change();
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cuarentena.id', $GPC['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cuarentena.id_usuario', $_SESSION['s_id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cuarentena.estatus', '2', array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CUARENTENA<br/><hr/>
    </div>    
    <fieldset>    
        <legend>Datos del Vehiculo</legend>
        <table align="center" border="0">
            <tr>
                <td align="left">Nro. Entrada:</td>
                <td><? echo $html->input('Recepcion.numero', $infoRecepcion[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos cuadricula', 'readOnly' => true)); ?></td>
                <td align="left">Fecha</td>
                <td><? echo $html->input('Cuarentena.fecha_mov', $general->date_sql_screen($infoCtna[0]['fecha_mov'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="3"><? echo $html->select('Cuarentena.id_cultivo', array('options' => $listaCultivos, 'selected' => $infoCtna[0]['id_cultivo'], 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Kilogramos Aprox.</td>
                <td><? echo $html->input('', $infoGuia[0]['kilogramos'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
            </tr>
            <tr>
                <td>Vehiculo Placa:</td>
                <td><? echo $html->input('', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td>Placa Rem:</td>            
                <td><? echo $html->input('', $infoGuia[0]['placa_remolques'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Chofer Cedula:</td>
                <td><? echo $html->input('', $infoGuia[0]['cedula_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td>Chofer Nombre:</td>
                <td><? echo $html->input('', $infoGuia[0]['nombre_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Laboratorio:</td>

            </tr>
        </table>        
    </fieldset>
    <fieldset>    
        <legend>Datos del Fumigaci&oacute;n</legend>
        <table align="center" border="0">
            <tr>
                <td>Insectos:</td>
                <td colspan="3"><? echo $html->select('Cuarentena.id_plaga', array('options' => $listaPlagas, 'selected' => $infoCtna[0]['id_plaga'], 'default' =>'Seleccione')); ?></td>
            </tr>
            <tr>
                <td>Producto:</td>
                <td colspan="3"><? echo $html->select('Cuarentena.id_producto', array('options' => $listaProductos, 'selected' => $infoCtna[0]['id_producto'], 'default' =>'Seleccione', 'class'=>'calcular_dosis')); ?></td>
            </tr>
            <tr>
                <td>Toneladas Aprox.</td>
                <td><? echo $html->input('Cuarentena.toneladas', $infoCtna[0]['toneladas'], array('type' => 'text', 'class' => 'crproductor calcular_dosis positive')); ?></td>
                <td>Dosis Estimada:</td>
                <td id="calculo"><? echo $html->input('Cuarentena.cant_producto', $infoCtna[0]['cant_producto'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor positive')); ?></td>
            </tr>
            <tr>
                <td>Fecha Fumigaci&oacute;n:</td>
                <td><? echo $html->input('Cuarentena.fecha_cultivo', $general->date_sql_screen($infoCtna[0]['fecha_cultivo'], '', 'es', '-'), array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?>
            <img src="../images/calendario.png" id="fcultivo" width="16" height="16" style="cursor:pointer" />
            <script>
                Calendar.setup({
                    trigger    : "fcultivo",
                    inputField : "Cuarentena[fecha_cultivo]",
                    dateFormat: "%d-%m-%Y",
                    selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoCtna[0]['fecha_cultivo  '])); ?>),
                    onSelect   : function() { verificar_fecha(); this.hide() }
                });
            </script>
            </td>
            <td>Hora Fumigaci&oacute;n:</td>
            <td><? echo $html->input('Cuarentena.hora_trab', $infoCtna[0]['hora_trab'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
            </tr>
            <tr>
                <td>Fecha Liberaci&oacute;n:</td>                
                <td><? echo $html->input('Cuarentena.fecha_lib', $general->date_sql_screen($infoCtna[0]['fecha_lib'],'','es','-'), array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
                <td>Hora Liberaci&oacute;n:</td>
                <td><? echo $html->input('Cuarentena.hora_lib', $infoCtna[0]['hora_lib'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>                
            </tr>               
        </table>
    </fieldset>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>                
                <?
                if ($GPC['estatus']=='liberar')
                    echo $html->input('Liberar', 'Liberar', array('type' => 'button')); 
                else if ($GPC['estatus']=='rechazar')
                    echo $html->input('Rechazar', 'Rechazar', array('type' => 'button')); 
                else
                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); 
                ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>        
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
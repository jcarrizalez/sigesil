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
$listaProductos = $Productos->find('', null, array('id', 'nombre'), 'list', 'id');
$listaUsuarios = $usuario->find('', null, array('id', 'nombre'), 'list', 'id');

//print_r($listaUsuarios);

$laboratorio = array(2 => '40tna. lab');

//echo 'id: '.$GPC['id'];
switch ($GPC['ac']) {
    case 'editar':
        $infoCtna = $Ctna->find(array('id' => $GPC['id']));
        $infoRecepcion = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
        $infoVehiculo = $Vehiculos->find(array('id' => $infoRecepcion[0]['id_vehiculo']));
        $infoGuia = $Guias->find(array('id' => $infoRecepcion[0]['id_guia']));
//        print_r($infoVehiculo);
//        die();
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
        window.location = 'curentena_listado.php';
    }
    
    $(document).ready(function(){       

        /*$('#Cuarentena\\[fecha_cultivo\\]').change(function() {
            sFechaMov=$('#Cuarentena\\[fecha_mov\\]').val();
        });*/

//        $('#Cuarentena\\[hora_lib\\]').keyup(function() {
//            alert('Handler for .keyup() called.');
//        });

        $('#Cuarentena\\[hora_trab\\]').change(function() {
            var hora_trab= $('#Cuarentena\\[hora_trab\\]').val();
            var Hora1=hora_trab.split(':');
            var Min1=Hora1[1].split(' ');            
            
            var h=isNaN(parseInt(Hora1[0])) ? 0: parseInt(Hora1[0]);
            var m=isNaN(parseInt(Min1[0])) ? 0: parseInt(Min1[0]);
            
            var h=h+40;
            
            horatotal=new Date()
            horatotal.setHours(h);
            horatotal.setMinutes(m);
            
            $('#Cuarentena\\[hora_lib\\]').val(horatotal.getHours()+":"+horatotal.getMinutes()+":"+horatotal.getSeconds());
            
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
    });
    
    function verificar_fecha(){
        sFechaMov=$('#Cuarentena\\[fecha_mov\\]').val();
        var aFechaMov = sFechaMov.split("-");
        diaMov=aFechaMov[0];
        mesMov=aFechaMov[1];
        anoMov=aFechaMov[2];
        var fechaMov = new Date(anoMov, mesMov, diaMov);

        sFechaCul=$('#Cuarentena\\[fecha_cultivo\\]').val();
        var aFechaCul = sFechaCul.split("-");
        diaCul=aFechaCul[0];
        mesCul=aFechaCul[1];
        anoCul=aFechaCul[2];
        var fechaCul = new Date(anoCul, mesCul, diaCul);
        if (fechaMov.getTime()>fechaCul.getTime()) {            
            $('#Cuarentena\\[fecha_cultivo\\]').val(sFechaMov);
        }
        
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <td><? echo $html->input('Cuarentena.id', $infoCtna[0]['id'], array('type' => 'hidden')); ?></td>    
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
                <td colspan="3"><? echo $html->select('Cuarentena.id_cultivo', array('options' => $listaCultivos, 'selected' => $infoCtna[0]['id_cultivo'])); ?></td>
            </tr>
            <tr>
                <td>Kilogramos Aprox.</td>
                <td><? echo $html->input('Cuarentena.toneladas', $infoCtna[0]['toneladas'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
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
                <td colspan="3"><? echo $html->select('Cuarentena.id_plaga', array('options' => $listaPlagas, 'selected' => $infoCtna[0]['id_plaga'])); ?></td>
            </tr>
            <tr>
                <td>Producto:</td>
                <td colspan="3"><? echo $html->select('Cuarentena.id_producto', array('options' => $listaProductos, 'selected' => $infoCtna[0]['id_producto'])); ?></td>
            </tr>
            <tr>
                <td>Toneladas Aprox.</td>
                <td><? echo $html->input('Cuarentena.toneladas', $infoCtna[0]['toneladas'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
                <td>Dosis Estimada:</td>
                <td><? echo $html->input('Cuarentena.cant_producto', $infoCtna[0]['cant_producto'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
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
                <td><? echo $html->input('Cuarentena.fecha_lib', $infoCtna[0]['fecha_lib'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
                <td>Hora Liberaci&oacute;n:</td>
                <td><? echo $html->input('Cuarentena.hora_lib', $infoCtna[0]['hora_lib'], array('type' => 'text', 'class' => 'crproductor')); ?></td>                
            </tr>
            <tr>
                <td>Analista Supervisor:</td>
                <td colspan="3"><? echo $html->select('Cuarentena.id_usuario', array('options' => $listaUsuarios, 'selected' => $infoCtna[0]['id_usuario'])); ?></td>
            </tr>
            <tr>
            </tr>                
        </table>
    </fieldset>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>                
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>                
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>        
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
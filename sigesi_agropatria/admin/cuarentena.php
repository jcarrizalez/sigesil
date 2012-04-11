<?
require_once('../lib/core.lib.php');

$Ctna = new Cuarentena();
$Rec = new Recepcion();
$Guias = new Guia();
$Cultivos = new Cultivo();
$Vehiculos = new Vehiculo();
$Plagas = new Plaga();
$Productos = new Producto();
$analisis=new Analisis();

$listaCultivos = $Cultivos->find('', null, array('id', 'nombre'), 'list', 'id');
$listaPlagas = $Plagas->find('', null, array('id', 'nombre'), 'list', 'id');
$listaProductos = $Productos->find('', null, "id, nombre || ' (' || presentacion || ')' as nombre", 'list', 'id');
$laboratorio = array(2 => '40tna. lab');
$estatusCtna=array('','2','5');
$idCA=(!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id']: null;

$id=(!empty($GPC['id'])) ? $GPC['id']: ''; 
$soloLectura=true;

switch ($GPC['ac']) {
    case 'editar':
        if (!empty($GPC['id'])) {
            $id=$GPC['id'];
            if ($_SESSION['s_mov']=='rec') {                
                $infoCtna = $Ctna->find(array('id_recepcion' => $id));
                $id_cuarentena=$infoCtna[0]['id']; 
                $listaCP = $Ctna->listadoPlaga($idCA, $id_cuarentena, $GPC['id']);
                $insectoCtna=array();
//                count($listaCP);
                if (!empty($id_cuarentena)) {                    
                    $infoRecepcion = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
                    $infoVehiculo = $Vehiculos->find(array('id' => $infoRecepcion[0]['id_vehiculo']));
                    $infoGuia = $Guias->find(array('id' => $infoRecepcion[0]['id_guia']));
                }
            }
            else {
                $infoCtna = $Ctna->find(array('id_despacho' => $id));
                $infoDespacho = $despacho->find(array('id' => $infoCtna[0]['id_despacho']));                
            }
            $id_cuarentena=$infoCtna[0]['id'];            
            $soloLectura=(empty($infoCtna[0]['estatus'])) ? false: true;
        }
        if (empty($id_cuarentena)) {
            header("location: ../admin/analisis_resultado_listado.php?msg=error&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
            die();
        }
        break;
    case 'guardar':
         if (!empty($GPC['id'])) {
            $id=$GPC['id'];
            if ($_SESSION['s_mov']=='rec') 
                $infoCtna = $Ctna->find(array('id_recepcion' => $id));
            else
                $infoCtna = $Ctna->find(array('id_despacho' => $id));            
            $id_cuarentena=$infoCtna[0]['id'];
            $Ctna->_begin_tool();
            $GPC['Cuarentena']['id']=$id_cuarentena;
            $GPC['Cuarentena']['fecha_mov']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_mov'],'es');
            $GPC['Cuarentena']['fecha_cultivo']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_cultivo'],'es');
            $GPC['Cuarentena']['fecha_lib']=$general->fecha_normal_sql($GPC['Cuarentena']['fecha_lib'],'es');
            if ($_SESSION['s_mov']=='rec')
                if ($_SESSION['s_lab']=='C')
                    $GPC['Cuarentena']['estatus']='2'; //Se fija el estatus 2 la primera vez que se registra
                else if ($_SESSION['s_lab']=='P') 
                    $GPC['Cuarentena']['estatus']='5'; //Se fija el estatus 2 la primera vez que se registra
            if (empty($infoCtna[0]['estatus'])) {
                $Ctna->save($GPC['Cuarentena']);
                for ($j=0; $j < $GPC['tipoInsecto']; $j++) {
                    $GPC['Plaga']['id_cuarentena']=$id_cuarentena;
                    $GPC['Plaga']['id_plaga']=$GPC['dataCP_id_'.$j];
                    $GPC['Plaga']['cantidad']=$GPC['dataCP_cantidad_'.$j];
                    $Ctna->guardarPlaga($GPC['Plaga']);
                }
            }
            else
                $id_cuarentena=null;
         }
        if ($id_cuarentena) {
            $Ctna->_commit_tool();
            header("location: analisis_resultado_listado.php?msg=exitoso&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
            die();
        }
        header("location: ../admin/analisis_resultado_listado.php?msg=error&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
        die();
        break;
    case 'liberar':
        if (!empty($GPC['id'])) {
            $id=$GPC['id'];
            //Asignacion de Nuevo estatus luego de Liberar
            if ($_SESSION['s_mov']=='rec')
                if ($_SESSION['s_lab']=='C')
                    $estatus='3';
                else if ($_SESSION['s_lab']=='P')
                        $estatus='6';
            if ($_SESSION['s_mov']=='rec') {                
                $infoCtna = $Ctna->find(array('id_recepcion' => $id));
                //Estatus Anterior
                $estatusA=$infoCtna[0]['estatus'];
                $infoRecepcion = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
                $GPC['Recepcion']['id']=$GPC['id'];
                $GPC['Recepcion']['estatus_rec']=$estatus;
                $Ctna->_begin_tool();
                $Rec->save($GPC['Recepcion']);
                $GPC['Cuarentena']['id']=$GPC['id'];
                $GPC['Cuarentena']['estatus']=$estatus;
                $id_cuarentena=$Ctna->save($GPC['Cuarentena']);
            }                
        }
        if (!empty($id_cuarentena) && (in_array($estatusA, $estatusCtna))) {            
            $Ctna->_commit_tool();
            header("location: ../admin/analisis_resultado_listado.php?msg=existoso&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);        
            die();            
        }
        $Ctna->_rollback_tool();
        header("location: ../admin/analisis_resultado_listado.php?msg=error&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
        die();
    break;        
    case 'rechazar':
        if (!empty($GPC['id'])) {            
            $id=$GPC['id'];
            //Asignacion de Nuevo estatus luego de Rechazar
            if ($_SESSION['s_mov']=='rec')
                if ($_SESSION['s_lab']=='C')
                    $estatus='7';
                else if ($_SESSION['s_lab']=='P')
                        $estatus='8';
            else
                $estatus='4';            
            $Ctna->_begin_tool();
            if ($_SESSION['s_mov']=='rec') {
                $infoCtna = $Ctna->find(array('id_recepcion' => $id));
                $id_cuarentena=$infoCtna[0]['id'];
                $estatusA=$infoCtna[0]['estatus'];
                $infoRecepcion = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
                $GPC['Recepcion']['id']=$GPC['id'];
                $GPC['Recepcion']['estatus_rec']=$estatus;                
                $Rec->save($GPC['Recepcion']);
            }
            else
                $infoCtna = $Ctna->find(array('id_despacho' => $id));
            $GPC['Cuarentena']['id']=$GPC['id'];
            $GPC['Cuarentena']['estatus']=$estatus;
            $id_cuarentena=$Ctna->save($GPC['Cuarentena']);         
        }
        if (!empty($id_cuarentena) && (in_array($estatusA, $estatusCtna))) {            
                $Ctna->_commit_tool();
                $id_analisis=$infoCtna[0]['id_analisis'];
                $listA=$analisis->listaAnalisis($id_analisis);
                $GPC['es_rechazado']="0_0:".$listA[0]['codigo'];
                header("location: ../reportes/imprimir_boleta_rechazo.php?id=". $GPC['id']."&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']."&es_rechazado=".$GPC['es_rechazado']);
                die();

        }
        $Ctna->_rollback_tool();
        header("location: analisis_resultado_listado.php?msg=error&mov=".$_SESSION['s_mov']."&lab=".$_SESSION['s_lab']);
        die();
    break;
}

require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->setRules('Cuarentena.id_plaga', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.id_producto', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.toneladas', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.cant_producto', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.fecha_cultivo', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.hora_trab', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.fecha_lib', array('required' => array('value' => true, 'message' => '')));
$validator->setRules('Cuarentena.hora_lib', array('required' => array('value' => true, 'message' => '')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = '<?=DOMAIN_ROOT?>/admin/analisis_resultado_listado.php?mov=<?=$_SESSION["s_mov"]?>&lab=<?=$_SESSION["s_lab"]?>';
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
            var horaTrab=$(this).val().toUpperCase();
            hora=horaTrab.split(' ');
            horaMin=hora[0].split(':');            
            fechaCultivo= $('#Cuarentena\\[fecha_cultivo\\]').val();
            fecha=fechaCultivo.split('-');
            var fechaLib=new Date(fecha[2],fecha[1]-1,fecha[0]);
            
            horaMil=parseInt(horaMin[0]);
            switch (hora[1].toUpperCase()) {
                case 'AM':
                    switch (horaMin[0]) {
                        case '01':
                            horaMil=1;
                            break;
                        case '02':
                            horaMil=2;
                            break;
                        case '03':
                            horaMil=3;
                            break;
                        case '04':
                            horaMil=4;
                            break;
                        case '05':
                            horaMil=5;
                            break;
                        case '06':
                            horaMil=6;
                            break;
                        case '07':
                            horaMil=7;
                            break;
                        case '08':
                            horaMil=8;
                            break;
                        case '09':
                            horaMil=9;                            
                            break;
                        case '10':
                            horaMil=10;
                            break;
                        case '11':
                            horaMil=11;
                            break;
                        case '12':
                            horaMil=0;
                            break;
                    }
                    break;
                case 'PM':
                    switch (horaMin[0]) {
                        case '01':
                            horaMil=13;
                            break;
                        case '02':
                            horaMil=14;
                            break;
                        case '03':
                            horaMil=15;
                            break;
                        case '04':
                            horaMil=16;
                            break;
                        case '05':
                            horaMil=17;
                            break;
                        case '06':
                            horaMil=18;
                            break;
                        case '07':
                            horaMil=19;
                            break;
                        case '08':
                            horaMil=20;
                            break;
                        case '09':
                            horaMil=21;
                            break;
                        case '10':
                            horaMil=22;
                            break;
                        case '11':
                            horaMil=23;
                            break;
                        case '12':
                            horaMil=12;
                            break;
                    }
                    break;                    
            }
            fechaLib.setHours(horaMil);
            fechaLib.setMinutes(parseInt(horaMin[1]));
            curentena=40;
            fechaLib.setTime(fechaLib.getTime()+1000*60*60*curentena); 
            
            horaF=''+fechaLib.getHours();
            meridiano=' AM';
            if (fechaLib.getHours() < 1) {
                horaF=''+(fechaLib.getHours()+12);
                meridiano=' AM';
            }
            else if (fechaLib.getHours()<10) {
                horaF='0'+fechaLib.getHours();
                meridiano=' AM';
            }
            else if (fechaLib.getHours()>12) {
                if ((fechaLib.getHours()-12) < 10) 
                    horaF='0'+(fechaLib.getHours()-12);                
                else
                    horaF=''+(fechaLib.getHours()-12);
                meridiano=' PM';
            }
            minF=(fechaLib.getMinutes() < 10) ? '0'+fechaLib.getMinutes(): ''+fechaLib.getMinutes();           
            diaF=(fechaLib.getDate()<10) ? '0'+fechaLib.getDate(): fechaLib.getDate();
            mesF=(fechaLib.getMonth() < 10) ? '0'+(fechaLib.getMonth()+1): ''+(fechaLib.getMonth()+1);
            
            $('#Cuarentena\\[fecha_lib\\]').val(diaF+'-'+mesF+'-'+fechaLib.getFullYear());
            $('#Cuarentena\\[hora_lib\\]').val(horaF+':'+minF+meridiano);
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
        
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('.calcular_dosis').change(function() {
            id_producto=$('#Cuarentena\\[id_producto\\]').val();
            toneladas=$('#Cuarentena\\[toneladas\\]').val();
            if (id_producto!='' && toneladas!='')  {
                $('#calculo').load('../ajax/cuarentena_calculo.php?ac=cal&id_producto='+id_producto+'&toneladas='+toneladas);
            }
        });
        
        $('#Rechazar').click(function() {
            if (confirm('EL MOVIMIENTO SERA RECHAZADO ESTA SEGURO QUE DESEA RECHAZAR!!!'))
                window.location = '?ac=rechazar&id=<?=$GPC["id"] ?>';
        });
        
        $('#Liberar').click(function() {
            if (confirm('EL MOVIMIENTO SERA LIBERADA ESTA SEGURO QUE DESEA LIBERAR!!!'))
                window.location = '?ac=liberar&id=<?=$GPC["id"] ?>';            
        });
        
        $('.contable').live('change', function(){
            indice=$(this).attr('id').substring($(this).attr('id').lastIndexOf('_')+1,$(this).attr('id').length);            
            if ($(this).val()=='I') {
                $('#dataCP_cantidad_'+indice).css('visibility','hidden');
                $('#dataCP_cantidad_'+indice).val(-1);
            }
            else {
                $('#dataCP_cantidad_'+indice).css('visibility','visible');
                $('#dataCP_cantidad_'+indice).val(0);
            }
                
        });
        
        $('#tipoInsecto').change(function() {             
            $('#insectos').load('../ajax/detalle_cuarentena.php?ac=nuevo&idCA='+<?=$_SESSION['s_ca_id']; ?>+'&idCtna='+<?=$id_cuarentena; ?>+'&cantidad='+$(this).val());
            //alert('../ajax/detalle_cuarentena.php?ac=nuevo&idCA='+<?=$_SESSION['s_ca_id']; ?>+'&idCtna='+<?=$id_cuarentena; ?>+'&cantidad='+$(this).val());
        });
        
        $("#form1").submit(function(){
            var isFormValid = true;
            $("#form1 :input").each(function(){
                if ($(this).attr('class')=='plaga' && $(this).val()=='') {
                    isFormValid = false;
                    $(this).focus();
                    return isFormValid;
                }
            });            
            if ($('#tipoInsecto').val() < 1) {                
                isFormValid = false;
                $('#tipoInsecto').focus();                
            }
            if (!isFormValid) {                
                alert('No ha registrado las plagas correctamente!');
            }
            return isFormValid;
        });
        $('.plaga').live('change', function() {
            Actual=$(this);             
            $(".plaga").each(function(){
                Proximo=$(this);
                if (Proximo.attr('id')!=Actual.attr('id')) {
                    if (Proximo.val()==Actual.val()) {
                        Actual.val(0);
                        alert('LA PLAGA SELECIONADA YA HA SIDO ELEGIDA CON ANTERIORIDAD');
                    }
                }
            });
            
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
    <? 
    echo $html->input('id', $GPC['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CUARENTENA<br/><hr/>
    </div>    
    <fieldset>    
        <legend>Datos de la Recepcion</legend>
        <table align="center" border="0">
            <tr>
                <td align="left">Nro. Entrada</td>
                <td><? echo $html->input('Recepcion.numero', $infoRecepcion[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos cuadricula', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td align="left">Fecha</td>
                <td><? echo $html->input('Cuarentena.fecha_mov', $general->date_sql_screen($infoCtna[0]['fecha_mov'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="4"><? echo $html->select('Cuarentena.id_cultivo', array('options' => $listaCultivos, 'selected' => $infoCtna[0]['id_cultivo'], 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Kilogramos Aprox.</td>
                <td colspan="4"><? echo $html->input('', $infoGuia[0]['kilogramos'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
            </tr>
            <tr>
                <td>Vehiculo Placa</td>
                <td><? echo $html->input('', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td>Placa Rem:</td>            
                <td><? echo $html->input('', $infoGuia[0]['placa_remolques'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Chofer Cedula</td>
                <td><? echo $html->input('', $infoGuia[0]['cedula_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td>Chofer Nombre</td>
                <td><? echo $html->input('', $infoGuia[0]['nombre_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
        </table>        
    </fieldset> 
<fieldset>    
    <legend>Datos de los Insectos</legend>    
        <table align="center" border="0">
            <tr>
                <td align="center colspan="2">Tipos de Insectos</td>
                <?
                if ($soloLectura) {
                ?>
                    <td align="left"><? echo $html->select('tipoInsecto', array('options' => range(0,count($listaPlagas)), 'selected'=>count($listaCP), 'readOnly' => $soloLectura)); ?></td>                
                <?
                } else {
                ?>                     
                <td align="left">                    
                <? 
                $opciones=range(0,count($listaPlagas));
                $opciones[0]='SELECCIONE';
                echo $html->select('tipoInsecto', array('options' => $opciones, 'selected'=>count($listaCP))); ?>
                </td>
                <? 
                }
                ?>
            </tr>
            </table> 
    <div id="insectos">
        <table align="center" border="0">
            <tr align="center" class="titulos_tabla">
            <? if (!empty($listaCP)) { ?>
                <th>Insecto</th>
                <th>Muestra</th>
                <th>Valor</th>
            </tr>
            <? }
            $i=0;
            foreach($listaCP as $dataCP) {
                $clase = $general->obtenerClaseFila($i); 
            ?>
            <tr class="<?=$clase?>">
                <td>
                <? 
                if ($soloLectura)
                    echo $html->select('dataCP_id_'.$i, array('options' => $listaPlagas, 'selected' => $dataCP['id_plaga'], 'default' =>'Seleccione', 'readOnly' => true, 'class'=>'plaga')); 
                else
                    echo $html->select('dataCP_id_'.$i, array('options' => $listaPlagas, 'selected' => $dataCP['id_plaga'], 'default' =>'Seleccione', 'class'=>'plaga')); 
                ?>
                </td>                    
                <td>
                <?
                if ($soloLectura)
                    echo $html->select('esContable_'.$i, array('options' => array('C'=>'CONTABLE','I'=>'INCONTABLE'), 'selected' => (($dataCP['cantidad'] >= 0) ? 'C': 'I'), 'default' =>'Seleccione', 'readOnly' => $soloLectura,'class' => 'contable'));
                else
                    echo $html->select('esContable_'.$i, array('options' => array('C'=>'CONTABLE','I'=>'INCONTABLE'), 'selected' => (($dataCP['cantidad'] >= 0) ? 'C': 'I'), 'default' =>'Seleccione', 'class' => 'contable'));
                ?>
                </td>
                <td>
                <?                
                    if ($dataCP['cantidad'] >= 0)                        
                        echo $html->input('dataCP_cantidad_'.$i, $dataCP['cantidad'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => $soloLectura, 'class' => 'estilo_campos cuadricula positive'));
                ?>
                </td>
            </tr>
            <? 
            $i++;
            }
            ?>
        </table>
    </div>
    </fieldset>
    <div id="fumigacion">
    <fieldset sytle="display: block">    
        <legend>Datos de la Fumigaci&oacute;n</legend>
        <table align="center" border="0">
            <tr>
                <td>Producto</td>
                <td colspan="4">
                <?
                if ($soloLectura)
                    echo $html->select('Cuarentena.id_producto', array('options' => $listaProductos, 'selected' => $infoCtna[0]['id_producto'], 'default' =>'Seleccione', 'class'=>'calcular_dosis', 'readOnly' => true)); 
                else
                    echo $html->select('Cuarentena.id_producto', array('options' => $listaProductos, 'selected' => $infoCtna[0]['id_producto'], 'default' =>'Seleccione', 'class'=>'calcular_dosis')); 
                ?>
                </td>
            </tr>
            <tr>
                <td>Toneladas Aprox.</td>
                <td><? echo $html->input('Cuarentena.toneladas', $infoCtna[0]['toneladas'], array('type' => 'text', 'readOnly' => $soloLectura, 'class' => 'crproductor calcular_dosis positive')); ?></td>
                <td width="50"></td>
                <td>Dosis Estimada</td>
                <td id="calculo"><? echo $html->input('Cuarentena.cant_producto', $infoCtna[0]['cant_producto'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor positive')); ?></td>
            </tr>
            <tr>
                <td>Fecha Fumigaci&oacute;n</td>
                <td>
                <? 
                echo $html->input('Cuarentena.fecha_cultivo', $general->date_sql_screen($infoCtna[0]['fecha_cultivo'], '', 'es', '-'), array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); 
                if (!$soloLectura) {
                ?>
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
                <? } ?>
            </td>
            <td width="50"></td>
            <td>Hora Fumigaci&oacute;n</td>
            <td><? echo $html->input('Cuarentena.hora_trab', $infoCtna[0]['hora_trab'], array('type' => 'text', 'readOnly' => true, 'disabled' => $soloLectura,'class' => 'crproductor')); ?></td>
            </tr>
            <tr>
                <td>Fecha Liberaci&oacute;n</td>
                <td><? echo $html->input('Cuarentena.fecha_lib', $general->date_sql_screen($infoCtna[0]['fecha_lib'],'','es','-'), array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
                <td width="50"></td>
                <td>Hora Liberaci&oacute;n</td>
                <td><? echo $html->input('Cuarentena.hora_lib', $infoCtna[0]['hora_lib'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>                
            </tr>               
        </table>
    </fieldset>
    </div>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>                
                <?
                $fecha=date('d-m-Y',strtotime(''.$infoCtna[0]['fecha_lib'])).' '.$infoCtna[0]['hora_lib'];
                if (empty($infoCtna[0]['estatus'])) {
                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit'));                
                } else if ((time() > strtotime($fecha)) && (trim($infoCtna[0]['estatus'])=='2')) {
                    echo $html->input('Liberar', 'Liberar', array('type' => 'button'));
                }
                echo $html->input('Rechazar', 'Rechazar', array('type' => 'button')); 
                echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); 
                ?>
            </td>
        </tr>        
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
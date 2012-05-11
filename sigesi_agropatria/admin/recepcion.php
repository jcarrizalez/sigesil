<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $listaCantM = array(1 => 1, 2, 3, 4);
    $pesoPartes = array(1 => 'Una Parte', 2 => 'Dos Partes');
    $listaCarriles = array(1 => 1, 2 => 2);
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    $listadoAgencias = array(1 => 'Agencia 1');
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch($GPC['ac']){
        case 'guardar':
            $recepcion = new Recepcion();
            $guia = new Guia();
            $productor = new Productor();
            $vehiculo = new Vehiculo();
            $chofer = new Chofer();
            
            $GPC['Guia']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Guia']['estatus'] = 'P';
            $GPC['Chofer']['id_org'] = $_SESSION['s_org_id'];
            $GPC['Chofer']['ced_rif'] = $GPC['nacion3'].$GPC['Chofer']['ced_rif'];
            $GPC['Chofer']['estatus'] = 't';
            $GPC['Recepcion']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Recepcion']['estatus_rec'] = 1;
            $GPC['Recepcion']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Recepcion']['fecha_recepcion'] = 'now()';
            
            $recepcion->_begin_tool();
            
            $guia->save($GPC['Guia']);
            $idGuia = $guia->id;
            
            if($GPC['cantguia'] >= 1){
                for($j=1; $j<=$GPC['cantguia']; $j++){
                    $guia->guardarSubGuias($idGuia, $GPC["subguia_$j"], $GPC["subguiaFecha_$j"]);
                }
            }
            
            $chofer->save($GPC['Chofer']);
            $idChofer = $chofer->id;
            $vehiculo->save($GPC['Vehiculo']);
            $idVehiculo = $vehiculo->id;
            
            $GPC['Recepcion']['id_productor'] = $GPC['id_productor'];
            $GPC['Recepcion']['id_asociacion'] = (!empty($GPC['id_asociacion'])) ? $GPC['id_asociacion'] : 0;
            $GPC['Recepcion']['id_asociado'] = (!empty($GPC['id_asociado'])) ? $GPC['id_asociado'] : 0;
            $GPC['Recepcion']['id_guia'] = $idGuia;
            $GPC['Recepcion']['id_vehiculo'] = $idVehiculo;
            $GPC['Recepcion']['id_chofer'] = $idChofer;
            $recepcion->save($GPC['Recepcion']);
            $idRecepcion = $recepcion->id;
            
            if(!empty($idGuia) && !empty($idChofer) && !empty($idVehiculo) && !empty($idRecepcion)){
                $recepcion->_commit_tool();
                header("location: ".DOMAIN_ROOT."reportes/imprimir.php?reporte=boleta_recepcion&redir=recepcion&id_rec=$idRecepcion");
                die();
            }else{
                header("location: recepcion.php?msg=error");
                die();
            }
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Recepcion.id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.numero_guia', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Guia.fecha_emision', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Guia.kilogramos', array('required' => array('value' => true, 'message' => 'Requerido'), 'number' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('ced_rif_productor', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('nombre_productor', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('ced_rif_asociacion', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('ced_rif_asociado', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Chofer.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.placa', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Recepcion.carril', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Recepcion.cant_muestras', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'recepcion.php';
    }
    
    function abrirPopup(accion){
        var ancho;
        var alto;
        ancho = (screen.width/2)-(550/2);
        alto = (screen.height/2)-(450/2);

        if(accion == 'nuevoV'){
            pla = $('#Vehiculo\\[placa\\]').val();
            url = "vehiculo_popup.php?placa="+pla;
            titulo = "Registro Vehiculo";
        }
        ventana = window.open(url,titulo,"status=no,toolbar=0,menubar=no,resizable=0,scrollbars=1,width=550,left="+ancho+",height=450,top="+alto);
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad');
    
        $('#Guia\\[numero_guia\\]').change(function(){
            var guia = $('#Guia\\[numero_guia\\]').val();
            if(guia != '' && $('#Recepcion\\[id_cosecha\\]').val() != '')
                $('#guia').load('../ajax/recepcion_detalle.php?ac=guia&numero_guia='+guia);
            else{
                $('#Guia\\[numero_guia\\]').val('');
                alert('Seleccione primero una Cosecha');
            }
        });
        
        $('.verifSubGuia').live('change', function(){
            var guia = $('#Guia\\[numero_guia\\]').val();
            var id = $(this).attr('id');
            var cod = '#'+id;
            
            if(guia != $(this).val()){
                $(".verifSubGuia").each(function(){
                    if(id != $(this).attr('id')){
                        if($(cod).val() == $(this).val()){
                            alert('SubGuia duplicada');
                            $(cod).val('');
                            return false;
                        }
                    }
                });
            }else{
                alert('SubGuia debe ser distinta a la principal');
                $(this).val('');
            }
        });
        
        $('#ced_rif_productor').live('change', function(){
            var np = $('#nacion').val();
            var ced = $('#ced_rif_productor');
            var co = $('#Recepcion\\[id_cosecha\\]').val();
            var verif = np+ced.val()
            var aso = $('#nacion2').val()+$('#ced_rif_asociacion').val();
            if(verif == aso){
                ced.attr('value', '');
                alert('La Cedula/Rif no puede ser igual a la de la Asociacion');
            }else if(ced.val().length >= 6 && co != ''){
                ced = np+ced.val();
                $('#productor').load('../ajax/recepcion_detalle.php?ac=productor&cp='+ced+'&co='+co);
            }else if(co == ''){
                ced.attr('value', '');
                alert('Favor seleccione una cosecha');
            }
        });
        
        $('#ced_rif_asociacion').live('change', function(){
            var np = $('#nacion2').val();
            var ced = $('#ced_rif_asociacion');
            var co = $('#Recepcion\\[id_cosecha\\]').val();
            var verif = np+ced.val();
            var prod = $('#nacion').val()+$('#ced_rif_productor').val();
            if(verif == prod){
                ced.attr('value', '');
                alert('La Cedula/Rif no puede ser igual a la del Productor');
            }else if(ced.val().length >= 6 && co != ''){
                ced = np+ced.val();
                $('#asociacion').load('../ajax/recepcion_detalle.php?ac=asociacion&caon='+ced+'&cpro='+prod+'&co='+co);
            }else if(co == ''){
                ced.attr('value', '');
                alert('Favor seleccione una cosecha');
            }
        });
        
        $('#ced_rif_asociado').live('change', function(){
            var np = $('#nacion3').val();
            var ced = $('#ced_rif_asociado');
            var co = $('#Recepcion\\[id_cosecha\\]').val();
            var verif = np+ced.val();
            var prod = $('#nacion').val()+$('#ced_rif_productor').val();
            
            if($('#ced_rif_asociacion').val() != '')
                var aon = $('#nacion2').val()+$('#ced_rif_asociacion').val();
            else
                var aon = '';
            
            if(verif == aon){
                ced.attr('value', '');
                alert('La Cedula no puede ser igual a la de la Asociacion');
            }else if(ced.val().length >= 6 && co != ''){
                ced = np+ced.val();
                $('#asociado').load('../ajax/recepcion_detalle.php?ac=asociado&cado='+ced+'&cpro='+prod+'&caon='+aon+'&co='+co);
            }else if(co == ''){
                ced.attr('value', '');
                alert('Favor seleccione una cosecha');
            }
        });
        
        $('#Chofer\\[ced_rif\\]').change(function(){
            var np = $('#nacion3').val();
            var ced = $('#Chofer\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#chofer').load('../ajax/recepcion_detalle.php?ac=chofer&cp='+ced);
            }
        });
        
        $('#Vehiculo\\[placa\\]').live('change', function(){
            var placa = $(this).val();
            if(placa != ''){
                $('#placas').load('../ajax/detalle_despacho.php?ac=otraPlaca&placa='+placa);
            }
        });
        
        $('#cantguia').live('change', function(){
            var cant = $(this).val();
            if(cant != '')
                $('#nuevasguias').load('../ajax/recepcion_detalle.php?ac=otraguia&cant='+cant);
            else
                $('#nuevasguias').html('');
        });
        
        $("#form1").submit(function(){
            if(!confirm('Desea Guardar')){
                return false;
            }else{
                var enviar = 0;
                $("#form1 :input").each(function(){
                    if ($(this).hasClass('error')) {
                        enviar++;
                    }
                });
                if(enviar == 0){
                    show_div_loader();
                    return true;
                }else
                    return false;
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        RECEPCI&Oacute;N<br/><hr/>
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
    <table align="center" border="0" width="100%">
        <tr>
            <td colspan="2" id="nrocosecha">Entrada Nro </td>
        </tr>
        <tr>
            <td width="80"><span class="msj_rojo">* </span>Cosecha </td>
            <td><? echo $html->select('Recepcion.id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Gu&iacute;a</legend>
        <table align="center" border="0">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Gu&iacute;a </td>
                <td>
                    <?
                        echo $html->input('Guia.numero_guia', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive'));
                    ?>
                </td>
            </tr>
            <!--tr>
                <td><span class="msj_rojo">* </span>Agencia Origen </td>
                <td><? echo $html->select('Guia.id_agencia', array('options' => $listadoAgencias, 'selected' => '', 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr-->
            <tbody id="guia">
                <tr>
                    <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n </td>
                    <td>
                        <? echo $html->input('Guia.fecha_emision', $general->date_sql_screen($infoGuia[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "femision",
                                inputField : "Guia[fecha_emision]",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>N&uacute;mero de Contrato </td>
                    <td><? echo $html->input('Guia.contrato', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <!--tr>
                    <td>Disponible a Recibir </td>
                    <td><? echo $html->input('Guia.disponible_rec', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr-->
                <tr>
                    <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a </td>
                    <td><? echo $html->input('Guia.kilogramos', '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
                </tr>
                <tr>
                    <td>Otras Gu&iacute;as </td>
                    <td><? echo $html->select('cantguia',array('options'=>$listaCantM, 'default' => 'Seleccione', 'class' => 'estilo_campos'))?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <div id="nuevasguias"></div>
    <fieldset>
        <legend>Datos del Productor</legend>
        <table align="center">
            <tbody id="productor">
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Productor</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR));
                            echo "&nbsp;".$html->input('ced_rif_productor', '', array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos Productor</td>
                    <td><? echo $html->input('nombre_productor', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tbody id="asociacion">
                <tr>
                    <td>C&eacute;dula/Rif Asociaci&oacute;n</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR));
                            echo "&nbsp;".$html->input('ced_rif_asociacion', '', array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociaci&oacute;n</td>
                    <td><? echo $html->input('nombre_asociacion', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tbody id="asociado">
                <tr>
                    <td>C&eacute;dula/Rif Asociado</td>
                    <td>
                        <?
                            echo $html->select('nacion3', array('options'=>$listaCR));
                            echo "&nbsp;".$html->input('ced_rif_asociado', '', array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociado</td>
                    <td><? echo $html->input('nombre_asociado', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <!--fieldset id="fieldAsociado" style="display: none;">
        <legend>Datos del Asociado</legend>
        <table align="center">
            <tr>
                <td>C&eacute;dula/Rif </td>
                <td>
                    <?
                        //echo $html->select('nacion2', array('options'=>$listaCR));
                        //echo "&nbsp;".$html->input('Asociado.ced_rif', '', array('type' => 'text', 'length' => '8', 'class' => 'crproductor positive'));
                    ?>
                </td>
            </tr>
            <tbody id="asociado">
                <tr>
                    <td>Nombres y Apellidos </td>
                    <td><? //echo $html->input('Asociado.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
        </table>
    </fieldset-->
    <fieldset>
        <legend>Datos del Veh&iacute;culo</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula Chofer </td>
                <td>
                    <?
                        echo $html->select('nacion3', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Chofer.ced_rif', '', array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                    ?>
                </td>
            </tr>
            <tbody id="chofer">
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos </td>
                    <td><? echo $html->input('Chofer.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tbody id="placas">
                <tr>
                    <td><span class="msj_rojo">* </span>Placa Motriz/Chuto</td>
                    <td><? echo $html->input('Vehiculo.placa', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <!--tr>
                <td><span class="msj_rojo">* </span>Placa Motriz/Chuto </td>
                <td><? echo $html->input('Vehiculo.placa', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Marca </td>
                <td><? echo $html->input('Vehiculo.marca', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr-->
            <tr>
                <td>Placa Remolque/Batea </td>
                <td><? echo $html->input('Vehiculo.placa_remolques', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Recepci&oacute;n</legend>
        <table align="center">
            <tr>
                <td>Fecha de Recepci&oacute;n </td>
                <td><? echo $html->input('Recepcion.fecha_recepcion', date('d-m-Y'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Carril de Muestreo </td>
                <td><? echo $html->select('Recepcion.carril', array('options'=>$listaCarriles, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>¿C&oacute;mo desea pesar?</td>
                <td><? echo $html->select('Recepcion.cant_muestras', array('options'=>$pesoPartes, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
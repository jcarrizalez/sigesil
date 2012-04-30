<?
    require_once('../lib/core.lib.php');
    
    $transporte = new Transporte();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $pesoPartes = array(1 => 'Una Parte', 2 => 'Dos Partes');
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoT = $transporte->find(array('id_centro_acopio' => $idCA), '', array('id', 'nombre'), 'list', 'nombre');
    $listadoT['99999'] = 'Otro';
    
    switch($GPC['ac']){
        case 'guardar':
            $orden = new Orden();
            $despacho = new Despacho();
            $transporte = new Transporte();
            $ptoEntrega = new PuntosEntrega();

            $despacho->_begin_tool();
            
            if($GPC['Transporte']['id'] == '99999'){
                unset($GPC['Transporte']['id']);
                $GPC['Transporte']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $transporte->save($GPC['Transporte']);
                $idTransporte = $transporte->id;
            }else
                $idTransporte = $GPC['Transporte']['id'];
            
            if($GPC['PtoEntrega']['id'] == '99999'){
                unset($GPC['PtoEntrega']['id']);
                $GPC['PtoEntrega']['id_cliente'] = $GPC['Despacho']['id_cliente'];
                $ptoEntrega->save($GPC['PtoEntrega']);
                $idPtoEntrega = $ptoEntrega->id;
            }else
                $idPtoEntrega = $GPC['PtoEntrega']['id'];
            
            if(!empty($GPC['subOrden1']) && !empty($GPC['subOrdenkg1'])){
                for($i=1;$i<=2;$i++){
                    if(!empty($GPC["subOrden$i"])){
                        $orden->guardarSubOrden($GPC['Despacho']['id_orden'], $GPC["subOrden$i"], null, null, $GPC["subOrdenkg$i"]);
                    }
                }
            }
            
            $GPC['Despacho']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Despacho']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Despacho']['id_transporte'] = $idTransporte;
            $GPC['Despacho']['id_punto_entrega'] = $idPtoEntrega;
            $GPC['Despacho']['fecha_des'] = 'now()';
            //MODIFICAR PARA QUE TOME EL SILO CORRESPONDIENTE
            $GPC['Despacho']['id_silo'] = 2;
            $GPC['Despacho']['estatus'] = 1;

            $despacho->save($GPC['Despacho']);
            $idDespacho = $despacho->id;
            
            if(!empty($idDespacho)){
                $despacho->_commit_tool();
                header("location: despacho.php?msg=exitoso");
                die();
            }else{
                header("location: despacho.php?msg=error");
                die();
            }
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Orden.numero_orden', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Chofer.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.placa', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.marca', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Transporte.id', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Transporte.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('PtoEntrega.id', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('PtoEntrega.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Despacho.cant_muestras', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'despacho.php';
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
        }else{
            cedula = $('#nacion2').val()+$('#Chofer\\[ced_rif\\]').val();
            url = "chofer_popup.php?cp="+cedula;
            titulo = "Registro Cliente";
        }
        ventana = window.open(url,titulo,"status=no,toolbar=0,menubar=no,resizable=0,scrollbars=1,width=550,left="+ancho+",height=450,top="+alto);
    }
    
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad2');
    
        $('#Orden\\[numero_orden\\]').live('change', function(){
            var orden = $(this).val();
            if(orden != '')
                $('#orden').load('../ajax/detalle_despacho.php?ac=orden&numero='+orden);
            else
                $('#Orden\\[numero_orden\\]').val('');
        });
    
        $('#Chofer\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion2').val();
            var ced = $('#Chofer\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#chofer').load('../ajax/detalle_despacho.php?ac=chofer&cp='+ced);
            }
        });
    
        $('#Vehiculo\\[placa\\]').live('change', function(){
            var placa = $(this).val();
            if(placa != ''){
                $('#placas').load('../ajax/detalle_despacho.php?ac=otraPlaca&placa='+placa);
            }
        });
        
        $('.otro').live('change', function(){
            combo = $(this).attr('id');
            if(combo == 'Transporte[id]' && $(this).val() == '99999')
                $('#otroTransporte').load('../ajax/detalle_despacho.php?ac=otroTransporte');
            else if(combo == 'Transporte[id]' && $(this).val() != '99999')
                $('#otroTransporte').html('');
            else if(combo == 'PtoEntrega[id]' && $(this).val() == '99999')
                $('#otroPtoEntrega').load('../ajax/detalle_despacho.php?ac=otroPto');
            else if(combo == 'PtoEntrega[id]' && $(this).val() != '99999')
                $('#otroPtoEntrega').html('');
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        DESPACHO<br/><hr/>
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
            <td colspan="2" id="nrocosecha">Salida Nro </td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Orden</legend>
        <table align="center" border="0">
            <tbody id="orden">
                <tr>
                    <td><span class="msj_rojo">* </span>N&uacute;mero de Orden</td>
                    <td>
                        <? echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?>
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Despacho</legend>
        <table align="center">
            <tbody id="chofer">
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Chofer</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR));
                            echo "&nbsp;".$html->input('Chofer.ced_rif', '', array('type' => 'text', 'length' => '8', 'class' => 'positive', 'style' => 'width: 150px'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombre del Chofer</td>
                    <td><? echo $html->input('Chofer.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tbody id="placas">
                <tr>
                    <td><span class="msj_rojo">* </span>Placa Motriz/Chuto</td>
                    <td><? echo $html->input('Vehiculo.placa', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            </tbody>
            <tr>
                <td>Placas Remolque/Batea</td>
                <td><? echo $html->input('Vehiculo.placa_remolques', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>C&oacute;digo del Transporte</td>
                <td><? echo $html->select('Transporte.id',array('options'=>$listadoT, 'default' => 'Seleccione', 'class' => 'estilo_campos otro'))?></td>
            </tr>
            <tbody id="otroTransporte"></tbody>
            <tr>
                <td>Orden de Carga 1</td>
                <td><? echo $html->input('subOrden1', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?></td>
            </tr>
            <tr>
                <td>Kilogramos</td>
                <td><? echo $html->input('subOrdenkg1', '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
            </tr>
            <tr>
                <td>Orden de Carga 2</td>
                <td><? echo $html->input('subOrden2', '', array('type' => 'text', 'length' => '9', 'class' => 'estilo_campos positive')); ?></td>
            </tr>
            <tr>
                <td>Kilogramos</td>
                <td><? echo $html->input('subOrdenkg2', '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
            </tr>
            <tbody id="ptosEntrega">
                <tr>
                    <td><span class="msj_rojo">* </span>Punto de Entrega</td>
                    <td><? echo $html->select('PtoEntrega.id',array('default' => 'Seleccione', 'class' => 'estilo_campos otro')); ?></td>
                </tr>
            </tbody>
            <tbody id="otroPtoEntrega"></tbody>
            <tr>
                <td><span class="msj_rojo">* </span>¿C&oacute;mo desea pesar?</td>
                <td><? echo $html->select('Despacho.cant_muestras', array('options'=>$pesoPartes, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
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
<?php
    require_once('../lib/core.lib.php');
    
    $movimiento = new Despacho();
    $cultivo = new Cultivo();
    $vehiculo = new Vehiculo();
    $carril = new Tolcarom();
    $chofer = new Chofer();
    $productor = new Cliente();
    $transporte = new Transporte();
    $cliente = new Cliente();
    $puntoEntrega = new PuntosEntrega();
    $orden = new Orden();
    
    $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');    
    $listadoE=array(1 => 'Romana Vacío', 2 => 'Lab. Central', 3 => 'Romana Lleno', 4 => 'Rechazado', 5 => 'Despachado');
    $Error=true;
            
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['id'])) {
                $infoMov=$movimiento->listadoDespacho($GPC['id']);
                $listaCu = $cultivo->find('', '', array('id', 'nombre'), 'list', 'id');
                $listaT = $transporte->find(array('id_centro_acopio'=>$infoMov[0]['id_centro_acopio']), '', array('id', 'nombre'), 'list', 'id');
                $listaP = $puntoEntrega->find('', '', array('id', 'nombre'), 'list', 'id');
                $listaCarril = $carril->listaTolcarom($_SESSION['s_ca_id'], "'2'");
                
                foreach($listaCarril as $dataCarril) {
                    $listaC[$dataCarril['numero']]=$dataCarril['nombre'];
                }
                foreach($listadoE as $clave=>$valor) {
                    if ($clave <= $infoMov[0]['estatus_rec'])
                        $listadoEstatus[$clave]=$valor;
                }
            }
        break;
        case 'guardar':
            if (!empty($GPC['Despacho']['id']) && !empty($GPC['Recepcion']['id_cultivo']) && $GPC['Despacho']['numero_guia'] 
                    && !empty($GPC['Despacho']['ced_cliente_pre']) && !empty($GPC['Despacho']['ced_cliente']) 
                    && !empty($GPC['Despacho']['ced_chofer_pre']) && !empty($GPC['Despacho']['ced_chofer'])) {

                $infoMov=$movimiento->find(array('id'=>$GPC['Despacho']['id']));                
                $infoOrd = $orden->buscarOrden(null, $infoMov[0]['id_centro_acopio'], null, null, $GPC['Despacho']['numero_guia']);
                
                if (!empty($infoOrd[0]['id'])) {
                    $GPC['Despacho']['id_orden']=$infoOrd[0]['id'];
                } else
                    $Error=$Error && true;
                
                unset($GPC['Despacho']['numero_guia']);

                $listaCli = $cliente->find(array('ced_rif'=>$GPC['Despacho']['ced_cliente_pre'].$GPC['Despacho']['ced_cliente']), '', array('id', 'nombre'), 'list', 'id');
                if (!empty($listaCli[0]['id'])) {
                    $GPC['Despacho']['id_cliente']=$listaOrd[0]['id'];
                } else
                    $Error=$Error && true;
                
                unset($GPC['Despacho']['ced_cliente_pre']);
                unset($GPC['Despacho']['ced_cliente']);
                
                $listaChofer = $chofer->buscarChofer($GPC['Despacho']['ced_chofer_pre'].$GPC['Despacho']['ced_chofer']);
                if (!empty($listaChofer[0]['id'])) {
                    $GPC['Despacho']['id_chofer']=$listaChofer[0]['id'];
                } else
                    $Error=$Error && true;
                
                unset($GPC['Despacho']['ced_chofer_pre']);
                unset($GPC['Despacho']['ced_chofer']);
                
                //$listaVeh = $vehiculo->find(array('placa'=>$GPC['Despacho']['placa']), '', array('id', 'marca'), 'list', 'id');
                $listaVeh = $vehiculo->buscar($GPC['Despacho']['placa']);
                if (!empty($listaVeh[0]['id'])) {
                    $GPC['Despacho']['id_vehiculo']=$listaVeh[0]['id'];
                } else
                    $Error=$Error && true;
                
                unset($GPC['Despacho']['numero']);
                unset($GPC['Despacho']['fecha_des']);
                unset($GPC['Despacho']['placa']);
                
                switch ($GPC['Despacho']['estatus']) {
                    case 1://'1 => Romana Vacío
                        $GPC['Despacho']['fecha_v']='';
                        $GPC['Despacho']['peso_01v']=0.000;
                        $GPC['Despacho']['peso_02v']=0.000;
                        $GPC['Despacho']['fecha_pel']='';
                        $GPC['Despacho']['peso_01l']=0.000;
                        $GPC['Despacho']['peso_02l']=0.000;
                        $GPC['Despacho']['humedad']=0.000;
                        $GPC['Despacho']['impureza']=0.000;
                        $GPC['Despacho']['humedad_des']=0.000;
                        $GPC['Despacho']['impureza_des']=0.000;
                        $GPC['Despacho']['kac_des']=0.000;
                        $GPC['Despacho']['carril']=-1;
                        $GPC['Despacho']['romana_ent']=-1;
                        $GPC['Despacho']['romana_sal']=-1;
                        $GPC['Despacho']['peso_acon']=0.000;
                        $GPC['Despacho']['peso_acon_liq']=0.000;
                        $GPC['Despacho']['muestra']=-1;
                        $GPC['Despacho']['humedad2']=0.000;
                        $GPC['Despacho']['impureza2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['impureza_des2']=0.000;
                        $GPC['Despacho']['peso_acon2']=0.000;
                        $GPC['Despacho']['peso_acon_liq2']=0.000;
                        break;
                    case 2: //'Lab. Central'
                        $GPC['Despacho']['peso_02v']=0.000;
                        $GPC['Despacho']['fecha_pel']='';
                        $GPC['Despacho']['peso_01l']=0.000;
                        $GPC['Despacho']['peso_02l']=0.000;
                        $GPC['Despacho']['humedad']=0.000;
                        $GPC['Despacho']['impureza']=0.000;
                        $GPC['Despacho']['humedad_des']=0.000;
                        $GPC['Despacho']['impureza_des']=0.000;
                        $GPC['Despacho']['kac_des']=0.000;
                        $GPC['Despacho']['carril']=-1;
                        $GPC['Despacho']['romana_sal']=-1;
                        $GPC['Despacho']['peso_acon']=0.000;
                        $GPC['Despacho']['peso_acon_liq']=0.000;
                        $GPC['Despacho']['muestra']=-1;
                        $GPC['Despacho']['humedad2']=0.000;
                        $GPC['Despacho']['impureza2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['peso_acon2']=0.000;
                        $GPC['Despacho']['peso_acon_liq2']=0.000;
                        break;
                    case 3: //'Romana Lleno'
                        $GPC['Despacho']['peso_02v']=0.000;                        
                        $GPC['Despacho']['fecha_pel']='';
                        $GPC['Despacho']['peso_01l']=0.000;
                        $GPC['Despacho']['peso_02l']=0.000;                        
                        $GPC['Despacho']['humedad']=0.000;                        
                        $GPC['Despacho']['impureza']=0.000;
                        $GPC['Despacho']['humedad_des']=0.000;
                        $GPC['Despacho']['impureza_des']=0.000;
                        $GPC['Despacho']['kac_des']=0.000;
                        $GPC['Despacho']['carril']=-1;
                        $GPC['Despacho']['romana_sal']=-1;
                        $GPC['Despacho']['peso_acon']=0.000;
                        $GPC['Despacho']['peso_acon_liq']=0.000;
                        $GPC['Despacho']['muestra']=-1;
                        $GPC['Despacho']['humedad2']=0.000;
                        $GPC['Despacho']['impureza2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['impureza_des2']=0.000;
                        $GPC['Despacho']['peso_acon2']=0.000;
                        $GPC['Despacho']['peso_acon_liq2']=0.000;
                        break;
                    case 4: //'Rechazado'
                        $GPC['Despacho']['peso_02v']=0.000;
                        $GPC['Despacho']['fecha_pel']='';
                        $GPC['Despacho']['peso_01l']=0.000;
                        $GPC['Despacho']['peso_02l']=0.000;
                        $GPC['Despacho']['humedad']=0.000;
                        $GPC['Despacho']['impureza']=0.000;
                        $GPC['Despacho']['humedad_des']=0.000;
                        $GPC['Despacho']['impureza_des']=0.000;
                        $GPC['Despacho']['kac_des']=0.000;
                        $GPC['Despacho']['carril']=-1;
                        $GPC['Despacho']['romana_sal']=-1;
                        $GPC['Despacho']['peso_acon']=0.000;
                        $GPC['Despacho']['peso_acon_liq']=0.000;
                        $GPC['Despacho']['muestra']=-1;
                        $GPC['Despacho']['humedad2']=0.000;
                        $GPC['Despacho']['impureza2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['humedad_des2']=0.000;
                        $GPC['Despacho']['peso_acon2']=0.000;
                        $GPC['Despacho']['peso_acon_liq2']=0.000;
                        break;
                    case 5: //'Despachado');
                        break;
                }
            }
            if (!empty($infoMov[0]['id'])) {
                $movimiento->_begin_tool();
                $movimiento->save($GPC['Despacho']);
                $movimiento->_commit_tool();
                header("location: ".DOMAIN_ROOT."admin/utilitario_despacho_listado.php?msg=exitoso");
                die();
            }
            header("location: ".DOMAIN_ROOT."admin/utilitario_despacho_listado.php?msg=error");
            die();
        break;
    }
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    function cancelar(){
        window.location = '<?php echo DOMAIN_ROOT?>admin/utilitario_despacho_listado.php';
    }
    
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#Despacho\\[ced_cliente\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Cliente!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#cliente_nombre').load('../ajax/detalle_utilitario.php?ac=cliente&cedCli='+$('#Despacho\\[ced_cliente_pre\\]').val()+$('#Despacho\\[ced_cliente\\]').val());
            $('#cliente_nombre').css('display','block');
        });
        
        $('#Despacho\\[ced_chofer\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Chofer!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#chofer_nombre').load('../ajax/detalle_utilitario.php?ac=chofer&cedC='+$('#Despacho\\[ced_chofer_pre\\]').val()+$('#Despacho\\[ced_chofer\\]').val());
            $('#chofer_nombre').css('display','block');
        });
        
        $('#Despacho\\[estatus\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Estatus!!!');
            } else
                $('#Guardar').removeAttr('disabled');
        });

        $('#Despacho\\[numero_guia\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe introducir el numero de guia!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#orden_nombre').load('../ajax/detalle_utilitario.php?ac=orden&numero='+$('#Despacho\\[numero_guia\\]').val());
            $('#orden_nombre').css('display','block');
        });

        $('#Despacho\\[id_transporte\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir el Transporte!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
        });

        $('#Despacho\\[id_punto_entrega\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe introducir el Punto de Entrega!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
        });
        
        $('#Recepcion\\[id_cultivo\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir el Cultivo!!!');
            } else
                $('#Guardar').removeAttr('disabled'); 
        });
        
        $('#Despacho\\[placa\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Placa!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#vehiculo_nombre').load('../ajax/detalle_utilitario.php?ac=vehiculo&placa='+$('#Despacho\\[placa\\]').val());
        });
       
        $("#form1").submit(function() {
            var isFormValid = true;
            $(".mensaje").each(function(){                 
                if ($(this).val()==1) {
                    isFormValid = false;
                    if ($(this).attr('id')=='msg1') {
                        alert("La fecha y la hora ya estan ocupadas!!!");
                    }                    
                    if ($(this).attr('id')=='msg2') {
                        alert("El chofer no existe!!!");
                    }
                    if ($(this).attr('id')=='msg3') {
                        alert("El Vehiculo no existe!!!");
                    }
                    if ($(this).attr('id')=='msg4') {
                        alert("El Cliente no existe!!!");
                    }
                    $('#Recepcion\\[numero\\]').focus();
                    return isFormValid;
                }
            });
            if (isFormValid==true)
                 if (confirm('SEGURO DESEAR GUARDAR?'))
                    isFormValid=true;
                 else
                    isFormValid=false;
            return isFormValid;
        });
    });
</script>
<div id="titulo_modulo">
    UTILITARIO - DESPACHO<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <fieldset>
        <legend>Datos del Despacho</legend>
        <table align="center" border="0">
            <tr>
                <td>Fecha Despacho</td>
                <td><?php echo $html->input('Despacho.fecha_des', $general->date_sql_screen($infoMov[0]['fecha_des'], '', 'es', '-'), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr> 
            <tr>
                <td>Numero Salida</td>
                <td><?php echo $html->input('Despacho.numero', $infoMov[0]['numero'], array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr> 
            <tr>
                <td>Cultivo</td>
                <td><?php echo $html->select('Recepcion.id_cultivo', array('options' => $listaCu, 'selected' => $infoMov[0]['id_cultivo'],  'default'=>'Seleccione', 'class' => 'estilo_campos'));?></td>
            </tr>            
            <tr>
                <td>Orden</td>
                <td><?php echo $html->input('Despacho.numero_guia', $infoMov[0]['numero_guia'], array('type' => 'text')); ?></td>
            </tr>
            <tr>
                <td>
                </td>
                <td id="orden_nombre" style="display: none" colspan="3">
                </td>
            </tr>  
            <tr>
                <td width="130px">Cliente</td>
                <td width="230px">
                <?php
                    echo $html->select('Despacho.ced_cliente_pre',array('options'=>$listaCR, 'selected' => $infoMov[0]['ced_cliente'][0]));
                    echo $html->input('Despacho.ced_cliente', str_replace($listaCR, "", $infoMov[0]['ced_cliente']), array('type' => 'text', 'class' => 'crproductor')); 
                ?>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td id="cliente_nombre" style="display: none" colspan="3">
                </td>
            </tr>  
            <tr>
                <td width="130px">Chofer</td>
                <td width="230px">
                <?php
                    echo $html->select('Despacho.ced_chofer_pre',array('options'=>$listaCR, 'selected' => $infoMov[0]['ced_chofer'][0]));
                    echo $html->input('Despacho.ced_chofer', str_replace($listaCR, "", $infoMov[0]['ced_chofer']), array('type' => 'text', 'class' => 'crproductor')); 
                ?>
                </td>
            <tr>
                <td>
                </td>
                <td id="chofer_nombre" style="display: none" colspan="3">
                </td>
            </tr>            
            <tr>
                <td>Placa del Vehiculo</td>
                <td><?php echo $html->input('Despacho.placa', $infoMov[0]['placa'], array('type' => 'text')); ?></td>
            </tr>
            <tr>
                <td></td>
                <td id="vehiculo_nombre"></td>
            </tr>
            <tr>
            <tr>
                <td>Transporte</td>
                <td><?php echo $html->select('Despacho.id_transporte', array('options' => $listaT, 'selected' => $infoMov[0]['id_transporte'],  'default'=>'Seleccione', 'class' => 'estilo_campos'));?></td>
            </tr>
            <tr>
                <td>Punto de Entrega</td>
                <td><?php echo $html->select('Despacho.id_punto_entrega', array('options' => $listaP, 'selected' => $infoMov[0]['id_punto_entrega'],  'default'=>'Seleccione', 'class' => 'estilo_campos'));?></td>
            </tr>
            <tr>
                <td>Peso lleno 1</td>
                <td><?php echo $html->input('Despacho.peso_01l', number_format($infoMov[0]['peso_01l'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr> 
            <tr>
                <td>Peso Vacio 1</td>
                <td><?php echo $html->input('Despacho.peso_01v', number_format($infoMov[0]['peso_01v'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Peso lleno 2</td>
                <td><?php echo $html->input('Despacho.peso_02l', number_format($infoMov[0]['peso_02l'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Peso Vacio 2</td>
                <td><?php echo $html->input('Despacho.peso_02v', number_format($infoMov[0]['peso_02v'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Desc Humedad</td>
                <td><?php echo $html->input('Despacho.humedad_des', number_format($infoMov[0]['humedad_des'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Desc Impureza</td>
                <td><?php echo $html->input('Despacho.impureza_des', number_format($infoMov[0]['impureza_des'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Nro Carril</td>
                <td><?php echo $html->select('Despacho.carril', array('options' => $listaC, 'selected' => $infoMov[0]['carril'],  'default'=>'Seleccione', 'class'=>'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Peso Acondicionado</td>
                <td><?php echo $html->input('Despacho.peso_acon', number_format($infoMov[0]['peso_acon'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Peso Acondicionado (liquidar)</td>
                <td><?php echo $html->input('Despacho.peso_acon_liq', number_format($infoMov[0]['peso_acon_liq'],2,'.',''), array('type' => 'text', 'readOnly'=>'true')); ?></td>
            </tr>
            <tr>
                <td>Estatus</td>
                <td><?php echo $html->select('Despacho.estatus',array('options'=>$listadoEstatus, 'selected' => $infoMov[0]['estatus_rec'],  'default'=>'Seleccione', 'default' => 'Seleccione'));?></td>
            </tr>
        </table>
    </fieldset>
    <?php echo $html->input('Despacho.id',$infoMov[0]['id'], array('type' => 'hidden')); ?>
    <table align="center" border="0">
        <tr>
            <td></td>
        </tr>
        <tr align="center">
            <td colspan="3">
                <?php echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <?php echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>        
    </table>
</form>
<?php
    require('../lib/common/footer.php');
?>
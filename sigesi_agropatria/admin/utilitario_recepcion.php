<?php
    require_once('../lib/core.lib.php');

    $movimiento = new Recepcion();
    $cosecha = new Cosecha();
    $productor = new Productor();
    $vehiculo = new Vehiculo();
    $guia= new Guia();
    $carril = new Tolcarom();
    $analisis = new Analisis();
    $rectipo = new Recultipo();
    /*$cosecha = new Cosecha();
    $vehiculo = new Vehiculo();
    $cultivo = new Cultivo();
     */
    
    $carril = new Tolcarom();
    
    $esResultado=true;
    $esTipo=true;
    $idCA=(!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id']: null;
    
    $listadoE = array('1' => '(1) Lab.Central', '2' => '(2) Ctna Lab.Central', '3' => '(3) Romana Lleno', '4' => '(4) Tolvas', '5' => '(5) Ctna Tolva','6' => '(6) Romana Vacio', '7' => '(7) Rechazo Central', '9' => '(9) Recibido',  '11' => '(11) Ctna Lab. Central - Apro.',  '12' => '(12) Ctna Lab. Central-Rech');
    
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['id'])) {
                $infoMov=$movimiento->listadoRecepcion($GPC['id']);
                $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
                $listaP = $productor->find(array('ced_rif'=>$infoMov[0]['ced_productor']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');
                $listaAon = $productor->find(array('ced_rif'=>$infoMov[0]['ced_asociacion']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');                
                $listaAdo = $productor->find(array('ced_rif'=>$infoMov[0]['ced_asociado']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');
                $listaCarril = $carril->listaTolcarom($_SESSION['s_ca_id'], "'2'");
                $listaGuia = $guia->find('', '', array('id', 'numero_guia'), 'list', 'id');
                $listaSubGuia = $guia->buscarSubGuias($infoMov[0]['id_guia']);

                foreach($listaCarril as $dataCarril) {
                    $listaC[$dataCarril['numero']]=$dataCarril['nombre'];
                }
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
            if (!empty($GPC['Recepcion']['id_cosecha']) && !empty($GPC['Recepcion']['ced_productor']) && !empty($GPC['Recepcion']['fecha_recepcion'])) {
                $movimiento->_begin_tool();                
                $infoProductor = $productor->find(array('ced_rif' => $GPC['Recepcion']['ced_productor']));
                $GPC['Recepcion']['id_productor']=$infoProductor[0]['id'];

                if (!empty($GPC['Recepcion']['ced_asociacion'])) {
                    $infoAsociacion = $productor->find(array('ced_rif' => $GPC['Recepcion']['ced_asociacion']));
                    $GPC['Recepcion']['id_asociacion']=$infoAsociacion[0]['id'];                    
                }
                
                if (!empty($GPC['Recepcion']['ced_asociado'])) {
                    $infoAsociado = $productor->find(array('ced_rif' => $GPC['Recepcion']['ced_asociado']));
                    $GPC['Recepcion']['id_asociado']=$infoAsociacion[0]['id'];
                }
                    
                //$ced_asociado=$GPC['Recepcion']['ced_asociado'];                
                $GPC['Recepcion']['fecha_recepcion']=$general->fecha_normal_sql($GPC['Recepcion']['fecha_recepcion']);
                
                
                $infoMovimiento = $movimiento->find(array('id'=>$GPC['Recepcion']['id']));
                
                unset($GPC['Recepcion']['ced_productor']);
                unset($GPC['Recepcion']['ced_asociacion']);
                unset($GPC['Recepcion']['ced_asociado']);
                
                if (!empty($infoMovimiento[0]['id'])) {
                    if ($infoMovimiento[0]['estatus_rec']!=$GPC['Recepcion']['estatus_rec']) {
                        switch ($GPC['Recepcion']['estatus_rec']) {
                            case 14:
                            case 13:
                            case 12:
                            case 11:
                            case 10:
                            case 9:
                            case 8:
                            case 7:
                            case 6:
                            case 5:
                            case 4:
                            case 3:
                            case 1:
                                $GPC['Recepcion']['muestra']=0;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                $esResultado=$analisis->borrarResultados($infoMovimiento[0]['id']);
                                $esTipo=$rectipo->borrar($infoMovimiento[0]['id']);
                                break;
                            case 2:
                                $GPC['Recepcion']['fecha_pel']='0000-00-00';
                                $GPC['Recepcion']['fecha_pel']='0000-00-00';
                                $GPC['Recepcion']['peso_01l']=0.001;
                                $GPC['Recepcion']['tolva']=0.001;
                                $GPC['Recepcion']['fecha_v']=='0000-00-00';
                                $GPC['Recepcion']['peso_01v']=0.001;
                                $GPC['Recepcion']['peso_02v']=0.001;
                                $GPC['Recepcion']['humedad']=0.001;
                                $GPC['Recepcion']['impureza']=0.001;
                                $GPC['Recepcion']['humedad_des']=0.001;
                                $GPC['Recepcion']['impureza_des']=0.001;
                                $GPC['Recepcion']['romana_ent']=0.001;
                                $GPC['Recepcion']['romana_sal']=0.001;
                                $GPC['Recepcion']['peso_acon']=0.001;
                                $GPC['Recepcion']['peso_acon_liq']=0.001;
                                break;
                        }                        
                    }
                }
                if (!empty($infoMovimiento[0]['id'])) {
                    if (($esResultado==true) || ($esTipo==true)) {
                        $movimiento->save($GPC['Recepcion']);
                        $movimiento->_commit_tool();
                    }
                    header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=exitoso");
                    die();
                }
                header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
                die();
                $movimiento->_rollback_tool();
            }
            header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
            die();
        default:
            //header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
            debug::pr($GPC['ac']);
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
        
        $('#Recepcion\\[id_cosecha\\]').change(function() {
            $('#productor_nombre').load('../ajax/detalle_utilitario.php?ac=productor&cosecha='+$('#Recepcion\\[id_cosecha\\]').val());
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val());
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+'&cedRifAon='+$('#Recepcion_asociacion').val());
        });

        $('#Recepcion\\[ced_productor\\]').live('change', function() {
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val());
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+'&cedRifAon='+$('#Recepcion_asociacion').val());
        });
        
        $('#Recepcion\\[ced_asociacion\\]').live('change', function() {
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val());
        });
        
        $('#Recepcion\\[numero\\]').live('change',function() {
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=n&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?=$idCA?>"+"&id=<?=$GPC['id']?>");
        });
        
        $('#Recepcion\\[fecha_recepcion\\]').live('change', function() {
            $('#fecha_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=f&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?=$idCA?>"+"&id=<?=$GPC['id']?>");
        });
        
        $('#Recepcion_placa').live('change', function() {
            $('#vehiculo_descrip').load('../ajax/detalle_utilitario.php?ac=vehiculo&placa='+$('#Recepcion_placa').val());
        });
        
//        $('#Recepcion\\[numero_guia\\]').live('change', function() {
            //$('#guia_nombre').load
//        });
    });
</script>
<div id="titulo_modulo">
    UTILITARIO - RECEPCION<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
<!--    <fieldset>
        <legend>Datos de la Guia</legend>        
            <table align="center" border="0">
                <tr>
                    <td width="130px">Guia Nro. 1</td>
                    <td width="230px">
                    <?=$html->input('Recepcion.numero_guia', $infoMov[0]['numero_guia'], array('type' => 'text', 'class' => 'crproductor')); ?>
                    </td>
                </tr>
            </table>
            <table align="center" border="0" id='guia_nombre'>
            <?
                $i=1;
                foreach($listaSubGuia as $subguia) {
                    $i++;
            ?>
                <tr>
                    <td>Guia Nro. <?=$i?></td>
                    <td>
                        <?=$html->input('Guia.subguia'.$i, $subguia['subguia'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?>
                    </td>
                </tr>
            <?
                }
            ?>
                <tr>
                    <td width="130px">Fecha de emision</td>
                    <td width="230px"><?=$html->input('Guia.placa', $listaGuia[0]['fecha_emision'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?></td>
                </tr>
                <tr>
                    <td width="130px">Placa del Vehiculo</td>
                    <td width="230px"><?=$html->input('Guia.placa', $infoMov[0]['placa'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?></td>
                </tr>
                <tr>
                    <td>Contrato</td>
                    <td>
                        <?=$html->input('Guia.contrato', $infoMov[0]['contrato'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?>
                    </td>
                </tr>
            </table>
    </fieldset>-->
    <fieldset>
        <legend>Datos de la Recepcion</legend>
    <table align="center" border="1">
        <tr>
            <td>Cosecha</td>
            <td colspan="2" id='cultivo_nombre' width="230px">                
            <? echo $html->select('Recepcion.id_cosecha', array('options' => $listaCo, 'selected' => $infoMov[0]['id_cosecha'],  'default'=>'Seleccione', 'class' => 'estilo_campos')); ?>
            </td>
        </tr>
        <tr>
            <td>Productor</td>
            <td colspan="2" id="productor_nombre">
            <? echo $html->select('Recepcion.ced_productor', array('options' => $listaP, 'selected' => $infoMov[0]['ced_productor'],  'default'=>'Seleccione', 'class'=>'estilo_campos')); ?>
            </td>
        </tr>
        <tr>
            <td>Asociacion</td>
            <td colspan="2" id="asociacion_nombre" width="130px">
                <?echo $html->select('Recepcion.ced_asociacion', array('options' => $listaAon, 'selected' => $infoMov[0]['ced_asociacion'],  'default'=>'Seleccione', 'class'=>'estilo_campos')); ?>
            </td>
        </tr>
        <tr>
            <td>Asociado</td>
            <td>
            <? 
                echo $html->select('Recepcion.ced_asociado', array('options' => $listaAdo, 'selected' => $infoMov[0]['ced_asociado'],  'default'=>'Seleccione', 'class'=>'estilo_campos'));
            ?>
            <td id="asociado_nombre" ></td>
        </tr>
        <tr>
            <td>Nro Entrada</td>
            <td><? echo $html->input('Recepcion.numero', $infoMov[0]['numero'], array('type' => 'text', 'class' => 'crproductor positive')); ?></td>
            <td id='numero_msg'></td>
        </tr>
        <tr>
            <td>Fecha de Recepcion</td>
            <td><? echo $html->input('Recepcion.fecha_recepcion', $general->date_sql_screen($infoMov[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                <script>
                    Calendar.setup({
                        trigger    : "femision",
                        inputField : "Recepcion[fecha_recepcion]",
                        dateFormat: "%d-%m-%Y",
                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoMov[0]['fecha_recepcion']));?>),
                        onSelect   : function() { $('#Recepcion\\[fecha_recepcion\\]').change();this.hide() }
                    });
                </script>
            </td>
            <td id="fecha_msg"></td>
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
            <td><? echo $html->select('Recepcion.carril', array('options' => $listaC, 'selected' => $infoMov[0]['carril'],  'default'=>'Seleccione', 'class'=>'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Estatus</td>
            <td><? echo $html->select('Recepcion.estatus_rec',array('options'=>$listadoEstatus, 'selected' => $infoMov[0]['estatus_rec'],  'default'=>'Seleccione', 'default' => 'Seleccione'));?></td>
        </tr>
    </table>
    <? echo $html->input('Recepcion.id', $GPC['id'], array('type' => 'hidden')); ?>
    </fieldset>
    <table align="center" border="1">
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
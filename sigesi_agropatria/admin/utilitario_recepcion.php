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
    $chofer = new Chofer();
    $Ctna = new Cuarentena();
    $CtnaPlaga = new CuarentenaPlaga();
    /*$cosecha = new Cosecha();
    $vehiculo = new Vehiculo();
    $cultivo = new Cultivo();
     */
    
    $carril = new Tolcarom();
    $esResultado=true;
    $esTipo=true;
    $idCA=(!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id']: null;
    
    $listadoE = array('1' => '(1) Lab.Central', '2' => '(2) Ctna Lab.Central', '3' => '(3) Romana Lleno', '4' => '(4) Tolvas', '5' => '(5) Ctna Tolva','6' => '(6) Romana Vacio', '7' => '(7) Rechazo Central', '9' => '(9) Recibido',  '11' => '(11) Ctna Lab. Central - Apro.',  '12' => '(12) Ctna Lab. Central-Rech');
    $juridico=array('V'=>'V', 'J'=>'J','E'=>'E','G'=>'G');
    
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
                    if (!empty($infoAsociacion[0]['id']))
                        $GPC['Recepcion']['id_asociacion']=$infoAsociacion[0]['id'];
                }
                
                if (!empty($GPC['Recepcion']['ced_asociado'])) {
                    $infoAsociado = $productor->find(array('ced_rif' => $GPC['Recepcion']['ced_asociado']));
                    if (!empty($infoAsociacion[0]['id']))
                        $GPC['Recepcion']['id_asociado']=$infoAsociacion[0]['id'];
                }
                
                if (!empty($GPC['Recepcion']['placa'])) {
                    $infoVehiculo = $vehiculo->buscar($GPC['Recepcion']['placa']);
                    if (!empty($infoVehiculo[0]['id']))
                        $GPC['Recepcion']['id_vehiculo']=$infoVehiculo[0]['id'];
                }
                
                if (!empty($GPC['Recepcion']['ced_chofer_pre']) && !empty($GPC['Recepcion']['ced_chofer'])) {
                    $infoChofer = $chofer->find(array('ced_rif' => $GPC['Recepcion']['ced_chofer_pre'].$GPC['Recepcion']['ced_chofer']));
                    if (!empty($infoChofer[0]['id']))
                        $GPC['Recepcion']['id_chofer']=$infoChofer[0]['id'];
                }

                $infoMovimiento = $movimiento->find(array('id'=>$GPC['Recepcion']['id']));
                
                unset($GPC['Recepcion']['ced_productor']);
                unset($GPC['Recepcion']['ced_asociacion']);
                unset($GPC['Recepcion']['ced_asociado']);
                unset($GPC['Recepcion']['numero_guia']);
                unset($GPC['Recepcion']['placa']);
                unset($GPC['Recepcion']['ced_chofer']);
                unset($GPC['Recepcion']['ced_chofer_pre']);
                unset($GPC['Recepcion']['fecha_recepcion']);
                unset($GPC['Recepcion']['numero']);
                $movimiento->_begin_tool();
                
                if (!empty($infoMovimiento[0]['id'])) {
                    if ($infoMovimiento[0]['estatus_rec']!=$GPC['Recepcion']['estatus_rec']) {
                        switch ($GPC['Recepcion']['estatus_rec']) {
                            case 14:
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 13:
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 12:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 11:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 10:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                            case 9:
                                break;
                            case 8://Rechazo de Tolva
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 7://Rechazo Laboratorio Central
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['muestra']=0;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 6:
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $esResultado=$analisis->borrarResultados($infoMovimiento[0]['id']);                                    
                                $listaT=$rectipo->find(array('id_recepcion'=>$infoMovimiento[0]['id'], 'id_centro_acopio'=>$infoMovimiento[0]['id_centro_acopio']));
                                $esTipo=$rectipo->borrar($infoMovimiento[0]['id']);
                                $Ctna->borrar($infoMovimiento[0]['id']);
                                $CtnaPlaga->borrar($infoMovimiento[0]['id']);
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 5:
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $esResultado=$analisis->borrarResultados($infoMovimiento[0]['id']);                                    
                                $listaT=$rectipo->find(array('id_recepcion'=>$infoMovimiento[0]['id'], 'id_centro_acopio'=>$infoMovimiento[0]['id_centro_acopio']));
                                $esTipo=$rectipo->borrar($infoMovimiento[0]['id']);
                                $Ctna->borrar($infoMovimiento[0]['id']);
                                $CtnaPlaga->borrar($infoMovimiento[0]['id']);
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 4:
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $esResultado=$analisis->borrarResultados($infoMovimiento[0]['id']);                                    
                                $listaT=$rectipo->find(array('id_recepcion'=>$infoMovimiento[0]['id'], 'id_centro_acopio'=>$infoMovimiento[0]['id_centro_acopio']));
                                $esTipo=$rectipo->borrar($infoMovimiento[0]['id']);
                                $Ctna->borrar($infoMovimiento[0]['id']);
                                $CtnaPlaga->borrar($infoMovimiento[0]['id']);
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                
                                break;
                            case 3:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;
                                $GPC['Recepcion']['impureza_des']=0.000;
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                break;
                            case 1:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']-1;//?
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;//?
                                $GPC['Recepcion']['impureza_des']=0.000;//?
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                $GPC['Recepcion']['muestra']=0;
                                $GPC['Recepcion']['estatus_rec']=$GPC['Recepcion']['estatus_rec'];
                                $esResultado=$analisis->borrarResultados($infoMovimiento[0]['id']);                                    
                                $listaT=$rectipo->find(array('id_recepcion'=>$infoMovimiento[0]['id'], 'id_centro_acopio'=>$infoMovimiento[0]['id_centro_acopio']));
                                $esTipo=$rectipo->borrar($infoMovimiento[0]['id']);
                                $Ctna->borrar($infoMovimiento[0]['id']);
                                $CtnaPlaga->borrar($infoMovimiento[0]['id']);
                                break;
                            case 2:
                                $GPC['Recepcion']['fecha_pel']='';
                                $GPC['Recepcion']['peso_01l']=0.000;
                                $GPC['Recepcion']['peso_02l']=0.000;
                                $GPC['Recepcion']['tolva']=-1;//?
                                $GPC['Recepcion']['fecha_v']=='';
                                $GPC['Recepcion']['peso_01v']=0.000;
                                $GPC['Recepcion']['peso_02v']=0.000;
                                $GPC['Recepcion']['humedad']=0.000;
                                $GPC['Recepcion']['impureza']=0.000;
                                $GPC['Recepcion']['humedad_des']=0.000;//?
                                $GPC['Recepcion']['impureza_des']=0.000;//?
                                $GPC['Recepcion']['romana_ent']=-1;
                                $GPC['Recepcion']['romana_sal']=-1;
                                $GPC['Recepcion']['peso_acon']=0.000;
                                $GPC['Recepcion']['peso_acon_liq']=0.000;
                                break;
                        }                        
                    }
                }
                if (!empty($infoMovimiento[0]['id'])) {
                    $movimiento->save($GPC['Recepcion']);
                    $movimiento->_commit_tool();
                    header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=exitoso");
                    die();
                }
                header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
                die();
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
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Cosecha!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#productor_nombre').load('../ajax/detalle_utilitario.php?ac=productor&cosecha='+$('#Recepcion\\[id_cosecha\\]').val());
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val());
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+'&cedRifAon='+$('#Recepcion_asociacion').val());
        });

        $('#Recepcion\\[ced_productor\\]').live('change', function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Productor!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val());
            //$('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+'&cedRifAon='+$('#Recepcion_asociacion').val());
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+"&cedRifAon="+$('#Recepcion\\[ced_asociacion\\]').val());
        });
        
        $('#Recepcion\\[ced_asociacion\\]').live('change', function() {
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+$('#Recepcion\\[ced_productor\\]').val()+"&cedRifAon="+$('#Recepcion\\[ced_asociacion\\]').val());
        });
        
        $('#Recepcion\\[numero\\]').live('change',function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Numero!!!');
            } else
                $('#Guardar').removeAttr('disabled');
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=n&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?=$idCA?>"+"&id=<?=$GPC['id']?>");
        });
        
        $('#Recepcion\\[fecha_recepcion\\]').live('change', function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Fecha!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=f&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?=$idCA?>"+"&id=<?=$GPC['id']?>");
        });
        
        $('#Recepcion\\[placa\\]').live('change', function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Placa!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#vehiculo_nombre').load('../ajax/detalle_utilitario.php?ac=vehiculo&placa='+$('#Recepcion\\[placa\\]').val());
        });
        
        $('#Recepcion\\[ced_chofer\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Chofer!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#chofer_nombre').load('../ajax/detalle_utilitario.php?ac=chofer&cedC='+$('#Recepcion\\[ced_chofer_pre\\]').val()+$('#Recepcion\\[ced_chofer\\]').val());
            $('#chofer_nombre').css('display','block');
        });
        
        $('#Recepcion\\[estatus_rec\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Estatus!!!');
            } else
                $('#Guardar').removeAttr('disabled');
        });
        
        $('#Recepcion\\[carril\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Carril!!!');
            } else
                $('#Guardar').removeAttr('disabled');            
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
    UTILITARIO - RECEPCION<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <fieldset>
        <legend>Datos de la Recepcion</legend>
    <table align="center" border="0">
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
            <td colospan="2" id="asociado_nombre">
            <? 
                echo $html->select('Recepcion.ced_asociado', array('options' => $listaAdo, 'selected' => $infoMov[0]['ced_asociado'],  'default'=>'Seleccione', 'class'=>'estilo_campos'));
            ?>
        </tr>
        <tr>
            <td>Nro Entrada</td>
            <td><? echo $html->input('Recepcion.numero', $infoMov[0]['numero'], array('type' => 'text', 'readOnly' => 'true', 'class' => 'crproductor positive')); ?></td>
            <td id='numero_msg'><? echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));?></td>
        </tr>
        <tr>
            <td>Fecha de Recepcion</td>
            <td><? echo $html->input('Recepcion.fecha_recepcion', $general->date_sql_screen($infoMov[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer; display: none;" />
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
            <td width="130px">Chofer</td>
            <td width="230px">
            <?
                echo $html->select('Recepcion.ced_chofer_pre',array('options'=>$juridico, 'selected' => $infoMov[0]['ced_chofer'][0]));
                echo $html->input('Recepcion.ced_chofer', str_replace($juridico, "", $infoMov[0]['ced_chofer']), array('type' => 'text', 'class' => 'crproductor')); 
            ?>
            </td>
        </tr>
        <tr>
            <td></td>
            <td id="chofer_nombre"></td>
        </tr>
        <tr>
            <td width="130px">Placa del Vehiculo</td>
            <td width="230px"><?=$html->input('Recepcion.placa', $infoMov[0]['placa'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
        </tr>
        <tr>
            <td></td>
            <td id="vehiculo_nombre"></td>
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
            <td>Peso Acondicionado</td>
            <td><? echo $html->input('Recepcion.peso_acon', $infoMov[0]['peso_acon'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td align="left">Peso Acondicionado (liquidar)</td>
            <td><? echo $html->input('Recepcion.peso_acon_liq', $infoMov[0]['peso_acon_liq'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Estatus</td>
            <td><? echo $html->select('Recepcion.estatus_rec',array('options'=>$listadoEstatus, 'selected' => $infoMov[0]['estatus_rec'],  'default'=>'Seleccione', 'default' => 'Seleccione'));?></td>
        </tr>
    </table>
    <? echo $html->input('Recepcion.id', $GPC['id'], array('type' => 'hidden')); ?>
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
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
                $listadoCosecha=$cosecha->infoCosechaCultivo($idCA);
                $listaP = $productor->find(array('ced_rif'=>$infoMov[0]['ced_productor']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');
                $listaAon = $productor->find(array('ced_rif'=>$infoMov[0]['ced_asociacion']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');                
                $listaAdo = $productor->find(array('ced_rif'=>$infoMov[0]['ced_asociado']), '', array('ced_rif', 'nombre'), 'list', 'ced_rif');
                $listaCarril = $carril->listaTolcarom($_SESSION['s_ca_id'], "'2'");
                $infoGuia = $guia->find(array('id'=>$infoMov[0]['id_guia']));
                $listaSubGuia = $guia->buscarSubGuias($infoMov[0]['id_guia']);

                foreach($listaCarril as $dataCarril) {
                    $listaC[$dataCarril['numero']]=$dataCarril['nombre'];
                }
                foreach($listadoE as $clave=>$valor) {
                    if ($clave <= $infoMov[0]['estatus_rec'])
                        $listadoEstatus[$clave]=$valor;
                }

                foreach($listadoCosecha as $dataCosecha) {
                    $listaCo[$dataCosecha['cosecha_id']]=$dataCosecha['cultivo_nombre'];
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
                
                $cedP=$GPC['Recepcion']['ced_productor_pre']+$GPC['Recepcion']['ced_productor'];
                if (empty($cedP)) {
                    $infoProductor = $productor->find(array('ced_rif' => $cedP));
                    if (!empty($infoProductor[0]['id']))
                        $GPC['Recepcion']['id_productor']=$infoProductor[0]['id'];                    
                }
                unset($GPC['Recepcion']['ced_productor_pre']);
                unset($GPC['Recepcion']['ced_productor']);
                
                $cedRifAon=$GPC['Recepcion']['ced_asociacion_pre']+$GPC['Recepcion']['ced_asociacion'];
                
                if (!empty($cedRifAon)) {
                    $infoAsociacion = $productor->find(array('ced_rif' => $cedRifAon));
                    
                    if (!empty($infoAsociacion[0]['id'])) 
                        $GPC['Recepcion']['id_asociacion']=$infoAsociacion[0]['id'];
                }

                unset($GPC['Recepcion']['ced_asociacion_pre']);
                unset($GPC['Recepcion']['ced_asociacion']);
                
                $cedRifAdo=$GPC['Recepcion']['ced_asociado_pre']+$GPC['Recepcion']['ced_asociado'];
                
                if (!empty($cedRifAdo)) {
                    $infoAsociado = $productor->find(array('ced_rif' => $cedRifAdo));
                    if (!empty($infoAsociacion[0]['id']))
                        $GPC['Recepcion']['id_asociado']=$infoAsociacion[0]['id'];
                    
                }
                unset($GPC['Recepcion']['ced_asociado_pre']);
                unset($GPC['Recepcion']['ced_asociado']);
                
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
                unset($GPC['Recepcion']['ced_chofer']);
                unset($GPC['Recepcion']['ced_chofer_pre']);
                
                if (!empty($GPC['Recepcion']['numero_guia'])) {
                    $infoGuia = $guia->find(array('numero_guia'=>$GPC['Recepcion']['numero_guia']), '');
                    if (!empty($infoGuia[0]['id'])) {
                        echo 'Guia:'.$GPC['Recepcion']['numero_guia']."<br>";
                        $GPC['Guia']['id']=$infoGuia[0]['id'];
                        $GPC['Guia']['numero_guia']=$GPC['Recepcion']['numero_guia'];
                        $GPC['Guia']['placa_vehiculo']=$infoVehiculo[0]['placa'];
                        $GPC['Guia']['fecha_emision']=(!empty($GPC['Recepcion']['fecha_emision'])) ? $GPC['Recepcion']['fecha_emision']: 'now()';
                        $GPC['Guia']['placa_remolque']=$GPC['Recepcion']['placa_remolques'];                        
                        $guia->save($GPC['Guia']);
                    }
                
                    if (!empty($GPC['Recepcion']['numero_guia_1'])) {
                        $infoGuia = $guia->find(array('numero_guia'=>$GPC['Recepcion']['numero_guia']), '');
                        $GPC['Guia']['id']=$infoGuia[0]['id'];
                        $GPC['Guia']['numero_guia']=$GPC['Recepcion']['numero_guia'];
                        $listaSubGuia = $guia->buscarSubGuias($infoGuia[0]['id']);
                        $numGuia=count($listaSubGuia);
                        for($i=1; $i <= $numGuia; $i++) {
                            $GPC['subGuia']['id']=$infoGuia[0]['id'];
                            $GPC['subGuia']['subguia']=$GPC['Recepcion']['numero_guia_'.$i];
                            $guia->borrarSubGuias($GPC['subGuia']['id']);
                            unset($GPC['Recepcion']['numero_guia_'.$i]);
                            $guia->guardarSubGuias($GPC['subGuia']['id'], $GPC['subGuia']['subguia']);
                        }
                    }
                }
                unset($GPC['Recepcion']['numero_guia']);
                unset($GPC['Recepcion']['fecha_emision']);
                unset($GPC['Recepcion']['placa_remolques']);
                
                $infoMovimiento = $movimiento->find(array('id'=>$GPC['Recepcion']['id']));
                
                unset($GPC['Recepcion']['placa']);
                unset($GPC['Recepcion']['fecha_recepcion']);
                unset($GPC['Recepcion']['numero']);
                unset($GPC['Recepcion']['numero_guia']);
                unset($GPC['Recepcion']['placa_remolques']);
                
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
            } else 
                echo 'NO tiene var<br>';
            die();
            header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
            die();
//        default:
            //header("location: ".DOMAIN_ROOT."admin/utilitario_recepcion_listado.php?msg=error");
//            debug::pr($GPC['ac']);
//            die();
//            break;
    }
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    function cancelar(){
        window.location = '<?php echo DOMAIN_ROOT?>admin/utilitario_recepcion_listado.php';
    }
    
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#Recepcion\\[id_cosecha\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_productor_pre\\]').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_productor\\]').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_asociacion_pre\\]').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_asociacion\\]').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_asociado_pre\\]').attr('disabled', 'disabled');
                $('#Recepcion\\[ced_asociado\\]').attr('disabled', 'disabled');
                alert('Se debe elegir una Cosecha!!!');
            } else {
                $('#Recepcion\\[ced_productor_pre\\]').removeAttr('disabled');
                $('#Recepcion\\[ced_productor\\]').removeAttr('disabled');
                $('#Recepcion\\[ced_asociacion_pre\\]').removeAttr('disabled');
                $('#Recepcion\\[ced_asociacion\\]').removeAttr('disabled');
                $('#Recepcion\\[ced_asociado_pre\\]').removeAttr('disabled');
                $('#Recepcion\\[ced_asociado\\]').removeAttr('disabled');
                $('#Guardar').removeAttr('disabled');  
            }
            
        });

        $('#Recepcion\\[ced_productor\\]').live('change', function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Productor!!!');
            } else
                $('#Guardar').removeAttr('disabled');
            cedRifP=$('#Recepcion\\[ced_productor_pre\\]').val()+$('#Recepcion\\[ced_productor\\]').val();
            cedRifAdo=$('#Recepcion\\[ced_asociado_pre\\]').val()+$('#Recepcion\\[ced_asociado\\]').val();
            cedRifAon=$('#Recepcion\\[ced_asociacion_pre\\]').val()+$('#Recepcion\\[ced_asociacion\\]').val();
            $('#productor_nombre').load('../ajax/detalle_utilitario.php?ac=productor&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+"&cedRifP="+cedRifP+'&cedRifAon='+cedRifAon+'&cedRifAdo='+cedRifAdo);
        });
        
        $('#Recepcion\\[ced_asociacion\\]').live('change', function() {
            cedRifP=$('#Recepcion\\[ced_productor_pre\\]').val()+$('#Recepcion\\[ced_productor\\]').val();
            cedRifAdo=$('#Recepcion\\[ced_asociado_pre\\]').val()+$('#Recepcion\\[ced_asociado\\]').val();
            cedRifAon=$('#Recepcion\\[ced_asociacion_pre\\]').val()+$('#Recepcion\\[ced_asociacion\\]').val();
            $('#asociacion_nombre').load('../ajax/detalle_utilitario.php?ac=asociacion&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+"&cedRifP="+cedRifP+'&cedRifAon='+cedRifAon+'&cedRifAdo='+cedRifAdo);
        });
        
        $('#Recepcion\\[ced_asociado\\]').live('change', function() {
            cedRifP=$('#Recepcion\\[ced_productor_pre\\]').val()+$('#Recepcion\\[ced_productor\\]').val();
            cedRifAdo=$('#Recepcion\\[ced_asociado_pre\\]').val()+$('#Recepcion\\[ced_asociado\\]').val();
            cedRifAon=$('#Recepcion\\[ced_asociacion_pre\\]').val()+$('#Recepcion\\[ced_asociacion\\]').val();
            $('#asociado_nombre').load('../ajax/detalle_utilitario.php?ac=asociado&cosecha='+$('#Recepcion\\[id_cosecha\\]').val()+'&cedRifP='+cedRifP+'&cedRifAon='+cedRifAon+'&cedRifAdo='+cedRifAdo);
        });
        
        $('#Recepcion\\[numero\\]').live('change',function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir un Numero!!!');
            } else
                $('#Guardar').removeAttr('disabled');
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=n&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?php echo $idCA?>"+"&id=<?php echo $GPC['id']?>");
        });
        
        $('#Recepcion\\[fecha_recepcion\\]').live('change', function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Fecha!!!');
            } else
                $('#Guardar').removeAttr('disabled');  
            $('#numero_msg').load('../ajax/detalle_utilitario.php?ac=recepcion&numero='+$('#Recepcion\\[numero\\]').val()+"&fecha="+$('#Recepcion\\[fecha_recepcion\\]').val()+"&tipo=f&co="+$('#Recepcion\\[id_cosecha\\]').val()+"&ca=<?php echo $idCA?>"+"&id=<?php echo $GPC['id']?>");
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

        $('#Recepcion\\[numero_guia\\]').change(function() {
            if ($(this).val()=='') {
                $('#Guardar').attr('disabled', 'disabled');
                alert('Se debe elegir una Guia!!!');
            } else {
                $('#Guardar').removeAttr('disabled');   
                $('#subguia').load('../ajax/detalle_utilitario.php?ac=guia&numero='+$(this).val());
            }
        });
        
        $('.subguia').change(function() {
            
        });
        
        $("#form1").submit(function() {
            var isFormValid = true;
            $(".mensaje").each(function(){                 
                if ($(this).val()==1) {
                    isFormValid = false;
                    switch($(this).attr('id'))
                    {
                        case 'msg1':
                            alert("La fecha y la hora ya estan ocupadas!!!");
                            break;
                        case 'msg2':
                            alert("El chofer no existe!!!");
                            break;
                        case 'msg3':
                            alert("El Vehiculo no existe!!!");
                            break;
                        case 'msg5':
                            alert("El productor no existe!!!");
                            break;
                        case 'msg6':
                            alert("La Asociacion no existe!!!");
                            break;
                        case 'msg7':
                            alert("El Asociado no existe!!!");
                            break;
                    }                    
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
    UTILITARIO - RECEPCI&Oacute;N<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <fieldset>
        <legend>Datos de la Gu&iacute;a</legend>
        <table align="center" border="0">
            <tr>
                <td width="130px">Numero de Gu&iacute;a</td>
                <td width="230px"><?php echo $html->input('Recepcion.numero_guia',$infoMov[0]['numero_guia'], array('type' => 'text', 'class' => 'crproductor guia', 'length'=>'9'));?></td>
        </table>
        <table id="subguia" align="center" border="0">
        <?php
            $listaSubGuia = $guia->buscarSubGuias($infoMov[0]['id_guia']);
            $i=0;
            foreach($listaSubGuia as $subguia) {
                $i++;
         ?>
            <tr>
                <td width="130px">SubGu&iacute;a Nro. <?php echo $i?></td>
                <td width="230px">
                    <?php echo $html->input('Recepcion.numero_guia_'.$i, $subguia['subguia'], array('type' => 'text', 'class' => 'crproductor subguia')); ?>
                </td>
            </tr>
            <?php
                }
            ?>
            </table>
        <table align="center" border="0">
                <tr>
                    <td width="130px">Fecha de emisi&oacute;n</td>
                    <td width="230px"><?php echo $html->input('Recepcion.fecha_emision', $general->date_sql_screen($infoGuia[0]['fecha_emision'],'','es','-'), array('type' => 'text', 'class' => 'crproductor','readOnly'=>true)); ?>
                        <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer;" />
                        <script>
                            Calendar.setup({
                                trigger    : "femision",
                                inputField : "Recepcion[fecha_emision]",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoMov[0]['fecha_emision']));?>),
                                onSelect   : function() {this.hide() }
                            });
                        </script>
                    </td>
                </td>
                <tr>
                    <td></td>
                    <td id="fecha_msg"></td>
                </tr>
                </tr>
                <tr>
                    <td width="130px">Placa del Vehiculo</td>
                    <td width="230px"><?php echo $html->input('Recepcion.placa', $infoMov[0]['placa'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
                </tr>
                <tr>
                    <td></td>
                    <td id="vehiculo_nombre"></td>
                </tr>
                <tr>
                    <td width="130px">Placa del Remolque</td>
                    <td width="230px"><?php echo $html->input('Recepcion.placa_remolques', $infoGuia[0]['placa_remolque'], array('type' => 'text', 'class' => 'crproductor')); ?></td>
                </tr>
                <tr>
                    <td>Contrato</td>
                    <td>
                        <?php echo $html->input('Guia.contrato', $infoMov[0]['contrato'], array('type' => 'text', 'class' => 'crproductor')); ?>
                    </td>
                </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Recepci&oacute;n</legend>
    <table align="center" border="0">
        <tr>
            <td>Cosecha</td>
            <td colspan="2" id='cultivo_nombre' width="230px">                
            <?php //echo $html->select('Recepcion.id_cosecha', array('options' => $listaCo, 'selected' => $infoMov[0]['id_cosecha'],  'default'=>'Seleccione', 'class' => 'estilo_campos', 'disabled'=>'true')); 
            echo $html->input('Recepcion.id_cosecha', $infoMov[0]['id_cosecha'], array('type' => 'hidden'));
            echo $html->input('', $infoMov[0]['cosecha'], array('type' => 'text', 'disabled'=>'true'));
            ?>
            </td>
        </tr>
        <tr>
            <td>Productor</td>
            <td>
            <?php 
            echo $html->select('Recepcion.ced_productor_pre',array('options'=>$juridico, 'selected' => $infoMov[0]['ced_productor'][0]));
            echo $html->input('Recepcion.ced_productor', str_replace($juridico, "", $infoMov[0]['ced_productor']), array('type' => 'text', 'class' => 'crproductor'));
            ?>
            </td>
        </tr>
        <tr>
            <td></td>
            <td id="productor_nombre"></td>
        </tr>
        <tr>
            <td>Asociaci&oacute;n</td>
            <td>
                <?php
                echo $html->select('Recepcion.ced_asociacion_pre',array('options'=>$juridico, 'selected' => $infoMov[0]['ced_asociacion'][0]));
                echo $html->input('Recepcion.ced_asociacion', str_replace($juridico, "", $infoMov[0]['ced_asociacion']), array('type' => 'text', 'class' => 'crproductor'));
                ?>
            </td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2" id="asociacion_nombre" width="130px"></td></tr>
        <tr>
            <td>Asociado</td>
            <td>
            <?php 
            echo $html->select('Recepcion.ced_asociado_pre',array('options'=>$juridico, 'selected' => $infoMov[0]['ced_asociado'][0]));
            echo $html->input('Recepcion.ced_asociado', str_replace($juridico, "", $infoMov[0]['ced_asociado']), array('type' => 'text', 'class' => 'crproductor'));
            ?>
        </tr>
        <tr>
            <td></td>
             <td colospan="2" id="asociado_nombre"></td>
        </tr>
        <tr>
            <td>Nro Entrada</td>
            <td><?php echo $html->input('Recepcion.numero', $infoMov[0]['numero'], array('type' => 'text', 'readOnly' => 'true', 'class' => 'crproductor positive')); ?></td>
            <td id='numero_msg'><?php echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));?></td>
        </tr>
        <tr>
            <td>Fecha de Recepci&oacute;n</td>
            <td><?php echo $html->input('Recepcion.fecha_recepcion', $general->date_sql_screen($infoMov[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
        </tr>
        <tr>
            <td width="130px">Chofer</td>
            <td width="230px">
            <?php
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
            <td>Peso lleno 1</td>
            <td><?php echo $html->input('Recepcion.peso_01l', $infoMov[0]['peso_01l'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vacio 1</td>
            <td><?php echo $html->input('Recepcion.peso_01v', $infoMov[0]['peso_01v'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso lleno 2</td>
            <td><?php echo $html->input('Recepcion.peso_02l', $infoMov[0]['peso_02l'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vacio 2</td>
            <td><?php echo $html->input('Recepcion.peso_02v', $infoMov[0]['peso_02v'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Desc H&uacute;medad</td>
            <td><?php echo $html->input('Recepcion.humedad_des', $infoMov[0]['humedad_des'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Desc Impureza</td>
            <td><?php echo $html->input('Recepcion.impureza_des', $infoMov[0]['impureza_des'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Nro Carril</td>
            <td><?php echo $html->select('Recepcion.carril', array('options' => $listaC, 'selected' => $infoMov[0]['carril'],  'default'=>'Seleccione', 'class'=>'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Peso Acondicionado</td>
            <td><?php echo $html->input('Recepcion.peso_acon', $infoMov[0]['peso_acon'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td align="left">Peso Acondicionado (liquidar)</td>
            <td><?php echo $html->input('Recepcion.peso_acon_liq', $infoMov[0]['peso_acon_liq'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Estatus</td>
            <td><?php echo $html->select('Recepcion.estatus_rec',array('options'=>$listadoEstatus, 'selected' => $infoMov[0]['estatus_rec'],  'default'=>'Seleccione', 'default' => 'Seleccione'));?></td>
        </tr>
    </table>
    <?php echo $html->input('Recepcion.id', $GPC['id'], array('type' => 'hidden')); ?>
    </fieldset>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
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
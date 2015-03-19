<?php
    require_once('../lib/core.lib.php');

    if(!in_array($GPC['mov'], array('rec', 'des'))){
        header('location: romana_movimiento.php');
        die();
    }
    
    $recepcion = new Recepcion();
    $despacho = new Despacho();
    $listadoEjes = $recepcion->toneladasPorEje();
    foreach($listadoEjes as $valor){
        $listaEjes[$valor['id']] = $valor['nombre'];
    }

    switch ($GPC['ac']) {
        case 'guardar':
            $GPC['Recepcion']['id'] = $GPC['id'];
            if (!empty($GPC['Recepcion']['id']) && (!empty($GPC['Recepcion']['romana_ent']) || !empty($GPC['Recepcion']['romana_sal'])) && (!empty($GPC['Recepcion']['peso_01l']) || !empty($GPC['Recepcion']['peso_01v']))) {
                $formula = new Formulas();
                $evaluar = new LaMermelex();
                $resultados = new Analisis();
                    $cultivo = new Cultivo();
                $evaluar->suppress_errors = true;

                if($GPC['mov'] == 'rec' && $GPC['estatus'] == '3'){
                    $GPC['Recepcion']['estatus_rec'] = ++$GPC['estatus'];
                    $GPC['Recepcion']['fecha_pel'] = "now()";
                }elseif($GPC['mov'] == 'rec' && $GPC['estatus'] == '6'){
                    $GPC['Recepcion']['estatus_rec'] = $GPC['estatus']+3;
                    $GPC['Recepcion']['fecha_v'] = "now()";
                }elseif($GPC['mov'] == 'rec' && $GPC['estatus'] == '8'){
                    $GPC['Recepcion']['estatus_rec'] = '14';
                    $GPC['Recepcion']['fecha_v'] = "now()";
                }elseif($GPC['mov'] == 'des' && $GPC['estatus'] == '1'){
                    $GPC['Recepcion']['estatus'] = ++$GPC['estatus'];
                    $GPC['Recepcion']['fecha_v'] = "now()";
                }elseif($GPC['mov'] == 'des' && $GPC['estatus'] == '3'){
                    $GPC['Recepcion']['estatus'] = $GPC['estatus']+2;
                    $GPC['Recepcion']['fecha_pel'] = "now()";
                }

                if(($GPC['mov'] == 'rec' && ($GPC['Recepcion']['estatus_rec'] == '9')) || ($GPC['mov'] == 'des' && ($GPC['Recepcion']['estatus'] == '5'))){
                    //CALCULAR LOS PESOS PARA GUARDARLOS

                    if($GPC['mov'] == 'rec')
                        $for_mov = 1;
                    elseif($GPC['mov'] == 'des')
                        $for_mov = 2;
                    else
                        $for_mov = 3;

                    $GPC['cod_cul'] = trim(substr($GPC['cultivo'], 0, 2));
                        $infoCultivo = $cultivo->find(array('codigo' => $GPC['cod_cul']), null, 'id');
                        $orden = " ORDER BY id_centro_acopio DESC, id_cultivo, id_analisis, id";
                        $formulas = $formula->formulaCultivo($_SESSION['s_ca_id'], $infoCultivo[0]['id'], $orden, $for_mov);

                    if($GPC['mov'] == 'rec'){
                        $infoMovimiento = $recepcion->find(array('id' => $id));
                        $infoResultados = $resultados->listadoResultados($id, '', '', "'1', '2'");
                    }else{
                        $infoMovimiento = $despacho->find(array('id' => $id));
                        $infoResultados = $resultados->listadoResultados('', $id, '', "'1', '2'");
                        $descuento = $despacho->despachoDescuento($id);
                    }

                    if(!empty($infoResultados)){
                        foreach($infoResultados as $valor){
                            if($valor['codigo'] == 1){
                                if($infoMovimiento[0]['muestra'] == 0){
                                    $sumHum = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                    $sumHum2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                    //$sumHumT = $sumHum + $sumHum2;
                                }elseif($infoMovimiento[0]['muestra'] == 1){
                                    $sumHum = 0;
                                    $sumHum2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                    //$sumHumT = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 2){
                                    $sumHum = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                    $sumHum2 = 0;
                                    //$sumHumT = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                }
                            }else{
                                if($infoMovimiento[0]['muestra'] == 0){
                                    $sumImp = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                    $sumImp2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                    //$sumImpT = $sumImp + $sumImp2;
                                }elseif($infoMovimiento[0]['muestra'] == 1){
                                    $sumImp = 0;
                                    $sumImp2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                    //$sumImpT = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 2){
                                    $sumImp = 0;
                                    $sumImp2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                    //$sumImpT = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                }
                            }
                        }
                    }/*else{
                        $sumHumT = 0;
                        $sumImpT = 0;
                    }*/

                    /*
                    //PROMEDIO PARA LA HUMEDAD E IMPUREZA
                    if($infoMovimiento[0]['muestra'] == 0){
                        $promHum = $sumHumT/$GPC['cant_m'];
                        $promImp = $sumImpT/$GPC['cant_m'];
                    }else{
                        $promHum = $sumHumT;
                        $promImp = $sumImpT;
                     }*/

                    //VARIABLES A USAR PARA LOS CALCULOS
                    $reservadas = array('PL1', 'PL2', 'PV1', 'PV2', 'HUML', 'IMPL', 'PHUM', 'PIMP');
                    $GPC['Recepcion']['pesoLleno2'] = (!empty($GPC['Recepcion']['pesoLleno2'])) ? $GPC['Recepcion']['pesoLleno2'] : 0;
                    $GPC['Recepcion']['peso_02v'] = (!empty($GPC['Recepcion']['peso_02v'])) ? $GPC['Recepcion']['peso_02v'] : 0;

                    /*if($GPC['mov'] == 'rec')
                        $pesos = array($GPC['Recepcion']['pesoLleno1'], $GPC['Recepcion']['pesoLleno2'], $GPC['Recepcion']['peso_01v'], $GPC['Recepcion']['peso_02v'], $promHum, $promImp);
                    else{*/
                        $pesos = array($GPC['Recepcion']['pesoLleno1'], 0, $GPC['Recepcion']['peso_01v'], 0, $sumHum, $sumImp);
                        $pesos2 = array(0, $GPC['Recepcion']['pesoLleno2'], 0, $GPC['Recepcion']['peso_02v'], $sumHum2, $sumImp2);
                    //}

                    //ALMACENAR FORMULAS EN ARREGLO
                    $otra = false;
                    foreach($formulas as $valor){
                        if($valor['codigo'] == 'PL12')
                            $formulaAplicar['PL'] = $valor['formula'];
                        elseif($valor['codigo'] == 'PV12')
                            $formulaAplicar['PV'] = $valor['formula'];
                        elseif($valor['codigo'] == 'PN')
                            $formulaAplicar['PN'] = $valor['formula'];
                        elseif($valor['codigo'] == 'PA')
                            $formulaAplicar['PA'] = $valor['formula'];
                        else{
                            if(empty($valor['condicion'])){
                                $humImp[] = $valor['formula'];
                                $humImp2[] = $valor['formula'];
                            }else{
                                if($valor['id_analisis'] == 1){
                                    $rango = split('<',$valor['condicion']);
                                    if(($sumHum >= $rango[0]) && ($sumHum < $rango[1]))
                                        $humImp[] = $valor['formula'];
                                    if(($sumHum2 >= $rango[0]) && ($sumHum2 < $rango[1]))
                                        $humImp2[] = $valor['formula'];
                                }elseif($valor['id_analisis'] == 2){
                                    $rango = split('<',$valor['condicion']);
                                    if(($sumImp >= $rango[0]) && ($sumImp < $rango[1]))
                                        $humImp[] = $valor['formula'];
                                    if(($sumImp2 >= $rango[0]) && ($sumImp2 < $rango[1]))
                                        $humImp2[] = $valor['formula'];
                                }else{
                                    $rango = split('=',$valor['condicion']);
                                    $rangoEvaluar = split('<', $rango[1]);
                                    $calculoFormula = str_replace($reservadas, $pesos, $rango[0]);
                                    $calculoFormula2 = str_replace($reservadas, $pesos2, $rango[0]);
                                    if ($evaluar->evaluate('y(x) = ' . $calculoFormula))
                                        $condicionFormula = $evaluar->e("y(0)");
                                    if ($evaluar->evaluate('y(x) = ' . $calculoFormula2))
                                        $condicionFormula2 = $evaluar->e("y(0)");
                                    
                                    if(($condicionFormula >= $rangoEvaluar[0]) && ($condicionFormula <= $rangoEvaluar[1]))
                                        $otraFormula[] = $valor['formula'];
                                    else{
                                        $otraFormula[] = $valor['formula'];
                                        $otra = true;
                                    }
                                    
                                    if(($condicionFormula2 >= $rangoEvaluar[0]) && ($condicionFormula2 <= $rangoEvaluar[1]))
                                        $otraFormula2[] = $valor['formula'];
                                    else{
                                        $otraFormula2[] = $valor['formula'];
                                        $otra2 = true;
                                    }
                                }
                            }
                        }
                    }

                    if($otra)
                        $otraFormula[1] = $formulaAplicar['PN'];
                    if($otra2)
                        $otraFormula2[1] = $formulaAplicar['PN'];

                    //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                    if($descuento[0]['descuento'] == 't' || $GPC['mov'] == 'rec'){
                        if(!empty($humImp)){
                            //CALCULO DE LA HUMEDAD
                            $totalH = str_replace($reservadas, $pesos, $humImp[0]);
                            if ($evaluar->evaluate('y(x) = ' . $totalH))
                                $pesoH = $evaluar->e("y(0)");
                            $pesos[] = $pesoH;

                            //CALCULO DE LA IMPUREZA
                            $totalI = str_replace($reservadas, $pesos, $humImp[1]);
                            if ($evaluar->evaluate('y(x) = ' . $totalI))
                                $pesoI = $evaluar->e("y(0)");
                            $pesos[] = $pesoI;
                        }
                    }else{
                        $pesos[] = 0;
                        $pesos[] = 0;
                    }

                    if(!empty($otraFormula)){
                        //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                        $totalA = str_replace($reservadas, $pesos, $otraFormula[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalA))
                        $pesoA = $evaluar->e("y(0)");

                        if(!empty($otraFormula[1])){
                            $totalAl = str_replace($reservadas, $pesos, $otraFormula[1]);
                            if ($evaluar->evaluate('y(x) = ' . $totalAl))
                            $pesoAl = $evaluar->e("y(0)");
                        }
                    }else{
                        //PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON FORMULACION POR HUMEDAD E IMPUREZAS
                        $totalAl = str_replace($reservadas, $pesos, $formulaAplicar['PA']);
                        if ($evaluar->evaluate('y(x) = ' . $totalAl))
                            $pesoAl = $evaluar->e("y(0)");
                    }

                    //CALCULO DEL PESO NETO
                    $totalN = str_replace($reservadas, $pesos, $formulaAplicar['PN']);
                    if ($evaluar->evaluate('y(x) = ' . $totalN))
                        $pesoN = $evaluar->e("y(0)");

                    //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                    $totalA = str_replace($reservadas, $pesos, $otraFormula[0]);
                    if ($evaluar->evaluate('y(x) = ' . $totalA))
                        $pesoA = $evaluar->e("y(0)");

                    $totalAl = str_replace($reservadas, $pesos, $otraFormula[1]);
                    if ($evaluar->evaluate('y(x) = ' . $totalAl))
                        $pesoAl = $evaluar->e("y(0)");

                    if(($sumHum2 != '' || $sumImp2 != '' || $GPC['Recepcion']['pesoLleno2'] != '' || $GPC['Recepcion']['peso_02v'] != '')){
                        //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                        if($descuento[0]['descuento'] == 't' || $GPC['mov'] == 'rec'){
                            if(!empty($humImp)){
                                //CALCULO DE LA HUMEDAD
                                $totalH2 = str_replace($reservadas, $pesos2, $humImp2[0]);
                                if ($evaluar->evaluate('y(x) = ' . $totalH2))
                                    $pesoH2 = $evaluar->e("y(0)");
                                $pesos2[] = $pesoH2;

                                //CALCULO DE LA IMPUREZA
                                $totalI2 = str_replace($reservadas, $pesos2, $humImp2[1]);
                                if ($evaluar->evaluate('y(x) = ' . $totalI2))
                                    $pesoI2 = $evaluar->e("y(0)");
                                $pesos2[] = $pesoI2;
                            }
                        }else{
                            $pesos2[] = 0;
                            $pesos2[] = 0;
                        }

                        if(!empty($otraFormula2)){
                            //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                            $totalA2 = str_replace($reservadas, $pesos2, $otraFormula2[0]);
                            if ($evaluar->evaluate('y(x) = ' . $totalA2))
                            $pesoA2 = $evaluar->e("y(0)");

                            if(!empty($otraFormula2[1])){
                                $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula2[1]);
                                if ($evaluar->evaluate('y(x) = ' . $totalAl2))
                                $pesoAl2 = $evaluar->e("y(0)");
                            }
                        }else{
                            //PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON FORMULACION POR HUMEDAD E IMPUREZAS
                            $totalAl2 = str_replace($reservadas, $pesos2, $formulaAplicar['PA']);
                            if ($evaluar->evaluate('y(x) = ' . $totalAl2))
                                $pesoAl2 = $evaluar->e("y(0)");
                        }

                        //CALCULO DEL PESO NETO
                        $totalN2 = str_replace($reservadas, $pesos2, $formulaAplicar['PN']);
                        if ($evaluar->evaluate('y(x) = ' . $totalN2))
                            $pesoN2 = $evaluar->e("y(0)");

                        //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                        $totalA2 = str_replace($reservadas, $pesos2, $otraFormula2[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalA2))
                            $pesoA2 = $evaluar->e("y(0)");

                        $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula2[1]);
                        if ($evaluar->evaluate('y(x) = ' . $totalAl2))
                            $pesoAl2 = $evaluar->e("y(0)");
                    }
                
                    /*if($GPC['mov'] == 'rec'){
                        $GPC['Recepcion']['humedad'] = ($GPC['Recepcion']['estatus_rec'] != '14') ? $promHum : 0;
                        $GPC['Recepcion']['impureza'] = ($GPC['Recepcion']['estatus_rec'] != '14') ? $promImp : 0;
                        $GPC['Recepcion']['humedad_des'] = ($GPC['Recepcion']['estatus_rec'] != '14') ? $pesoH : 0;
                        $GPC['Recepcion']['impureza_des'] = ($GPC['Recepcion']['estatus_rec'] != '14') ?  $pesoI : 0;
                        $GPC['Recepcion']['peso_acon'] = ($GPC['Recepcion']['estatus_rec'] != '14') ? $pesoA : $pesoN;
                        $GPC['Recepcion']['peso_acon_liq'] = ($GPC['Recepcion']['estatus_rec'] != '14') ? $pesoAl : $pesoN;
                    }else{*/
                        $GPC['Recepcion']['humedad'] = $sumHum;
                        $GPC['Recepcion']['impureza'] = $sumImp;
                        $GPC['Recepcion']['humedad_des'] = $pesoH;
                        $GPC['Recepcion']['impureza_des'] = $pesoI;
                        $GPC['Recepcion']['peso_acon'] = $pesoA;
                        $GPC['Recepcion']['peso_acon_liq'] = $pesoAl;
                        
                        $GPC['Recepcion']['humedad2'] = $sumHum2;
                        $GPC['Recepcion']['impureza2'] = $sumImp2;
                        $GPC['Recepcion']['humedad_des2'] = $pesoH2;
                        $GPC['Recepcion']['impureza_des2'] = $pesoI2;
                        $GPC['Recepcion']['peso_acon2'] = $pesoA2;
                        $GPC['Recepcion']['peso_acon_liq2'] = $pesoAl2;
                    //}

                    if($GPC['mov'] == 'rec'){
                        unset($GPC['Recepcion']['pesoLleno1']);
                        unset($GPC['Recepcion']['pesoLleno2']);
                        $recepcion->save($GPC['Recepcion']);
                        $idMovimiento = $recepcion->id;
                    }else{
                        $GPC['Recepcion']['peso_01l'] = $GPC['Recepcion']['pesoLleno1'];
                        $GPC['Recepcion']['peso_02l'] = $GPC['Recepcion']['pesoLleno2'];
                        unset($GPC['Recepcion']['pesoLleno1']);
                        unset($GPC['Recepcion']['pesoLleno2']);
                        $despacho->save($GPC['Recepcion']);
                        $idMovimiento = $despacho->id;
                    }
                    
                }elseif($GPC['mov'] == 'rec' && ($GPC['Recepcion']['estatus_rec'] == '4')){
                    //RECEPCION PESO LLENO
                    $recepcion->save($GPC['Recepcion']);
                    $idMovimiento = $recepcion->id;
                    
                }elseif($GPC['mov'] == 'des' && ($GPC['Recepcion']['estatus'] == '2')){
                    //DESPACHO PESO VACIO
                    $despacho->save($GPC['Recepcion']);
                    $idMovimiento = $despacho->id;
                    
                }
            }
            if (!empty($idMovimiento) && (($GPC['mov'] == 'rec' && (in_array($GPC['Recepcion']['estatus_rec'], array(9, 14)))) || ($GPC['mov'] == 'des' && $GPC['Recepcion']['estatus'] == '5'))) {
                header("location: ".DOMAIN_ROOT."reportes/imprimir.php?reporte=boleta_liquidacion&redir=romana_listado&id_rec=$idMovimiento&ca=".$_SESSION['s_ca_id']."&mov=".$GPC['mov']."&status=9");
                die();
            } elseif (!empty($idMovimiento) && (($GPC['mov'] == 'rec' && $GPC['Recepcion']['estatus_rec'] == '4') || ($GPC['mov'] == 'des' && $GPC['Recepcion']['estatus'] == '2'))){
                header("location: ".DOMAIN_ROOT."admin/romana_listado.php?msg=exitoso&mov=".$GPC['mov']);
                die();
            } else {
                header("location: ".DOMAIN_ROOT."admin/romana_listado.php?msg=error&mov=".$GPC['mov']);
                die();
            }
        break;
        case 'pesar':
            $romana = new Tolcarom();
            
            $infoMovimiento = ($GPC['mov'] == 'rec') ? $recepcion->listadoRecepcion($GPC['id']) : $despacho->listadoDespacho($GPC['id']);
            $infoRomana = $romana->listaTolcarom($_SESSION['s_ca_id'], "'3'");
            foreach($infoRomana as $valor){
                $listaRomanas[$valor['id']] = $valor['nombre'];
            }

            $vehiculo = (!empty($infoMovimiento[0]['marca'])) ? $infoMovimiento[0]['marca']."/" : "Sin Marca/";
            $vehiculo .= $infoMovimiento[0]['placa'];
            $cultivo = trim($infoMovimiento[0]['cultivo_codigo'])." ".trim($infoMovimiento[0]['cultivo_nombre']);
            break;
    }
    
    require('../lib/common/header.php');

    $validator = new Validator('form1');
    $validator->printIncludes();
    if($GPC['mov'] == 'rec' && $infoMovimiento[0]['estatus_rec'] == '3'){
        $validator->setRules('Recepcion.romana_ent', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01l', array('required' => array('value' => true, 'message' => 'Requerido')));
    }elseif($GPC['mov'] == 'rec' && $infoMovimiento[0]['estatus_rec'] == '6'){
        $validator->setRules('Recepcion.romana_sal', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01v', array('required' => array('value' => true, 'message' => 'Requerido')));
    }elseif($GPC['mov'] == 'des' && $infoMovimiento[0]['estatus_rec'] == '1'){
        $validator->setRules('Recepcion.romana_ent', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01v', array('required' => array('value' => true, 'message' => 'Requerido')));
    }elseif($GPC['mov'] == 'des' && $infoMovimiento[0]['estatus_rec'] == '3'){
        $validator->setRules('Recepcion.romana_sal', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01l', array('required' => array('value' => true, 'message' => 'Requerido')));
    }
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'romana_listado.php?mov=<?php echo $GPC['mov']?>';
    }
    
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#cant_ejes').change(function(){
            var opc = $(this).val();
            if(opc != '')
                $('#pesoEjes').load('../ajax/detalle_formula.php?ac=ejes&opc='+opc);
            else{
                $('#pesoEjes').html('');
                alert('Elija la Cantidad de Ejes');
            }
        });
        
        $('.verifPeso').live('blur', function(){
            if($(this).val() != ''){
                var form = $('#form1').serialize();
                $("#resultado").load('../ajax/detalle_formula.php?ac=pesoromana&formula='+form);
            }
        });
        
        /*$('#Guardar').click(function(){
            var contador = 0;
            $(".verifPeso").each(function(){
                if($(this).val() == ''){
                    contador++;
                    $(this).focus();
                    return false;
                }else
                    contador = 0;
            });
            if(contador != 0){
                alert('Complete el Campo Vacio');
                return false;
            }else{
                if(!confirm('Desea Guardar'))
                    return false;
                else
                    show_div_loader();
            }
        });*/
        
        $(".capturar").live('click', function() {
            var id = $(this).attr('id').substring(5);
            var tipo_mov = $('#mov').val();
            var romana;
            
            if(typeof($('#Recepcion\\[romana_ent\\]').val()) != 'undefined' && $('#Recepcion\\[romana_ent\\]').val() != '')
                romana = $('#Recepcion\\[romana_ent\\]').val();
            
            if(typeof($('#Recepcion\\[romana_sal\\]').val()) != 'undefined' && $('#Recepcion\\[romana_sal\\]').val() != '')
                romana = $('#Recepcion\\[romana_sal\\]').val();
            
            romana = (romana != '' && typeof(romana) != 'undefined') ? romana : '';
            
            if((tipo_mov == 'rec' || tipo_mov == 'des') && romana != ''){
                td = '#capturarPeso'+id;
                var status = $('#estatus').val();
                $(td).load("../ajax/detalle_formula.php?ac=pesar&status=<?php echo $GPC['mov']?>-"+status+"-"+romana+"&boton="+id);
            }else
                alert('Seleccione la Romana');
        });
    });
</script>
<div id="titulo_modulo">
    ROMANA<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php
        echo $html->input('id', $infoMovimiento[0]['id'], array('type' => 'hidden'));
        echo $html->input('estatus', $infoMovimiento[0]['estatus_rec'], array('type' => 'hidden'));
        echo $html->input('cant_m', $infoMovimiento[0]['cant_muestras'], array('type' => 'hidden'));
        echo $html->input('rechazada', $infoMovimiento[0]['muestra'], array('type' => 'hidden'));
        echo $html->input('mov', $GPC['mov'], array('type' => 'hidden'));
    ?>
    <table align="center">
        <tr>
            <td>N&uacute;mero de <?php echo $tipoMovimiento = ($GPC['mov'] == 'rec') ? 'Entrada' : 'Salida';?></td>
            <td><?php echo $html->input('entrada', $infoMovimiento[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Fecha de <?php echo $fechaMovimiento = ($GPC['mov'] == 'rec') ? 'Recepci&oacute;n' : 'Despacho';?></td>
            <td><?php echo $html->input('fecha', $general->date_sql_screen($infoMovimiento[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de <?php echo $docMovimiento = ($GPC['mov'] == 'rec') ? 'Gu&iacute;a' : 'Orden';?></td>
            <td><?php echo $html->input('guia', $infoMovimiento[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Veh&iacute;culo</td>
            <td><?php echo $html->input('vehiculo', $vehiculo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Chofer</td>
            <td><?php echo $html->input('chofer', $infoMovimiento[0]['chofer_nombre'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><?php echo $html->input('cultivo', $cultivo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <?php
            //PESOS PARA RECEPCIONES
            if($GPC['mov'] == 'rec'){
                //PESO LLENO PARA RECEPCION
                if($infoMovimiento[0]['estatus_rec'] == '3'){
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Romana de Entrada</td>
            <td><?php echo $html->select('Recepcion.romana_ent', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <?php
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
                        if($infoMovimiento[0]['muestra'] == 0){
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso<?php echo $i?>">
                <?php
                    echo $html->input('Recepcion.peso_0'.$i.'l', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                        }elseif($infoMovimiento[0]['muestra'] == 1){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input('peso_0l', 'RECHAZADO', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive')); ?></td>
        </tr>
        <?php
                            }else{
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso1">
                <?php
                    echo $html->input('Recepcion.peso_01l', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    echo $html->input('pesar1', 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                            }
                        }elseif($infoMovimiento[0]['muestra'] == 2){
                            if($i == 1){
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso1">
                <?php
                    echo $html->input('Recepcion.peso_01l', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    echo $html->input('pesar1', 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input('peso_0l', 'RECHAZADO', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive')); ?></td>
        </tr>
        <?php
                            }
                        }
                    }
                //PESO VACIO PARA RECEPCION
                }elseif(in_array($infoMovimiento[0]['estatus_rec'], array(6, 8))){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><?php echo $html->input('romana_ent', $infoMovimiento[0]['romana_ent'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Romana de Salida</td>
            <td><?php echo $html->select('Recepcion.romana_sal', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <?php
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
                        if($infoMovimiento[0]['muestra'] == 0){
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input("Recepcion.pesoLleno$i", $infoMovimiento[0]['peso_0'.$i.'l'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso<?php echo $i?>">
                <?php
                    echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                    
                        }elseif($infoMovimiento[0]['muestra'] == 1){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input("pesoLleno$i", 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos2 positive', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input('peso_0'.$i.'v', 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos2 positive verifPeso', 'readOnly' => true)); ?></td>
        </tr>
        <?php
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input("Recepcion.pesoLleno1", $infoMovimiento[0]['peso_01l'], array('type' => 'text', 'class' => 'estilo_campos2 positive', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso1">
                <?php
                    echo $html->input('Recepcion.peso_01v', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                            }
                        }elseif($infoMovimiento[0]['muestra'] == 2){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input("Recepcion.pesoLleno1", $infoMovimiento[0]['peso_01l'], array('type' => 'text', 'class' => 'estilo_campos2 positive', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso1">
                <?php
                    echo $html->input('Recepcion.peso_01v', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input("pesoLleno$i", 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos2 positive', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input('peso_0'.$i.'v', 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos2 positive verifPeso', 'readOnly' => true)); ?></td>
        </tr>
        <?php
                            }
                        }
                    }
                }
            //PESOS PARA DESPACHO
            }elseif($GPC['mov'] == 'des'){
                //PESO VACIO PARA DESPACHO
                if($infoMovimiento[0]['estatus_rec'] == '1'){
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Romana de Entrada</td>
            <td><?php echo $html->select('Recepcion.romana_ent', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <?php
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Vacio <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso<?php echo $i?>">
                <?php
                    echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php          }
                //PESO LLENO PARA DESPACHO    
                }elseif($infoMovimiento[0]['estatus_rec'] == '3'){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><?php echo $html->input('romana_ent', $infoMovimiento[0]['romana_ent'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Romana de Salida</td>
            <td><?php echo $html->select('Recepcion.romana_sal', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <tr>
            <td>Cantidad de Ejes</td>
            <td><?php echo $html->select('cant_ejes', array('options' => $listaEjes, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <tbody id="pesoEjes"></tbody>
        <?php
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
        ?>
        <tr>
            <td><span class="msj_rojo">* </span>Peso Vac&iacute;o <?php echo $pesar?> Kgrs</td>
            <td><?php echo $html->input('Recepcion.peso_0'.$i.'v', $infoMovimiento[0]['peso_0'.$i.'v'], array('type' => 'text', 'class' => 'estilo_campos2 positive', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Lleno <?php echo $pesar?> Kgrs</td>
            <td id="capturarPeso<?php echo $i?>">
                <?php
                    echo $html->input("Recepcion.pesoLleno$i", '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                    echo $html->input('pesar'.$i, 'PESAR', array('type' => 'button', 'class' => 'capturar'));
                ?>
            </td>
        </tr>
        <?php
                    }
                }
            }
        ?>
        <tbody id="resultado" class="verif_resul"></tbody>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?php
                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit'));
                    echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()'));
                ?>
            </td>
        </tr>
    </table>
</form>
<?php
    require('../lib/common/footer.php');
?>
<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');

    if(!in_array($GPC['mov'], array('rec', 'des'))){
        header('location: romana_movimiento.php');
        die();
    }
    
    $recepcion = new Recepcion();
    $despacho = new Despacho();

    switch ($GPC['ac']) {
        case 'guardar':
            $GPC['Recepcion']['id'] = $GPC['id'];
            if (!empty($GPC['Recepcion']['id']) && (!empty($GPC['Recepcion']['romana_ent']) || !empty($GPC['Recepcion']['romana_sal'])) && (!empty($GPC['Recepcion']['peso_01l']) || !empty($GPC['Recepcion']['peso_01v']))) {
                $formula = new Formulas();
                $evaluar = new LaMermelex();
                $resultados = new Analisis();
                $evaluar->suppress_errors = true;
                
                if($GPC['mov'] == 'rec' && $GPC['estatus'] == '3'){
                    $GPC['Recepcion']['estatus_rec'] = ++$GPC['estatus'];
                    $GPC['Recepcion']['fecha_pel'] = "now()";
                }elseif($GPC['mov'] == 'rec' && $GPC['estatus'] == '6'){
                    $GPC['Recepcion']['estatus_rec'] = $GPC['estatus']+3;
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
                    $orden = " ORDER BY id_centro_acopio DESC, id_cultivo, id_analisis";
                    $formulas = $formula->formulaCultivo($_SESSION['s_ca_id'], trim(substr($GPC['cultivo'], 0, 2)), $orden);
                    
                    if($GPC['mov'] == 'rec'){
                        $infoMovimiento = $recepcion->find(array('id' => $id));
                        $infoResultados = $resultados->listadoResultados($id, '', '', "'1', '2'");
                    }else{
                        $infoMovimiento = $despacho->find(array('id' => $id));
                        $infoResultados = $resultados->listadoResultados('', $id, '', "'1', '2'");
                    }
                    
                    if(!empty($infoResultados)){
                        foreach($infoResultados as $valor){
                            if($valor['codigo'] == 1){
                                if($infoMovimiento[0]['muestra'] == 0){
                                    $sumHum = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                    $sumHum += (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 1){
                                    $sumHum = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 2){
                                    $sumHum = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                }
                            }else{
                                if($infoMovimiento[0]['muestra'] == 0){
                                    $sumImp = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                    $sumImp += (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 1){
                                    $sumImp = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                }elseif($infoMovimiento[0]['muestra'] == 2){
                                    $sumImp = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                }
                            }
                        }
                    }else{
                        $sumHum = 0;
                        $sumImp = 0;
                    }
                    
                     //PROMEDIO PARA LA HUMEDAD
                    if($infoMovimiento[0]['muestra'] == 0)
                        $GPC['Recepcion']['humedad'] = $sumHum/$GPC['cant_m'];
                    else
                        $GPC['Recepcion']['humedad'] = $sumHum;

                    //PROMEDIO PARA LA IMPUREZA
                    if($infoMovimiento[0]['muestra'] == 0)
                        $GPC['Recepcion']['impureza'] = $sumImp/$GPC['cant_m'];
                    else
                        $GPC['Recepcion']['impureza'] = $sumImp;
                    
                    //VARIABLES A USAR PARA LOS CALCULOS
                    $reservadas = array('PL1', 'PL2', 'PV1', 'PV2', 'HUML', 'IMPL', 'PHUM', 'PIMP');
                    $GPC['Recepcion']['pesoLleno2'] = (!empty($GPC['Recepcion']['pesoLleno2'])) ? $GPC['Recepcion']['pesoLleno2'] : 0;
                    $GPC['Recepcion']['peso_02v'] = (!empty($GPC['Recepcion']['peso_02v'])) ? $GPC['Recepcion']['peso_02v'] : 0;
                    $pesos = array($GPC['Recepcion']['pesoLleno1'], $GPC['Recepcion']['pesoLleno2'], $GPC['Recepcion']['peso_01v'], $GPC['Recepcion']['peso_02v'], $GPC['Recepcion']['humedad'], $GPC['Recepcion']['impureza']);

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
                            if(empty($valor['condicion']))
                                $humImp[] = $valor['formula'];
                            else{
                                $rango = split('<',$valor['condicion']);
                                if($valor['id_analisis'] == 1){
                                    if(($GPC['Recepcion']['humedad'] >= $rango[0]) && ($GPC['Recepcion']['humedad'] < $rango[1]))
                                        $humImp[] = $valor['formula'];
                                }elseif($valor['id_analisis'] == 2){
                                    if(($GPC['Recepcion']['impureza'] >= $rango[0]) && ($GPC['Recepcion']['impureza'] < $rango[1]))
                                        $humImp[] = $valor['formula'];
                                }else{
                                    $rango = split('=',$valor['condicion']);
                                    $rangoEvaluar = split('<', $rango[1]);
                                    $calculoFormula = str_replace($reservadas, $pesos, $rango[0]);
                                    if ($evaluar->evaluate('y(x) = ' . $calculoFormula)){
                                        $condicionFormula = $evaluar->e("y(0)");
                                    }
                                    if(($condicionFormula >= $rangoEvaluar[0]) && ($condicionFormula <= $rangoEvaluar[1]))
                                        $otraFormula[] = $valor['formula'];
                                    else
                                        $otra = true;
                                }
                            }
                        }
                    }
                    
                    if(empty($otraFormula) && $otra)
                        $otraFormula[] = $formulaAplicar['PN'];

                    //CALCULO DEL PESO BRUTO
                    $totalB = str_replace($reservadas, $pesos, $formulaAplicar['PL']);
                    if ($evaluar->evaluate('y(x) = ' . $totalB))
                        $pesoL = $evaluar->e("y(0)");

                    //CALCULO DE LA TARA
                    $totalV = str_replace($reservadas, $pesos, $formulaAplicar['PV']);
                    if ($evaluar->evaluate('y(x) = ' . $totalV))
                        $pesoV = $evaluar->e("y(0)");

                    //CALCULO DEL PESO NETO
                    $totalN = str_replace($reservadas, $pesos, $formulaAplicar['PN']);
                    if ($evaluar->evaluate('y(x) = ' . $totalN))
                        $pesoN = $evaluar->e("y(0)");

                    //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                    if(!empty($humImp)){
                        //CALCULO DE LA HUMEDAD
                        $totalH = str_replace($reservadas, $pesos, $humImp[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalH))
                            $pesoH = $evaluar->e("y(0)");
                        $GPC['Recepcion']['humedad_des'] = round($pesoH * 1000) / 1000;
                        $pesos[] = $GPC['Recepcion']['humedad_des'];

                        //CALCULO DE LA IMPUREZA
                        $totalI = str_replace($reservadas, $pesos, $humImp[1]);
                        if ($evaluar->evaluate('y(x) = ' . $totalI))
                            $pesoI = $evaluar->e("y(0)");
                        $GPC['Recepcion']['impureza_des'] = round($pesoI * 1000) / 1000;
                        $pesos[] = $GPC['Recepcion']['impureza_des'];
                    }

                    if(!empty($otraFormula)){
                        //PESO ACONDICIONADO, PARA EL CASO DE CULTIVOS QUE NO APLIQUEN EL CALCULO DE HUMEDAD E IMPUREZA
                        $totalA = str_replace($reservadas, $pesos, $otraFormula[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalA))
                        $pesoA = $evaluar->e("y(0)");
                    }else{
                        //PESO ACONDICIONADO, PARA EL CASO DE CULTIVOS QUE APLIQUEN EL CALCULO DE HUMEDAD E IMPUREZA
                        $totalA = str_replace($reservadas, $pesos, $formulaAplicar['PA']);
                        if ($evaluar->evaluate('y(x) = ' . $totalA))
                            $pesoA = $evaluar->e("y(0)");
                    }
                    
                    $GPC['Recepcion']['peso_acon'] = round($pesoA * 1000) / 1000;
                    
                    if($GPC['mov'] == 'rec'){
                        unset($GPC['Recepcion']['pesoLleno1']);
                        unset($GPC['Recepcion']['pesoLleno2']);
                    }else{
                        $GPC['Recepcion']['peso_01l'] = $GPC['Recepcion']['pesoLleno1'];
                        $GPC['Recepcion']['peso_02l'] = $GPC['Recepcion']['pesoLleno2'];
                        unset($GPC['Recepcion']['pesoLleno1']);
                        unset($GPC['Recepcion']['pesoLleno2']);
                    }
                    if($GPC['mov'] == 'rec'){
                        $recepcion->save($GPC['Recepcion']);
                        $idMovimiento = $recepcion->id;
                    }else{
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
            if (!empty($idMovimiento) && (($GPC['mov'] == 'rec' && $GPC['Recepcion']['estatus_rec'] == '9') || ($GPC['mov'] == 'des' && $GPC['Recepcion']['estatus'] == '5'))) {
                header("location: ".DOMAIN_ROOT."reportes/imprimir.php?reporte=boleta_liquidacion&redir=romana_listado&id_rec=$idMovimiento&mov=".$GPC['mov']);
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
            //Debug::pr($infoMovimiento);
            break;
    }

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
        window.location = 'romana_listado.php?mov=<?=$GPC['mov']?>';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
        
        $('.verifPeso').blur(function(){
            if($(this).val() != ''){
                var form = $('#form1').serialize();
                $("#resultado").load('../ajax/detalle_formula.php?ac=pesoromana&formula='+form);
            }
        });
        
        $('#Guardar').click(function(){
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
            }
        });
    });
</script>
<div id="titulo_modulo">
    ROMANA<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?
        echo $html->input('id', $infoMovimiento[0]['id'], array('type' => 'hidden'));
        echo $html->input('estatus', $infoMovimiento[0]['estatus_rec'], array('type' => 'hidden'));
        echo $html->input('cant_m', $infoMovimiento[0]['cant_muestras'], array('type' => 'hidden'));
        echo $html->input('rechazada', $infoMovimiento[0]['muestra'], array('type' => 'hidden'));
        echo $html->input('mov', $GPC['mov'], array('type' => 'hidden'));
    ?>
    <table align="center">
        <tr>
            <td>N&uacute;mero de <?=$tipoMovimiento = ($GPC['mov'] == 'rec') ? 'Entrada' : 'Salida';?></td>
            <td><? echo $html->input('entrada', $infoMovimiento[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Fecha de <?=$fechaMovimiento = ($GPC['mov'] == 'rec') ? 'Recepci&oacute;n' : 'Despacho';?></td>
            <td><? echo $html->input('fecha', $general->date_sql_screen($infoMovimiento[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de <?=$docMovimiento = ($GPC['mov'] == 'rec') ? 'Gu&iacute;a' : 'Orden';?></td>
            <td><? echo $html->input('guia', $infoMovimiento[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Veh&iacute;culo</td>
            <td><? echo $html->input('vehiculo', $vehiculo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Chofer</td>
            <td><? echo $html->input('chofer', $infoMovimiento[0]['chofer_nombre'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><? echo $html->input('cultivo', $cultivo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <?
            //PESOS PARA RECEPCIONES
            if($GPC['mov'] == 'rec'){
                //PESO LLENO PARA RECEPCION
                if($infoMovimiento[0]['estatus_rec'] == '3'){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><? echo $html->select('Recepcion.romana_ent', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <?
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
                        if($infoMovimiento[0]['muestra'] == 0){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'l', '', array('type' => 'text', 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?
                        }elseif($infoMovimiento[0]['muestra'] == 1){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input('peso_0l', 'RECHAZADO', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_01l', '', array('type' => 'text', 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?
                            }
                        }elseif($infoMovimiento[0]['muestra'] == 2){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_01l', '', array('type' => 'text', 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input('peso_0l', 'RECHAZADO', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?
                            }
                        }
                    }
                //PESO VACIO PARA RECEPCION
                }elseif($infoMovimiento[0]['estatus_rec'] == '6'){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><? echo $html->input('romana_ent', $infoMovimiento[0]['romana_ent'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Romana de Salida</td>
            <td><? echo $html->select('Recepcion.romana_sal', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
                        if($infoMovimiento[0]['muestra'] == 0){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("Recepcion.pesoLleno$i", $infoMovimiento[0]['peso_0'.$i.'l'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <?
                    
                        }elseif($infoMovimiento[0]['muestra'] == 1){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("pesoLleno$i", 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('peso_0'.$i.'v', 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso', 'readOnly' => true)); ?></td>
        </tr>
        <?
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("Recepcion.pesoLleno1", $infoMovimiento[0]['peso_01l'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_01v', '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <?
                            }
                        }elseif($infoMovimiento[0]['muestra'] == 2){
                            if($i == 1){
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("Recepcion.pesoLleno1", $infoMovimiento[0]['peso_01l'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_01v', '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <?
                            }else{
        ?>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("pesoLleno$i", 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('peso_0'.$i.'v', 'RECHAZADO', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso', 'readOnly' => true)); ?></td>
        </tr>
        <?
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
            <td>Romana de Entrada</td>
            <td><? echo $html->select('Recepcion.romana_ent', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')); ?></td>
        </tr>
        <?
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
        ?>
        <tr>
            <td>Peso Vacio <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'class' => 'estilo_campos2 integer')); ?></td>
        </tr>
        <?          }
                //PESO LLENO PARA DESPACHO    
                }elseif($infoMovimiento[0]['estatus_rec'] == '3'){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><? echo $html->input('romana_ent', $infoMovimiento[0]['romana_ent'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Romana de Salida</td>
            <td><? echo $html->select('Recepcion.romana_sal', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?
                    for($i=1; $i<=$infoMovimiento[0]['cant_muestras']; $i++){
                        $pesar = ($i == 1) ? 'Motriz' : 'Remolque';
        ?>
        <tr>
            <td>Peso Vac&iacute;o <?=$pesar?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'v', $infoMovimiento[0]['peso_0'.$i.'v'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Peso Lleno <?=$pesar?></td>
            <td><? echo $html->input("Recepcion.pesoLleno$i", '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <?
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
                <?
                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit'));
                    echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()'));
                ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'tipo':
            if(!empty($GPC['cul'])){
                $analisis = new Analisis();
                $infoAnalisis = $analisis->listaAnalisis('', '', '', '', 't', 't');
                foreach($infoAnalisis as $valor){
                    $listaAnalisis[$valor['codigo']] = $valor['nombre'];
                }
                ?>
                <tr>
                    <td width="110">An&aacute;lisis </td>
                    <td><? echo $html->select('Formula.id_analisis', array('options' => $listaAnalisis, 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?></td>
                </tr>
                <?
            }
        break;
        case 'campos':
            $tipo = $GPC['tipo'];
            $condicion = $GPC['cond'];
            if(!empty($tipo) && !empty($condicion)){
                if($tipo == 1 && $condicion == 2){
                    echo "Condici&oacute;n ".$html->input("desde_1", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                    echo "<&nbsp;&nbsp;".$html->input("hasta_1", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                }elseif($tipo != 1 && ($condicion == 1 || $condicion == 2)){
                    echo "Condici&oacute;n ".$html->input('otra_condicion_1', '', array('type' => 'text', 'class' => 'otra_con', 'style' => 'width: 100px')).":&nbsp;";
                    echo $html->input('desde_1', '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                    echo "<&nbsp;&nbsp;".$html->input('hasta_1', '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                    echo "Evaluada&nbsp;&nbsp;".$html->input('condicion_eval', '', array('type' => 'text', 'readOnly' => 'readOnly', 'style' => 'width: 100px'));
                }
            }
        break;
        case 'multiple':
            $formulas = new Formulas();
            $parametros->listaParametros(1, 6);
            $formulas->listaFormulas(1, '');
            $nro = $GPC['nro'];
            ?>
            <legend>F&oacute;rmula <?=$nro?></legend>
            <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" style="padding: 10px 0;">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $html->input("btn_".$parametro['parametro_llave']."_$nro", $parametro['parametro_llave'], array('type' => 'button', 'class' => 'formula_campos constante'));
                        }
                        foreach($formulas->listaF as $formula){
                            echo $html->input("btn_".$formula['codigo']."_$nro", $formula['codigo'], array('type' => 'button', 'class' => 'btnFormula', 'onClick' => "asignarFormula($nro, '".$formula['formula']."')"));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <?
                            if(!empty($GPC['tipo']) && $GPC['tipo'] == 2){
                                echo "Condici&oacute;n ".$html->input('otra_condicion_'.$nro, '', array('type' => 'text', 'readOnly' => 'readOnly', 'class' => 'otra_con', 'style' => 'width: 100px')).":&nbsp;";
                                echo $html->input("desde_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo "<&nbsp;&nbsp;".$html->input("hasta_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo $html->input('formula_exp_'.$nro, $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp'));
                            }else{
                                echo "Condici&oacute;n ".$html->input("desde_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'));
                                echo "<&nbsp;&nbsp;".$html->input("hasta_$nro", '', array('type' => 'text', 'class' => 'positive rango', 'style' => 'width: 40px'))."<br/>";
                                echo $html->input('formula_exp_'.$nro, $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp'));
                            }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px 0;"><hr/></td>
                </tr>
                <tr>
                    <th>Comprobar F&oacute;rmula<br/><br/></th>
                </tr>
                <tr>
                    <td align="center" id="td_<?=$nro?>" style="padding: 10px 0;">
                        <?
                        foreach($parametros->lista as $parametro){
                            echo $parametro['parametro_llave']."&nbsp;&nbsp;";
                            echo $html->input($parametro['parametro_llave']."_$nro", '', array('type' => 'text', 'length' => '7', 'class' => 'cuadricula valores positive'));
                        }
                        ?>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <? echo $html->input('formula_eval_'.$nro, '', array('type' => 'text', 'readOnly' => true, 'class' => 'campo_formula')); ?>
                    </td>
                </tr>
                <tbody id="resultado_<?=$nro?>" class="verif_resul"></tbody>
                <tr align="center">
                    <td style="padding-top: 20px;">
                        <? echo $html->input('Comprobar_'.$nro, 'Comprobar', array('type' => 'button', 'class' => 'comprobar')); ?>
                    <? echo $html->input('Recuperar_'.$nro, 'Corregir Valores', array('type' => 'button', 'class' => 'recuperar')); ?>
                    </td>
                </tr>
            </table>
            <script type="text/javascript">
                $('.otra_con').val($('#otra_condicion_1').val());
            </script>
            <?
        break;
        case 'formu':
            if(!empty($GPC['formula_eval'])){
                $evaluar = new LaMermelex();
                $evaluar->suppress_errors = true;
                if ($evaluar->evaluate('y(x) = ' . $GPC['formula_eval'])) {
                    $total = $evaluar->e("y(0)");
                    if($total < 0)
                        echo "<tr><th class='error' align='center'><h3>El resultado es: " . number_format($total, 2) . "</h3></th></tr>";
                    else
                        echo "<tr><th class='msj_verde' align='center'><h3>El resultado es: " . number_format($total, 2) . "</h3></th></tr>";
                } else {
                    echo "<tr><th class='error' align='center'><h3>No se puede evaluar la funci&oacute;n: " . $evaluar->last_error . "</h3></th></tr>";
                }
            }
        break;
        case 'ejes':
            $recepcion = new Recepcion();
            $aprox = $recepcion->toneladasPorEje($GPC['opc']);
            ?>
            <tr>
                <td>Peso Recomendado</td>
                <td id=""><? echo $html->input('pesoAprox', $aprox[0]['capacidad'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
            </tr>
            <?
        break;
        case 'pesar':
            $romana = new Tolcarom();
            
            $movimiento = split('-', $GPC['status']);
            $infoRomana = $romana->find(array('id' => $movimiento[2]), null, 'parametros');
            $peso=file_get_contents($infoRomana[0]['parametros']);
            $peso = rand(5000, 50000)."K";
            //$peso = "21890K";
            $peso = ($peso < 0 || $peso == '') ? '0K' : $peso;
            switch($movimiento[0]){
                case 'rec':
                    if($movimiento[1] == 3)
                        echo $html->input('Recepcion.peso_0'.$GPC['boton'].'l', round(substr($peso, 0, -1)), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    elseif(in_array($movimiento[1], array(6, 8))){
                        echo $html->input('Recepcion.peso_0'.$GPC['boton'].'v', round(substr($peso, 0, -1)), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                        ?>
                            <script type="text/javascript">
                                $(document).ready(function(){
                                    var form = $('#form1').serialize();
                                    $("#resultado").load('../ajax/detalle_formula.php?ac=pesoromana&formula='+form);
                                });
                            </script>
                        <?
                    }
                break;
                case 'des':
                    if($movimiento[1] == 1)
                        echo $html->input('Recepcion.peso_0'.$GPC['boton'].'v', substr($peso, 0, -1), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive'));
                    elseif($movimiento[1] == 3){
                        echo $html->input('Recepcion.pesoLleno'.$GPC['boton'], substr($peso, 0, -1), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos2 positive verifPeso'));
                        ?>
                            <script type="text/javascript">
                                $(document).ready(function(){
                                    var form = $('#form1').serialize();
                                    $("#resultado").load('../ajax/detalle_formula.php?ac=pesoromana&formula='+form);
                                });
                            </script>
                        <?
                    }
                break;
            }
            
            echo $html->input('pesar'.$GPC['boton'], 'PESAR', array('type' => 'button', 'class' => 'capturar'));
        break;
        case 'pesoromana':
            if(!empty($GPC['Recepcion'])){
                $id = split('=', $GPC['formula']);
                $id = $id[1];

                $formula = new Formulas();
                $evaluar = new LaMermelex();
                $resultados = new Analisis();
                $cultivo = new Cultivo();
                $evaluar->suppress_errors = true;
                
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
                    $recepcion = new Recepcion();
                    $infoMovimiento = $recepcion->find(array('id' => $id));
                    $infoResultados = $resultados->listadoResultados($id, '', '', "'1', '2'");
                }else{
                    $despacho = new Despacho();
                    $infoMovimiento = $despacho->find(array('id' => $id));
                    $infoResultados = $resultados->listadoResultados('', $id, '', "'1', '2'");
                }
                
                if(!empty($infoResultados)){
                    foreach($infoResultados as $valor){
                        if($valor['codigo'] == 1){
                            if($infoMovimiento[0]['muestra'] == 0){
                                $sumHum = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                $sumHum2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                $sumHumT = $sumHum + $sumHum2;
                            }elseif($infoMovimiento[0]['muestra'] == 1){
                                $sumHumT = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                            }elseif($infoMovimiento[0]['muestra'] == 2){
                                $sumHumT = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                            }
                        }else{
                            if($infoMovimiento[0]['muestra'] == 0){
                                $sumImp = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                                $sumImp2 = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                                $sumImpT = $sumImp + $sumImp2;
                            }elseif($infoMovimiento[0]['muestra'] == 1){
                                $sumImpT = (!empty($valor['muestra2'])) ? $valor['muestra2'] : 0;
                            }elseif($infoMovimiento[0]['muestra'] == 2){
                                $sumImpT = (!empty($valor['muestra1'])) ? $valor['muestra1'] : 0;
                            }
                        }
                    }
                }else{
                    $sumHumT = 0;
                    $sumImpT = 0;
                }
                
                //PROMEDIO PARA LA HUMEDAD
                if($infoMovimiento[0]['muestra'] == 0)
                    $promHum = $sumHumT/$GPC['cant_m'];
                else
                    $promHum = $sumHumT;
                
                //PROMEDIO PARA LA IMPUREZA
                if($infoMovimiento[0]['muestra'] == 0)
                    $promImp = $sumImpT/$GPC['cant_m'];
                else
                    $promImp = $sumImpT;
                
                //VARIABLES A USAR PARA LOS CALCULOS
                $reservadas = array('PL1', 'PL2', 'PV1', 'PV2', 'HUML', 'IMPL', 'PHUM', 'PIMP');
                $GPC['Recepcion']['pesoLleno2'] = (!empty($GPC['Recepcion']['pesoLleno2'])) ? $GPC['Recepcion']['pesoLleno2'] : 0;
                $GPC['Recepcion']['peso_02v'] = (!empty($GPC['Recepcion']['peso_02v'])) ? $GPC['Recepcion']['peso_02v'] : 0;

                if($GPC['mov'] == 'rec')
                    $pesos = array($GPC['Recepcion']['pesoLleno1'], $GPC['Recepcion']['pesoLleno2'], $GPC['Recepcion']['peso_01v'], $GPC['Recepcion']['peso_02v'], $promHum, $promImp);
                else{
                    $pesos = array($GPC['Recepcion']['pesoLleno1'], 0, $GPC['Recepcion']['peso_01v'], 0, $sumHum, $sumImp);
                    $pesos2 = array(0, $GPC['Recepcion']['pesoLleno2'], 0, $GPC['Recepcion']['peso_02v'], $sumHum2, $sumImp2);
                }

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
                            if($valor['id_analisis'] == 1){
                                $rango = split('<',$valor['condicion']);
                                if(($promHum >= $rango[0]) && ($promHum < $rango[1]))
                                    $humImp[] = $valor['formula'];
                            }elseif($valor['id_analisis'] == 2){
                                $rango = split('<',$valor['condicion']);
                                if(($promImp >= $rango[0]) && ($promImp < $rango[1]))
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
                                else{
                                    $otraFormula[] = $valor['formula'];
                                    $otra = true;
                                }
                            }
                        }
                    }
                }
                
                if($otra){
                    //$otraFormula[0] = $formulaAplicar['PN'];
                    $otraFormula[1] = $formulaAplicar['PN'];
                }
                
                //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                if(!empty($humImp)){
                    //CALCULO DE LA IMPUREZA
                    $totalH = str_replace($reservadas, $pesos, $humImp[0]);
                    if ($evaluar->evaluate('y(x) = ' . $totalH))
                        $pesoH = ($GPC['estatus'] != 8) ? $evaluar->e("y(0)") : 0;
                    $pesos[] = $pesoH;

                    //CALCULO DE LA IMPUREZA
                    $totalI = str_replace($reservadas, $pesos, $humImp[1]);
                    if ($evaluar->evaluate('y(x) = ' . $totalI))
                        $pesoI = ($GPC['estatus'] != 8) ? $evaluar->e("y(0)") : 0;
                    $pesos[] = $pesoI;
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

                $movimiento = ($GPC['mov'] == 'rec') ? 'Recibido' : 'Despachado Motriz';
                $label = ($GPC['mov'] == 'rec') ? '' : 'Motriz';
                
                $pesoA = ($GPC['estatus'] != 8) ? $pesoA : $pesoN;
                $pesoAl = ($GPC['estatus'] != 8) ? $pesoAl : $pesoN;
            ?>
            <tr>
                <td>Peso Neto <?=$movimiento?> Kgrs</td>
                <td><? echo $html->input('pesoRecibido1', $general->formato_numero(round($pesoN), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                if(in_array($infoCultivo[0]['id'], array(10,12))){
                    $suma = $sumHum + $sumImp;
                    $desc1 = ($suma >= 14) ? ($pesoN - $pesoA) : 0;
            ?>
            <tr>
                <td>Desc. Hum | Imp <?=$label?> Kgrs</td>
                <td><? echo $html->input('descuento1', $general->formato_numero(round($desc1), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    if($GPC['mov'] == 'rec'){
            ?>
            <tr>
                <td>Peso Neto Acondicionado <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionado1', $general->formato_numero(round($pesoA), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }else{
            ?>
            <tr>
                <td>Peso Neto Acondicionado <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionado1', $general->formato_numero(round($pesoAl), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }
                }else{
            ?>
            <tr>
                <td>Desc. por Humedad <?=$label?> Kgrs</td>
                <td><? echo $html->input('descHumedad1', $general->formato_numero(round($pesoH), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Desc. por Impureza <?=$label?> Kgrs</td>
                <td><? echo $html->input('descImpurezas1', $general->formato_numero(round($pesoI), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
                if($GPC['mov'] == 'rec'){
            ?>
            <tr>
                <td>Peso Neto a Liquidar <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionadoL1', $general->formato_numero(round($pesoAl), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
                if($GPC['mov'] == 'des' && ($sumHum2 != '' || $sumImp2 != '' || $GPC['Recepcion']['pesoLleno2'] != '' || $GPC['Recepcion']['peso_02v'] != '')){
                    //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                    if(!empty($humImp)){
                        //CALCULO DE LA IMPUREZA
                        $totalH2 = str_replace($reservadas, $pesos2, $humImp[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalH2))
                            $pesoH2 = $evaluar->e("y(0)");
                        $pesos2[] = $pesoH2;

                        //CALCULO DE LA IMPUREZA
                        $totalI2 = str_replace($reservadas, $pesos2, $humImp[1]);
                        if ($evaluar->evaluate('y(x) = ' . $totalI2))
                            $pesoI2 = $evaluar->e("y(0)");
                        $pesos2[] = $pesoI2;
                    }

                    if(!empty($otraFormula)){
                        //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                        $totalA2 = str_replace($reservadas, $pesos2, $otraFormula[0]);
                        if ($evaluar->evaluate('y(x) = ' . $totalA2))
                        $pesoA2 = $evaluar->e("y(0)");

                        if(!empty($otraFormula[1])){
                            $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula[1]);
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
                    $totalA2 = str_replace($reservadas, $pesos2, $otraFormula[0]);
                    if ($evaluar->evaluate('y(x) = ' . $totalA2))
                        $pesoA2 = $evaluar->e("y(0)");

                    $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula[1]);
                    if ($evaluar->evaluate('y(x) = ' . $totalAl2))
                        $pesoAl2 = $evaluar->e("y(0)");
            ?>
            <tr>
                <td>Peso Neto Despachado Remolque Kgrs</td>
                <td><? echo $html->input('pesoRecibido2', $general->formato_numero(round($pesoN2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                if(in_array($infoCultivo[0]['id'], array(10,12))){
                    $suma2 = $sumHum2 + $sumImp2;
                    $desc2 = ($suma2 >= 14) ? ($pesoN2 - $pesoA2) : 0;
            ?>
            <tr>
                <td>Desc. Hum | Imp Remolque Kgrs</td>
                <td><? echo $html->input('descuento2', $general->formato_numero(round($desc2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    if($GPC['mov'] == 'rec'){
            ?>
            <tr>
                <td>Peso Neto Acondicionado Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionado2', $general->formato_numero(round($pesoA2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }else{
            ?>
            <tr>
                <td>Peso Neto Acondicionado Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionado2', $general->formato_numero(round($pesoAl2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }
                }else{
            ?>
            <tr>
                <td>Desc. por Humedad Remolque Kgrs</td>
                <td><? echo $html->input('descHumedad2', $general->formato_numero(round($pesoH2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Desc. por Impureza Remolque Kgrs</td>
                <td><? echo $html->input('descImpurezas2', $general->formato_numero(round($pesoI2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
                    if($GPC['mov'] == 'rec'){
            ?>
            <tr>
                <td>Peso Neto a Liquidar Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionadoL2', $general->formato_numero(round($pesoAl2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }
                }   
                //EN CASO DE SER NEGATIVOS LOS RESULTADOS
                if (($pesoN < 0) || ($pesoH < 0) || ($pesoI < 0) || ($pesoAl < 0)){
            ?>
            <tr class="error" align="center">
                <td colspan="2" style="padding-top: 20px;">Favor, verifique los pesos, el calculo no puede ser negativo</td>
            </tr>
            <script type="text/javascript">
                $('#Guardar').attr('disabled', true);
            </script>
            <?
                }else{
            ?>
            <script type="text/javascript">
                $('#Guardar').removeAttr('disabled');
            </script>
            <?
                }
            }
        break;
        case 'boleta_v':
            $id = split('=', $GPC['formula']);
            $id = $id[1];
            
            $formula = new Formulas();
            $evaluar = new LaMermelex();
            $evaluar->suppress_errors = true;
            $orden = " ORDER BY id_centro_acopio DESC, id_cultivo, id_analisis, id";
            $formulas = $formula->formulaCultivo($_SESSION['s_ca_id'], $GPC['id_cultivo'], $orden, $id);

            //PROMEDIANDO LOS VALORES DE HUMEDAD E IMPUREZA
            $sumHum = (!empty($GPC['humedad2'])) ? $GPC['humedad1'] + $GPC['humedad2'] : $GPC['humedad1'];
            $promHum = (!empty($GPC['humedad2'])) ? $sumHum/2 : $sumHum;
            $sumImp = (!empty($GPC['impureza2'])) ? $GPC['impureza1'] + $GPC['impureza2'] : $GPC['impureza1'];
            $promImp = (!empty($GPC['impureza2'])) ? $sumImp/2 : $sumImp;

            //VARIABLES A USAR PARA LOS CALCULOS
            $reservadas = array('PL1', 'PL2', 'PV1', 'PV2', 'HUML', 'IMPL', 'PHUM', 'PIMP');
            $GPC['peso_02l'] = (!empty($GPC['peso_02l'])) ? $GPC['peso_02l'] : 0;
            $GPC['peso_02v'] = (!empty($GPC['peso_02v'])) ? $GPC['peso_02v'] : 0;
            
            if($id == 1)
                $pesos = array($GPC['peso_01l'], $GPC['peso_02l'], $GPC['peso_01v'], $GPC['peso_02v'], $promHum, $promImp);
            else{
                $pesos = array($GPC['peso_01l'], 0, $GPC['peso_01v'], 0, $GPC['humedad1'], $GPC['impureza1']);
                $pesos2 = array(0, $GPC['peso_02l'], 0, $GPC['peso_02v'], $GPC['humedad2'], $GPC['impureza2']);
            }
            
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
                        if($valor['id_analisis'] == 1){
                            $rango = split('<',$valor['condicion']);
                            if(($promHum >= $rango[0]) && ($promHum < $rango[1]))
                                $humImp[] = $valor['formula'];
                        }elseif($valor['id_analisis'] == 2){
                            $rango = split('<',$valor['condicion']);
                            if(($promImp >= $rango[0]) && ($promImp < $rango[1]))
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
                            else{
                                $otraFormula[] = $valor['formula'];
                                $otra = true;
                            }
                        }
                    }
                }
            }

            if($otra){
                //$otraFormula[0] = $formulaAplicar['PN'];
                $otraFormula[1] = $formulaAplicar['PN'];
            }

            //CALCULO DE LA HUMEDAD Y LA IMPUREZA
            if(!empty($humImp)){
                //CALCULO DE LA IMPUREZA
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
            
            $movimiento = ($id == 1) ? 'Recibido' : 'Despachado Motriz';
            $label = ($id == 1) ? '' : 'Motriz';
            ?>
            <tr>
                <td>Peso Neto <?=$movimiento?> Kgrs</td>
                <td><? echo $html->input('pesoRecibido1', $general->formato_numero(round($pesoN), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                if(in_array($GPC['id_cultivo'], array(10,12))){
                    $suma = $GPC['humedad1'] + $GPC['impureza1'];
                    $desc1 = ($suma >= 14) ? ($pesoN - $pesoA) : 0;
            ?>
            <tr>
                <td>Desc. Hum | Imp <?=$label?> Kgrs</td>
                <td><? echo $html->input('descuento1', $general->formato_numero(round($desc1), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    if($id == 1){
            ?>
            <tr>
                <td>Peso Neto Acondicionado <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionado1', $general->formato_numero(round($pesoA), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }else{
            ?>
            <tr>
                <td>Peso Neto Acondicionado <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionado1', $general->formato_numero(round($pesoAl), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }
                }else{
            ?>
            <tr>
                <td>Desc. por Humedad <?=$label?> Kgrs</td>
                <td><? echo $html->input('descHumedad1', $general->formato_numero(round($pesoH), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Desc. por Impureza <?=$label?> Kgrs</td>
                <td><? echo $html->input('descImpurezas1', $general->formato_numero(round($pesoI), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
                if($id == 1){
            ?>
            <tr>
                <td>Peso Neto a Liquidar <?=$label?> Kgrs</td>
                <td><? echo $html->input('netoAcondicionadoL1', $general->formato_numero(round($pesoAl), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
            if($id == 2 && ($GPC['humedad2'] != '' || $GPC['impureza2'] != '' || $GPC['peso_02l'] != '' || $GPC['peso_02v'] != '')){
                //CALCULO DE LA HUMEDAD Y LA IMPUREZA
                if(!empty($humImp)){
                    //CALCULO DE LA IMPUREZA
                    $totalH2 = str_replace($reservadas, $pesos2, $humImp[0]);
                    if ($evaluar->evaluate('y(x) = ' . $totalH2))
                        $pesoH2 = $evaluar->e("y(0)");
                    $pesos2[] = $pesoH2;

                    //CALCULO DE LA IMPUREZA
                    $totalI2 = str_replace($reservadas, $pesos2, $humImp[1]);
                    if ($evaluar->evaluate('y(x) = ' . $totalI2))
                        $pesoI2 = $evaluar->e("y(0)");
                    $pesos2[] = $pesoI2;
                }

                if(!empty($otraFormula)){
                    //PESO ACONDICIONADO Y PESO ACONDICIONADO A LIQUIDAR, PARA EL CASO DE CULTIVOS CON OTRA FORMULACION
                    $totalA2 = str_replace($reservadas, $pesos2, $otraFormula[0]);
                    if ($evaluar->evaluate('y(x) = ' . $totalA2))
                    $pesoA2 = $evaluar->e("y(0)");

                    if(!empty($otraFormula[1])){
                        $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula[1]);
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
                $totalA2 = str_replace($reservadas, $pesos2, $otraFormula[0]);
                if ($evaluar->evaluate('y(x) = ' . $totalA2))
                    $pesoA2 = $evaluar->e("y(0)");

                $totalAl2 = str_replace($reservadas, $pesos2, $otraFormula[1]);
                if ($evaluar->evaluate('y(x) = ' . $totalAl2))
                    $pesoAl2 = $evaluar->e("y(0)");
            ?>
            <tr>
                <td>Peso Neto Despachado Remolque Kgrs</td>
                <td><? echo $html->input('pesoRecibido2', $general->formato_numero(round($pesoN2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                if(in_array($GPC['id_cultivo'], array(10,12))){
                    $suma2 = $GPC['humedad2'] + $GPC['impureza2'];
                    $desc2 = ($suma2 >= 14) ? ($pesoN2 - $pesoA2) : 0;
            ?>
            <tr>
                <td>Desc. Hum | Imp Remolque Kgrs</td>
                <td><? echo $html->input('descuento2', $general->formato_numero(round($desc2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    if($id == 1){
            ?>
            <tr>
                <td>Peso Neto Acondicionado Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionado2', $general->formato_numero(round($pesoA2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }else{
            ?>
            <tr>
                <td>Peso Neto Acondicionado Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionado2', $general->formato_numero(round($pesoAl2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                    }
                }else{
            ?>
            <tr>
                <td>Desc. por Humedad Remolque Kgrs</td>
                <td><? echo $html->input('descHumedad2', $general->formato_numero(round($pesoH2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Desc. por Impureza Remolque Kgrs</td>
                <td><? echo $html->input('descImpurezas2', $general->formato_numero(round($pesoI2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
                if($id == 1){
            ?>
            <tr>
                <td>Peso Neto a Liquidar Remolque Kgrs</td>
                <td><? echo $html->input('netoAcondicionadoL2', $general->formato_numero(round($pesoAl2), 2), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <?
                }
            }
            //EN CASO DE SER NEGATIVOS LOS RESULTADOS
            if (($pesoN < 0) || ($pesoH < 0) || ($pesoI < 0) || ($pesoAl < 0)){
            ?>
            <tr class="error" align="center">
                <td colspan="2" style="padding-top: 20px;">Favor, verifique los pesos, el calculo no puede ser negativo</td>
            </tr>
            <?
                }
        break;
    }
?>
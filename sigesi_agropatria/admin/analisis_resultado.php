<?php
require_once('../lib/core.lib.php');

$analisis = new Analisis();
$Rec = new Recepcion();
$despacho = new Despacho();
$cosecha=new Cosecha();
$cultivo=new Cultivo();
$tipificacion = new Recultipo();


$idCA = $_SESSION['s_id_ca'];
$id = $GPC['id'];
$IdCosecha = $GPC['id_cosecha'];
$idORG = $_SESSION['s_org_id'];
$cant_muestras = $GPC['cant_muestras'];
$estatus='';
$booleano = array('' => '', 'NO' => 'NO', 'SI' => 'SI');
$calidad = array('' => '', 'A' => 'A', 'B' => 'B', 'C' => 'C', 'D' => 'D');
$tipo_mov=array('rec'=>'R','des'=>'D');
$listaMov = array('rec' => 'RECEPCI&Oacute;N', 'des' => 'DESPACHO');
$enCuarentena=false;
$enRechazo=false;

$tipoCultivo='I';
$tipoTemp='I';  
$T1='I';
$T2='I';
$T3='I';
$estipo=false;
$idRec='';
$idDes='';

if (!empty($GPC['mov']))
    $_SESSION['s_mov']=$GPC['mov'];
else 
    $GPC['mov']=$_SESSION['s_mov'];

if (!empty($GPC['lab']))
    $_SESSION['s_lab']=$GPC['lab'];
else
    $GPC['lab']=$_SESSION['s_lab'];         

switch ($GPC['ac']) {
    case 'nuevo':
        if (!empty($GPC['id']) && !empty($GPC['cant_muestras']) && !empty($_SESSION['s_lab']) && !empty($_SESSION['s_mov'])) {
            if ($GPC['mov']=='rec') {
                $InfoCosecha = $cosecha->find(array('id' => $GPC['id_cosecha']));
                $idCultivo=$InfoCosecha[0]['id_cultivo'];
                $infoMov = $Rec->listadoAnalisis($idCA, $idCultivo, $id);
            } elseif ($GPC['mov']=='des') {
                $infoMov = $despacho->listadoDespacho($GPC['id'], $idCA);
                $idCultivo=$infoMov[0]['id_cultivo'];
            }            
            $laboratorio=($_SESSION['s_lab']=='C')? $laboratorio="'C','A'": $laboratorio="'A'";
            $listadoAnalisis = $analisis->buscarAC(null, $idCultivo, $idCA, $laboratorio);
            $cantidad = count($listadoAnalisis);
            $infoCultivo=$cultivo->find(array('id' => $idCultivo));
        }
        break;
    case 'guardar':
        if (!empty($GPC['id']) && !empty($_SESSION['s_lab']) && !empty($_SESSION['s_mov'])) {
            if ($GPC['mov']=='rec') {
                $infoRecepcion = $Rec->find(array('id' => $GPC['id']));
                $InfoCosecha=$cosecha->find(array('id'=>$infoRecepcion[0]['id_cosecha']));
                $idCultivo=$InfoCosecha[0]['id_cultivo'];
            } elseif ($GPC['mov']=='des') {
                $infoDespacho = $despacho->find(array('id' => $GPC['id']));
                $idCultivo=$infoDespacho[0]['id_cultivo'];
            }            
            $laboratorio=(trim($_SESSION['s_lab'])=='C')? $laboratorio="'C','A'": $laboratorio="'A'";
            $listadoAnalisis = $analisis->buscarAC(null, $idCultivo, $idCA, $laboratorio);
            $analisis->_begin_tool();
            $j = 0;
            $Resultados=array();
            foreach ($listadoAnalisis as $dataAnalisis) {                 
                if ($_SESSION['s_mov']=='rec') 
                    $GPC['Resultados']['id_recepcion'] = $GPC['id'];
                if ($_SESSION['s_mov']=='des') 
                    $GPC['Resultados']['id_despacho'] = $GPC['id'];                
                $GPC['Resultados']['id_analisis'] = $GPC['id_analisis'][$j];
                $GPC['Resultados']['id_usuario'] = $_SESSION['s_id'];
                $valor = 'muestra' . $j . '_' . $dataAnalisis['codigo'];
                $GPC['Resultados']['muestra1'] = is_numeric($GPC[$valor][0]) ? number_format($GPC[$valor][0], 3) : $GPC[$valor][0];
                $GPC['Resultados']['muestra2'] = is_numeric($GPC[$valor][1]) ? number_format($GPC[$valor][1], 3) : $GPC[$valor][1];
                $GPC['Resultados']['muestra3'] = is_numeric($GPC[$valor][2]) ? number_format($GPC[$valor][2], 3) : $GPC[$valor][2];                
                $GPC['Resultados']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $GPC['Resultados']['tipo_mov']=$tipo_mov[$_SESSION['s_mov']];
                //vector para la tipificacion
                $Resultados[$j]['id_analisis']=$GPC['Resultados']['id_analisis'];
                $Resultados[$j]['muestra1']=$GPC['Resultados']['muestra1'];
                $Resultados[$j]['muestra2']=$GPC['Resultados']['muestra2'];
                $Resultados[$j]['muestra3']=$GPC['Resultados']['muestra3'];
                $j++;                
                $id_analisis = $analisis->guardarResultados($GPC['Resultados']);                
            }            
            if ($_SESSION['s_lab']=='C' && $_SESSION['s_mov']=='rec') 
                $estatus = '3'; // 3=> Romana            
            if ($_SESSION['s_lab']=='P' && $_SESSION['s_mov']=='rec') 
                $estatus = '6'; // 6=> Romana Vacio
            if ($_SESSION['s_lab']=='C' && $_SESSION['s_mov']=='des') 
                $estatus = '3'; // 3=> Romana Vacio
            if ($GPC['es_rechazado'] != '0_0:') {                
                $Muestra1=(strpos($GPC['es_rechazado'],'_1:') > 0) ? 1: 0; //Se cambia el rechazado por el aceptado en Muestra1
                $Muestra2=(strpos($GPC['es_rechazado'],'_2:') > 0) ? 2: 0; //Se cambia el rechazado por el aceptado en Muestra2
                if (($Muestra1==0) && ($Muestra2==0)) 
                   $Muestra=0;
                elseif ($Muestra1==0) 
                   $Muestra=2; 
                elseif ($Muestra2==0) 
                    $Muestra=1;
                else 
                    $Muestra=3;
                if ($_SESSION['s_mov']=='rec') {
                    if ($_SESSION['s_lab']=='C') {
                        if ($Muestra==3)
                            $estatus = '7';
                        else
                            $estatus = '3';
                    }
                    elseif ($_SESSION['s_lab']=='P') {
                        if ($Muestra==3)
                            $estatus = '8';
                        else
                            $estatus = '6';
                    }
                } elseif ($_SESSION['s_mov']=='des') {
                    if ($_SESSION['s_lab']=='C') {
                        if ($Muestra==3)
                            $estatus = '4';
                        else
                            $estatus = '3';
                    }
                }
                $enRechazo=true;
            } else if ($GPC['es_cuarentena'] != '0_0:') {
                    $enCuarentena=true;
//                    $estatus = '2';     
                    $Ctna = new Cuarentena();
                    $recepcion['id_centro_acopio'] = $_SESSION['s_ca_id'];
                    $recepcion['id_recepcion'] = $GPC['id'];
                    $recepcion['id_cultivo'] = $idCultivo;
                    $recepcion['id_usuario'] = $_SESSION['s_id'];
                    $serial1 = split(':', $GPC['es_cuarentena']);
                    $serial2 = split('_', $serial1[1]);
                    $codAnalisis=trim($serial2[0]);
                    $infoAnalisis=$analisis->listaAnalisis(null, null, null,$codAnalisis);                    
                    $recepcion['id_analisis'] = $infoAnalisis[0]['id'];
                    $recepcion['tipo_mov'] = $tipo_mov[$_SESSION['s_mov']];
                    $recepcion['fecha_mov'] = 'now()';
                    $recepcion['fecha_cultivo'] = 'now()';                
                    $recepcion['laboratorio'] = $_SESSION['s_lab'];
                    $Muestra1=(strpos($GPC['es_cuarentena'],'_1:') > 0) ? 1: 0; //Se cambia el rechazado por el aceptado en Muestra1
                    $Muestra2=(strpos($GPC['es_cuarentena'],'_2:') > 0) ? 2: 0; //Se cambia el rechazado por el aceptado en Muestra2
                    if (($Muestra1==0) && ($Muestra2==0))
                        $Muestra=0;
                    elseif ($Muestra1==0)
                        $Muestra=2;
                    elseif ($Muestra2==0)
                        $Muestra=1;
                    else
                        $Muestra=3;
                    if ($_SESSION['s_mov']=='rec') {
                        if ($_SESSION['s_lab']=='C') 
                            $estatus = 2; // Se asigna Estatus de Pendiente por Aprobar Cuarentena
                        elseif ($_SESSION['s_lab']=='P')
                                $estatus = '2';
                    } elseif ($_SESSION['s_mov']=='des')
                        if ($_SESSION['s_lab']=='P')
                            $estatus = '4';
                    $id_cuarentena = $Ctna->save($recepcion);
            }
            if (!empty($id_analisis)) {
                if ($_SESSION['s_mov']=='rec') {
                    $GPC['Recepcion']['id'] = $GPC['id'];
                    $GPC['Recepcion']['estatus_rec'] = $estatus;
                    if ($Muestra!=0)
                        $GPC['Recepcion']['muestra'] = $Muestra;
                    $Rec->save($GPC['Recepcion']);                    
                } elseif ($_SESSION['s_mov']=='des') {
                    $GPC['Despacho']['id'] = $GPC['id'];
                    $GPC['Despacho']['estatus'] = $estatus;                    
                    $GPC['Recepcion']['muestra'] = $Muestra;
                    $despacho->save($GPC['Despacho']);
                }
                
            }
            if ($_SESSION['s_mov']=='rec') {
                $tipoCultivo = array();
                $listaTipo=$cultivo->buscarTipo($idCultivo, $idCA);
                if (!empty($listaTipo)) {
                    foreach ($listaTipo as $tipo) {//Valores de Tipificacion
                        $estipo=true;
                        foreach ($Resultados as $aR) {// Resultado de Analisis                                                 
                            if ($tipo['id_analisis']==$aR['id_analisis']) {
    //                            echo 'Entrando al Bucle Valores de Tipificacion: ';
                                $T1=($aR['muestra1'] >= $tipo['min'] && $aR['muestra1'] <= $tipo['max']) ? trim($tipo['tipo']): 'I';
                                if (!empty($aR['muestra2']))
                                    $T2=($aR['muestra2'] >= $tipo['min'] && $aR['muestra2'] <= $tipo['max']) ? trim($tipo['tipo']): 'I';
                                if (!empty($aR['muestra3']))
                                    $T3=($aR['muestra3'] >= $tipo['min'] && $aR['muestra3'] <= $tipo['max']) ? trim($tipo['tipo']): 'I';
                                if ($T1=='B' || $T2=='B' || $T3=='B') 
                                    $tipoCultivo[]='B';                            
                                else 
                                    $tipoCultivo[]='A';                            
                            }
                        }
                    }
                }
                if ($estipo==true) {
                    $GPC['Tipificacion']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                    $GPC['Tipificacion']['id_recepcion'] = $GPC['id'];
                    $GPC['Tipificacion']['id_cultivo']= $idCultivo;                
                    $GPC['Tipificacion']['laboratorio']= $_SESSION['s_lab'];                    
                    $GPC['Tipificacion']['tipo'] = (in_array('B',$tipoCultivo)) ? 'B': 'A';
                    $id_tipo=$tipificacion->save($GPC['Tipificacion']);                    
                }
            }
        }            
        switch ($estatus) {
            case '2':
            case '3':
                $analisis->_commit_tool();
                if ($enRechazo==true) {
                    //header('location: '.DOMAIN_ROOT."/reportes/imprimir.php?reporte=boleta_rechazo&id=".$GPC['id']."&es_rechazado=".$GPC['es_rechazado'].'&redir=analisis_resultado_listado');
                    header("location: ".DOMAIN_ROOT."reportes/imprimir_boleta_rechazo?id=".$GPC['id']."&es_rechazado=".$GPC['es_rechazado']);
                    die();
                } elseif ($estipo) {
                    header("location: ".DOMAIN_ROOT."reportes/imprimir_boleta_tipificacion.php?id_rec=".$GPC['id']);
                    die();
                }
                header("location: analisis_resultado_listado.php?msg=exitoso");
                die();
            case '6':
                $analisis->_commit_tool();
                if ($estipo) {
                    //header('location: '.DOMAIN_ROOT."/reportes/imprimir.php?reporte=boleta_tipifica?id_rec=".$GPC['id'].'&redir=analisis_resultado_listado');
                    header("location: ".DOMAIN_ROOT."reportes/imprimir_boleta_tipificacion.php?id_rec=".$GPC['id']);
                    die();
                } else {
                    header("location: analisis_resultado_listado.php?msg=exitoso");
                    die();
                }
                break;
            case '7':
            case '8':
                $analisis->_commit_tool();                
                //header('location: '.DOMAIN_ROOT."/reportes/imprimir.php?reporte=boleta_rechazo&id=".$GPC['id']."&es_rechazado=".$GPC['es_rechazado'].'&redir=analisis_resultado_listado');                
                header("location: ".DOMAIN_ROOT."reportes/imprimir_boleta_rechazo?id=".$GPC['id']."&es_rechazado=".$GPC['es_rechazado']);
                die();
                break;
            default:
                $analisis->_rollback_tool();
                header("location: analisis_resultado_listado.php?msg=error");
                die();
                break;
        }
        break;
    }

    require('../lib/common/header.php');
    ?>
    <script type="text/javascript">
        function cancelar(){
            history.back();
        }

        function valoresMinMax(valor, min, max, codigo, muestra, estatus, objeto) {        
            var campo=codigo+'_'+muestra;
            i=muestra-1;
            var rechazo = document.getElementById("es_rechazado");
            var cuarentena=document.getElementById("es_cuarentena");
            var Tupla=document.getElementById(objeto.id);

            if (valor != ''){            
                if (estatus=='R') {
                    if ((valor< min) || (valor > max) || (valor=='SI')) {
                        esRechazada=alert('<?= $html->unhtmlize($etiqueta['E_FueraNorma']); ?>');
                        if (rechazo.value.indexOf(campo)==-1) {
                            rechazo.value+=campo+':';
                        }
                    } else {
                        if (rechazo.value.indexOf(campo)!=-1) {                    
                            rechazo.value = rechazo.value.replace(campo+':','');                    
                        }
                    }                
                }            

                if (estatus=='C') {                
                    if (valor=='SI') {
                        if (rechazo.value=='0_0:') {
                            esCuarentena=confirm('<?= $html->unhtmlize($etiqueta['E_40TNA']); ?>');
                            cuarentena.value+=campo+':';
                        }
                        else {
                            Tupla.value='NO';
                            esRechazada=confirm('<?= $html->unhtmlize($etiqueta['E_NO40TNA']); ?>');
                        }                                                
                    }
                    else {                    
                        cuarentena.value = cuarentena.value.replace(campo+':','');
                    }
                }
            }
        }       
      
        $(document).ready(function() {
            $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });           
           
            $("#form1").submit(function(){
                var isFormValid = true;
                $("#form1 :input").each(function(){
                    if ($.trim($(this).val()).length == 0){
                        alert('Por favor llene todo los datos del Analisis !');
                        $(this).focus();
                        isFormValid = false;
                        return false;
                    }             
                });
                if (isFormValid) {
                    if (($('#es_rechazado').val()!='0_0:') && ($.trim($(this).val()).length == 0))  {
                        esRechazada=confirm('<?= $html->unhtmlize($etiqueta['M_Rechazo']); ?>');
                        if (esRechazada) {
                            isFormValid = true;
                            //return false;
                        }
                        else {
                            isFormValid = false;
                            //return false;
                        }
                    }
                    //alert('Pregunta si es Cuarentena! ');
                    if (($('#es_cuarentena').val()!='0_0:') && ($.trim($(this).val()).length == 0)) {                        
                        esCuarentena=confirm('<?= $html->unhtmlize($etiqueta['E_40TNA']); ?>');
                        if (esCuarentena) {
                            isFormValid = true;
                            //return false;                            
                        }
                        else {
                            isFormValid = false;
                            //return false;                            
                        }
                    }
                }
                return isFormValid;
            });
        });
    </script>
<div id="titulo_modulo">
    ANALISIS DE RESULTADOS - <? echo $listaMov[$GPC['mov']]; ?><hr/>
</div>
<div id="mensajes" style="display:none">
    <?
    switch ($GPC['msg']) {
        case 'exitoso':
            echo "<span class='msj_verde'>Registro Guardado !</span>";
            break;
        case 'error':
            echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
            break;
        default:
            echo "<span class='msj_rojo'>Los analisis no est&aacute en norma !</span>";
            break;
    }
    ?>
    </div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('cantA',  $cantidad, array('type' => 'hidden')); ?>
    <fieldset>
        <legend>Datos de la Muestra</legend>
        <table align="center" width="100%" border="0">
            <tr>
                <td>Nro. Entrada</td>                
                <td><? echo $html->input('', $infoMov[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos cuadricula', 'readOnly' => true)); ?></td>
                <td>Fecha</td>
                <td><? echo $html->input('', $general->date_sql_screen($infoMov[0]['fecha_recepcion']), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Carril</td>
                <td><? echo $html->input('', ((empty($infoMov[0]['carril'])==true) ? 0: $infoMov[0]['carril']), array('type' => 'text', 'class' => 'estilo_campos cuadricula', 'readOnly' => true)); ?></td>
                <td>Hora</td>
                <td><? echo $html->input('', $general->hora_sql_normal($infoMov[0]['fecha_recepcion']), array('type' => 'text', 'class' => 'estilo_campos crproductor', 'readOnly' => true));
                ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="3"><? 
                echo $html->input('', trim($infoCultivo[0]['codigo']) . ' - ' . $infoCultivo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>                
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de los An&aacute;lisis</legend>
        <table align="center" width="100%">
            <tr align="center" class="titulos_tabla">            
                <th width="1">C&oacute;digo</th>
                <th>Descripci&oacute;n</th>
                <? for ($j = 1; $j <= $cant_muestras; $j++) { ?>
                    <th width="70"><?= 'Muestra ' . $j; ?></th>
                <? } ?>
                <th>Min / Max</th>
            </tr>
            <?
            $i = 0;
            foreach ($listadoAnalisis as $dataAnalisis) {
                $clase = $general->obtenerClaseFila($i);
                ?>

                <tr class="<?= $clase ?>">
                    <td align="center" >
                        <? echo $html->input('id_analisis[]', $dataAnalisis['id'], array('type' => 'hidden')); ?>
                        <?= $dataAnalisis['codigo'] ?>
                    </td>
                    <td><?= $dataAnalisis['nombre'] ?></td>
                    <?
                    for ($j = 1; $j <= $cant_muestras; $j++) {
                        switch ($dataAnalisis['tipo_analisis']) {
                            case '1':
                                ?>
                                <td align="center">
                                <? 
                                if ($GPC['mov']=='rec')
                                    echo $html->input('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', '', array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                elseif ($GPC['mov']=='des')
                                    echo $html->input('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', '', array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_des'] . "," . $dataAnalisis['max_des'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                ?>
                                </td>
                                <?
                                break;
                            case '2':
                                ?>                    
                                <td align="center"><? echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $calidad, 'class' => 'cuadricula cualitativo')); ?></td>
                                <?
                                break;
                            case '3':
                                ?>
                                <td align="center">
                                <?
                                if ($dataAnalisis['estatus'] == 'C')
                                    if ($GPC['mov']=='rec')
                                        echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $booleano, 'class' => 'cuadricula booleano 40tna', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                    elseif ($GPC['mov']=='des')
                                            echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $booleano, 'class' => 'cuadricula booleano 40tna', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_des'] . "," . $dataAnalisis['max_des'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                if ($dataAnalisis['estatus'] == 'R')
                                    if ($GPC['mov']=='rec')
                                        echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $booleano, 'class' => 'cuadricula booleano', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                    elseif ($GPC['mov']=='des')
                                        echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $booleano, 'class' => 'cuadricula booleano', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_des'] . "," . $dataAnalisis['max_des'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                ?>
                                </td>
                                <?
                                break;
                            }
                        }
                        if ($dataAnalisis['tipo_analisis'] == 1) {
                            if ($GPC['mov']=='rec')
                                echo '<td align="center" width="100">' . $dataAnalisis['min_rec'] . " / " . $dataAnalisis['max_rec'] . '</td>';
                            else 
                                echo '<td align="center" width="100">' . $dataAnalisis['min_des'] . " / " . $dataAnalisis['max_des'] . '</td>';
                        } else {
                            ?>
                        <td align="center">&nbsp;</td>
                    </tr>
                    <?
                }
                $i++;
            }
            ?>
        </table>
    </fieldset>
    <table align="center">
        <tr><td>&nbsp;</td></tr>
        <tr align="center">
            <td colspan="1">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
    <?
    echo $html->input('id', $id, array('type' => 'hidden'));
    if (!empty($IdCosecha))
        echo $html->input('cosecha', $IdCosecha, array('type' => 'hidden'));
    echo $html->input('es_cuarentena', '0_0:', array('type' => 'hidden'));
    echo $html->input('es_rechazado', '0_0:', array('type' => 'hidden'));    
    ?>    
</form>    
<?
require('../lib/common/footer.php');
?>
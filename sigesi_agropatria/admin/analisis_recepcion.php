<?php
require_once('../lib/core.lib.php');

$analisisCul = new AnalisisCultivo();
$Rec = new Recepcion();

$idCA = $_SESSION['s_id_ca'];
$id_rec = $GPC['id_rec'];
$IdCultivo = $GPC['id_cultivo'];
$idORG = $_SESSION['s_org_id'];
$cant_muestras = $GPC['cant_muestras'];
$estatus = array('' => '', 'NO' => 'NO', 'SI' => 'SI');
$calidad = array('' => '', 'A' => 'A', 'B' => 'B', 'C' => 'C', 'D' => 'D');

$listadoAnalisis = $analisisCul->buscarAC(null, $IdCultivo, $idORG);
$cantidad = count($listadoAnalisis);
$infoRec = $Rec->listadoAnalisis(null, $IdCultivo, $id_rec);

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['id_rec'])) {
            $analisis = new Analisis();

            $infoRecepcion = $Rec->find(array('id' => $GPC['id_rec']));

            $analisis->_begin_tool();
            $j = 0;
            foreach ($listadoAnalisis as $dataAnalisis) {
                //$dataAnalisis['min_rec'];
                //$dataAnalisis['max_rec'];                
                $GPC['Resultados']['id_recepcion'] = $GPC['id_rec'];
                $GPC['Resultados']['id_analisis'] = $GPC['id_analisis'][$j];
                $GPC['Resultados']['id_usuario'] = $_SESSION['s_id'];
                $valor = 'muestra' . $j . '_' . $dataAnalisis['codigo'];
                $GPC['Resultados']['muestra1'] = is_numeric($GPC[$valor][0]) ? number_format($GPC[$valor][0], 3) : $GPC[$valor][0];
                $GPC['Resultados']['muestra2'] = is_numeric($GPC[$valor][1]) ? number_format($GPC[$valor][1], 3) : $GPC[$valor][1];
                $GPC['Resultados']['muestra3'] = is_numeric($GPC[$valor][2]) ? number_format($GPC[$valor][2], 3) : $GPC[$valor][2];
                //$GPC['Resultados']['id_analisis'];
                $j++;
                //print_r($GPC['Resultados']);
                $id_analisis_res = $analisis->guardarResultados($GPC['Resultados']);
                //echo '<br>id_analisis_res:'.$id_analisis_res.'</br>';
            }
            $estatus_rec = '3';
            //Estatus = 2=>Cuarentena, 3=> Romana
            if ($GPC['es_rechazado'] != '0_0:') {
                //7 => 'Rch.Lab.Cen'
                $estatus_rec = '7';
            } else if ($GPC['es_cuarentena'] != '0_0:') {
//                  $Rec->cambiarEstatus($GPC['id_rec'], 2);
                $estatus_rec = '2';
                $Ctna = new Cuarentena();
                $recepcion['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $recepcion['id_recepcion'] = $GPC['id_rec'];
                $recepcion['id_cultivo'] = $GPC['id_cultivo'];
                $serial_cuarentena = split(':', $GPC['es_cuarentena']);
                $id_analisis_cuarentena = split('_', $GPC[$serial_cuarentena]);
                $recepcion['id_analisis'] = $id_analisis_cuarentena[0];
                $recepcion['tipo_mov'] = 'R';
                $recepcion['fecha_mov'] = 'now()';
                $recepcion['fecha_cultivo'] = 'now()';
                $recepcion['laboratorio'] = 'C';
                $id_cuarentena = $Ctna->guardar($recepcion);
            }
            if (!empty($id_analisis_res)) {
                $GPC['Recepcion']['id'] = $GPC['id_rec'];
                $GPC['Recepcion']['estatus_rec'] = $estatus_rec;
                $Rec->save($GPC['Recepcion']);
                $analisis->_commit_tool();

                switch ($estatus_rec) {
                    case '2':
                        header("location: cuarentena.php?ac=editar&id=" . $id_cuarentena);
                        break;
                    case '3':
                        header("location: analisis_recepcion_listado.php?msg=exitoso");
                        break;
                    case '7':
                        header("location: ../reportes/imprimir_boleta_rechazo.php?id=". $GPC['id_rec']);
                        break;
                }
                die();
            }        
        }
    }

    require('../lib/common/header.php');
    ?>
    <script type="text/javascript">
        function cancelar(){
            history.back();
        }
        
        //    function Left(str, n){
        //        if (n <= 0)
        //            return "";
        //        else if (n > String(str).length)
        //            return str;
        //        else
        //            return String(str).substring(0,n);
        //    }

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
                            esCuarentena=confirm('Va A cuarentena. !!!');
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
            
            //        $(".cuadricula").change(function(){                
            //            if ($.trim($(this).val()).length != 0){
            //                alert($(this).attr('name')+$(this).attr('name').indexOf('_'));
            //            }             
            //        });
            
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
                        esRechazada=confirm('La Muestra  rechazada. Desea emitir boleta de Rechazo !');
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
                        esCuarentena=confirm('La Muestra contiene INSECTOS VIVOS. Desea enviar a Cuarentena !');
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
    <form name="form1" id="form1" method="POST" action="?ac=guardar&cantA=<?= $cantidad ?>" enctype="multipart/form-data">
        <?
        echo $html->input('id_rec', $id_rec, array('type' => 'hidden'));
        echo $html->input('id_cultivo', $IdCultivo, array('type' => 'hidden'));
        echo $html->input('es_cuarentena', '0_0:', array('type' => 'hidden'));
        echo $html->input('es_rechazado', '0_0:', array('type' => 'hidden'));
        ?>
        <div id="titulo_modulo">
            ANALISIS DE RECEPCI&Oacute;N<br/><hr/>
        </div>
        <fieldset>
            <legend>Datos de la Muestra</legend>
            <table align="center" width="100%" border="0">
                <tr>
                    <td>Nro. Entrada</td>
                    <td><span><? echo $infoRec[0]['numero']; ?></span></td>
                    <td>Fecha</td>
                    <td><span><? echo $general->date_sql_screen($infoRec[0]['fecha_recepcion']); ?></span></td>            
                </tr>
                <tr>
                    <td>Carril</td>
                    <td><span><? echo $infoRec[0]['carril']; ?></span></td>
                    <td>Hora</td>
                    <td><? echo $general->hora_sql_normal($infoRec[0]['fecha_recepcion']); ?></td>
                </tr>
                <tr>
                    <td>Cultivo</td>
                    <td colspan="3"><? echo $infoRec[0]['codigo_cul'] . ' - ' . $infoRec[0]['nombre_cul']; ?></td>                
                </tr>
            </table>
        </fieldset>
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
                                    <td align="center"><? echo $html->input('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', '', array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)")); ?></td>
                    <!--                                    <td align="center"><? echo $html->input('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', '', array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>-->
                                    <?
                                    break;
                                case '2':
                                    ?>                    
                                    <td align="center"><? echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $calidad, 'class' => 'cuadricula cualitativo')); ?></td>
                                    <?
                                    break;
                                case '3':
                                    ?>
                                    <td align="center"><?
                    if ($dataAnalisis['estatus'] == 'C')
                        echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $estatus, 'class' => 'cuadricula booleano 40tna', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                    if ($dataAnalisis['estatus'] == 'R')
                        echo $html->select('muestra' . $i . "_" . $dataAnalisis['codigo'] . '[]', array('options' => $estatus, 'class' => 'cuadricula booleano', 'onChange' => "valoresMinMax(this.value," . $dataAnalisis['min_rec'] . "," . $dataAnalisis['max_rec'] . "," . $dataAnalisis['codigo'] . "," . $j . ",'" . $dataAnalisis['estatus'] . "', this)"));
                                    ?></td>
                                        <?
                                        break;
                                }
                            }
                            if ($dataAnalisis['tipo_analisis'] == 1) {
                                echo '<td align="center" width="80">' . $dataAnalisis['min_rec'] . " / " . $dataAnalisis['max_rec'] . '</td>';
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
    </form>    

    <?
    require('../lib/common/footer.php');
?>

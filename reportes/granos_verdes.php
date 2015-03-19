<?php
    require_once('../lib/core.lib.php');
    
    $recepcion = new Recepcion();
    $centro_acopio = new CentroAcopio();
    $cosecha = new Cosecha();
    $analisis = new Analisis();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA, null, null, null, null, null, '2, 7, 8');
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);

    $idCo = (!empty($GPC['id_cosecha'])) ? $GPC['id_cosecha'] : '';
    $fdesde = (!empty($GPC['fecha_inicio'])) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : date('Y-m-d');
    $fhasta = (!empty($GPC['fecha_fin'])) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : date('Y-m-d');
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoRecepciones = $recepcion->recepcionesReporteGeneral($fdesde, $fhasta, $idCA, $idCo, null, null, '2, 7, 8', $porPagina, $inicio);
    
    $total_registros = $recepcion->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if(!empty($GPC['exportar'])){
        $formato = ($GPC['exportar'] == 'Excel') ? 'xlsx' : 'ods';

        $filename_client = "Granos_Verdes_".date("d_m_Y");
        $filename_server = md5(date("dmYhis").rand());
        if($formato=='xlsx'){
            $filename_client .= '.xlsx';
            $filename_server .= '.xlsx';
        }else{
            $filename_client .= '.ods';
            $filename_server .= '.ods';
        }

        require_once APPROOT.'lib/class/PHPExcel/PHPExcel.php';
        require_once APPROOT.'lib/class/PHPExcel/PHPExcel/IOFactory.php';
        $workbook = new PHPExcel();
        $activeWorksheet = $workbook->getActiveSheet();
        $activeWorksheet->setTitle("Reporte Granos Verdes");

        $activeWorksheet->getDefaultStyle()->applyFromArray(
            array('font' => array('name' => 'arial',
            'size' => 10))
        );

        $activeWorksheet->getStyle('A1')->applyFromArray(
            array('font' => array('bold' => true,
            'size' => 12,
            'color' => array('rgb' => '8B0000')))
        );
        $activeWorksheet->getStyle('A2')->applyFromArray(
            array('font' => array('bold' => true,
            'size' => 11))
        );
        $activeWorksheet->getStyle('A3')->applyFromArray(
            array('font' => array('bold' => false,
            'size' => 10))
        );
        $activeWorksheet->getStyle('A4')->applyFromArray(
            array('font' => array('bold' => false,
            'size' => 10))
        );

        $arrStyleTitle = array('fill' => array('type' => PHPExcel_Style_Fill::FILL_SOLID,
            'startcolor' => array('rgb' => '04B486')),
            'font' => array('bold' => true,
            'color' => array('argb' => PHPExcel_Style_Color::COLOR_WHITE)),
            'alignment' => array('horizontal' => PHPExcel_Style_Alignment::HORIZONTAL_CENTER));
        
        $arrStyleNumberTotal = array('font' => array('bold' => true,
            'color' => array('argb' => PHPExcel_Style_Color::COLOR_BLACK)),
            'numberformat' => array('code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1));
        
        $arrStyleNumber = array('numberformat' => array('code' => PHPExcel_Style_NumberFormat::FORMAT_NUMBER_COMMA_SEPARATED1));

        $activeWorksheet->getColumnDimension('A')->setWidth(17); //Fecha Recepcion
        $activeWorksheet->getColumnDimension('B')->setWidth(15); //Nro Entrada
        $activeWorksheet->getColumnDimension('C')->setWidth(17); //Placa
        $activeWorksheet->getColumnDimension('D')->setWidth(15); //Peso Bruto
        $activeWorksheet->getColumnDimension('E')->setWidth(15); //% Humedad
        $activeWorksheet->getColumnDimension('F')->setWidth(15); //% Impureza
        $activeWorksheet->getColumnDimension('G')->setWidth(15); //% Granos Verdes
        $activeWorksheet->getColumnDimension('H')->setWidth(20); //Peso Acondicionado

        //Titulo del reporte
        $activeWorksheet->setCellValue('A1', "AGROPATRIA - SIGESIL");
        $activeWorksheet->setCellValue('A2', "GRANOS VERDES");
        $activeWorksheet->setCellValue('A3', "Fecha: ".date("d-m-Y"));
        $activeWorksheet->setCellValue('A4', "Hora: ".date("h:i"));

        $titulos = array('Fecha Recepción','Nro Entrada','Placa','Peso Bruto','% Humedad','% Impureza','% Gr Verdes','Peso Acondicionado');

        $fila=6;
        
        $idP = $GPC['idP'];
        $idCo = $GPC['idCo'];
        $fDes = $GPC['fdes'];
        $fHas = $GPC['fhas'];
        $idCa = $GPC['idCa'];
        $orden = ' ORDER BY ca.codigo, p.nombre, p2.nombre, p3.nombre, r.fecha_recepcion, r.numero';
        $listadoRecepciones = $recepcion->listadoRecepcion('', $idCa, $idCo, "2, 7, 8", null, '9', null, null, null, null, $idP, $orden, null, null, null, null, $fDes, $fHas);
        if(!empty($listadoRecepciones)){
            $totalRegistros = count($listadoRecepciones);
            $cant = 0;
            foreach($listadoRecepciones as $recepcion){
                $cant++;
                if($centroA != $recepcion['ca_id']){
                    $centroAcopio = "Centro de Acopio: (".$recepcion['ca_codigo'].") ".$recepcion['centro_acopio'];
                    $activeWorksheet->setCellValueByColumnAndRow(0, $fila, $centroAcopio);
                    $fila++;
                }
                $centroA = $recepcion['ca_id'];
                
                if($pro != $recepcion['ced_productor']){
                    //
                    if(!empty($totalPro)){
                        //Total Gral
                        $total[1] += $totalPro[1];
                        $total[2] = '';
                        $total[3] = '';
                        $total[4] = '';
                        $total[5] += $totalPro[5];
                        
                        $activeWorksheet->setCellValueByColumnAndRow(2, $fila, 'Total Productor: ');
                        $oColumn = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));

                        $columnaTotal = 3;
                        foreach($totalPro as $valor){
                            $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                            $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                            $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleNumberTotal);
                            $columnaTotal++;
                        }
                        unset($totalPro);
                        $fila++;$fila++;
                    }
                    //
                    $productor = "Productor: ".$recepcion['productor_nombre']." Cédula/Rif: ".$recepcion['ced_productor'];
                    $activeWorksheet->setCellValueByColumnAndRow(0, $fila, $productor);
                    $fila++;
                    if(empty($recepcion['ced_asociado'])){
                        $j=0;
                        foreach($titulos as $columnTitle){
                            $activeWorksheet->setCellValueByColumnAndRow($j, $fila, $columnTitle);
                            $oColumn = $activeWorksheet->getCellByColumnAndRow($j, $fila)->getColumn();
                            $oRow = $activeWorksheet->getCellByColumnAndRow($j, $fila)->getRow();
                            $activeWorksheet->getStyle($oColumn.$oRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);;
                            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleTitle);
                            $j++;
                        }
                    }
                    $fila++;
                }
                $pro = $recepcion['ced_productor'];
                
                if($aon != $recepcion['ced_asociacion']){
                    $asociacion = "Asociación: ".$recepcion['asociacion_nombre']." Cédula/Rif: ".$recepcion['ced_asociacion'];
                    $activeWorksheet->setCellValueByColumnAndRow(3, $fila, $asociacion);
                    $fila++;
                }
                $aon = $recepcion['ced_asociacion'];
                
                if($ado != $recepcion['ced_asociado']){
                    //
                    if(!empty($totalAdo)){
                        //Total Gral
                        $total[1] += $totalAdo[1];
                        $total[2] = '';
                        $total[3] = '';
                        $total[4] = '';
                        $total[5] += $totalAdo[5];
                        
                        $activeWorksheet->setCellValueByColumnAndRow(2, $fila, 'Total Asociado: ');
                        $oColumn = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));

                        $columnaTotal = 3;
                        foreach($totalAdo as $valor){
                            $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                            $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                            $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleNumberTotal);
                            $columnaTotal++;
                        }
                        unset($totalAdo);
                        $fila++;$fila++;
                    }
                    //
                    $asociado = "Asociado: ".$recepcion['asociado_nombre']." Cédula/Rif: ".$recepcion['ced_asociado'];
                    $activeWorksheet->setCellValueByColumnAndRow(0, $fila, $asociado);
                    $fila++;
                    $j=0;
                    foreach($titulos as $columnTitle){
                        $activeWorksheet->setCellValueByColumnAndRow($j, $fila, $columnTitle);
                        $oColumn = $activeWorksheet->getCellByColumnAndRow($j, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow($j, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);;
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleTitle);
                        $j++;
                    }
                    $fila++;
                }
                $ado = $recepcion['ced_asociado'];
                
                $valores = array();
                $resultado = $analisis->listadoResultados($recepcion['id'], null, null, '32');
                $valores[] = $general->date_sql_screen($recepcion['fecha_recepcion'], '', 'es', '-');
                $numero = ($recepcion['numero'] < 10) ? '0'.$recepcion['numero'] : $recepcion['numero'];
                $nroEntrada = "R".$numero.$general->date_sql_screen($recepcion['fecha_recepcion'], '', 'es', null);
                $valores[] = $nroEntrada;
                $valores[] = $recepcion['placa'];
                $recepcion['peso_02l'] = (!empty($recepcion['peso_02l'])) ? $recepcion['peso_02l'] : 0;
                $recepcion['peso_02v'] = (!empty($recepcion['peso_02v'])) ? $recepcion['peso_02v'] : 0;
                $kgrsNetos = (($recepcion['peso_01l'] + $recepcion['peso_02l']) - ($recepcion['peso_01v'] + $recepcion['peso_02v']));
                $valores[] = $kgrsNetos;
                $valores[] = (!empty($recepcion['humedad'])) ? $recepcion['humedad'] : 0.00;
                $valores[] = (!empty($recepcion['impureza'])) ? $recepcion['impureza'] : 0.00;
                $grsVrds = (!empty($resultado[0]['muestra2'])) ? ($resultado[0]['muestra1'] + $resultado[0]['muestra2']) / 2 : $resultado[0]['muestra1'];
                $valores[] = $grsVrds;
                $grsVrdImp = $grsVrds + $recepcion['impureza'];
                $grsVrdImpResta = $grsVrdImp - 4;
                $impHasta = 4;
                $grsVrdHum = $grsVrdImpResta + $recepcion['humedad'];
                $grsVrdResta = $grsVrdHum - 12;
                $cienResta = 88;
                $impDivision = $impHasta / 100;
                $descHum = (($kgrsNetos * $grsVrdResta) / $cienResta);
                $descImp = (($kgrsNetos - $descHum) * $impDivision);
                $pesoAcon = ($kgrsNetos - $descHum - $descImp);
                $valores[] = $pesoAcon;

                $columna = 0;
                foreach($valores as $valor){
                    if(is_numeric($valor)){
                        $activeWorksheet->setCellValueByColumnAndRow($columna, $fila, $valor);
                        $oColumn2 = $activeWorksheet->getCellByColumnAndRow($columna, $fila)->getColumn();
                        $oRow2 = $activeWorksheet->getCellByColumnAndRow($columna, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn2.$oRow2)->applyFromArray($arrStyleNumber);
                    }else
                        $activeWorksheet->setCellValueByColumnAndRow($columna, $fila, $valor);
                    $columna++;
                }
                $fila++;
                
                //TOTALES POR ASOCIADO
                if(!empty($recepcion['ced_asociado'])){
                    $totalAdo[1] += $kgrsNetos;
                    $totalAdo[2] = '';
                    $totalAdo[3] = '';
                    $totalAdo[4] = '';
                    $totalAdo[5] += $pesoAcon;
                }
                
                //TOTALES POR PRODUCTOR
                if(empty($recepcion['ced_asociado'])){
                    $totalPro[1] += $kgrsNetos;
                    $totalPro[2] = '';
                    $totalPro[3] = '';
                    $totalPro[4] = '';
                    $totalPro[5] += $pesoAcon;
                }
                
                
                if($cant == $totalRegistros){
                    //TOTAL POR ASOCIADO
                    if(!empty($totalAdo)){
                        //Total Gral
                        $total[1] += $totalAdo[1];
                        $total[2] = '';
                        $total[3] = '';
                        $total[4] = '';
                        $total[5] += $totalAdo[5];
                        
                        $activeWorksheet->setCellValueByColumnAndRow(2, $fila, 'Total Asociado: ');
                        $oColumn = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));

                        $columnaTotal = 3;
                        foreach($totalAdo as $valor){
                            $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                            $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                            $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleNumberTotal);
                            $columnaTotal++;
                        }
                        $fila++;
                    }
                    
                    //TOTAL POR PRODUCTOR
                    if(!empty($totalPro)){
                        //Total Gral
                        $total[1] += $totalPro[1];
                        $total[2] = '';
                        $total[3] = '';
                        $total[4] = '';
                        $total[5] += $totalPro[5];
                        
                        $activeWorksheet->setCellValueByColumnAndRow(2, $fila, 'Total Productor: ');
                        $oColumn = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));

                        $columnaTotal = 3;
                        foreach($totalPro as $valor){
                            $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                            $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                            $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleNumberTotal);
                            $columnaTotal++;
                        }
                        $fila++;
                    }
                }
            }
            $fila++;
            $activeWorksheet->setCellValueByColumnAndRow(2, $fila, 'Total: ');
            $oColumn = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getColumn();
            $oRow = $activeWorksheet->getCellByColumnAndRow(2, $fila)->getRow();
            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));

            $columnaTotal = 3;
            foreach($total as $valor){
                $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleNumberTotal);
                $columnaTotal++;
            }
        }
        
        chdir(APPROOT.'temp_files');

        if($formato=='xlsx'){
            $writer_name = 'Excel2007';
        } else {
            $writer_name = 'Excel5';
        }

        $writer = PHPExcel_IOFactory::createWriter($workbook, $writer_name);
        $writer->save($filename_server);
        $descarga = new Descarga(APPROOT.'temp_files/'.$filename_server, $filename_client, $_SERVER['PHP_SELF']);
        //Quitar el true para que no elimine los archivos temporales
        $resultado = $descarga->download_file(true);

        if($resultado!=1){
            header("location: $referer?msg=error");
        }
        exit;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    show_div_loader();
    
    $(document).ready(function(){
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        REPORTE - GRANOS VERDES<br/><hr/>
    </div>
    <div id="mensajes">
        <?php
            switch($GPC['msg']){
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?php
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <?php } ?>
                <tr>
                    <td width="1">Desde </td>
                    <td width="200">
                        <?php echo $html->input('fecha_inicio', $general->date_sql_screen($fdesde, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fdesde" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fdesde",
                                inputField : "fecha_inicio",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_inicio']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td width="1">Hasta </td>
                    <td>
                        <?php echo $html->input('fecha_fin', $general->date_sql_screen($fhasta, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fhasta" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fhasta",
                                inputField : "fecha_fin",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_fin']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>Cosecha </td>
                    <td><?php echo $html->select('id_cosecha',array('options'=>$listadoC, 'selected' => $GPC['id_cosecha'], 'default' => 'Todas'))?></td>
                </tr>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?php
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <?php } ?>
            <th>Cosecha</th>
            <th>Cedula/Rif Productor</th>
            <th>Productor</th>
            <th>Accion</th>
        </tr>
        <?php
            $i=0;
            $idCA = (!empty($idCA)) ? "_$idCA" : '';
            foreach($listadoRecepciones as $dataRecepcion){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?php echo "(".$dataRecepcion['codigo'].") ".$dataRecepcion['nombre_ca']?></td>
            <?php } ?>
            <td><?php echo $dataRecepcion['cosecha']?></td>
            <td align="center"><?php echo $dataRecepcion['ced_rif']?></td>
            <td><?php echo $dataRecepcion['productor']?></td>
            
            <td align="center">
                <?php
                    echo $html->link('<img src="../images/excel.png" width="16" height="16" title=Excel>', 'granos_verdes.php?exportar=Excel&idP='.$dataRecepcion['id'].'&idCo='.$dataRecepcion['id_co'].'&fdes='.$fdesde.'&fhas='.$fhasta.'&idCa='.$dataRecepcion['ca_id']);
                    $urls = array(3 => '../reportes/pdf_listado_granos_verdes_individual.php?id='.$dataRecepcion['id'].'_'.$dataRecepcion['id_co'].'_'.$fdesde.'_'.$fhasta.$idCA);
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?php
    require('../lib/common/footer.php');
?>
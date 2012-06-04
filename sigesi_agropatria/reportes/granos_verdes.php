<?
    require_once('../lib/core.lib.php');
    
    $recepcion = new Recepcion();
    $centro_acopio = new CentroAcopio();
    $cosecha = new Cosecha();
    $analisis = new Analisis();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);

    /*$cedRif = (!empty($GPC['ced_rif'])) ? $GPC['ced_rif'] : '';
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';*/
    $fliqD = (!empty($GPC['fecha_liqD'])) ? $general->fecha_normal_sql($GPC['fecha_liqD'], 'es') : '';
    $fliqH = (!empty($GPC['fecha_liqH'])) ? $general->fecha_normal_sql($GPC['fecha_liqH'], 'es') : '';
    $frecD = (!empty($GPC['fecha_recD'])) ? $GPC['fecha_recD'] : date("d-m-Y", time() - 86400);
    $frecH = (!empty($GPC['fecha_recH'])) ? $GPC['fecha_recH'] : date("d-m-Y");
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $orden = ($_SESSION['s_perfil_id'] == GERENTEG) ? ' ORDER BY r.id_centro_acopio, r.creado, numero' : ' ORDER BY r.creado, numero';
    $listadoRecepciones = $recepcion->listadoRecepcion('', $idCA, '', "2, 7", null, '9', null, null, $porPagina, $inicio, null, $orden, $contrato, $productor, null, null, $fliqD, $fliqH, $frecD, $frecH);
    
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

        $activeWorksheet->getColumnDimension('A')->setWidth(20); //Centro de Acopio
        $activeWorksheet->getColumnDimension('B')->setWidth(17); //Fecha Recepcion
        $activeWorksheet->getColumnDimension('C')->setWidth(20); //Peso Bruto
        $activeWorksheet->getColumnDimension('D')->setWidth(15); //% Humedad
        $activeWorksheet->getColumnDimension('E')->setWidth(15); //% Impureza
        $activeWorksheet->getColumnDimension('F')->setWidth(20); //% Granos Verdes        
        $activeWorksheet->getColumnDimension('G')->setWidth(15); //Desc por Hum
        $activeWorksheet->getColumnDimension('H')->setWidth(15); //Desc por Imp
        $activeWorksheet->getColumnDimension('I')->setWidth(20); //Peso Acondicionado

        //Titulo del reporte
        $activeWorksheet->setCellValue('A1', "AGROPATRIA - SIGESIL");
        $activeWorksheet->setCellValue('A2', "GRANOS VERDES");
        $activeWorksheet->setCellValue('A3', "Fecha: ".date("d-m-Y"));
        $activeWorksheet->setCellValue('A4', "Hora: ".date("h:i"));

        /*indice pata inprimir los titulos de la columnas de reporte*/
        $index_title=6;
        $index_detail=0;
        /*linea de titulo del detalle*/
        $j=0;
        $titulos = array('Centro de Acopio','Fecha Recepción','Peso Bruto',
                '% Hum Pond','% Imp Pond','% Gr Verdes Pond','Desc por Hum','Desc por Imp','Peso Acondicionado');
        foreach($titulos as $columnTitle){
            $activeWorksheet->setCellValueByColumnAndRow($j, $index_title, $columnTitle);
            $oColumn = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getColumn();
            $oRow = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getRow();
            $activeWorksheet->getStyle($oColumn.$oRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);;
            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleTitle);
            $j++;
        }

        $fila = 7;
        
        $listadoRecepciones = $recepcion->listadoRecepcion('', $idCA, '', "2, 7", null, '9', null, null, $porPagina, $inicio, null, $orden, $contrato, $productor, null, null, $fliqD, $fliqH, $frecD, $frecH);
        if(!empty($listadoRecepciones)){
            foreach($listadoRecepciones as $recepcion){
                $resultado = $analisis->listadoResultados($recepcion['id'], null, null, '32');
                
                $valores = array();
                $valores[] = "(".$recepcion['ca_codigo'].") ".$recepcion['centro_acopio'];
                $valores[] = $general->date_sql_screen($recepcion['fecha_recepcion'], '', 'es', '-');
                $recepcion['peso_02l'] = (!empty($recepcion['peso_02l'])) ? $recepcion['peso_02l'] : 0;
                $recepcion['peso_02v'] = (!empty($recepcion['peso_02v'])) ? $recepcion['peso_02v'] : 0;
                $kgrsNetos = (($recepcion['peso_01l'] + $recepcion['peso_02l']) - ($recepcion['peso_01v'] + $recepcion['peso_02v']));
                $valores[] = round($kgrsNetos);
                $valores[] = (!empty($recepcion['humedad'])) ? $recepcion['humedad'] : 0.00;
                $valores[] = (!empty($recepcion['impureza'])) ? $recepcion['impureza'] : 0.00;
                $grsVrds = (!empty($resultado[0]['muestra2'])) ? ($resultado[0]['muestra1'] + $resultado[0]['muestra2']) / 2 : $resultado[0]['muestra1'];
                $valores[] = round($grsVrds);
                $grsVrdImp = $grsVrds + $recepcion['impureza'];
                $grsVrdImpResta = $grsVrdImp - 4;
                $impHasta = 4;
                $grsVrdHum = $grsVrdImpResta + $recepcion['humedad'];
                $grsVrdResta = $grsVrdHum - 12;
                $cienResta = 88;
                $impDivision = $impHasta / 100;
                $descHum = (($kgrsNetos * $grsVrdResta) / $cienResta);
                $valores[] = round($descHum);
                $descImp = (($kgrsNetos - $descHum) * $impDivision);
                $valores[] = round($descImp);
                $pesoAcon = ($kgrsNetos - $descHum - $descImp);
                $valores[] = round($pesoAcon);

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
                
                //TOTALES POR CENTRO DE ACOPIO
                $total[1] += round($kgrsNetos);
                $total[2] = '';
                $total[3] = '';
                $total[4] = '';
                $total[5] += round($descHum);
                $total[6] += round($descImp);
                $total[7] += round($pesoAcon);
                
                //TOTALES PORCENTUALES NO SE SACAN
            }
            $fila++;
            $activeWorksheet->setCellValueByColumnAndRow(1, $fila, 'Total:');
            $oColumn = $activeWorksheet->getCellByColumnAndRow(1, $fila)->getColumn();
            $oRow = $activeWorksheet->getCellByColumnAndRow(1, $fila)->getRow();
            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));
            
            $columnaTotal = 2;
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
        <?
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
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr>
                    <td width="150">Fecha Recepci&oacute;n Desde</td>
                    <td>
                        <? echo $html->input('fecha_recD', $frecD, array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="frecD" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "frecD",
                                inputField : "fecha_recD",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($frecD));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td width="150">Fecha Recepci&oacute;n Hasta</td>
                    <td>
                        <? echo $html->input('fecha_recH', $frecH, array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="frecH" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "frecH",
                                inputField : "fecha_recH",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($frecH));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>Fecha Liquidaci&oacute;n Desde</td>
                    <td>
                        <? echo $html->input('fecha_liqD', $general->date_sql_screen($fliqD, '', 'es', '-'), array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fliqD" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fliqD",
                                inputField : "fecha_liqD",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_liqD']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td>Fecha Liquidaci&oacute;n Hasta</td>
                    <td>
                        <? echo $html->input('fecha_liqH', $general->date_sql_screen($fliqH, '', 'es', '-'), array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fliqH" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fliqH",
                                inputField : "fecha_liqH",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_liqH']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <!--tr>
                    <td>C&eacute;dula/Rif</td>
                    <td><? echo $html->input('ced_rif', $cedRif, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                    <td>Nombre</td>
                    <td><? echo $html->input('nombre', $nombre, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                </tr-->
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            echo $html->input('exportar', 'Excel', array('type' => 'submit'));
                            echo $html->input('exportar', 'Calc', array('type' => 'submit'));
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th width="150">Centro de Acopio</th>
            <? } ?>
            <th>Fecha Recepci&oacute;n</th>
            <th>Kgrs Netos</th>
            <th>%Hum Pond</th>
            <th>%Imp Pond</th>
            <th>%Grs Verdes Pond</th>
            <th>Desc por Hum</th>
            <th>Desc por Imp</th>
            <th>Peso Acond</th>
        </tr>
        <?
            $i=0;
            foreach($listadoRecepciones as $dataRecepcion){
                $clase = $general->obtenerClaseFila($i);
                $resultado = $analisis->listadoResultados($dataRecepcion['id'], null, null, '32');
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?="(".$dataRecepcion['ca_codigo'].") ".$dataRecepcion['centro_acopio']?></td>
            <?
                }
                $dataRecepcion['peso_02l'] = (!empty($dataRecepcion['peso_02l'])) ? $dataRecepcion['peso_02l'] : 0;
                $dataRecepcion['peso_02v'] = (!empty($dataRecepcion['peso_02v'])) ? $dataRecepcion['peso_02v'] : 0;
                $kgrsNetos = round((($dataRecepcion['peso_01l'] + $dataRecepcion['peso_02l']) - ($dataRecepcion['peso_01v'] + $dataRecepcion['peso_02v'])));
                $grsVrds = (!empty($resultado[0]['muestra2'])) ? round(($resultado[0]['muestra1'] + $resultado[0]['muestra2']) / 2) : round($resultado[0]['muestra1']);
                $grsVrdImp = $grsVrds + $dataRecepcion['impureza'];
                $grsVrdImpResta = $grsVrdImp - 4;
                $impHasta = 4;
                $grsVrdHum = $grsVrdImpResta + $dataRecepcion['humedad'];
                $grsVrdResta = $grsVrdHum - 12;
                $cienResta = 88;
                $impDivision = $impHasta / 100;
                $descHum = round((($kgrsNetos * $grsVrdResta) / $cienResta));
                $descImp = round((($kgrsNetos - $descHum) * $impDivision));
                $pesoAcon = round(($kgrsNetos - $descHum - $descImp));
                
                $totalKgrsNetos += $kgrsNetos;
                $totalDescHum += $descHum;
                $totalDescImp += $descImp;
                $totalDescPesoA += $pesoAcon;
            ?>
            <td align="center"><?=$general->date_sql_screen($dataRecepcion['fecha_recepcion'], '', 'es', '-')?></td>
            <td align="right"><?=$general->formato_numero($kgrsNetos, 2)?></td>
            <td align="right"><?=(!empty($dataRecepcion['humedad'])) ? $general->formato_numero($dataRecepcion['humedad'], 2) : 0.00?></td>
            <td align="right"><?=(!empty($dataRecepcion['impureza'])) ? $general->formato_numero($dataRecepcion['impureza'], 2) : 0.00?></td>
            <td align="right"><?=$general->formato_numero($grsVrds, 2)?></td>
            <td align="right"><?=$general->formato_numero($descHum, 2)?></td>
            <td align="right"><?=$general->formato_numero($descImp, 2)?></td>
            <td align="right"><?=$general->formato_numero($pesoAcon, 2)?></td>
        </tr>
        <? $i++; } ?>
        <tr align="right">
            <th>&nbsp;</th>
            <th>Total</th>
            <th><?=$general->formato_numero(round($totalKgrsNetos), 2)?></th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
            <th><?=$general->formato_numero(round($totalDescHum), 2)?></th>
            <th><?=$general->formato_numero(round($totalDescImp), 2)?></th>
            <th><?=$general->formato_numero(round($totalDescPesoA), 2)?></th>
        </tr>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?
    require('../lib/common/footer.php');
?>
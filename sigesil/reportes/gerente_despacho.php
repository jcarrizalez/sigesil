<?
    require_once('../lib/core.lib.php');
    
    $despacho = new Despacho();
    $centro_acopio = new CentroAcopio();
    $objCultivo = new Cultivo();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listadoCultivos = $objCultivo->buscarCultivo();
    foreach($listadoCultivos as $valor){
        $listadoC[$valor['id']] = "(".$valor['codigo'].") ".$valor['nombre'];
    }
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $listadoE = array(1 => 'Romana Vac&iacute;o', 
                            'Lab. Central', 
                            'Romana Lleno', 
                            'Rechazado', 
                            'Despachado');

    $orden = (!empty($GPC['orden'])) ? $GPC['orden'] : '';
    $salida = (!empty($GPC['salida'])) ? $GPC['salida'] : '';
    $cliente = (!empty($GPC['cliente'])) ? $GPC['cliente'] : '';
    $cultivo = (!empty($GPC['id_cultivo'])) ? $GPC['id_cultivo'] : '';
    $placa = (!empty($GPC['placa'])) ? $GPC['placa'] : '';
    $estatus = (!empty($GPC['estatus'])) ? $GPC['estatus'] : '';
    $fliqD = (!empty($GPC['fecha_liqD'])) ? $general->fecha_normal_sql($GPC['fecha_liqD'], 'es') : '';
    $fliqH = (!empty($GPC['fecha_liqH'])) ? $general->fecha_normal_sql($GPC['fecha_liqH'], 'es') : '';
    
    $fdesD = (!empty($GPC['fecha_desD'])) ? $GPC['fecha_desD'] : date("d-m-Y");
    $fdesH = (!empty($GPC['fecha_desH'])) ? $GPC['fecha_desH'] : date("d-m-Y");
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $order = ($_SESSION['s_perfil_id'] == GERENTEG) ? ' ORDER BY d.id_centro_acopio, d.creado, d.numero' : ' ORDER BY d.creado, d.numero';
    $listadoDespachos = $despacho->listadoDespacho(null, $idCA, $cultivo, null, $salida, $estatus, null, null, $porPagina, $inicio, $orden, $order, $cliente, $placa, $fliqD, $fliqH, $fdesD, $fdesH);
    $total_registros = $despacho->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if(!empty($GPC['exportar'])){
        $formato = ($GPC['exportar'] == 'Excel') ? 'xlsx' : 'ods';

        $filename_client = "Consulta_Gerente_Despacho_".date("d_m_Y");
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
        $activeWorksheet->setTitle("Reporte Gerente");

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

        $activeWorksheet->getColumnDimension('A')->setWidth(20); //Centro de Acopio
        $activeWorksheet->getColumnDimension('B')->setWidth(15); //Cultivo
        $activeWorksheet->getColumnDimension('C')->setWidth(15); //Nro Salida
        $activeWorksheet->getColumnDimension('D')->setWidth(17); //Fecha Despacho
        $activeWorksheet->getColumnDimension('E')->setWidth(10); //Estatus
        $activeWorksheet->getColumnDimension('F')->setWidth(15); //Orden
        $activeWorksheet->getColumnDimension('G')->setWidth(20); //Ced/Rif Cliente
        $activeWorksheet->getColumnDimension('H')->setWidth(35); //Cliente
        $activeWorksheet->getColumnDimension('I')->setWidth(15); //Vehiculo
        $activeWorksheet->getColumnDimension('J')->setWidth(15); //Placa Motriz
        $activeWorksheet->getColumnDimension('K')->setWidth(15); //Placa Remolque
        $activeWorksheet->getColumnDimension('L')->setWidth(20); //Cedula Chofer
        $activeWorksheet->getColumnDimension('M')->setWidth(35); //Chofer
        $activeWorksheet->getColumnDimension('N')->setWidth(20); //Peso Lleno Motriz
        $activeWorksheet->getColumnDimension('O')->setWidth(20); //Peso Lleno Remolque
        $activeWorksheet->getColumnDimension('P')->setWidth(20); //Peso Bruto
        $activeWorksheet->getColumnDimension('Q')->setWidth(20); //Peso Vacio Motriz
        $activeWorksheet->getColumnDimension('R')->setWidth(20); //Peso Vacio Remolque
        $activeWorksheet->getColumnDimension('S')->setWidth(20); //Peso Tara
        $activeWorksheet->getColumnDimension('T')->setWidth(15); //% Humedad Motriz
        $activeWorksheet->getColumnDimension('U')->setWidth(15); //% Humedad Remolque
        $activeWorksheet->getColumnDimension('V')->setWidth(15); //Humedad Desc Motriz
        $activeWorksheet->getColumnDimension('W')->setWidth(15); //Humedad Desc Remolque
        $activeWorksheet->getColumnDimension('X')->setWidth(15); //% Impureza Motriz
        $activeWorksheet->getColumnDimension('Y')->setWidth(15); //% Impureza Remolque
        $activeWorksheet->getColumnDimension('Z')->setWidth(15); //Impureza Desc Motriz
        $activeWorksheet->getColumnDimension('AA')->setWidth(15); //Impureza Desc Remolque
        $activeWorksheet->getColumnDimension('AB')->setWidth(20); //Peso Acond Motriz
        $activeWorksheet->getColumnDimension('AC')->setWidth(20); //Peso Acond Remolque
        $activeWorksheet->getColumnDimension('AD')->setWidth(20); //Peso Acon Liq. Motriz
        $activeWorksheet->getColumnDimension('AE')->setWidth(20); //Peso Acon Liq. Remolque
        $activeWorksheet->getColumnDimension('AF')->setWidth(17); //Fecha Liquidacion

        //Titulo del reporte
        $centroAcopio = ($_SESSION['s_perfil_id'] == GERENTEG) ? 'TODOS ': $_SESSION['s_ca_nombre'];
        $activeWorksheet->setCellValue('A1', "AGROPATRIA - $centroAcopio");
        $activeWorksheet->setCellValue('A2', "CONSULTA DEL GERENTE - DESPACHO");
        $activeWorksheet->setCellValue('A3', "Fecha: ".date("d-m-Y"));
        $activeWorksheet->setCellValue('A4', "Hora: ".date("h:i"));

        /*indice pata inprimir los titulos de la columnas de reporte*/
        $index_title=6;
        $index_detail=0;
        /*linea de titulo del detalle*/
        $j=0;
            $titulos = array('Centro de Acopio','Cultivo','Nro Salida','Fecha Despacho','Estatus',
                'Orden','Ced/Rif Cliente','Cliente','Vehiculo','Placa Motriz','Placa Remolque','Cedula Chofer',
                'Chofer', 'Peso Lleno Motriz','Peso Lleno Remolque','Peso Bruto','Peso Vacio Motriz','Peso Vacio Remolque',
                'Peso Tara','% Humedad Motriz','% Humedad Remolque','Humedad Desc Motriz','Humedad Desc Remolque',
                '% Impureza Motriz','% Impureza Remolque','Impureza Desc Motriz','Impureza Desc Remolque','Peso Acond Motriz','Peso Acond Remolque',
                'Peso Acon Liq. Motriz','Peso Acon Liq. Remolque','Fecha Liquidacion');
        foreach($titulos as $columnTitle){
            $activeWorksheet->setCellValueByColumnAndRow($j, $index_title, $columnTitle);
            $oColumn = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getColumn();
            $oRow = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getRow();
            $activeWorksheet->getStyle($oColumn.$oRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);;
            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleTitle);
            $j++;
        }

        $fila = 7;
        
        $listadoDespachos = $despacho->listadoDespacho(null, $idCA, $cultivo, null, $salida, $estatus, null, null, $porPagina, $inicio, $orden, $order, $cliente, $placa, $fliqD, $fliqH, $fdesD, $fdesH);
        $totalRegistros = count($listadoDespachos);
        if(!empty($listadoDespachos)){
            $cant = 0;
            foreach($listadoDespachos as $despacho){
                $cant++;
                
                if($caDiferente != '' && $caDiferente != $despacho['id_centro_acopio']){
                    $columnaTotalCA = 12;
                    foreach($totalesCA as $valor){
                        $activeWorksheet->setCellValueByColumnAndRow($columnaTotalCA, $fila, $valor);
                        $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotalCA, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotalCA, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));
                        $columnaTotalCA++;
                    }

                    //TOTALES
                    $totales[0] = 'Total: ';
                    $totales[1] += $totalesCA[1];
                    $totales[2] += $totalesCA[2];
                    $totales[3] += $totalesCA[3];
                    $totales[4] += $totalesCA[4];
                    $totales[5] += $totalesCA[5];
                    $totales[6] += $totalesCA[6];
                    $totales[7] += $totalesCA[7];
                    $totales[8] += $totalesCA[7];
                    $totales[9] += $totalesCA[8];
                    $totales[10] += $totalesCA[8];
                    $totales[11] += $totalesCA[9];
                    $totales[12] += $totalesCA[9];
                    $totales[13] += $totalesCA[10];
                    $totales[14] += $totalesCA[10];
                    $totales[15] += $totalesCA[11];
                    $totales[16] += $totalesCA[11];
                    $totales[17] += $totalesCA[12];
                    $totales[18] += $totalesCA[12];
                    unset($totalesCA);
                    $fila++; $fila++;
                }
                $caDiferente = $despacho['id_centro_acopio'];
                
                $valores = array();
                $valores[] = "(".$despacho['ca_codigo'].") ".$despacho['centro_acopio'];
                $valores[] = "(".$despacho['cultivo_codigo'].") ".$despacho['cultivo_nombre'];
                $numero = ($despacho['numero'] < 10) ? '0'.$despacho['numero'] : $despacho['numero'];
                $numSalida = "R".$numero.$general->date_sql_screen($despacho['fecha_des'], '', 'es', null);
                $valores[] = $numSalida;
                $valores[] = $general->date_sql_screen($despacho['fecha_des'], '', 'es', '-');
                $valores[] = $general->estatus($despacho['estatus'], 'rec');
                $valores[] = $despacho['numero_guia'];
                $valores[] = $despacho['ced_cliente'];
                $valores[] = $despacho['cliente_nombre'];
                $valores[] = $despacho['marca'];
                $valores[] = $despacho['placa'];
                $valores[] = $despacho['placa_remolques'];
                $valores[] = $despacho['ced_chofer'];
                $valores[] = $despacho['chofer_nombre'];
                $valores[] = (!empty($despacho['peso_01l'])) ? $despacho['peso_01l'] : 0;
                $valores[] = (!empty($despacho['peso_02l'])) ? $despacho['peso_02l'] : 0;
                $totalL = $despacho['peso_01l'] + $despacho['peso_02l'];
                $valores[] = $totalL;
                $valores[] = (!empty($despacho['peso_01v'])) ? $despacho['peso_01v'] : 0;
                $valores[] = (!empty($despacho['peso_02v'])) ? $despacho['peso_02v'] : 0;
                $totalV = $despacho['peso_01v'] + $despacho['peso_02v'];
                $valores[] = $totalV;
                $valores[] = (!empty($despacho['humedad'])) ? $despacho['humedad'] : 0;
                $valores[] = (!empty($despacho['humedad2'])) ? $despacho['humedad2'] : 0;
                $valores[] = (!empty($despacho['humedad_des'])) ? $despacho['humedad_des'] : 0;
                $valores[] = (!empty($despacho['humedad_des2'])) ? $despacho['humedad_des2'] : 0;
                $valores[] = (!empty($despacho['impureza'])) ? $despacho['impureza'] : 0;
                $valores[] = (!empty($despacho['impureza2'])) ? $despacho['impureza2'] : 0;
                $valores[] = (!empty($despacho['impureza_des'])) ? $despacho['impureza_des'] : 0;
                $valores[] = (!empty($despacho['impureza_des2'])) ? $despacho['impureza_des2'] : 0;
                $valores[] = (!empty($despacho['peso_acon'])) ? $despacho['peso_acon'] : 0;
                $valores[] = (!empty($despacho['peso_acon2'])) ? $despacho['peso_acon2'] : 0;
                $valores[] = (!empty($despacho['peso_acon_liq'])) ? $despacho['peso_acon_liq'] : 0;
                $valores[] = (!empty($despacho['peso_acon_liq2'])) ? $despacho['peso_acon_liq2'] : 0;
                $valores[] = $general->date_sql_screen($despacho['fecha_pel'], '', 'es', '-');

                $columna = 0;
                foreach($valores as $valor){
                    $activeWorksheet->setCellValueByColumnAndRow($columna, $fila, $valor);
                    $columna++;
                }
                $fila++;
                
                //TOTALES POR CENTRO DE ACOPIO
                $totalesCA[0] = 'Total del Centro de Acopio: '.$despacho['centro_acopio'];
                $totalesCA[1] += $despacho['peso_01l'];
                $totalesCA[2] += $despacho['peso_02l'];
                $totalesCA[3] += $despacho['peso_01l'] + $despacho['peso_02l'];
                $totalesCA[4] += $despacho['peso_01v'];
                $totalesCA[5] += $despacho['peso_02v'];
                $totalesCA[6] += $despacho['peso_01v'] + $despacho['peso_02v'];
                $totalesCA[7] += $despacho['humedad'];
                $totalesCA[8] += $despacho['humedad2'];
                $totalesCA[9] += $despacho['humedad_des'];
                $totalesCA[10] += $despacho['humedad_des2'];
                $totalesCA[11] += $despacho['impureza'];
                $totalesCA[12] += $despacho['impureza2'];
                $totalesCA[13] += $despacho['impureza_des'];
                $totalesCA[14] += $despacho['impureza_des2'];
                $totalesCA[15] += $despacho['peso_acon'];
                $totalesCA[16] += $despacho['peso_acon2'];
                $totalesCA[17] += $despacho['peso_acon_liq'];
                $totalesCA[18] += $despacho['peso_acon_liq2'];
                
                if($totalRegistros == $cant){
                    $columnaTotalCA = 12;
                    foreach($totalesCA as $valor){
                        $activeWorksheet->setCellValueByColumnAndRow($columnaTotalCA, $fila, $valor);
                        $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotalCA, $fila)->getColumn();
                        $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotalCA, $fila)->getRow();
                        $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));
                        $columnaTotalCA++;
                    }

                    //TOTALES
                    $totales[0] = 'Total: ';
                    $totales[1] += $totalesCA[1];
                    $totales[2] += $totalesCA[2];
                    $totales[3] += $totalesCA[3];
                    $totales[4] += $totalesCA[4];
                    $totales[5] += $totalesCA[5];
                    $totales[6] += $totalesCA[6];
                    $totales[7] += $totalesCA[7];
                    $totales[8] += $totalesCA[8];
                    $totales[9] += $totalesCA[9];
                    $totales[10] += $totalesCA[10];
                    $totales[11] += $totalesCA[11];
                    $totales[12] += $totalesCA[12];
                    $totales[13] += $totalesCA[13];
                    $totales[14] += $totalesCA[14];
                    $totales[15] += $totalesCA[15];
                    $totales[16] += $totalesCA[16];
                    $totales[17] += $totalesCA[17];
                    $totales[18] += $totalesCA[18];
                    $fila++;
                }
            }
            $fila++;
            $columnaTotal = 12;
            foreach($totales as $valor){
                $activeWorksheet->setCellValueByColumnAndRow($columnaTotal, $fila, $valor);
                $oColumn = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getColumn();
                $oRow = $activeWorksheet->getCellByColumnAndRow($columnaTotal, $fila)->getRow();
                $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray(array('font' => array('bold' => true, 'size' => 10)));
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
    
    function array_sum_key($arr, $index = null, $field = null){
        if(!is_array($arr) || sizeof($arr) < 1){
            return 0;
        }
        $ret = 0;
        foreach( $arr as $id => $data ){
            if(isset($index) && $field == null){
                $ret += (isset( $data[$index])) ? $data[$index] : 0;
            }elseif(isset($field)){
                if($data[$field] == $index) $ret++;
            }else{
                $ret += $data;
            }
        }
        return $ret;
    }

    $tRomanaV = array_sum_key($listadoDespachos,'1', 'estatus');
    $tLabC = array_sum_key($listadoDespachos, '2', 'estatus');
    $tRomanaL = array_sum_key($listadoDespachos,'3', 'estatus');
    $tRechazo = array_sum_key($listadoDespachos,'4', 'estatus');
    $tLiquidado = array_sum_key($listadoDespachos,'5', 'estatus');
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    show_div_loader();
    
    var win = null;
    function openWindow(mypage,myname,w,h,scroll){
        LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
        TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
        settings ='height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+', scrollbars=yes ';
        win = window.open(mypage,myname,settings)
    }
    
    $(document).ready(function(){
        $('#anterior').attr('disabled', true);
        $('#Regresar').click(function(){
           history.back();
        });
        
        $('#anterior').click(function(){
            $('#siguiente').attr('disabled', false);
            var siguiente = $('#campos').val();
            if(siguiente > 6){
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').hide();
                siguiente++;
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').hide();
                siguiente = siguiente-3;
                $('#campos').val(siguiente);
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').show();
                siguiente++;
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').show();
            }
            if(siguiente == 7) $('#anterior').attr('disabled', true);
        });
        
        $('#siguiente').click(function(){
            $('#anterior').attr('disabled', false);
            var siguiente = $('#campos').val();
            if(siguiente < 22){
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').hide();
                siguiente++;
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').hide();
                siguiente++;
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').show();
                $('#campos').val(siguiente);
                siguiente++;
                $('td:nth-child('+siguiente+'),th:nth-child('+siguiente+')').show();
            }
            if(siguiente == 23) $('#siguiente').attr('disabled', true);
        });
        
        // Funcion que abre los Dialogos
        $('#dialog').dialog({
            autoOpen: false,
            draggable: false,
            closeOnEscape: true,
            width: 250,
            modal: true,
            resizable: false
        });

        // Boton para abir el Dialogo
        $('#leyenda').click(function(){
            $('#dialog').dialog('open');
            return false;
        });
    });
</script>
    <div id="titulo_modulo">
        CONSULTA DEL GERENTE - DESPACHO<br/><hr/>
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
    <div id="dialog" title="Leyenda de Estatus" style="display: none;">
	<table align="center" border="0" style="font-size: 11px;">
            <tr align="center" class="titulos_tabla">
                <th width="140">Estatus</th>
                <th>Cantidad</th>
            </tr>
            <tr>
                <th style="vertical-align: middle !important">
                    <? echo $html->link('<img src="../images/peso1.png" width="16" height="16">'); ?>
                    Romana Vac&iacute;o
                </th>
                <td align="center"><?=$tRomanaV?></td>
            </tr>
            <tr>
                <th style="vertical-align: middle !important">
                    <? echo $html->link('<img src="../images/reloj.png" width="16" height="16">'); ?>
                    Lab. Central
                </th>
                <td align="center"><?=$tLabC?></td>
            </tr>
            <tr>
                <th style="vertical-align: middle !important">
                    <? echo $html->link('<img src="../images/peso1.png" width="26" height="20">'); ?>
                    Romana Lleno
                </th>
                <td align="center"><?=$tRomanaL?></td>
            </tr>
            <tr>
                <th style="vertical-align: middle !important">
                    <? echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16">'); ?>
                    Rechazado
                </th>
                <td align="center"><?=$tRechazo?></td>
            </tr>
            <tr>
                <th style="vertical-align: middle !important">
                    <? echo $html->link('<img src="../images/habilitar.png" width="16" height="16">'); ?>
                    Despachado
                </th>
                <td align="center"><?=$tLiquidado?></td>
            </tr>
        </table>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <tr>
                    <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                    <td>Centro de Acopio</td>
                    <td><? echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $idCA, 'default' => 'Todos', 'class' => 'inputLogin')); ?></td>
                    <? } ?>
                </tr>
                <tr>
                    <td>Orden</td>
                    <td><? echo $html->input('orden', $orden, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                    <td width="150">Salida</td>
                    <td><? echo $html->input('salida', $salida, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                </tr>
                <tr>
                    <td width="150">Cliente</td>
                    <td><? echo $html->input('cliente', $cliente, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                    <td>Cultivo</td>
                    <td><? echo $html->select('id_cultivo',array('options'=>$listadoC, 'selected' => $cultivo, 'default' => 'Todos', 'class' => 'inputLogin'))?></td>
                </tr>
                <tr>
                    <td>Placa</td>
                    <td><? echo $html->input('placa', $placa, array('type' => 'text', 'class' => 'inputLogin')); ?></td>
                    <td>Estatus</td>
                    <td><? echo $html->select('estatus',array('options'=>$listadoE, 'selected' => $estatus, 'default' => 'Todos', 'class' => 'inputLogin'))?></td>
                </tr>
                <tr>
                    <td width="1">Fecha Despacho Desde</td>
                    <td>
                        <? echo $html->input('fecha_desD', $fdesD, array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fdesD" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fdesD",
                                inputField : "fecha_desD",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fdesD));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td width="1">Fecha Despacho Hasta</td>
                    <td width="240">
                        <? echo $html->input('fecha_desH', $fdesH, array('type' => 'text', 'class' => 'inputLogin', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fdesH" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fdesH",
                                inputField : "fecha_desH",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fdesH));?>),
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
                    <td width="240">
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
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            echo $html->input('leyenda', 'Estatus', array('type' => 'button'));
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            echo $html->input('exportar', 'Excel', array('type' => 'submit'));
                            echo $html->input('exportar', 'Calc', array('type' => 'submit'));
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
            <? echo $html->input('campos', '6', array('type' => 'hidden')); ?>
        </form>
    </div><hr/>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%" border="0">
        <tr>
            <th colspan="5"></th>
            <th align="center" colspan="2">
                <? echo $html->input('anterior', '<', array('type' => 'button')); ?>
                <? echo $html->input('siguiente', '>', array('type' => 'button')); ?>
            </th>
        </tr>
        <tr align="center" class="titulos_tabla">
            <th width="1">Salida Nro</th>
            <!--th width="1">Cedula/Rif</th-->
            <th>Cliente</th>
            <th width="1">Orden</th>
            <th>Cultivo</th>
            <th width="60">Estatus</th>
            <th>Peso Vac&iacute;o M</th>
            <th>Peso Vac&iacute;o R</th>
            <th style="display: none;">Peso Lleno M</th>
            <th style="display: none;">Peso Lleno R</th>
            <th style="display: none;">Peso Bruto</th>
            <th style="display: none;">Tara del Veh&iacute;culo</th>
            <th style="display: none;">% Hum M</th>
            <th style="display: none;">% Hum R</th>
            <th style="display: none;">Desc Hum M</th>
            <th style="display: none;">Desc Hum R</th>
            <th style="display: none;">% Imp M</th>
            <th style="display: none;">% Imp R</th>
            <th style="display: none;">Desc Imp M</th>
            <th style="display: none;">Desc Imp R</th>
            <th style="display: none;">Peso Acon. M</th>
            <th style="display: none;">Peso Acon. R</th>
            <th style="display: none;">Peso Acon. Liq. M</th>
            <th style="display: none;">Peso Acon. Liq. R</th>
            <th width="1">Accion</th>
        </tr>
        <?
            $i=0;
            $idCA = (!empty($idCA)) ? "_$idCA" : '';
            
            $totalPesoLM = 0;
            $totalPesoLR = 0;
            $totalPesoVM = 0;
            $totalPesoVR = 0;
            $totalPesoBruto = 0;
            $totalPesoTara = 0;
            $totalH = 0;
            $totalI = 0;
            $totalHD = 0;
            $totalID = 0;
            $totalPesoAcon = 0;
            $totalPesoAconL = 0;
            
            foreach($listadoDespachos as $dataDespacho){
                $clase = $general->obtenerClaseFila($i);
                $numero = ($dataDespacho['numero'] < 10) ? '0'.$dataDespacho['numero'] : $dataDespacho['numero'];
                $numSalida = "D".$numero.$general->date_sql_screen($dataDespacho['fecha_des'], '', 'es', null);
                $totalPesoVM += $dataDespacho['peso_01v'];
                $totalPesoVR += $dataDespacho['peso_02v'];
                $totalPesoLM += $dataDespacho['peso_01l'];
                $totalPesoLR += $dataDespacho['peso_02l'];
                $pesoBruto = $dataDespacho['peso_01l'] + $dataDespacho['peso_02l'];
                $pesoTara = $dataDespacho['peso_01v'] + $dataDespacho['peso_02v'];
                $totalPesoBruto += $pesoBruto;
                $totalPesoTara += $pesoTara;
                $totalH += $dataDespacho['humedad'];
                $totalH2 += $dataDespacho['humedad2'];
                $totalHD += $dataDespacho['humedad_des'];
                $totalHD2 += $dataDespacho['humedad_des2'];
                $totalI += $dataDespacho['impureza'];
                $totalI2 += $dataDespacho['impureza2'];
                $totalID += $dataDespacho['impureza_des'];
                $totalID2 += $dataDespacho['impureza_des2'];
                $totalPesoAcon += $dataDespacho['peso_acon'];
                $totalPesoAcon2 += $dataDespacho['peso_acon2'];
                $totalPesoAconL += $dataDespacho['peso_acon_liq'];
                $totalPesoAconL2 += $dataDespacho['peso_acon_liq2'];
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$numSalida?></td>
            <!--td align="center"><?=$dataDespacho['ced_cliente']?></td-->
            <td align="center"><?=$dataDespacho['cliente_nombre']?></td>
            <td align="center"><?=$dataDespacho['numero_guia']?></td>
            <td align="center"><?="(".$dataDespacho['cultivo_codigo'].") ".$dataDespacho['cultivo_nombre']?></td>
            <td align="center">
                <?
                    switch($dataDespacho['estatus_rec']){
                        case 1:
                            echo $html->link('<img src="../images/peso1.png" width="16" height="16">').' Vac&iacute;o';
                        break;
                        case 2:
                            echo $html->link('<img src="../images/reloj.png" width="16" height="16">').' Central';
                        break;
                        case 3:
                            echo $html->link('<img src="../images/peso1.png" width="16" height="16">').' Lleno';
                        break;
                        case 4:
                            echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16">');
                        break;
                        case 5:
                            echo $html->link('<img src="../images/habilitar.png" width="16" height="16">');
                        break;
                    }
                    
                    $humedad = (!empty($dataDespacho['humedad'])) ? $dataDespacho['humedad'] : 0;
                    $humedad2 = (!empty($dataDespacho['humedad2'])) ? $dataDespacho['humedad2'] : 0;
                    $impureza = (!empty($dataDespacho['impureza'])) ? $dataDespacho['impureza'] : 0;
                    $impureza2 = (!empty($dataDespacho['impureza2'])) ? $dataDespacho['impureza2'] : 0;
                ?>
            </td>
            
            <td align="right"><?=$general->formato_numero(round($dataDespacho['peso_01v']), 2)?></td>
            <td align="right"><?=$general->formato_numero(round($dataDespacho['peso_02v']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_01l']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_02l']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($pesoBruto), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($pesoTara), 2)?></td>
            <td align="right" style="display: none"><?=$humedad?></td>
            <td align="right" style="display: none"><?=$humedad2?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['humedad_des']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['humedad_des2']), 2)?></td>
            <td align="right" style="display: none"><?=$impureza?></td>
            <td align="right" style="display: none"><?=$impureza2?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['impureza_des']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['impureza_des2']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_acon']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_acon2']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_acon_liq']), 2)?></td>
            <td align="right" style="display: none"><?=$general->formato_numero(round($dataDespacho['peso_acon_liq2']), 2)?></td>
            <td align="center">
                <img src="../images/buscar.png" width="16" height="16" title="Detalle" border="0" style="cursor:pointer" onclick="openWindow('gerente_despacho_detalle.php?id=<?php echo $dataDespacho['id'] ?>&ca=<?php echo $dataDespacho['ca_id']?>','','1200','500','visible');return false;">
            </td>
        </tr>
        <? $i++; } ?>
        <tr align="right">
            <th></th>
            <!--th></th-->
            <th></th>
            <th></th>
            <th></th>
            <th>Total:</th>
            <th><?=$general->formato_numero(round($totalPesoVM), 2)?></th>
            <th><?=$general->formato_numero(round($totalPesoVR), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoLM), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoLR), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoBruto), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoTara), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalH), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalH2), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalHD), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalHD2), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalI), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalI2), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalID), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalID2), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoAcon), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoAcon2), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoAconL), 2)?></th>
            <th style="display: none"><?=$general->formato_numero(round($totalPesoAconL2), 2)?></th>
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
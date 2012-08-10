<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $listaEstatus = array('t' => 'Activo', 'f' => 'Inactivo');
    
    $codigo = (!empty($GPC['codigo'])) ? $GPC['codigo'] : '';
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';
    $estatus = (!empty($GPC['estatus'])) ? $GPC['estatus'] : '';
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoCosechas = $cosecha->buscarCosechaP(null, null, $estatus, null, $idCA, $codigo, $nombre, $porPagina, $inicio);
    
    $total_registros = $cosecha->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if(!empty($GPC['exportar'])){
        $formato = ($GPC['exportar'] == 'Excel') ? 'xlsx' : 'ods';

        $filename_client = "Reporte_Programas_".date("d_m_Y");
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
        $activeWorksheet->setTitle("Reporte de Cosechas");

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

        $activeWorksheet->getColumnDimension('A')->setWidth(25); //Centro de Acopio
        $activeWorksheet->getColumnDimension('B')->setWidth(20); //Codigo Programa
        $activeWorksheet->getColumnDimension('C')->setWidth(40); //Nombre Programa
        $activeWorksheet->getColumnDimension('D')->setWidth(20); //Codigo Cosecha
        $activeWorksheet->getColumnDimension('E')->setWidth(30); //Nombre cosecha
        $activeWorksheet->getColumnDimension('F')->setWidth(50); //Cultivo
        $activeWorksheet->getColumnDimension('G')->setWidth(15); //Proyectado
        $activeWorksheet->getColumnDimension('H')->setWidth(15); //Area Siembra
        $activeWorksheet->getColumnDimension('I')->setWidth(15); //Fecha Inicio
        $activeWorksheet->getColumnDimension('J')->setWidth(15); //Fecha Fin
        $activeWorksheet->getColumnDimension('K')->setWidth(15); //Estatus

        //Titulo del reporte
        $activeWorksheet->setCellValue('A1', "AGROPATRIA - SIGESIL");
        $activeWorksheet->setCellValue('A2', "REPORTE - COSECHAS");
        $activeWorksheet->setCellValue('A3', "Fecha: ".date("d-m-Y"));
        $activeWorksheet->setCellValue('A4', "Hora: ".date("h:i"));

        /*indice pata inprimir los titulos de la columnas de reporte*/
        $index_title=6;
        $index_detail=0;
        /*linea de titulo del detalle*/
        $j=0;
            $titulos = array('Centro de Acopio','Codigo Programa','Nombre Programa','Codigo Cosecha','Nombre Cosecha',
                            'Cultivo','Proyectado', 'Area Siembra', 'Fecha Inicio', 'Fecha Fin', 'Estatus');
        foreach($titulos as $columnTitle){
            $activeWorksheet->setCellValueByColumnAndRow($j, $index_title, $columnTitle);
            $oColumn = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getColumn();
            $oRow = $activeWorksheet->getCellByColumnAndRow($j, $index_title)->getRow();
            $activeWorksheet->getStyle($oColumn.$oRow)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);;
            $activeWorksheet->getStyle($oColumn.$oRow)->applyFromArray($arrStyleTitle);
            $j++;
        }

        $fila = 7;
        
        $listadoCosechas = $cosecha->buscarCosechaP(null, null, $estatus, null, $idCA, $codigo, $nombre);
        if(!empty($listadoCosechas)){
            foreach($listadoCosechas as $dataCosecha){                
                $valores = array();
                $valores[] = "(".$dataCosecha['ca_codigo'].") ".$dataCosecha['ca_nombre'];
                $valores[] = $dataCosecha['co_programa'];
                $valores[] = $dataCosecha['nombre_programa'];
                $valores[] = $dataCosecha['codigo'];
                $valores[] = $dataCosecha['nombre_cosecha'];
                $valores[] = "(".$dataCosecha['co_cultivo'].") ".$dataCosecha['nombre_cultivo'];
                $valores[] = $dataCosecha['proyectado'];
                $valores[] = $dataCosecha['area_siembra'];
                $valores[] = $general->date_sql_screen($dataCosecha['fecha_inicio'], '', 'es', '-');
                $valores[] = $general->date_sql_screen($dataCosecha['fecha_fin'], '', 'es', '-');
                $estado = ($dataCosecha['estatus'] == 't') ? 'Activo' : 'Inactivo';
                $valores[] = $estado;

                $columna = 0;
                foreach($valores as $valor){
                    $activeWorksheet->setCellValueByColumnAndRow($columna, $fila, $valor);
                    $columna++;
                }
                $fila++;
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
        $resultado = $descarga->download_file(true);

        if($resultado!=1){
            header("location: $referer?msg=error");
        }
        exit;
    }
    
    require('../lib/common/header.php');
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
        REPORTE DE COSECHAS<br/><hr/>
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
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos', 'class' => 'estilo_campos'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr>
                    <td>Codigo</td>
                    <td><? echo $html->input('codigo', $codigo, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                    <td>Nombre</td>
                    <td><? echo $html->input('nombre', $nombre, array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Estatus</td>
                    <td><? echo $html->select('estatus', array('options'=>$listaEstatus, 'selected' => $estatus, 'default' => 'Todos', 'class' => 'estilo_campos')); ?></td>
                </tr>
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
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Codigo</th>
            <th>Nombre</th>
            <th>Cultivo</th>
            <th>Estatus</th>
        </tr>
        <?
            $i=0;
            foreach($listadoCosechas as $dataCosecha){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?="(".$dataCosecha['ca_codigo'].") ".$dataCosecha['ca_nombre']?></td>
            <? } ?>
            <td align="center"><?=$dataCosecha['codigo']?></td>
            <td><?=$dataCosecha['nombre_cosecha']?></td>
            <td><?="(".$dataCosecha['co_cultivo'].") ".$dataCosecha['nombre_cultivo']?></td>
            <td align="center">
                <?
                    if($dataCosecha['estatus'] == 't')
                        echo $html->link('<img src="../images/habilitar.png" width="16" height="16" title=Activo>');
                    else
                        echo $html->link('<img src="../images/deshabilitar.png" width="16" height="16" title=Inactivo>');
                ?>
            </td>
        </tr>
        <? $i++; } ?>
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
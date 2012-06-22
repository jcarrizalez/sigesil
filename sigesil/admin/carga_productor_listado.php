<?
    require_once('../lib/core.lib.php');

    $productor = new Productor();

    $idfile = $GPC['idfile'];
    $status_process = $GPC['status'];

    if ($_REQUEST['ac'] == "cancel") {
        $productor->cancelar_archivo_transferido($idfile);
        header("location: carga_productor_listado.php");
        exit;
    }

    if ($_REQUEST['ac'] == "delete") {
        $productor->delete_archivo_venta($idfile);
        header("location: carga_productor_listado.php");
        exit;
    }
    if ($_REQUEST['ac'] == "revalid") {
        /* $productor->reEvaluation($idfile);
        header("location: carga_productor_listado.php");
        exit; */
        $productor->updSales($idfile, '10'); // Se cambia a estatus de transferencia de puntos
        $var_dir = DIR_BACKGROUND . "sales_revalid.bat";
        $ppointer = popen('start ' . $var_dir, 'r');
        pclose($ppointer);
        header("location: carga_productor_listado.php");
        exit;
    }
    if ($_REQUEST['ac'] == "transfer") {
        $productor->updSales($idfile, '8'); // Se cambia a estatus de transferencia de puntos
        $var_dir = DIR_BACKGROUND . "points_back.bat";
        $ppointer = popen('start ' . $var_dir, 'r');
        pclose($ppointer);
        header("location: carga_productor_listado.php");
        exit;
    }
    if ($GPC['ac'] == "update_process_file") {
        $productor->update_status_process_sale_file($idfile, $status_process);
        echo "Save";
        exit();
    }
    if ($GPC['ac'] == "xls") {
        define('LOCAL_PEAR_DIR', APPROOT . "lib/PEAR/");
        require_once(APPROOT . "lib/PEAR/Spreadsheet/Excel/Writer.php");
        $mod = $GPC['mod'];
        set_time_limit(0);
        ini_set('memory_limit', -1);
        // Creating a workbook
        $workbook = new Spreadsheet_Excel_Writer();
        // Title format
        $fmtTitle = & $workbook->addFormat();
        $fmtTitle->setSize(12);
        $fmtTitle->setAlign('left');
        $fmtTitle->setColor('black');
        $fmtTitle->setPattern();
        $fmtTitle->setFgColor('white');
        $fmtTitle->setBold(1);
        // Title format
        $fmtTitle3 = & $workbook->addFormat();
        $fmtTitle3->setSize(11);
        $fmtTitle3->setAlign('left');
        $fmtTitle3->setColor($verde1);
        $fmtTitle3->setPattern();
        $fmtTitle3->setFgColor('white');
        $fmtTitle3->setBold(1);
        // Header format
        $fmtHeader = & $workbook->addFormat();
        $fmtHeader->setSize(10);
        $fmtHeader->setAlign('center');
        $fmtHeader->setColor('white');
        $fmtHeader->setPattern();
        $fmtHeader->setFgColor('gray');
        $fmtHeader->setBold(1);
        $fmtHeader->setTop(1);
        $fmtHeader->setBottom(1);
        $fmtHeader->setLeft(1);
        $fmtHeader->setRight(1);
        // sending HTTP headers
        $workbook->send('imported_' . $mod . '_sales_report_' . $idfile . '.xls');
        $worksheet = & $workbook->addWorksheet('Sales');
        $row = 0;
        $col = 0;
        $worksheet->writeString($row, $col, "Sales Report", $fmtTitle);
        $row++;
        $worksheet->writeString($row, $col, date("mdY h:i:s"), $fmtTitle3);
        $row++;
        $row++;
        $worksheet->writeString($row, $col, "Territory", $fmtHeader);
        $worksheet->setColumn(0, 0, 30);
        $col++;
        $worksheet->writeString($row, $col, "Seller Company Level Name", $fmtHeader);
        $worksheet->setColumn(0, 1, 30);
        $col++;
        $worksheet->writeString($row, $col, "Seller TAX ID", $fmtHeader);
        $worksheet->setColumn(0, 2, 30);
        $col++;
        $worksheet->writeString($row, $col, "Buyer Company Level Name", $fmtHeader);
        $worksheet->setColumn($row, $col, 30);
        $col++;
        $worksheet->writeString($row, $col, "Customer ID", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        $worksheet->writeString($row, $col, "Partner ID", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        $worksheet->writeString($row, $col, "Customer PO Number", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        $worksheet->writeString($row, $col, "Product Number", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        $worksheet->writeString($row, $col, "Total", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        $worksheet->writeString($row, $col, "Date", $fmtHeader);
        $worksheet->setColumn($row, $col, 20);
        $col++;
        if ($mod == 'invalids' || $mod == 'total') {
            $worksheet->writeString($row, $col, "Errors", $fmtHeader);
            $worksheet->setColumn($row, $col, 50);
            $col++;
        }
        $row++;

        $productor->get_archivo_venta($idfile);
        $productor->get_lineas_cargadas($idfile);
        switch ($mod) {
            case "invalids":
                $show = 'invalids';
                $type = array(0, 4, 6);
                break;
            case 'transfered':
                $show = 'transfered';
                $type = array(5);
                break;
            case 'notalias':
                $show = 'notalias';
                $type = array(6);
                break;
            case 'total':
                $show = 'total';
                $type = array(0, 1, 2, 3, 5, 6);
                break;
            case "valids":
            default:
                $show = 'valids';
                $type = array(1, 3, 5); //validos y uploaded
                break;
        }
        $arr_data = $productor->get_data_to_preview($idfile, $type, false);
        if (count($arr_data) > 0) {
            //Empezamos la lectura de los datos
            for ($i = 0, $cant = count($arr_data); $i < $cant; $i++) {
                $col = 0;
                $worksheet->writeString($row, $col, $arr_data[$i]['country_file']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['disti_name']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['tax_identifier']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['reseller_name']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['customerID']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['partnerID']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['bill_number']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['part_number']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['amount']);
                $col++;
                $worksheet->writeString($row, $col, $arr_data[$i]['bill_date']);
                $col++;
                if ($mod == 'invalids' || $mod == 'total') {
                    $var_error = '';
                    $arrError = array_unique(explode(",", $arr_data[$i]['errors']));
                    if ($arr_data[$i]['reseller_id'] == '0') {
                        $var_error .= $lang['err_reseller2'] . ",";
                    }
                    for ($e = 0; $e < count($arrError); $e++) {
                        if ($lang[$arrError[$e]] == 'OK' && $var_error != '') {
                            break;
                        }
                        if ($arrError[$e] != '') {
                            $var_error .= $lang[$arrError[$e]] . ",";
                        }
                    }
                    $var_error = substr($var_error, 0, strlen($var_error) - 1);
                    $worksheet->writeString($row, $col, $var_error);
                    $col++;
                    $var_error = '';
                }
                $row++;
            }
        }

        $workbook->close();
    }

    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;

    $productor->archivosProductor('', $porPagina, $inicio);

    $total_registros = $productor->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);

    require('../lib/common/header.php');
?>

<script language="javascript1.5" type="text/javascript">
    function fncatras(){
        document.location = "../pages/landing_page.php";
    }

    function newSalesFile(){
        document.location = "sales_file_upload.php";
    }

    function gotoop(opcion,idfile,pg){
        if (opcion == "previewTEMP"){
            show_div_loader();
            window.location = "sales_file_view.php?idfile="+idfile;
        }
        if(opcion == "preview"){
            show_div_loader();
            window.location = "sales_file_preview.php?idfile="+idfile;
        }
        if(opcion == "calculate"){
            show_div_loader();
            window.location = "?ac=transfer&idfile="+idfile;
            //window.location = "sales_file_transfer.php?idfile="+idfile;
        }
        if(opcion == "transfer"){
            show_div_loader();
            window.location = "sales_file_winpoints.php?idfile="+idfile+"&st=0&pg"+pg;
        }
        if(opcion == "viewErrors"){
            show_div_loader();
            window.location = "sales_file_winpoints.php?idfile="+idfile+"&st=2&pg"+pg;
        }
        if(opcion == "viewPoints"){
            show_div_loader();
            window.location = "sales_file_winpoints.php?idfile="+idfile;
        }
        if(opcion == "cancel"){
            show_div_loader();
            window.location = "?ac=cancel&idfile="+idfile;
        }
        if(opcion == "revalid"){
            show_div_loader();
            window.location = "?ac=revalid&idfile="+idfile;
        }
        if(opcion == "delete"){
            if(confirm('<? echo html_entity_decode($lang['txt_delete_file']) ?>')){
                window.location = "?ac=delete&idfile="+idfile;
            } else {
                return false;
            }
        }
    }

    function downloadExcel(){
        var countryId = $('#contry_select').val();
        var quarterId = $('#quarter_select').val();
        var year = $('#year_select').val();	
        window.location='sales_file_list_error.xlsx.php?cid=' + countryId + '&qid=' + quarterId + '&year=' + year;
    }
</script>

<p class="mainTitle"><? echo $lang['txtSales'] ?></p>
<hr class="hr">
<table width="100%" cellspacing="0" cellpadding="0" border="0" >
    <tr>
        <td width="10%" align="left"><? echo $lang['txtCountry'] ?>:</td>
        <td width="35%" align="left"><? echo $html->select('contry_select', array('options' => $countriesList, 'selected' => $GPC['country_id'], 'class' => 'countryList', 'default' => $lang['txtAll'])) ?></td>
        <td width="30%" align="left">&nbsp;</td>
        <td width="40%" align="right">&nbsp;</td>
    </tr>
    <tr>
        <td width="10%" align="left"><? echo $lang['txtQuarter'] ?>:</td>
        <td width="35%" align="left"><? echo $html->select('quarter_select', array('options' => $quarterList, 'selected' => $GPC['quarter_id'], 'class' => 'countryList', 'default' => $lang['txtAll'])) ?></td>
        <td width="30%" align="left">&nbsp;</td>
        <td width="40%" align="right">&nbsp;</td>
    </tr>
    <tr>
        <td width="10%" align="left"><? echo $lang['txtYear'] ?></td>
        <td width="35%" align="left"><? echo $html->select('year_select', array('options' => $yearList, 'selected' => $GPC['year_id'], 'class' => 'countryList', 'default' => $lang['txtAll'])) ?></td>
        <td colspan="2">
            <input type="button" name="search" id="search" onclick="search('carga_productor_listado.php');" value="<?= $lang['txtSearch']; ?>">
            <input type="button" name="search" id="search" onclick="clear_list('carga_productor_listado.php');" value="<?= $lang['txtclear']; ?>">
            <input type="button" onclick="fncatras();" value="<? echo $lang['txtBack'] ?>">
            <input type="button" value="<? echo $lang['txtAdd'] ?>" onclick="newSalesFile()">
            <input type="button" value="Download Errors" onclick="downloadExcel();">
        </td>
    </tr>
</table>
<hr class="hr">
<div align="right"></div>
<table width="100%" cellspacing="0" cellpadding="0" border="0" >
    <tr>
        <td colspan="10" style="padding-top:5px;">
            <?
                $paginador->print_page_counter($lang['txtPage'], $lang['txtOf']);
                echo "&nbsp;&nbsp;";
                $paginador->print_paginator();
            ?>
        </td>
    </tr>
    <tr>
        <td height="20px;"></td>
    </tr>
    <tr height="25px">
        <th width="20%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtFileName'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtMonth'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtYear'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtTotalRegister'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtTotalValids'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtTotalInvalids'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtTotalTransfered'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;">Status</th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;">Progress</th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtActions'] ?></th>
        <th width="10%" align="center" bgcolor="#999999" style="color:#FFFFFF;"><? echo $lang['txtDontProcess'] ?></th>
    </tr>
    <? if (count($productor->lista)){ ?>
        <?
        for ($i = 0, $cant = count($productor->lista); $i < $cant; $i++) {
            $productor->contar_validos_invalidos($productor->lista[$i]['id']);
            if ($productor->lista[$i]['status'] == 1) {
                $reg_valids = "N/A";
                $reg_invalids = "N/A";
                $reg_transfered = "N/A";
            } else {
                $reg_valids = $productor->validos;
                $reg_invalids = $productor->invalidos;
                $reg_transfered = $productor->transferido;
            }
            $reg_total = $productor->total;
            $idf = $productor->lista[$i]['id'];
            $nombre_original = str_replace("_", " ", $productor->lista[$i]['name']);
            $fyear_qrt = $productor->lista[$i]['quarter_id'];
            $arrCount = $productor->contarArchivoDetalle($productor->lista[$i]['id']);
            if ($productor->lista[$i]['status'] != '9' && $productor->lista[$i]['status'] != '8' && $productor->lista[$i]['status'] != '12') {
                if ($productor->lista[$i]['rowFile'] > 0) {
                    $varProgress = round(($arrCount[0]['contado'] * 100) / $productor->lista[$i]['rowFile'], 2);
                } else {
                    $varProgress = 0;
                }
            } else {
                $varProgress = 50;
            }
            if ($productor->lista[$i]['status'] != '1' && $productor->lista[$i]['status'] != '5' && $productor->lista[$i]['status'] != '6' && $productor->lista[$i]['status'] != '8' && $productor->lista[$i]['status'] != '9' && $productor->lista[$i]['status'] != '12') {
                $varProgress = 100;
            }
            // Verifico que el archivo de ventas tenga registros con errores en el calculo de lo puntos
            $arrErrors = $productor->erroresArchivo($productor->lista[$i]['id'], '3');
            ?>
            <tr>
                <td class="cell_center"><? echo $nombre_original ?></td>
                <td align="center" class="cell_center"><? echo $productor->lista[$i]['file_month'] ?></td>
                <td align="center" class="cell_center"><? echo $productor->lista[$i]['file_year'] ?></td>
                <td align="center" class="cell_center"><a href="?ac=xls&idfile=<? echo $idf ?>&mod=total"><? echo $reg_total ?></a></td>
                <td align="center" class="cell_center"><a href="?ac=xls&idfile=<? echo $idf ?>&mod=valids"><? echo $reg_valids ?></a></td>
                <td align="center" class="cell_center"><a href="?ac=xls&idfile=<? echo $idf ?>&mod=invalids"><? echo $reg_invalids ?></a></td>
                <td align="center" class="cell_center"><a href="?ac=xls&idfile=<? echo $idf ?>&mod=transfered"><? echo $reg_transfered ?></a></td>
                <td align="center" class="cell_center"><?= $productor->lista[$i]['statusdesc'] ?></td>
                <td align="center" class="cell_center"><?= $varProgress . " %" ?></td>
                <td align="center" class="cell_right">
                    <select name="act" id="act" onchange="gotoop(this.value,'<? echo $idf ?>','<?= $GPC['pg'] ?>')" style="width:100px;">
                        <option value=""><? echo $lang['txt_Select'] ?></option>
                        <? if (in_array($productor->lista[$i]['status'], array(2, 3))) { ?>
                        <option value="preview"><? echo $lang['txt_preview'] ?></option>
                        <? } else if ($productor->lista[$i]['status'] == 1) { ?>
                        <option value="previewTEMP"><? echo $lang['txt_preview'] ?></option>
                        <? } ?>
                        <? if (in_array($productor->lista[$i]['status'], array(1, 2, 3))) { ?>
                        <option value="revalid"><? echo $lang['txt_revalid'] ?></option>
                        <? } ?>
                        <? if (in_array($productor->lista[$i]['status'], array(2, 3))) { ?>
                        <option value="calculate"><? echo $lang['txt_calculate'] ?></option>
                        <? } ?>
                        <? if (in_array($productor->lista[$i]['status'], array(7))) { ?>
                        <option value="transfer"><? echo $lang['txt_to_transfer'] ?></option>
                        <? } ?>
                        <? if ($productor->lista[$i]['status'] == 9999) { ?>
                        <option value="cancel"><? echo $lang['txt_Cancel'] ?></option>
                        <? } ?>
                        <? if (in_array($productor->lista[$i]['status'], array(1, 2))) { ?>
                        <option value="delete"><? echo $lang['txt_delete'] ?></option>
                        <? } ?>
                        <? if (in_array($productor->lista[$i]['status'], array(3, 4))) { ?>
                        <option value="viewPoints"><? echo $lang['txt_view_points'] ?></option>
                        <? } ?>
                        <? if (count($arrErrors) > 0) { ?>
                        <option value="viewErrors"><? echo $lang['txt_errors'] ?></option>
                        <? } ?>
                    </select>
                </td>
                <td align="center" class="cell_right">
                    <?
                        ($productor->lista[$i]['dont_process'] == 1) ? $check = 'checked' : $check = null;
                        $file_id = $productor->lista[$i]['id'];
                        echo $html->input($file_id, $productor->lista[$i]['dont_process'], array('type' => 'checkbox', 'onClick' => 'changeStatus(this.id, this.value);', 'checked' => $check))
                    ?>
                    <img id="load_<?= $file_id; ?>" src="<?= DOMAIN_ROOT . 'images/load.gif' ?>" style="visibility: hidden;">
                </td>
            </tr>
                <? } ?>
            <? }else{ ?>
        <tr>
            <td colspan="10" style="padding-left:10px">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="10" style="padding-left:10px"><? echo $lang['noSalesFound']; ?></td>
        </tr>
        <tr>
            <td colspan="10" style="padding-left:10px">&nbsp;</td>
        </tr>
<? }; ?>
    <tr>
        <td height="20px;"></td>
    </tr>
    <tr>
        <td colspan="10" style="padding-top:5px;">
<?
    $paginador->print_page_counter($lang['txtPage'], $lang['txtOf']);
    echo "&nbsp;&nbsp;";
    $paginador->print_paginator();
?>
        </td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
<script type="text/javascript">
    function search(url){
        var quarter =$("#quarter_select").attr('value');
        var country =$("#contry_select").attr('value');
        var year =$("#year_select").attr('value');
        window.location=url+"?quarter_id="+quarter+"&country_id="+country+"&year_id="+year;
    }

    function clear_list(url){
        window.location=url;
    }

    function changeStatus(id, value){
        var url = "carga_productor_listado.php";
        switch(value){
            case '0':
                value_final = 1;
                break;
            case '1':
                value_final = 0;
                break;
        }
        document.getElementById(id).value = value_final;
        $("#load_"+id).css("visibility","visible");
        $.get(url+"?ac=update_process_file"+"&idfile="+id+"&status="+value_final, function(){$("#load_"+id).css("visibility","hidden");});
    }
</script>
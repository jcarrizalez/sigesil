<?php
require_once('../lib/core.lib.php');

$objlogs = new cls_logs();

$start_date = ($GPC['start_date'])? $GPC['start_date'] : date("Y-m-d",time()-86400); 
$end_date = ($GPC['end_date'])? $GPC['end_date'] : date("Y-m-d");
$fltr_compania = $GPC['fltr_compania'];
$fltr_usuario = $GPC['fltr_usuario'];
$fltr_event_id = $GPC['fltr_event_id'];

if (!empty($GPC['DownloadXLS']) ) {
	// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	
	// sending HTTP headers
	$workbook->send('USAGEREPORT -'.date("Y-m-d").'.xls');
	$worksheet =& $workbook->addWorksheet($lang['txtrActivityReport']);
	// Header format
	$fmtHeader =& $workbook->addFormat();
	$fmtHeader->setSize(10);
	$fmtHeader->setAlign('center');
	$fmtHeader->setColor('white');
	$fmtHeader->setPattern();
	$fmtHeader->setFgColor('gray');
	$fmtHeader->setBold(1);
	$fmtHeader->setTop(0);
	$fmtHeader->setBottom(0);
	$fmtHeader->setLeft(0);
	$fmtHeader->setRight(0);
	
	// Title format
	$fmtTitle =& $workbook->addFormat();
	$fmtTitle->setSize(12);
	$fmtTitle->setAlign('left');
	$fmtTitle->setColor('black');
	$fmtTitle->setPattern();
	$fmtTitle->setFgColor('white');
	$fmtTitle->setBold(1);
	
	//Celda de procentaje
	$fmt_porcien =& $workbook->addFormat();
	$fmt_porcien->setSize(10);
	$fmt_porcien->setAlign('Right');
	$fmt_porcien->setNumFormat('0.0"%"');

	//Celda % fondo naraja y texto blanco
	$fmt_xcien_ow =& $workbook->addFormat();
	$fmt_xcien_ow->setSize(10);
	$fmt_xcien_ow->setAlign('center');
	$fmt_xcien_ow->setColor('white');
	$fmt_xcien_ow->setPattern();
	$fmt_xcien_ow->setFgColor('gray');
	$fmt_xcien_ow->setBold(1);
	$fmt_xcien_ow->setTop(0);
	$fmt_xcien_ow->setBottom(0);
	$fmt_xcien_ow->setLeft(0);
	$fmt_xcien_ow->setRight(0);
	$fmt_xcien_ow->setNumFormat('0.0"%"');
	
		// Date format
	$fmtDate =& $workbook->addFormat();
	$fmtDate->setNumFormat('mmm-dd-yy');
	//$fmtDate->setLocked();
	
	$strTitle = SYSTEM_NAME.' REPORT';
	$worksheet->writeString(1,0,$strTitle,$fmtTitle);
	$worksheet->writeString(2,0,$lang['txt_activity_report'],$fmtrow);
	$worksheet->writeString(3,0,'Date: '.date("m/d/Y"),$fmtrow);
	
	//Tama?os de columnas
	for ($i=0; $i<9; $i++) { 
		$worksheet->setColumn(0,$i,20);	
	}

	// Titulos de Columnas
	$worksheet->writeString(6,0,$lang['txtUser'],$fmtHeader); 
	$worksheet->writeString(6,1,$lang['txtEmailAddress'] ,$fmtHeader); 
	$worksheet->writeString(6,2,$lang['txtCompanyName'],$fmtHeader); 
	$worksheet->writeString(6,3,'IP',$fmtHeader); 
	$worksheet->writeString(6,4,$lang['txtDate'],$fmtHeader); 
	$worksheet->writeString(6,5,$lang['txtEvents'],$fmtHeader); 	
	$worksheet->writeString(6,6,'ST',$fmtHeader);
	$worksheet->writeString(6,7,$lang['txtTables'],$fmtHeader); 		 		

	$rowcount = 7;
	$fmtcount = 0; 

	$objlogs->list_consultas($start_date, $end_date, $fltr_compania, $fltr_usuario, $fltr_event_id);
	
	for($i=0, $cant=count($objlogs->lista); $i<$cant; $i++){

		$worksheet->writeString($rowcount,0,$objlogs->lista[$i]['usuario_info'],$fmtrow);
		$worksheet->writeString($rowcount,1,$objlogs->lista[$i]['usuario_email'],$fmtrow);
		$worksheet->writeString($rowcount,2,$objlogs->lista[$i]['usuario_compania'],$fmtrow);
		$worksheet->writeString($rowcount,3,$objlogs->lista[$i]['direccion_ip'],$fmtrow);
		 if ($objlogs->lista[$i]['en_fecha']=='0000-00-00 00:00:00'){
			$worksheet->writeString($rowcount,4,"NA",$fmtrow);
		}else{
			$fecharevi = $obj_general->fechahora_sql_normal($objlogs->lista[$i]['en_fecha'],true);
			$worksheet->writeFormula($rowcount,4,"=DATE(".$fecharevi[1].",".$fecharevi[2].",".$fecharevi[3].")",$fmtDate);
		} 
		$worksheet->writeString($rowcount,5,$objlogs->lista[$i]['log_codigo_nombre_'.$language->currentLanguageShortName],$fmtrow);		
		$worksheet->writeString($rowcount,6,$objlogs->lista[$i]['log_codigo_tipo'] ,$fmtrow);
		$worksheet->writeString($rowcount,7,$objlogs->lista[$i]['en_tablas'],$fmtrow);	
		$rowcount++;				
	}

	$workbook->close();
	exit();
}


require('../lib/common/top_interno.php');
require('../lib/common/init_calendar.php');
?>
<script language="javascript">
show_div_loader(); //cargador en el header interno
	var win = null;
	function openWindow(mypage,myname,w,h,scroll){
		LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
		TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
		settings ='height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+', scrollbars=yes ';
		win = window.open(mypage,myname,settings)
	}
	
	function fncatras(){
		document.location = "../pages/landing_page.php";	
	}
		
</script>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <!--td class="pag_title"><?php echo strtoupper($lang['txtActivityReport']) ?>&nbsp;</td-->
    <p class="mainTitle"><?php echo $lang['txtActivityReport']?></p>
    <hr class="hr">
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><form id="form1" name="form1" method="get" action="">
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr>
          <td width="13%" align="right"><strong><?php echo $lang['txtDateStart'] ?></strong></td>
          <td width="29%" nowrap="nowrap"><input name="start_date" id="start_date" readonly="readonly" class="calendar2" value="<?php echo $start_date ?>" />
          <img src="../images/icons/x-office-calendar.png" id="start_date_trigger" width="16" height="16" style="cursor:pointer" />
			<script>
                Calendar.setup({
                    trigger    : "start_date_trigger",
                    inputField : "start_date",
					selection  : Calendar.dateToInt(<?php echo date("Ymd", strtotime($start_date));?>),
					onSelect   : function() { this.hide() }
                });
            </script>          </td>
          <td width="12%" align="right"><strong><?php echo $lang['txtDealer'] ?></strong></td>
          <td width="27%">
          <select name="fltr_compania" id="fltr_compania" class="select2">
            <option value=""><?php echo $lang['txt_all'] ?></option>
            <?php
			$obj_general->get_filers_colum('usuario_compania','usuario_compania','log_consultas');
			for($i=0, $cant=count($obj_general->filter); $i<$cant; $i++){
			?>
            <option value="<?php echo $obj_general->filter[$i]['valor'] ?>" <?php if($fltr_compania==$obj_general->filter[$i]['valor']){ echo 'selected'; } ?> ><?php echo $obj_general->filter[$i]['texto'] ?></option>
            <?php } ?>
          </select>
          </td>
          <td width="19%">&nbsp;</td>
        </tr>
        <tr>
          <td align="right" nowrap="nowrap"><strong><?php echo $lang['txtDateEnd'] ?></strong></td>
          <td nowrap="nowrap">
          <input name="end_date" id="end_date" readonly="readonly" class="calendar2" value="<?php echo $end_date ?>" />
          <img src="../images/icons/x-office-calendar.png" id="end_date_trigger" width="16" height="16" style="cursor:pointer" />
			<script>
                Calendar.setup({
                    trigger    : "end_date_trigger",
                    inputField : "end_date",
					selection  : Calendar.dateToInt(<?php echo date("Ymd", strtotime($end_date));?>),
					onSelect   : function() { this.hide() }
                });
            </script>          </td>
          <td align="right"><strong><?php echo $lang['txtUser'] ?></strong></td>
          <td>
          <select name="fltr_usuario" id="fltr_usuario" class="select2">
            <option value=""><?php echo $lang['txt_all'] ?></option>
            <?php
			$obj_general->get_filers_colum('usuario_info','usuario_info','log_consultas');
			for($i=0, $cant=count($obj_general->filter); $i<$cant; $i++){
			?>
            <option value="<?php echo $obj_general->filter[$i]['valor'] ?>" <?php if($fltr_usuario==$obj_general->filter[$i]['valor']){ echo 'selected'; } ?> ><?php echo $obj_general->filter[$i]['texto'] ?></option>
            <?php } ?>
          </select>          </td>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align="right"><strong><?php echo $lang['txtEvents'] ?></strong></td>
          <td>
          <select name="fltr_event_id" id="fltr_event_id" class="select2">
            <option value=""><?php echo $lang['txt_all'] ?></option>
            <?php
			$obj_general->get_filers_colum('log_codigo_id','log_codigo_nombre_'.$language->currentLanguageShortName,'log_codigos');
			for($i=0, $cant=count($obj_general->filter); $i<$cant; $i++){
			$etiqueta_texto =  $obj_general->filter[$i]['texto'] ;			
			?>
            <option value="<?php echo $obj_general->filter[$i]['valor'] ?>" <?php if($fltr_event_id==$obj_general->filter[$i]['valor']){ echo 'selected'; } ?> ><?php echo $etiqueta_texto?></option>
            <?php } ?>
          </select>                    </td>
          <td align="right" ><br /></td>
          <td colspan="2"  ><input type="submit" name="seach" id="seach" value="<?php echo $lang['txtSearch'] ?>" />
            &nbsp;
            <input type="button" name="clear" id="clear" value="<?php echo $lang['txtClear'] ?>" onclick="javascript:(window.location='report_activity.php')" />
           <!-- &nbsp;
            <input type="submit" name="DownloadXLS" value="<?php echo $lang['txtDownload']?>"  />
            -->&nbsp;
            <input type="button" name="txt_Print" value="<?php echo $lang['txtPrint']?>" onclick="window.print();" />
            </td>
          </tr>
        <tr>
          <td colspan="5" align="center">&nbsp;</td>
          </tr>
      </table>
    </form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="2" class="normal_report">
      <tr>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtUser'] ?></td>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtEmailAddress'] ?></td>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtCompanyName'] ?></td>
        <td align="center" class="table_head_gray_mm">IP</td>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtDate'] ?></td>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtEvents'] ?></td>
        <td align="center" width="1%" class="table_head_gray_mm">ST</td>
        <td align="center" class="table_head_gray_mm"><?php echo $lang['txtTables'] ?></td>
        <td  width="5%" align="center" class="table_head_gray_mm"><?php echo $lang['txtView'] ?></td>
      </tr>
      <?php
	$page_size = MAX_RESULTS_PAGE;
	$start_record = ($GPC['pg'])? (($GPC['pg'] * $page_size) - $page_size) : 0;
	
	$objlogs->list_consultas($start_date, $end_date, $fltr_compania, $fltr_usuario, $fltr_event_id, '', $start_record,$page_size);
	$total_registros = $objlogs->total_verdadero;
	$objpaginator = new paginator($total_registros,$page_size);
	  
	  for($i=0, $cant=count($objlogs->lista); $i<$cant; $i++){
		$classname = $obj_general->get_classfila($i);

	  ?>
      <tr class="<?=$classname?>" onMouseOver="this.className='highlight2'" onMouseOut="this.className='<?=$classname?>'">
        <td><?php echo $objlogs->lista[$i]['usuario_info'] ?></td>
        <td ><?php echo $objlogs->lista[$i]['usuario_email'] ?></td>
        <td align="center" ><?php echo $objlogs->lista[$i]['usuario_compania'] ?></td>
        <td ><?php echo $objlogs->lista[$i]['direccion_ip'] ?></td>
        <td ><?php echo $obj_general->fechahora_sql_normal($objlogs->lista[$i]['en_fecha'],false, $language->currentLanguageShortName ) ?></td>
        <td ><?php echo $objlogs->lista[$i]['log_codigo_nombre_'.$language->currentLanguageShortName] ?></td>
        <td ><?php echo $objlogs->lista[$i]['log_codigo_tipo'] ?></td>
        <td ><?php echo $objlogs->lista[$i]['en_tablas'] ?></td>
        <td align="center" ><img src="../images/icons/system-search.png" width="16" height="16" title="view" border="0" style="cursor:pointer" onclick="openWindow('view_log.php?id_log=<?php echo $objlogs->lista[$i]['log_id'] ?>','','700','600','visible');return false;"></td>
      </tr>
	  <?php } ?>
    </table></td>
  </tr>
  <tr>
    <td style="padding-top:5px;">
	<?php 
	$objpaginator->print_page_counter($lang['txtPage'],$lang['txtOf']);
	echo "&nbsp;&nbsp;";
	$objpaginator->print_paginator(); 
	?>
    </td>
  </tr>
  <tr>
	<td ></td>
  </tr>  
  <tr>
	<td align="center"><input type="button" onclick="fncatras();" value="<?php echo $lang['txtBack']?>"></td>
  </tr>
  <tr>
	<td >&nbsp;</td>
  </tr>    
</table>

<?php require('../lib/common/bottom_interno.php'); ?>

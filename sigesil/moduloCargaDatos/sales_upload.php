<?php
require_once('../lib/core.lib.php');
$sales= new Sales();
$validator = new validator();
$ac=$GPC['ac'];
if($ac=="upload"){
	try{
		if(!$_FILES['file']['name']){
			throw new Exception("File is Required");
		}
  	$file=$sales->upload_credit_card_file($_FILES['file'],$GPC);
  	$sales->readDataAndInsert($file['sales_archivo_id'], new FileReader($file['ext']));
  	header("location: sales_file_view.php?file=".$file['sales_archivo_id']);
    exit;
	}catch(Exception $e){
		header("location: ?error=".$e->getMessage());
		exit;
	}
}
$arrRows=$sales->getFormatReturn();
require_once('../lib/common/top.php');
?>
	<div id="main_form">
	<div class="pag_title"><?php echo $CORE_lang['txtSales_file'] ?></div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all" style="width: 81%; left: 90px;">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top"><a href="sales_files.php"><?php echo $CORE_lang['txtFile_list'] ?></a></li>
			<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-1"><?php echo $CORE_lang['txtFile_upload'] ?></a></li>
			<li class="ui-state-default ui-corner-top ui-state-disabled"><a href="#"><?php echo $CORE_lang['txtView'] ?></a></li>
			<li class="ui-state-default ui-corner-top"><a href="../reports/sales.php"><?php echo $CORE_lang['txt_download_full_sales_report'] ?></a></li>
		</ul>
		<div id="tabs-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
			<div id="div1" style="position: relative; width: 14%; height: 50px; left: 825px;">
				<?php echo $CORE_html->input('button', 'cmdatras', $CORE_lang['txtBack'], array('onclick'=>"window.location = 'sales_files.php'"))?>
			</div>
			<div>
				<form action="?ac=upload" method="post" enctype="multipart/form-data" name="form1">
				  <table width="60%" align="center" border="0" cellspacing="0" cellpadding="2">
					  <tr>
						<td align="right"></td>
						<td><strong class="errormsg"><?php if($GPC['error']){ echo  htmlentities($GPC['error']); } ?> </strong></td>
					  </tr>
					  <tr>
						<td width="20%" class="rpt_descr_field"><?php echo $CORE_lang['txtUpload_csv_file'] ?></td>
						<td><input name="file" type="file" id="file" class="input3" /><?php $validator->show("archivo_ventas", ' *'); ?></td>
						<td></td>
					  </tr>
					  <tr>
						<td class="rpt_descr_field"><?php echo $CORE_lang['txtCsv_separator'] ?></td>
						<td>
						<select name="csv_sep" id="csv_sep" class="select3">
						  <option value=","><?php echo $CORE_lang['txtComma']." ( , )" ?></option>
						  <option value=";"><?php echo $CORE_lang['txtSemicolon']." ( ; )" ?></option>
						  <option value=" "><?php echo $CORE_lang['txtTab']?></option>
						</select>
						</td>
						<td></td>
					  </tr>
					  <tr>
						<td class="rpt_descr_field"><?php echo $CORE_lang['txtFirst_row_data'] ?></td>
						<td><input name="data_linea" type="text" class="input3" id="data_linea" value="2"></td>
						<td></td>
					  </tr>
					  <tr>
						<td height="50" valign="bottom">
							<input type="submit" name="salvar" id="salvar" value="<?php echo $CORE_lang['txtSubmit'] ?>"  />
						</td>
					  </tr>
					</table>
				</form>
			</div>
			<div style="text-align:center;"><br/>
				<strong style="color:#FF0000;"><?php echo $CORE_lang['txtSales_file_waring'] ?></strong><br />
				<div style="height: 70px; position: relative">
				  <table width="60%" cellpadding="0" cellspacing="0" align="center">
				   <tr>
					<?php foreach ($arrRows as $key=>$val){ ?>
					<td align="center"  class="table_head_gray"><?php echo $key?><span class="errormsg">*</span></td>
					<?php }?>
				  </tr>
				  <tr>
					<?php
					$i="A";
					foreach ($arrRows as $key=>$val){ ?>
					<td align="center"  class="cell_center"><?php echo $i++?></td>
					<?php }?>
				  </tr>
				  </table>
				</div>
			</div>
		</div>
	</div>
	</div>
<?php
	require_once('../lib/common/bottom.php');
?>
<?php
	require_once('../lib/core.lib.php');
	$file_id=$GPC['file'];
	$sales= new Sales();
	$arrRows=$sales->getFormatReturn();
	$arrRows=array_merge(array('linea'=>array('db'=>'salesdet_linea_nro')),$arrRows);
	$arrData=$sales->getCreditCardsByFile($file_id);
	require_once('../lib/common/top.php');
?>
	<div class="pag_title"><?php echo $CORE_lang['txtFile_detail'] ?></div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all" style="width: 81%; left: 90px;">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top"><a href="sales_files.php"><?php echo $CORE_lang['txtFile_list'] ?></a></li>
			<li class="ui-state-default ui-corner-top"><a href="sales_upload.php"><?php echo $CORE_lang['txtFile_upload'] ?></a></li>
			<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-1"><?php echo $CORE_lang['txtView'] ?></a></li>
			<li class="ui-state-default ui-corner-top"><a href="../reports/sales.php"><?php echo $CORE_lang['txt_download_full_sales_report'] ?></a></li>
		</ul>
		<div id="tabs-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
			<div id="div1" style="position: relative; width: 14%; height: 50px; left: 825px;">
				<?php echo $CORE_html->input('button', 'cmdatras', $CORE_lang['txtBack'], array('onclick'=>"window.location = 'sales_files.php'"))?>
			</div>
			<div id="table" style="overflow: auto; width: 100%; height: 550px;">
				<table align="center" cellspacing="2" width="100%">
				  <tr>
					<?php foreach ($arrRows as $key=>$val){ ?>
					<td class="table_head_gray"><?php echo $key?></td>
					<?php }?>
					<td class="table_head_gray"><?php echo $CORE_lang['txtValid']; ?></td>
				  </tr>
				  <?php for($i=0,$max=count($arrData);$i<$max;$i++){
					$dataRow=$arrData[$i];
					$classname = ($i%2==0)? "firstalt2" : "secondalt2";
					?>
					<tr class="<?php echo $classname?>" onMouseOver="this.className='highlight2'" onMouseOut="this.className='<?php echo $classname?>'" style="font-size:10px;">
					<?php foreach($arrRows as $key=>$val){?>
					  <td><?php echo $CORE_html->htmlize($dataRow[$val['db']]) ?></td>
					  <?php }?>
					  <td><?php echo $dataRow['salesdet_valido']==1?"OK":"ERR" ?></td>
					</tr>
				  <?php }?>
				</table>
			</div>
		</div>
	</div>
<?php
	require_once('../lib/common/bottom.php');
?>
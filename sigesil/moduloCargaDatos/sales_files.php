<?php
	require_once('../lib/core.lib.php');
	$sales= new Sales();
	$dataList= $sales->getListFiles();
	//include("../lib/common/header_interno.php")
	switch($GPC['ac']){
		case  "active":
			$file_id = $GPC['resource_id'];
			$sales->update_credit_card_file($file_id, 1);
			header('location: sales_files.php');
		break;
		case  "delete":
			$file_id = $GPC['resource_id'];
			$sales->update_credit_card_file($file_id, 3);
			header('location: sales_files.php');
		break;
	}
	require_once('../lib/common/top.php');
?>
	<script type="text/javascript" language="javascript">
		function func_action(Op, ID){
			switch(Op){
				case 'A':
					if(confirm('<?=html_entity_decode($CORE_lang['txtchangeStatus'])?>')) window.location = "?ac=active&resource_id="+ID;
				break;
				case 'D':
					if(confirm('<?=html_entity_decode($CORE_lang['txtDeletethis'])?>')) window.location = "?ac=delete&resource_id="+ID;
				break;
			}
		}
	</script>
	<div class="pag_title"><?php echo $CORE_lang['txtSales_list'] ?></div>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<div id="tabs" class="ui-tabs ui-widget ui-widget-content ui-corner-all" style="width: 81%; left: 90px;">
		<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
			<li class="ui-state-default ui-corner-top ui-tabs-selected ui-state-active"><a href="#tabs-1"><?php echo $CORE_lang['txtFile_list'] ?></a></li>
			<li class="ui-state-default ui-corner-top"><a href="sales_upload.php"><?php echo $CORE_lang['txtFile_upload'] ?></a></li>
			<li class="ui-state-default ui-corner-top ui-state-disabled"><a href="#"><?php echo $CORE_lang['txtView'] ?></a></li>
			<li class="ui-state-default ui-corner-top"><a href="../reports/sales.php"><?php echo $CORE_lang['txt_download_full_sales_report'] ?></a></li>
		</ul>
		<div id="tabs-1" class="ui-tabs-panel ui-widget-content ui-corner-bottom">
			<div id="div1" style="position: relative; width: 14%; height: 50px; left: 825px;">
				<input name="atras" type="button" value="<?php echo $CORE_lang['txtBack'] ?>" onclick="window.location.href='../index.php'" />
				<input name="agregar" type="button" id="agregar" value="<?php echo $CORE_lang['txtadd'] ?>" onclick="window.location='sales_upload.php'" />
			</div>
			<div>
			  <table width="90%" align="center" border="0" cellspacing="0" cellpadding="2" >
				<tr  align="center" class="table_head_gray">
				  <td class="table_head_gray" align="left"><?php echo $CORE_lang['txtDate'] ?></td>
				  <td class="table_head_gray" align="left"><?php echo $CORE_lang['txtfile_name'] ?></td>
				  <td align="center" class="table_head_gray"><?php echo $CORE_lang['txtTotal'] ?></td>
				  <td  align="center" class="table_head_gray"><?php echo $CORE_lang['txtValid'] ?></td>
				  <td  align="center" class="table_head_gray"><?php echo $CORE_lang['txtInvalid'] ?></td>
				  <td  align="center" class="table_head_gray">&nbsp</td>
				  <td  align="center" class="table_head_gray"><?php echo $CORE_lang['txtStatus'] ?></td>
				</tr>
				<?php foreach ($dataList as $key=>$row){?>
				<tr>
				  <td class="cell_center"><?php echo $CORE_general->date_sql_screen($row['sales_archivo_creado'],false,$_SESSION['lng']); ?></td>
				  <td class="cell_center"><a class="linkhover green_text" title="Download" href='<?php  echo $sales->getLocationInDomain($row['sales_archivo_id'], $row['sales_archivo_fisical_name']) ?>'><?php echo $row['sales_archivo_original_name'] ?></a></td>
				  <td class="cell_center" align="center"><?php echo $row['total'] ?></td>
				  <td class="cell_center" align="center"><?php echo $row['valids'] ?></td>
				  <td class="cell_center" align="center"><?php echo $row['invalids'] ?></td>
				  <td align="center" class="cell_center"><a class="linkhover green_text" title="Download" href="sales_file_view.php?file=<?php echo $row['sales_archivo_id'] ?>"><?php echo $CORE_lang['txtView'] ?></a></td>
				  <?
				  	switch($row['sales_archivo_status']){
				  		case 1:
				  ?>
				  	<td class="cell_center" align="center"><?php echo $CORE_lang['txtactive']?></td>
				  	<?
				  		break;
				  		case 2:
				  	?>
				  		<td class="cell_center" align="center">
						  	<select id="status" name="status" onchange="func_action(this.value, <?=$row['sales_archivo_id'];?>);">
					          <option value="A"><?php echo $CORE_lang['txtActivate']?></option>
					          <option value="I" <?=($row['sales_archivo_status'] == 2)?'selected':'';?>><?php echo $CORE_lang['txtinactive']?></option>
					          <option value="D"><?php echo $CORE_lang['txtDelete']?></option>
					        </select>
				        </td>
			        <?
			        	break;
			        	case 3:
			        ?>
			        	<td class="cell_center" align="center"><?php echo $CORE_lang['txtDeleted']?></td>
			        <?
			        	break;
			        	}
		            ?>
				</tr>
				<?php }?>
			  </table>
			</div><br/><br/><br/>
		</div>
	</div>
<?
	require_once('../lib/common/bottom.php');
?>
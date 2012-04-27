<?php
require_once('../lib/core.lib.php');
$objparams = new Parameter();
$objparams->listParameters();
if ($GPC['ac']=="btnPais"){
// Creating a workbook
	$workbook = new Spreadsheet_Excel_Writer();
	
	// sending HTTP headers
	$workbook->send($lang['txtsystem_options'].'-'.date("Y-m-d").'.xls');
	$worksheet =& $workbook->addWorksheet('Prizes List');
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
	
	$strTitle = $lang['txtsystem_options'];
	$worksheet->writeString(1,0,$strTitle,$fmtTitle);
	$worksheet->writeString(2,0,$lang['txtsystem_options'] .' Report',$fmtrow);
	$worksheet->writeString(3,0,'Date: '.date("m/d/Y"),$fmtrow);
	
	//Tama�os de columnas
	for ($i=0; $i<18; $i++) { 
		$worksheet->setColumn(0,$i,30);	
	}

	// Titulos de Columnas
	$worksheet->writeString(6,0, $lang['txtDescription'],$fmtHeader);
	$worksheet->writeString(6,1,$lang['txtvalue'],$fmtHeader);
		
	$rowcount = 7;
	$fmtcount = 0; 
	
	
        
     
	  for($i=0, $cant=count($objparams->lista); $i<$cant; $i++){
	
	if($objparams->lista[$i]['id']==2 and $objparams->lista[$i]['parameter_value']==0) {
		$value_id = $lang['txtactive'];
	} elseif ($objparams->lista[$i]['id']==2 and $objparams->lista[$i]['parameter_value']==1) {
		$value_id = $lang['txtin_maintenance'];
	} else {
		$value_id = $objparams->lista[$i]['parameter_value'];
	}
	     	$worksheet->writeString($rowcount,0,$objparams->lista[$i]['description'],$fmtrow);
			
			$worksheet->writeString($rowcount,1, $value_id ,$fmtrow);
			
			$rowcount++;
							
	}

			
	$workbook->close();
	exit();
}
require('../lib/common/top_interno.php');
?>
<script language="javascript">
anterior = 0;
function edit_maintenance(ids,indice){
		var ids = ids;
		var op = "edit";
		$.get("parametros_asin.php", {  ids : ids , op : op  },
		 function(data){
   			$('#opc_'+indice).html(data);
 		  });
		if(anterior!=indice){
			$('#opc_'+anterior).html(' ');
			anterior = indice;
		}
}
 function guardar(ids){
		var v_valor = $("#valor").val();
		var vids = ids;
		if(v_valor!='')
		{
		    var vac = "edit";
		    $.get("parametros_asin.php", {  av_valor:v_valor , ids : vids , ac : vac  },
 		    function(data){
   			   window.location.reload();
 		    });
		}
		else
		{
		   
            $("#error2").html('<?php echo $lang['txtRequired'] ?>')
			$("#valor").attr('class','inputText error')
            //$("#Company\\[url_alias\\]").attr('class','input error');
            
		}
}
function cerrar(){
   		window.location.reload();
}
</script>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td class="pag_title"><?php echo $lang['txtsystem_options'] ?>&nbsp;</td>
  </tr>
  <tr>
  <td>&nbsp;</td>
  </tr>
  <tr>
    <td align="right">
    <input name="atras" type="button" value="<?php echo $lang['txtBack'] ?>" onclick="window.location.href='../pages/index.php'" />
    <!--<input type="submit" name="btnPais" value="<?php //echo $lang['txtdownload']?>" " onClick="window.location='master_parametros.php?ac=btnPais'" /></td>-->
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="2">
      <tr>
        <td width="50%" class="table_head_gray"><?php echo $lang['txtDescription'] ?></td>
        <td width="40%" class="table_head_gray"><?php echo $lang['txtValue'] ?></td>
        <td width="5%" align="center" class="table_head_gray"><?php echo $lang['txtEdit'] ?></td>
      </tr>
      <?php
	  for($i=0, $cant=count($objparams->lista); $i<$cant; $i++){
	
	if($objparams->lista[$i]['id']==2 and $objparams->lista[$i]['parameter_value']==0) {
		$value_id = $lang['txtactive'];
	} elseif ($objparams->lista[$i]['id']==2 and $objparams->lista[$i]['parameter_value']==1) {
		$value_id = $lang['txtin_maintenance'];
	} else if($objparams->lista[$i]['id']==17 and $objparams->lista[$i]['parameter_value']==1) {
		$value_id = $lang['txtactive'];
	} elseif ($objparams->lista[$i]['id']==17 and $objparams->lista[$i]['parameter_value']==0) {
		$value_id = $lang['txtinactive'];
	} else {
		$value_id = $objparams->lista[$i]['parameter_value'];
	}
	$classname = $obj_general->get_classfila($i);
	  ?>
      <tr>
        <td class="<?=$classname?>"><?php echo ucfirst($objparams->lista[$i]['description']) ?></td>
        <td class="<?=$classname?>"><?php echo $value_id ?> <div id="opc_<?=$i ?>"></div></td>
        <td align="center" class="<?=$classname?>"><a href="#" onclick="javascript:edit_maintenance('<?=$objparams->lista[$i]['id']?>','<?=$i ?>');"><img src="../images/icons/accessories-text-editor.png" width="16" height="16"></a></td>
      </tr>
     
       
	  <?php } ?>
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>

<? require('../lib/common/bottom_interno.php'); ?>
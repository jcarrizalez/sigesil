<?
require("../lib/core.lib.php");
$objparams = new Parameter();
$op=$GPC['op'];
$ac=$GPC['ac'];
$ids=$GPC['ids']; 

if($ac=="edit"){
	$objparams->update($ids, $GPC['av_valor']);
}
 
if($op=="edit"){
	$objparams->findFirst($ids);

	if($ids==2){ 
	?>
    <select name="valor" id="valor" style="width:50%">
        <option value="0" <? if($objparams->data['parameter_value']=="0"){ echo "selected"; } ?> ><?=$lang['txtactive']?></option>
        <option value="1" <? if($objparams->data['parameter_value']=="1"){ echo "selected"; } ?> ><?=$lang['txtin_maintenance']?></option>
       			
    </select>            
  <? } elseif($ids==17){ ?>
  <select name="valor" id="valor" style="width:50%">
        <option value="1" <? if($objparams->data['parameter_value']=="1"){ echo "selected"; } ?> ><?=$lang['txtactive']?></option>
        <option value="0" <? if($objparams->data['parameter_value']=="0"){ echo "selected"; } ?> ><?=$lang['txtinactive']?></option>
   </select>    
	<? } elseif($ids==11){ ?>
  <select name="valor" id="valor" style="width:50%">
        <option value="active" <? if($objparams->data['parameter_value']=="active"){ echo "selected"; } ?> ><?=$lang['txtactive']?></option>
        <option value="inactive" <? if($objparams->data['parameter_value']=="inactive"){ echo "selected"; } ?> ><?=$lang['txtinactive']?></option>
        <option value="redirect" <? if($objparams->data['parameter_value']=="redirect"){ echo "selected"; } ?> ><?=$lang['txtredirect']?></option>
   </select>    
	<? } else { ?>
 <input name="valor" id="valor" type="text"  value="<?=$objparams->data['parameter_value']?>" style="width:50%">
	<?php } ?>
 <input type="button" name="Submit" value="<?=$lang['txtsave']?>"  onclick="javascript:guardar('<?=$GPC['ids'] ?>');"/>
 <input type="button" name="Submit" value="<?=$lang['txtclose']?>"  onclick="javascript:cerrar();"/>

<?
}
?>
<span id="error2" class="error"></span>

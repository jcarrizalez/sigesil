<?
    require_once('../lib/core.lib.php');

    $error_code=$GPC['code'];

    $obj_dbtools = new cls_dbtools;
    $obj_dbtools->get_SQL_error($error_code);
    $arr_tree = unserialize($obj_dbtools->SQL_error['apperror_text']);

    require('../lib/common/header_externo.php');
?>
<style type="text/css">
.error_detail{
	height:200px;
	overflow:auto;
	clear:both;
	display:none;
	text-align:left;
}

.err_child{
	 margin-left:30px;
	 border: solid 1px #666;
}
</style>
<table width="100%" cellspacing="0" cellpadding="0" border="0">
      <tr>
        <td width="135" valign="top">
            <div id="leftTitle">
                 <?  echo $contentInfo[0]["title_".$lan] ?>
            <!--img width="135" height="51" src="../images/titleA_nu_en.jpg"-->
            </div>
        </td>
        <td width="852" valign="top">
        <table width="830" cellspacing="0" cellpadding="0" border="0">
          <tbody><tr>
            <td width="40"><img width="40" height="34" src="../images/box_c_01.jpg"></td>
            <td width="764" class="bg_box1">&nbsp;</td>
            <td width="26"><img width="27" height="34" src="../images/box_c_02.jpg"></td>
          </tr>
          <tr>
            <td class="bg_box2">&nbsp;</td>
            <td height="350px">
            <!--  content -->
            <div id="contentBox">
              
                    <p>
                    <p align="center" style="font-size:13px">
					<?php echo $lang['txtAppError'] ?>
                    <? 
                    if($_SESSION['s_pgen'] || (defined(DEBUG) && DEBUG!=0)){
                        echo "<br /><br /><a href=\"#\" onClick=\"document.getElementById('error_detail').style.display='block';\"  >show error</a>"	;
                    }
                    ?>
                    </p>
                    <div class="error_detail" id="error_detail">
                        <div >
                        <? 
                        if($_SESSION['s_pgen'] || (defined(DEBUG) && DEBUG!=0)){
                            $cant_div_chid=0;
                            for($i=0,$max=count($arr_tree);$i<$max;$i++){
                            ?>
                            <div class="err_child">
                            <?
                                echo "File: ".$arr_tree[$i]['file']." <strong>in line ".$arr_tree[$i]['line']."</strong><br />"; 
                                echo "Class: ".$arr_tree[$i]['class']."<br />";
                                echo "Function:". $arr_tree[$i]['function'];
                            }
                            for($i=0,$max=count($arr_tree);$i<$max;$i++){ 
                            ?>
                            </div>	
                            <? 
                            }
                            echo "<strong>Query:</strong><br>". $arr_tree[0]['query']."<br />";
                            echo "<strong>Error #: </strong>". $arr_tree[0]['mysql_errno']."<br />";
                            echo "<strong>Error description: </strong>". $arr_tree[0]['mysql_error']."<br />";
                        }
                        ?>
                        </div>
                    </div>
                    </p>
              
             </div>
             <!-- content -->   
            </td>
            <td class="bg_box3">&nbsp;</td>
          </tr>
          <tr>
            <td valign="top"><img width="40" height="12" src="../images/box_c_03.jpg"></td>
            <td class="bg_box4">&nbsp;</td>
            <td valign="top"><img width="27" height="12" src="../images/box_c_04.jpg"></td>
          </tr>
        </tbody></table>
        </td>
      </tr>
    </tbody>
</table>

<? require('../lib/common/footer.php'); ?>
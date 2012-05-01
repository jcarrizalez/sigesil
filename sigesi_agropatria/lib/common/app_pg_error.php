<?
require_once(APPROOT.'lib/core.lib.php');

?>
<style type="text/css">
.message_error_SQL_body{
	position:absolute; 
	z-index:10000; 
	vertical-align:middle; 
	width:100%;
	height:100%;
}

.message_error_SQL{
	position:absolute;
	z-index:10000;
	background: transparent ;
	background: rgba(0,0,0,0.5);
	filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=1, StartColorStr='#88000000', EndColorStr='#88000000'); 
	width:50%;
	left:25%;
	top:25%;
	color: #5F5F7C;
	font-family:Arial, Helvetica, sans-serif;
	font-size:12px;
	
}

.message_error_SQL .title_error{
	color:#5F5F7C;
	font-weight:bold;
	background-color:#DFDFDF;
}

.message_error_SQL .message_error{
	background-color:#FFF;
	text-align:center;
}

.message_error_SQL .message_error .error_code{
	float:right;
	width:170px;
	margin-right:2px;
	border:solid 1px #F00;
	border-top:none;
	border-right:none;
	color:#F00;
	font-stretch:expanded;
	font-weight:bold;
	white-space:nowrap;
}
.message_error_SQL .message_error .error_detail{
	height:200px;
	overflow:auto;
	clear:both;
	display:none;
	text-align:left;
	
}

.message_error_SQL .message_error .error_detail .err_child{
	 margin-left:30px;
	 border: solid 1px #666;
}
.message_error_SQL .message_error .error_footer{
	margin:5px;
}

</style>
<script language="javascript">
	function APP_error_goback(){
		parent.window.location.href = '<?php echo DOMAIN_ROOT."pages/home.php" ?>'; 
	}
</script>
<div class="message_error_SQL_body">
<div class="message_error_SQL">
	<div style="margin:7px; background-color:#FFF">
	<div class="title_error"><strong>&nbsp;&nbsp;<?php echo SYSTEM_NAME ?></strong></div>
    <div class="message_error">
    	<div class="error_code">Code: <?php echo $id_error ?></div>
        <br /><br />
        <?php echo "AppError"//$lang['txtAppError'] ?>
        <br /><br />
        <? 
    	if($_SESSION['s_pgen'] || (defined(DEBUG) && DEBUG!=0) ){
			echo "<br /><a href=\"#\" onClick=\"document.getElementById('error_detail').style.display='block';\"  >show error</a>"	;
		}
		?>
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
    </div>
    <div class="error_footer"><!--<a href="javascript:APP_error_goback()">Back to home</a>-->&nbsp;</div>
	</div>
  </div>
</div>
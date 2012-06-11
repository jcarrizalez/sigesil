<?php
    require("../lib/core.lib.php"); 

    $objdbtools = new cls_dbtools();
    
    if(!empty($_SESSION['s_id'])){
        $query="UPDATE si_usuarios SET conectado= 0 , sesion = NULL 
                WHERE id='".$_SESSION['s_id']."' AND sesion = '".session_id()."' ";
    }else{
        $query="UPDATE si_usuarios SET conectado= 0 , sesion = NULL 
                WHERE sesion = '".session_id()."' ";
    }
    
    $result=$objdbtools->_SQL_tool('UPDATE', __METHOD__, $query);
    
    if($result){
	$objlogs = new cls_logs();
	$objlogs->set_log_consulta($query,102);
    }
    session_unset();
    session_destroy();

    header("location: ".DOMAIN_ROOT."pages/");
    exit; 
?>
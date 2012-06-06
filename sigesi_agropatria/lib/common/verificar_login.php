<?php

    if (!is_object($objuser)){
        $objuser = new Usuario();
    }
    
    if ($objuser->noLogeado()){
        header("location: " . DOMAIN_ROOT . "pages/index.php?msg=auth_requerida");
        exit;
    }
    
    $fechaCon = $_SESSION['s_fecha_contrasena'];
    $contrasenaExp = strtotime($fechaCon)+(24*60*60*30)."<br/>";
    $fechaActual = strtotime('now');
    //Otra forma de sumar o restar dias, semanas, meses o años
    //$contrasenaExp = strtotime("$fechaCon + 30 days");
    if ($fechaActual > $contrasenaExp){
        header("location: " . DOMAIN_ROOT . "admin/cambiar_contrasena.php");
        die();
    }
    
    /*if (MANTEINANCE && !$_SESSION['s_pgen']) {
        header("location: " . DOMAIN_ROOT . "site_maintenance.php");
        exit;
    }
    
    $objuser->get_user_by_fields(array("user_status_id" => 1, "email" => $_SESSION['s_email']));
    if (empty($objuser->usrsdata[0]['question']) && $_SERVER['PHP_SELF'] != '/pages/user_info.php') {
        $_SESSION['update_my_information'] = 1;
        header("location: " . DOMAIN_ROOT . "pages/user_info.php");
        exit;
    }*/

?>
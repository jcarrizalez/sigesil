<?php

    if (!is_object($objuser)) {
        $objuser = new Usuario();
    }
    
    if ($objuser->noLogeado()) {
        header("location: " . DOMAIN_ROOT . "pages/index.php?msg=auth_requerida");
        exit;
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
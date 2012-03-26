<?
    require("../lib/core.lib.php"); 
    
    $var_puerta = $GPC ['txt_puerta'];

    switch ($var_puerta) {
        case 1:  
            if ($_SESSION['captcha_val'] == strtoupper($GPC['tmptxt'])) {
            echo "1";

        } else {
            echo "<span class='error'>Incorrecto</span>";
        }
        break;
    }
?>
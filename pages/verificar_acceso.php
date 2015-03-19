<?php
    require('../lib/core.lib.php');
    if($GPC['ac']=="access"){
	if (!empty($_SESSION['captcha_val']) && !empty($GPC['tmptxt'])){
            if ($_SESSION['captcha_val'] == strtoupper($GPC['tmptxt'])){
                // El texto ingresado es valido, aquí pondremos el código de mandar mensaje...
                $usuarios = new Usuario();
                $login = strtoupper($GPC['usuario']);
                $pass = strtoupper(sha1($GPC['pass']));

                $acction = $usuarios->do_login($login,$pass);
                switch($acction){
                    case 'success':
                        header("location: principal.php");
                        exit();
                    break;
                    default:
                        $msg = ($acction)? '?msg='.$acction : '';
                        header("location: index.php".$msg);
                        exit();
                }
            }else{
                // El texto ingresado es invalido, informamos el error al usuario...
                header("location: index.php?msg=captcha_invalido");
                exit();
            }
	}else{
            // No introdujo el captcha, informamos el error al usuario...
            header("location: index.php?msg=captcha_vacio");
            exit();
        }
    }else{
        header("location: index.php");
        exit();
    }
?>
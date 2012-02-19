<?
    require('../lib/core.lib.php');
    require('../lib/common/recaptchalib.php');
    
    if($GPC['ac']=="access"){
        $privatekey = LLAVE_PRIVADA;
	if ($_POST["recaptcha_response_field"]){
            $resp = recaptcha_check_answer ($privatekey,
            $_SERVER["REMOTE_ADDR"],
            $_POST["recaptcha_challenge_field"],
            $_POST["recaptcha_response_field"]);

            if ($resp->is_valid){
                // El texto ingresado es valido, aquí pondremos el código de mandar mensaje...
                $usuarios = new Usuario();
                $login = $GPC['usuario'];
                $pass = $GPC['pass'];

                $acction = $usuarios->do_login($login,sha1($pass));
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
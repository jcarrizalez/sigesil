<?
    require('../lib/core.lib.php');

    if($GPC['ac']=="access"){
        $usuarios = New User();

        $login = $GPC['usuario'];
        $pass = $GPC['pass'];

        //$usuarios = new User;

        $acction = $usuarios->do_login($login,sha1($pass));
        switch($acction){
                case 'success':	header("location: principal.php");
                    exit();
                default:
                    $msg = ($acction)? '?msg='.$acction : '';
                    header("location: index.php".$msg);
                    exit();
        }
    }else{
        header("location: ../login.php");
        exit();
    }
?>
<?
if(file_exists(APPROOT.'lib/core.lib.php'))
    require_once(APPROOT.'lib/core.lib.php');
else 
    require_once('../lib/core.lib.php');
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title><?=SYSTEM_NAME?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link href="<?=DOMAIN_ROOT?>images/favicon.ico" rel="shortcut icon" />
        <link href="<?=DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
        <link href="<?=DOMAIN_ROOT?>css/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css" />
        <?
            $javascript->includeFile('jquery/jquery-1.7.1.min.js');
            $javascript->includeFile('jquery/jquery-ui-1.8.17.custom.min.js');
            $javascript->includeFile('jquery/jquery.validate.js');
            $javascript->includeFile('jquery/jquery.numeric.js');
            $javascript->includeFile('general.js');
        ?>
        <script type="text/javascript">
            $(function(){
                $("#accordion").accordion({ header: "h3", active: false });
                $(this).bind("contextmenu", function(e) {
                    e.preventDefault();
                });
            });
            
            $("#accordion h3 a").click(function() {
                window.location = $(this).attr('href');
                return false;
            });
        </script>
    </head>
    <body>
        <div id="cabecera"></div>
        <div id="cabecera2"></div>
        <div id="global">
            <div id="global_sep"></div>
            <div id="menu">
                <div id="boton_inicio">
                    <a href="<?=DOMAIN_ROOT?>pages/principal.php"><img alt="Inicio" title="Inicio" src="../images/inicio.png" /></a>
                    <a href="<?=DOMAIN_ROOT?>pages/cerrar_sesion.php"><img alt="Salir" title="Salir" src="../images/salir.png" /></a>
                </div>
                <?php require(APPROOT.'/lib/common/menu.php'); ?>
                <br/><a href="http://www.agropatria.co.ve" target="_blank"><img alt="Agropatria" title="Agropatria" src="../images/logo_agropatria.png" width="100%" height="40"/></a>
            </div>
            <div id="contenido">
                <div id="modulo">
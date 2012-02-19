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
        <link href="<?=DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
        <link href="<?=DOMAIN_ROOT?>css/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css" />
        <?
            $javascript->includeFile('jquery/jquery-1.7.1.min.js');
            $javascript->includeFile('jquery/jquery-ui-1.8.17.custom.min.js');
            $javascript->includeFile('general.js');
        ?>
        <script type="text/javascript">
            $(function(){
                $("#accordion").accordion({ header: "h3", active: false });
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
            <div id="contenido_externo">
                <div id="modulo_externo">
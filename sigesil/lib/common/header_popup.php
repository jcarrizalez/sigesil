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
        <!--script type="text/javascript" src="https://www.google.com/jsapi"></script>
        <script type="text/javascript">
            // Load jQuery
            google.load("jquery", "1.7.1");
            google.load("jqueryui", "1");
        </script>
        <script type="text/javascript">if(typeof jQuery==='undefined'){document.write(unescape("<scri"+"pt src='../js/jquery/jquery-1.7.1.min.js' type='text/javascript'></scri"+"pt>"));}</script>
        <script type="text/javascript">if(typeof jQuery.ui==='undefined'){document.write(unescape("<scri"+"pt src='../js/jquery/jquery-ui-1.8.17.custom.min.js' type='text/javascript'></scri"+"pt>"));}</script-->
        <?
            $javascript->includeFile('jquery/jquery-1.7.1.min.js');
            $javascript->includeFile('jquery/jquery-ui-1.8.17.custom.min.js');
            $javascript->includeFile('jquery/jquery.validate.js');
            $javascript->includeFile('jquery/jquery.numeric.js');
            $javascript->includeFile('general.js');
        ?>
    </head>
    <body>
        <div id="modulo">
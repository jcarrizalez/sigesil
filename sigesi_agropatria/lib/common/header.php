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
        <script type="text/javascript">
            $(function(){
                $("#accordion").accordion({ header: "h3", active: false });
                
                /*$(this).bind("contextmenu", function(e) {
                    e.preventDefault();
                });*/
            });
            
            $("#accordion h3 a").click(function() {
                window.location = $(this).attr('href');
                return false;
            });
        </script>
    </head>
    <body>
        <div id="div_loader" align="center" class="pageloader"></div>
        <div align="center" id="div_loader_img" style="display:none;z-index:500;position:absolute;top:40%;left:33%;">
            <img src="<?php echo DOMAIN_ROOT ?>images/ajax-loader.gif" style="padding-top: 70px;"/><br /><br />
            <?php echo 'PROCESANDO POR FAVOR ESPERE' ?>
        </div>
        <script type="text/javascript">
            var divs_transparentDiv = document.getElementById('div_loader');
            divs_transparentDiv.style.display='none';
            var divs_transparentDivImg = document.getElementById('div_loader_img');
            
            function __getBrowserSize(){
                var bodyWidth = document.documentElement.clientWidth;
                var bodyHeight = document.documentElement.clientHeight;
                var bodyWidth, bodyHeight; 
                if (self.innerHeight){ // all except Explorer 
                    bodyWidth = window.innerWidth; //self.innerWidth; 
                    bodyHeight = window.innerHeight; //self.innerHeight; 
                }  else if (document.documentElement && document.documentElement.clientHeight) {
                    // Explorer 6 Strict Mode 		 
                    bodyWidth = document.documentElement.clientWidth; 
                    bodyHeight = document.documentElement.clientHeight; 
                } else if (document.body) {// other Explorers 		 
                    bodyWidth = document.body.clientWidth; 
                    bodyHeight = document.body.clientHeight; 
                } 
                return [bodyWidth,bodyHeight];		
            }

            function __repositionTransparentDiv(){
                //divs_transparentDiv.style.top = Math.max(document.body.scrollTop,document.documentElement.scrollTop) + 'px';
                divs_transparentDiv.style.top = '0px';
                divs_transparentDiv.style.left = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft) + 'px';
                var brSize = __getBrowserSize();
                var bodyWidth = brSize[0];
                var bodyHeight = brSize[1];
                var padtop = (bodyHeight/2);
                //divs_transparentDiv.style.width = bodyWidth + 'px';
                divs_transparentDiv.style.paddingTop = padtop + 'px';
                divs_transparentDiv.style.height = '2000px'; //bodyHeight + 'px';
            }
            
            function show_div_loader(){
                //divs_transparentDiv.filters.alpha.opacity=90;
                divs_transparentDiv.style.display='';
                divs_transparentDivImg.style.display='';
                // Preserve scroll position
                var st = Math.max(document.body.scrollTop,document.documentElement.scrollTop);
                var sl = Math.max(document.body.scrollLeft,document.documentElement.scrollLeft);
                window.scrollTo(sl,st);
                setTimeout('window.scrollTo(' + sl + ',' + st + ');',10);
                __repositionTransparentDiv();
            }

            function hide_div_loader(){
                divs_transparentDiv.style.display='none';
                divs_transparentDivImg.style.display='none';
            }
        </script>
        <div id="main">
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
                    <div id="logo_menu"><!--a href="http://www.agropatria.co.ve" target="_blank"--><img alt="Agropatria" title="Agropatria" src="../images/logo_agropatria.png"/><!--/a--></div>
                </div>
                <div id="contenido">
                    <div id="modulo">
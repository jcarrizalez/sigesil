<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>SIGESI</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <? use_stylesheet('frontend.css') ?>
        <? use_stylesheet('jquery-ui-1.8.17.custom.css') ?>
        <? use_javascript('jquery/jquery-1.7.1.min.js') ?>
        <? use_javascript('jquery/jquery-ui-1.8.17.custom.min.js') ?>
        <? use_javascript('general.js') ?>
        <?php include_stylesheets() ?>
        <?php include_javascripts() ?>
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
        <div id="global">
            <div id="global_sep"></div>
            <div id="menu">
                <div id="boton_inicio">
                    <a href="principal"><img alt="Inicio" title="Inicio" src="../images/inicio.png" /></a>
                    <a href="salir"><img alt="Salir" title="Salir" src="../images/salir.png" /></a>
                </div>
                <? require_once 'menu.php'; ?>
            </div>
            <div id="contenido">
                <div id="modulo">
                    <?php echo $sf_content ?>
                </div>
            </div>
        </div>
        <div id="pie_pagina">
            <div id="izq_pie_pagina"></div>
            <div id="pie_pagina_central"><br/>
                <span>
                    SIGESI<br/>
                    &copy; 2012 Todos los Derechos Reservados.<br/>
                    Desarrollado por Agropatria.
                </span>
            </div>
            <div id="der_pie_pagina"></div>
        </div>
    </body>
</html>

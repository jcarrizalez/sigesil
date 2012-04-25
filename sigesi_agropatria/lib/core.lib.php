<?php
    error_reporting(E_ALL & ~E_NOTICE);
    
    //CONFIGURACION DE LA ZONA HORARIA PARA VENEZUELA
    setlocale(LC_TIME, 'es_VE', 'es_VE.utf-8', 'es_VE.utf8'); # Asi es mucho mas seguro que funciones, ya que no todos los sistemas llaman igual al locale ;)
    date_default_timezone_set('America/Caracas');
    
    //PREVENT ATTACK FROM OTHER SITES
    if (preg_match( "/core.lib.php/", $_SERVER ["PHP_SELF"] ) || preg_match( "/core.lib.php/", $HTTP_SERVER_VARS ["PHP_SELF"] ))
        die("Access denied!");
    $ini_request=microtime(true);
    //config var goes in the same place than core.lib
    require_once("config_var.php");
    $conn_string = "host=".SERVER." port=5432 password=".PASS." user=".USER." dbname=".DB;
    //$conn_string = "host=localhost port=5432 password=123456 user=admin dbname=sigesi";
    $link = pg_connect($conn_string);
    if (pg_ErrorMessage($link)) { echo "<p><b>Ocurrio un error conectando a la base de datos: .</b></p>"; exit; }
    //$link=mysql_connect(SERVER,USER,PASS) or die("Could not connect to Database server");
    //mysql_select_db(DB,$link) or die( "Could not open database");

    require_once(APPROOT."lib/class/logs.class.php");
    require_once(APPROOT."lib/class/dbtools.class.php");
    require_once(APPROOT."lib/class/debug.class.php");
    require_once(APPROOT."lib/rewrite_globals.php"); //REWRITE GLOBALSS
    require_once(APPROOT."lib/class/general.class.php");
    require_once(APPROOT."lib/class/parameter.class.php");
    require_once(APPROOT."lib/class/html.class.php");
    require_once(APPROOT."lib/class/javascript.class.php");
    require_once(APPROOT."lib/class/externals/cake/inflector.php");
    
    require(APPROOT."lib/class/autoloader.class.php");
    Autoloader::Register();
    
    ini_set("session.cookie_lifetime", 10800);
    ini_set("session.gc_maxlifetime", 10800);
    define('GERENTEG',1);
    define('GERENTES',2);
    define('ADMING',3);
    define('ADMINS',4);
    define('CALIDADG',5);
    define('CALIDADS',6);
    define('ROMANERO',7);
    define('RECEPCION',8);
    define('DESPACHO',9);
    
    session_start();

    // Global Objects
    $general = new General;
    $parametros = new Parameter();
    $javascript = new Javascript();
    $lenguaje = new Lenguaje();
    $html = new Html();
    $menu = new Menu();
    
    $etiqueta = $lenguaje->etiquetasPorPagina($_SERVER['PHP_SELF']);
    
    if(!empty($_SESSION['s_id'])){
        $infoPagina = substr($_SERVER["SCRIPT_NAME"], strrpos($_SERVER["SCRIPT_NAME"], "/") + 1);
        $acciones = $menu->accionesPagina($_SESSION['s_id'], $infoPagina);
    }

    if (file_exists(APPROOT.'lib/common/verificar_login.php')){
        $usuario = new Usuario();
	$requerido = $usuario->paginasRequeridas($_SERVER['SCRIPT_NAME']);
	if ($requerido[0]['pagina_requerida'] > 0){
            require_once(APPROOT.'lib/common/verificar_login.php');
        }
    }
    //habilitamos el error handler
    if ((DEBUG) and (Debug::$config['Handler'])){
    /* replace PHP's errorhandler */
        $errorhandler = array (
        Debug,
            'errorHandlerCallback'
        );
        set_error_handler($errorhandler);
    }
?>
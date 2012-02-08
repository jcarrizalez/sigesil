<?php
//Evitamos ataques de scripts de otros sitios
if (preg_match( "/config_var.php/", $_SERVER ["PHP_SELF"] ) || preg_match( "/config_var.php/", $HTTP_SERVER_VARS ["PHP_SELF"] ))
	die ( "Access denied!" );
	
//Directorios
define ( "APPROOT", $_SERVER ['DOCUMENT_ROOT'] . "/sigesi_agropatria/" );
// Ej: se usa para los includes
define ( "DOMAIN_ROOT", "http://" . $_SERVER ['SERVER_NAME'] . "/sigesi_agropatria/" );
// Ej: se usa para las im�genes, link, etc.


// Constantes de Base de datos
define ( "USER", "admin" );
define ( "PASS", "123456" );
define ( "SERVER", "localhost" );
define ( "DB", "sigesi" );

define ( "DEBUG", "1" );

define('GERENTE',1);
define('ADMINISTRADOR',2);
define('CALIDAD',3);
define('ROMANERO',4);
define('RECEPCION',5);
define('DESPACHO',6);
?>
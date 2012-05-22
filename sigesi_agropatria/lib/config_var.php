<?php
//Evitamos ataques de scripts de otros sitios
if (preg_match( "/config_var.php/", $_SERVER ["PHP_SELF"] ) || preg_match( "/config_var.php/", $HTTP_SERVER_VARS ["PHP_SELF"] ))
	die ( "Access denied!" );
	
//Directorios
define ( "APPROOT", $_SERVER ['DOCUMENT_ROOT'] . "/sigesil/" );
// Ej: se usa para los includes
define ( "DOMAIN_ROOT", "http://" . $_SERVER ['SERVER_NAME'] . "/sigesil/" );
// Ej: se usa para las im�genes, link, etc.


// Constantes de Base de datos
define ( "USER", "admin" );
define ( "PASS", "123456" );
define ( "SERVER", "192.168.65.5" );
define ( "DB", "sigesi" );

define ( "DEBUG", "1" );
?>
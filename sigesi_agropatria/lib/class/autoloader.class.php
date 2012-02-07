<?php
/*
 * OPTIME Consulting, Inc.
 *
 * Description: Clase para autocargar las clases del sistema
 *
 * @author Javier Mijares
 * @version 1.0  2010/10/21
 */
class Autoloader
{
	public static function Register() {
		return spl_autoload_register(array('Autoloader', 'APP_Load'));
	}	//	function Register()

	public static function APP_Load($class_name){
		if ((class_exists($class_name))) {
                        return false;
                }
                if(substr($class_name,0,4)=='cls_'){
                        if (file_exists(APPROOT."lib/class/".substr($class_name, 4, strlen($class_name)). '.class.php')) {
                            $pObjectFilePath = APPROOT."lib/class/".substr($class_name, 4, strlen($class_name)). '.class.php';
                        }
                }else{
                        $class = Inflector::underscore($class_name);
                        if (file_exists(APPROOT."lib/class/".strtolower(lcfirst($class)).'.class.php')) {
                            $pObjectFilePath = APPROOT."lib/class/".lcfirst($class).'.class.php';
                        }
                }

                if ((file_exists($pObjectFilePath) === false) || (is_readable($pObjectFilePath) === false)) {
                        return false;
                }

                require_once($pObjectFilePath);
	}	//	function Load()

}
?>

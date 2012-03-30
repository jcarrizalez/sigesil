<?php

/**
 * Clase general de funciones mas utilizadas o utiles
 */
class General {

    function fechaPhp() {
        switch (date('l')) {
            case 'Monday':
                $dia = 'Lunes';
                break;
            case 'Tuesday':
                $dia = 'Martes';
                break;
            case 'Wednesday':
                $dia = 'Mi&eacute;rcoles';
                break;
            case 'Thursday':
                $dia = 'Jueves';
                break;
            case 'Friday':
                $dia = 'Viernes';
                break;
            case 'Saturday':
                $dia = 'S&aacute;bado';
                break;
            case 'Sunday':
                $dia = 'Domingo';
                break;
        }

        switch (date('F')) {
            case 'January':
                $mes = 'Enero';
                break;
            case 'February':
                $mes = 'Febrero';
                break;
            case 'March':
                $mes = 'Marzo';
                break;
            case 'April':
                $mes = 'Abril';
                break;
            case 'May':
                $mes = 'Mayo';
                break;
            case 'June':
                $mes = 'Junio';
                break;
            case 'July':
                $mes = 'Julio';
                break;
            case 'August':
                $mes = 'Agosto';
                break;
            case 'September':
                $mes = 'Septiembre';
                break;
            case 'October':
                $mes = 'Octubre';
                break;
            case 'November':
                $mes = 'Noviembre';
                break;
            case 'December':
                $mes = 'Diciembre';
                break;
        }
        $diaNumero = date('d');
        $anoNumero = date('Y');
        $fechaFinal = 'Hoy es ' . ' ' . $dia . ', ' . $diaNumero . ' de ' . $mes . ' de ' . $anoNumero;

        return $fechaFinal;
    }
    
    function caracter($repetir, $caracter){
        $resultado = '';
        for($i=1; $i<=$repetir; $i++){
            $resultado .= $caracter;
        }
        return $resultado;
    }

    function calculaEdad($fechanacimiento) {
        list($ano, $mes, $dia) = explode("-", $fechanacimiento);
        $ano_diferencia = date("Y") - $ano;
        $mes_diferencia = date("m") - $mes;
        $dia_diferencia = date("d") - $dia;
        if ($dia_diferencia < 0 || $mes_diferencia < 0)
            $ano_diferencia--;
        return $ano_diferencia;
    }

    /**
     * Cambia un formato sql a una fecha normal o la divide en un arreglo
     *
     * @param string $fecha cadena de fecha con formato sql (yyyy-mm-dd hh:mm:ss)
     * @param boolean $inarray indica si retornar el resultado en un arreglo o no
     * @param string $lang formato de la fecha segun el lenguaje
     * @param string $sep caracter separador de numeros con el que se imprime la fecha
     * @return mixed retorna la fecha o un arreglo segun el valor del segundo parametro de la funcion
     */
    function date_sql_screen($fecha, $inarray=false, $lang="en", $sep="/") {
        $fechanor = "";
        preg_match("/([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2})/", $fecha, $frev);
        if ($frev) {
            if ($inarray) {
                return $frev;
            }
            if ($lang == "en") {
                $fechanor = date("m" . $sep . "d" . $sep . "Y", mktime(0, 0, 0, $frev[2], $frev[3], $frev[1]));
            } else {
                $fechanor = date("d" . $sep . "m" . $sep . "Y", mktime(0, 0, 0, $frev[2], $frev[3], $frev[1]));
            }
        }
        return $fechanor;
    }

    /**
     * Cambia el formato sql de una fecha con hora a formato humano o la divide en un arreglo
     *
     * @param string $fecha cadena de fecha con formato sql (yyyy-mm-dd hh:mm:ss)
     * @param boolean $inarray indica si retornar el resultado en un arreglo o no
     * @param string $lang formato de la fecha segun el lenguaje
     * @param string $sep caracter separador de numeros con el que se imprime la fecha
     * @param integer $format formato de la hora a mostrar, 12 o 24 horas
     * @return mixed retorna la fecha o un arreglo segun el valor del segundo parametro de la funcion
     */
    function fechahora_sql_normal($fecha, $inarray=false, $lang="en", $sep="-", $format=12) {
        $fechanor = "";
        $fh = "H";
        $ap = "";
        preg_match("/([0-9]{2,4})-([0-9]{1,2})-([0-9]{1,2}) ([0-9]{1,2}):([0-9]{1,2})/", $fecha, $frev);
        if ($frev) {
            if ($inarray) {
                return $frev;
            }
            if ($format != 24) {
                $fh = "h";
                $ap = "a";
            }
            if ($lang == "en") {
                $fechanor = date("m" . $sep . "d" . $sep . "Y " . $fh . ":i " . $ap, mktime($frev[4], $frev[5], 0, $frev[2], $frev[3], $frev[1]));
            } else {
                $fechanor = date("d" . $sep . "m" . $sep . "Y " . $fh . ":i " . $ap, mktime($frev[4], $frev[5], 0, $frev[2], $frev[3], $frev[1]));
            }
            $fechanor = trim($fechanor);
        }
        return $fechanor;
    }

    /**
     * Cambia el formato de una hora
     *
     * @param string $hora cadena de la hora (hh:mm:ss)
     * @param boolean $inarray indica si retornar el resultado en un arreglo o no
     * @param integer $format formato de la hora a mostrar, 12 o 24 horas
     * @return mixed retorna la hora o un arreglo segun el valor del segundo parametro de la funcion
     */
    function hora_sql_normal($hora, $inarray=false, $format=12) {
        $horanor = "";
        preg_match("/([0-9]{1,2}):([0-9]{1,2})/", $hora, $hrev);
        if ($hrev) {
            if ($inarray) {
                return $hrev;
            }
            if ($format != 24) {
                $horanor = date("h:i a", mktime($hrev[1], $hrev[2]));
            } else {
                $horanor = date("H:i", mktime($hrev[1], $hrev[2]));
            }
        }
        return $horanor;
    }

    /**
     * Da el formato de una fecha a el formato sql (yyyy-mm-dd)
     *
     * @param string $fecha cadena con la fecha a dar formato
     * @param string $lang formato de lenguaje de la fecha de origien (dd-mm-yyyy o mm-dd-yyyy)
     * @return string
     */
    function fecha_normal_sql($fecha, $lang="en") {
        $fechasql = "";
        preg_match("/([0-9]{1,2})[-\/]([0-9]{1,2})[-\/]([0-9]{2,4})/", $fecha, $frev);
        if ($frev) {
            if ($lang == "en") {
                $fechasql = date("Y-m-d", mktime(0, 0, 0, $frev[1], $frev[2], $frev[3]));
            } else {
                $fechasql = date("Y-m-d", mktime(0, 0, 0, $frev[2], $frev[1], $frev[3]));
            }
        }
        return $fechasql;
    }

    /**
     * Da el formato de una fecha hora a el formato sql (yyyy-mm-dd hh:mm:ss)
     *
     * @param string $fecha cadena con la fecha y hora a dar formato (dd-mm-yyyy hh:mm:ss [am/pm])
     * @param string $lang formato de lenguaje de la fecha de origien (dd-mm-yyyy o mm-dd-yyyy)
     * @return string
     */
    function fechahora_normal_sql($fecha, $lang="en") {
        $fsql = "";
        $hsql = "";
        $farray = explode(" ", trim($fecha));

        preg_match("/([0-9]{1,2})[-\/]([0-9]{1,2})[-\/]([0-9]{2,4})/", $farray[0], $frev);
        if ($frev) {
            if ($lang == "en") {
                $fsql = date("Y-m-d", mktime(0, 0, 0, $frev[1], $frev[2], $frev[3]));
            } else {
                $fsql = date("Y-m-d", mktime(0, 0, 0, $frev[2], $frev[1], $frev[3]));
            }
        }

        preg_match("/([0-9]{1,2}):([0-9]{1,2})/", $farray[1], $frev);
        if ($frev) {
            if ($farray[2]) {
                $chars = array(" ", ".");
                $farray[2] = strtolower(str_replace($chars, "", $farray[2]));
                if ($farray[2] == "pm" && $frev[1] <= 12) {
                    $frev[1]+=12;
                }
            }
            $hsql = date("H:i:s", mktime($frev[1], $frev[2], 0));
        }

        $fechasql = trim($fsql . " " . $hsql);
        return $fechasql;
    }

    /**
     * Por defecto calcula el numero de dias entre dos fechas o la fecha actual si
     * no se define el segundo parametro, el tercer y cuarto parametro hacen un
     * calculo segun los valores dados y retorna la fecha obtenida
     *
     * Las fechas ingresadas debe tener un formato GNU valudo como el formato SQL,
     * para mas detalles puede verse el manual de la funcion strtotime de php en
     * http://www.php.net/manual/es/function.strtotime.php o en el manual GNU
     * http://www.gnu.org/software/tar/manual/html_node/tar_113.html para saber
     * otras fechas validas para esta funcion
     *
     * @param string $fechalow fecha de inicio a comparar
     * @param string $fechahigh fecha final a comparar
     * @param integer $diff numero de diferencia a calcular
     * @param string $mod factor de calculo, por defecto en dias
     * @return integer|string retorna el numero de dias de difrencia, devuelte la fecha calculada
     */
    function timebtwdates($fechalow, $fechahigh='', $diff='', $mod="Dias") {
        switch ($mod) {
            case "Segundos":
                $factor = 1;
                break;
            case "Minutos":
                $factor = 60;
                break;
            case "Horas":
                $factor = 3600;
                break;
            case "Dias":
                $factor = 86400;
                break;
        }
        $regDate = strtotime($fechalow);
        if (empty($diff)) {
            if (!empty($fechahigh)) {
                $curDate = strtotime($fechahigh);
            } else {
                $curDate = mktime();
            }
            $tiempo = $curDate - $regDate;
            $tiempo = $tiempo / $factor;
        } else {
            $diff = $diff * $factor;
            $todate = $diff + $regDate;
            $tiempo = date("Y-m-d", $todate);
        }
        return $tiempo;
    }

    /**
     * Evalua una expresion para retornar uno de los dos valores dados
     *
     * @param mixed $expresion expresion a evaluar
     * @param mixed $returntrue valor a retornar si es verdadero
     * @param mixed $returnfalse valor a retornar si es false
     * @return mixed
     */
    function ifelse($expresion, $returntrue, $returnfalse="") {
        if (!$expresion) {
            return $returnfalse;
        } else {
            return $returntrue;
        }
    }

    /**
     * Generar un password aleatorio
     *
     * @param integer $passlen logintud de caracteres del password
     * @param string $chars lista de caracteres a utilizar
     * @return string password obtenido sin encriptar
     */
    function randompass($passlen=15, $chars="") {
        $chars = trim($chars);
        if (empty($chars))
            $chars = "aAb0BcCdD1eEfF2gGh3HiIjJ4kKl5Lm6MnNo7OpPqQrR6sStTuUvV9wWxXyYzZ";
        $charlen = strlen($chars);
        for ($i = 0; $i < $passlen; $i++) {
            mt_srand(date("s", time() + $i * 4567));
            $password .= substr($chars, mt_rand(1, $charlen), 1);
        }
        return $password;
    }

    /**
     * Obtiene el valor de un campo en una tabla en base a la cadena encriptada.
     *
     * El valor del campo a consultar no debe estar encriptado obligatoriamente,
     * esta funcione es solo un metodo de seguridad para usar cadenas encriptadas
     * en los url de php en vez de usar campos importantes como un id unico a
     * ocultar. El metodo sha1 es mas potente que el md5 por eso se usa por defecto
     *
     * El PHP y MySQL deben generar las mismas cadenas encriptadas para poder
     * obtener el valor real del campo, los metodos de cifrado de PHP se pueden
     * revisar en este link http://ve.php.net/manual/es/ref.strings.php y los
     * metodos de cifrado de MySQL se pueden revisar en este otro link
     * http://dev.mysql.com/doc/refman/5.0/en/encryption-functions.html
     *
     * @param string $hash cadena encriptada a buscar
     * @param string $campo nombre del campo de la tabla a consultar
     * @param string $tabla nombre de la tabla a consultar
     * @param string $mode metodo de encriptacion puede ser md5, sha1, etc
     * @return mixed valor del campo consultado
     */
    function normalhash($hash, $campo, $tabla, $mode="sha1") {
        $query = "SELECT $campo FROM $tabla WHERE $mode($campo)='$hash' ";
        $result = mysql_query($query) or die(mysql_error());
        if ($row = mysql_fetch_array($result)) {
            $valor_normal = $row[$campo];
        }
        return $valor_normal;
    }

    /**
     * Cuenta el total de registros de una tabla
     *
     * El total obtenido ademas de ser retornado tambien es guardado en
     * un vector como propiedad de la clase para algun uso extra durante
     * un script como por ejemplo un paginador, se usa el nombre de la
     * tabla por defecto o un nombre unico dado por el segundo parametro
     *
     * @param string $tabla nombre de la tabla o tablas a consultar (se puede usar JOIN)
     * @param string $key nombre de la clave con la que se guarda el resultado en un arreglo
     * @param string $cond alguna condicion extra en la consulta para filtar algun resultado
     * @return integer el numero total de registros encontrados
     */
    function total_regist($tabla, $key='', $cond='') {
        $query = "SELECT COUNT(*) as total FROM $tabla WHERE 1 " . $cond;
        //die($query);
        $result = mysql_query($query) or die(mysql_error());
        if ($row = mysql_fetch_array($result)) {
            if (!$key) {
                $key = $tabla;
            }
            $this->total[$key] = $row['total'];
        }
        return $row['total'];
    }

    /**
     * Buscar recursivamente un valor en un arreglo multiple incluyendo sus indices
     *
     * @param string $aguja valor a buscar en el arreglo
     * @param mixed $pajar arreglo o vector multiple en el que se hara la busqueda
     * @return boolean puede ser encontrado o no
     */
    function in_multi_array($aguja, $pajar) {
        $in_multi_array = false;
        if (@in_array($aguja, $pajar)) {
            $in_multi_array = true;
        } else {
            foreach ($pajar as $key => $val) {
                if (@is_array($val)) {
                    if ($this->in_multi_array($aguja, $val)) {
                        $in_multi_array = true;
                        break;
                    }
                }
            }
        }
        return $in_multi_array;
    }

    /**
     * Ordena un arreglo multiple de manera natural segun el nombre del campo
     *
     * @param mixed $array arreglo o vector multiple a ordenar
     * @param string $porcampo nombre del campo por el que se hara el orden
     * @return mixed arreglo ordenado
     */
    function ordermultiarray($array, $porcampo) {
        usort($array, create_function('$a,$b', 'return strcasecmp($a["' . $porcampo . '"],$b["' . $porcampo . '"]);'));
        return $array;
    }

    /**
     * Obtiene el id de la session usada
     *
     * @param str $sessid
     * @return str
     */
    function get_session_id($sessid = '') {
        if (!empty($sessid)) {
            return session_id($sessid);
        } else {
            return session_id();
        }
    }

    function obtenerClaseFila($fila) {
        if ($fila % 2 != 0) {
            $class = "primeraclase";
        } else {
            $class = "segundaclase";
        }
        return $class;
    }

    /*
     * Genera una lista de datos de una columna agrupada 
     */

    function get_filers_colum($colum_value, $colum_text, $table_name) {
        $query = "SELECT $colum_value AS valor, $colum_text AS texto 
			FROM $table_name GROUP BY $colum_value ORDER BY $colum_text ";
        $this->filter = cls_dbtools::_SQL_tool('SELECT', __METHOD__, $query);
    }

    /*
     * Obtiene el querystring de la pagina y genera la cadena excluyendo ciertos parametros
     */

    function capute_request($exclude) {
        $output = "";
        foreach ($_GET as $k => $v) {
            if ($k != $exclude && !in_array($k, array('lng', 'pg'))) {
                $output.= '&' . $k . '=' . $v;
            }
        }
        return $output;
    }

    function vldField($field) {
        if (isset($field) && $field != 0 && $field != "") {
            return $field;
        } else {
            return null;
        }
    }

}

?>
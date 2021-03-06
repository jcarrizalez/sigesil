<?php
/**
 * Manejo de logs de eventos
 * Los Id de eventos pueden ser visto en la tabla si_log_codigos
 */
class cls_logs {
	private $saltodelinea = array ("\t","\n","\r","\0","\x0B");
	private $codigos = array();
	private $log_usuario_id='';
	private $log_usuario_info='';
	private $log_usuario_email='';
	private $log_centro_acopio='';
	private $log_navegador='';
	private $data_old='No data';
	private $data_new='No data';
	public $table_name='No data';
	private $data_old_del = array();
	

	/**
	 * Funcion constructora, obtiene los codigos de los logs
	 * @return unknown_type
	 */
	function __construct(){
		$query="SELECT * FROM si_log_codigos";
		$res=pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
		$res_array=array();
		while ( $row = pg_fetch_array ( $res ) ) {
			foreach ( $row as $key => $value ) {
				$res_array[$row['log_codigo_id']][$key] = $value;
			}
		}
		$this->codigos=$res_array;
	}
	
	/**
	 * Desglosa el query segun su funcionabilidad para almacenar los datos en el log
	 * @param $query
	 * @param $tipo
	 * @return unknown_type
	 */
	function process_query($query, $tipo){
		$query = trim( str_ireplace($this->saltodelinea, " ", $query) );		
		$tipo = strtoupper($tipo);
		$this->data_old = 'No data'; 
		$this->data_new = 'No data';
		$this->table_name = '';
		$var_data_old = '';
		$var_data_new = '';
		$i=0;
			
		if($tipo=='INSERT'){
			/**
			 * http://dev.mysql.com/doc/refman/5.0/en/insert.html
			 * El query en verdad es un insert?
			 */
			if(strtoupper(substr($query, 0, 6))=='INSERT'){
				$array_rep = array();
				
				//Obtengo las tablas a actualizar 
				$tablas_string = substr($query, (stripos($query,'INTO ')+5) );
				$tablas_string = trim( substr($tablas_string, 0, stripos($tablas_string,'(')) );
				//die($tablas_string);
				
				//Obtengo la cadena de campos
				$campos = substr($query, (stripos($query,'(')+1));
				$campos = trim( substr($campos, 0, stripos($campos,')')) );
				$arr_campos = explode( ",", $campos);
				//die($campos);
				
				//Obtengo la cadena de valores
				$var_string= trim( substr($query, stripos($query,')')+1) );
				//die($var_string);
				
				if( strtoupper(substr($var_string, 0, 6)) != 'SELECT' ){
					//Insert simple
					//$val_string = trim( substr($query, $pos_values+8) );
					//$valores = trim( substr($val_string, (stripos($val_string,'(')+1), strripos($val_string,')')) );
					
					$valores = substr( $var_string, (stripos($var_string,'(')+1) );
					$valores = trim( substr($valores, 0, strripos($valores,')')) );
					//die($valores);
					$arr_valores = explode(",",$valores);
					if( count($arr_campos) != count($arr_valores) ){
						/**
						 * TODO hacer el arreglo de la cadena cuando la cantidad de valores y columnas no coincide
						 */
					} 
					foreach($arr_campos as $key => $value){
						$var_data_new .= trim($value)." = ".$arr_valores[$key]."<br />";							
					}
					
				} else {
					/**
					 * Es un INSERT ... SELECT Syntax
					 * http://dev.mysql.com/doc/refman/5.0/en/insert-select.html
					 */ 
					$res=pg_query($var_string) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$var_string);
					$cant_data=pg_num_rows($res);
					if($cant_data<>0){
						while($row=pg_fetch_row($res) ){
							$var_data_new .= "Register No.".$i."<br />";	
							foreach($row as $key => $value){
								if(is_numeric($key)){ //Hay que usar los indices numericos
									$var_data_new .= trim($arr_campos[$key])." = ".$value."<br />";
								}
							}
							$i++;
						}
					}
				}				
				
				$this->data_new = $var_data_new;
				$this->table_name = trim($tablas_string);
				
				return 1;
			}
		}
		
		if($tipo=='UPDATE'){
			/**
			 * http://dev.mysql.com/doc/refman/5.0/en/update.html
			 * El query en verdad es un update?
			 */
			if(strtoupper(substr($query, 0, 6))=='UPDATE'){
				$array_where = array();
				$arr_valores = array();
				
				//Obtengo las tablas a actualizar 
				$tablas_string = substr($query, 0, stripos($query,' SET '));
				$tablas_string = trim( substr( $tablas_string, 7) );
				//die($tablas_string);
				
				//Obtengo la cadena de campos y valores
				$campos = stristr($query, ' SET ');
				$campos = trim( substr($campos, 4, (strripos($campos, "WHERE ")-4)) );
				//die($campos);
				
				//Obtengo la cadena del where
				$where_string = trim( substr($query, (strripos($query,' WHERE ')+7)) );
				//die($where_string);
				
				//Pico la cadena de campos para obtener los nombres reales
				$es_primero = true;
				$split_campos=explode(",",$campos);
				//print_r($split_campos);
				foreach($split_campos as $indice => $valor){
					//Si existe en la cadena un "=" quizas sea un campo
					if(strpos($valor, "=")!==false){
						$campo=trim( substr($valor, 0,  strpos($valor, "=") ) );
						//Si no se encuentran espacios en el nombre del campo entonces es valido
						if(strpos($campo, " ")===false){
							$campos_string .= $separador.$campo;
							if($es_primero){
								$separador=", ";
								$es_primero = false;
							}
						}
					}
				}
				
				//Obtenemos los valores viejos antes del cambio
				$this->get_old_data($campos_string,$tablas_string,$where_string);
				
				$this->data_new = $campos;
				$this->table_name = trim($tablas_string);
				
				return 1;
			}
		}
		
		if($tipo=='DELETE'){
			/**
			 * http://dev.mysql.com/doc/refman/5.0/en/delete.html
			 * El query en verdad es un delete?
			 */
			if(strtoupper(substr($query, 0, 6))=='DELETE'){
				$array_where = array();
				$pos_where = stripos($query,' WHERE ');
				$pos_from = stripos($query,' FROM ');
				
				/**
				 * Se extrae la parte de la sentencia para realizar una busqueda del registro 
				 * antes de borrarlo y poder buscar los valores para mostrar en el texto del log
				 */	

				//Obtengo las tablas a actualizar 
				$tablas_string = stristr($query, ' FROM ');
				$tablas_string = substr($tablas_string, 6) ;
				$tablas_string = trim( substr($tablas_string, 0, stripos($tablas_string,' WHERE ')) ) ;
				//die($tablas_string);
				
				//Obtengo la cadena del where
				$where_string = trim( substr($query, (stripos($query,' WHERE ')+7)) );
				//die($where_string);
				
				if(stripos($tablas_string, ",")!==false){
					//Delete en multiples tablas
					$var_campo=''; $var_tabla='';
					$tablas_array = explode(",", $tablas_string);
					foreach($tablas_array as $tabla){
						$var_campo .= $tabla.'.*, ';
						$var_tabla .=  $tabla.', ';
					}
					$var_campo = substr($var_campo,0,-2);
					$var_tabla = substr($var_tabla,0,-2);
				} else {
					//Delete simple
					$var_campo = '*';
					$var_tabla = $tablas_string;
				}
				//die($var_campo);

				//Obtenemos los valores viejos antes del cambio
				$this->get_old_data($var_campo, $var_tabla, $where_string);

				$this->table_name = trim($var_tabla);
				
				return 1;
			}
			
		}
		return 0;		
	}
	
	/**
	 * Obtiene los datos viejos antes de un cambio
	 * @param string $campos campos a usar
	 * @param string $tablas tablas a usar
	 * @param string $sentencia sentencia del where
	 */
	/* FUNCION ANTERIOR QUE PRESENTABA ERRORES Y NO ALMACENABA LA DATA ANTERIOR
        function get_old_data($campos,$tablas,$sentencia){
		$i=0; $var_data_old = array();
		$query="SELECT ".$campos." FROM ".$tablas." WHERE ".$sentencia;
		//die($query);
		$res=pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
		$cant_data=pg_num_rows($res);
		if($cant_data<>0){
			while($row=pg_fetch_array($res) ){
				$var_data_old[$i] = "Register No.".$i."<br />";	
				foreach($row as $key => $value){
					if(!is_numeric($key)){ //Hay que obiar los indices numericos
						$var_data_old[$i] = $key." = ".$value."<br />";
					}
				}
				$i++;					
			}
			$var_data_old = substr($var_data_old, 0, -6);
		} else {
			$var_data_old[0] = 'No data';
		}		
		$this->data_old_del = $var_data_old;
	}*/
        
        function get_old_data($campos,$tablas,$sentencia){
		$i=0; $var_data_old = array();
		$query="SELECT ".$campos." FROM ".$tablas." WHERE ".$sentencia;
		//die($query);
		$res=pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
		$cant_data=pg_num_rows($res);
		if($cant_data<>0){
			while($row=pg_fetch_array($res) ){
				$var_data_old = "Register No.".$i."<br />";	
				foreach($row as $key => $value){
					if(!is_numeric($key)){ //Hay que obiar los indices numericos
						$var_data_old .= $key." = ".$value."<br />";
					}
				$i++;					
				}
			}
			//$var_data_old = substr($var_data_old, 0, -6);
		} else {
			$var_data_old[0] = 'No data';
		}
		$this->data_old = $var_data_old;
                //var_dump($this->data_old);die();
		$this->data_old_del = $var_data_old;
	}
	
	/**
	 * Obtiene los datos de un usuario para ser guardados en el log
	 * @return unknown_type
	 */
	private function get_userinfo_log(){
		$this->log_usuario_info = ($_SESSION['s_nombre'] || $_SESSION['s_apellido'])? $_SESSION['s_nombre']." ".$_SESSION['s_apellido'] : 'N/A';
		$this->log_usuario_id = ($_SESSION['s_id'])? (int)$_SESSION['s_id'] : 0;
		$this->log_usuario_email = ($_SESSION['s_email'])? $_SESSION['s_email'] : 'N/A';
		$this->log_centro_acopio = ($_SESSION['s_ca_nombre'])? $_SESSION['s_ca_nombre'] : 'N/A';
		
	}
	
	/**
	 * Inserta el log en la bd
	 * @param $query_log
	 * @param $log_codigo_id
	 * @param $comentario
	 * @return unknown_type
	 */
	function set_log_consulta($query_log, $log_codigo_id,$comentario=''){
		//Para detectar el navegador
		require('browser_detection/your_computer_info.php');		
		$this->log_navegador=$html;	
		//Para detectar el navegador
		
		
		$this->get_userinfo_log();
		$query_log = pg_escape_string( str_ireplace($this->saltodelinea, " ", $query_log) );
		$comentario = pg_escape_string($comentario);
		$query="INSERT INTO si_log_consultas 
			(en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, 
			direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) 
			VALUES 
			( NOW(), '$log_codigo_id', '".$this->log_usuario_id."', '".$this->log_usuario_info."', 
			'".$this->log_usuario_email."', '".pg_escape_string($this->log_centro_acopio)."', '".session_id()."', 
			'".$_SERVER['REMOTE_ADDR']."', '".pg_escape_string($this->log_navegador)."', 
			'".$this->table_name."', '".pg_escape_string($this->data_old)."', 
			'".pg_escape_string($this->data_new)."', '".$query_log."', '$comentario' )";
		//die($query);
		$res=pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
	}
	
	/**
	 * Inserta el log en la bd
	 * @param $query_log
	 * @param $log_codigo_id
	 * @param $comentario
	 * @return unknown_type
	 */
	function set_log_consulta_del($query_log, $log_codigo_id,$comentario=''){
		//Para detectar el navegador
		require('browser_detection/your_computer_info.php');		
		$this->log_navegador=$html;	
		//Para detectar el navegador
		$this->get_userinfo_log();
		$query_log = pg_escape_string( str_ireplace($this->saltodelinea, " ", $query_log) );
		$comentario = pg_escape_string($comentario);
		$cant = count($this->data_old_del);
		for($i=0; $i<$cant; $i++){
			$query="INSERT INTO si_log_consultas  (en_fecha, log_codigo_id, usuario_id, usuario_info, usuario_email, centro_acopio, session_id, direccion_ip, navegador, en_tablas, data_vieja, data_nueva, sentencia_sql, comentario) 
				VALUES  ( NOW(), '$log_codigo_id', '".$this->log_usuario_id."', '".$this->log_usuario_info."', 
				'".$this->log_usuario_email."', '".pg_escape_string($this->log_centro_acopio)."', '".session_id()."', 
				'".$_SERVER['REMOTE_ADDR']."', '".pg_escape_string($this->log_navegador)."', 
				'".$this->table_name."', '".pg_escape_string($this->data_old_del[$i])."', 
				'".pg_escape_string($this->data_new)."', '".$query_log."', '$comentario' )";
			$res=pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
		}
		
	}
	
	/**
	 * Lista los logs del sistema
	 * @param $start_date
	 * @param $end_date
	 * @param $compania
	 * @param $usuario
	 * @param $event
	 * @param $order
	 * @param $min
	 * @param $max
	 * @return unknown_type
	 */
	function list_consultas($finicio, $ffin, $ca, $usuario, $evento, $order = null, $porPagina = null, $inicio = null){
		$query="SELECT cons.*,cod.* FROM si_log_consultas AS cons, si_log_codigos AS cod 
			WHERE cons.log_codigo_id=cod.log_codigo_id ";
		if($finicio){ 
			$query.=" AND cons.en_fecha >= '$finicio 00:00:01' "; 
		}
		if($ffin){ 
			$query.=" AND cons.en_fecha <= '$ffin 23:59:59' "; 
		}
		if($ca){ $query.=" AND cons.centro_acopio='$ca' "; }
		if($usuario){ $query.=" AND cons.usuario_info='$usuario' "; }
		//if($evento){ $query.=" AND cod.log_codigo_id='$evento' "; }
		if($evento){ $query.=" AND cod.log_codigo_nombre_es='$evento' "; }
		if (! empty ( $order )) {
			$query .= " ORDER BY $order ";
		} else {
			$query .= " ORDER BY en_fecha DESC ";
		}
		$query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
		$this->lista = cls_dbtools::_SQL_tool('SELECT',__METHOD__,$query);
	}
	
	/**
	 * Obtiene un log por su id
	 * @param $log_id
	 * @return unknown_type
	 */
	function get_log_id($log_id){
		$query="SELECT cons.*,cod.* FROM si_log_consultas AS cons, si_log_codigos AS cod 
			WHERE cons.log_codigo_id=cod.log_codigo_id AND cons.log_id='$log_id' ";
		$this->data = cls_dbtools::_SQL_tool('SELECT_SINGLE',__METHOD__,$query);
	}
	
	protected function setLogdataNew($arrNew){
		$this->data_new=$this->getFormatedDataLog($arrNew);
	}
	
	protected function getFormatedDataLog($arrNew){
		$strReturn="";
		if(is_array($arrNew)){
			$i=0;
			foreach($arrNew as $index=>$array){
				if($i>=1){$strReturn.="<br />";}
				foreach($array as $name=>$val){
					$strReturn.=$name."='".$val."'<br />";
				}
				$i++;
			}
		}
		return $strReturn;
	}
	protected function setLogTable($tableName){
		$this->table_name=$tableName;
	}
}
?>
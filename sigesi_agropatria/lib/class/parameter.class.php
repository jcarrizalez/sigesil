<?php
    class Parameter extends cls_dbtools {
	/**
	 * Funcion constructora que define las constantes en la aplicacion
	 * @return unknown_type
	 */
	function __construct(){
            $query="SELECT * FROM si_parametros";
            $res_array=$this->_SQL_tool($this->SELECT, __METHOD__, $query);
            for($i=0, $cant=count($res_array); $i<$cant; $i++){
                //if($res_array[$i]['parametro_key']!='EMAIL_FROM')  //el email es diferente para cada país
                define($res_array[$i]['parametro_llave'], $res_array[$i]['parametro_valor']);
            }
	}
	
	/**
	 * Lista los parametros de la bd
	 * @param $mostrar
	 * @return unknown_type
	 */
	function listaParametros($mostrar = 1, $constantes = ''){
            $query="SELECT * FROM si_parametros WHERE '1' ";
            if(!is_null($mostrar)){ $query.=" AND parametro_mostrar = '$mostrar' "; }
            if(!is_null($constantes)){ $query.=" AND id >= $constantes "; }
            $this->lista=$this->_SQL_tool($this->SELECT, __METHOD__, $query);
	}
	
	/**
	 * Actualiza los valores de un parametro
	 * @param $parametro_id
	 * @param $parametro_value
	 * @return unknown_type
	 */
	function update($id,$value){
            $query="UPDATE si_parametros SET parametro_valor='$value' WHERE 
                    id='$id' ";
            $this->_SQL_tool($this->UPDATE, __METHOD__, $query);	
	}
	
	/**
	 * Obtiene un parametro por su id
	 * @param $parametro_id
	 * @return unknown_type
	 */
	function findFirst($id){
            $query="SELECT * FROM si_parametros WHERE id='$id' ";
            $this->data=$this->_SQL_tool($this->SELECT_SINGLE, __METHOD__, $query);
	}

	function lista_trimestres_disponibles($pais_id){
            $query = "SELECT * FROM quarters WHERE pais_id = '$pais_id' AND 
                        (date_redeem_limit > DATE_SUB(NOW(),INTERVAL 3 MONTH)) 
                        ORDER BY date_redeem_limit";
            $this->lista_qrt=$this->_SQL_tool('SELECT', __METHOD__, $query);
	}
        
	function update_pais($id,$pais_lenguaje,$pais_email){
            $query="UPDATE paises 
            SET pais_lenguaje='$pais_lenguaje', pais_email='$pais_email' 
            WHERE pais_id =  '$id' ";
            $this->_SQL_tool('UPDATE', __METHOD__, $query);
	}
}
?>
<?php

class Recepcion extends Model {
    var $table = 'si_recepcion';
    
    function recepcionesDia($idCA, $idCo){
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' AND id_cosecha = '$idCo' AND fecha_recepcion = '2012-02-23'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function guardarGuia($data){
        $query = "INSERT INTO si_guiarec (";
        foreach($data as $campo => $valor){
            $query .= $campo.", ";
        }
        $query = substr($query, 0, -2) . ") VALUES (";
        foreach($data as $campo => $valor){
            $query .= "'$valor', ";
        }
        $query = substr($query, 0, -2) . ")";
        //$id = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $this->id = $id;
    }
}
?>
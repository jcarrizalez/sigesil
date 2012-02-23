<?php

class Recepcion extends Model {
    var $table = 'si_recepcion';
    
    function recepcionesDia($idCA, $idCo){
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' AND id_cosecha = '$idCo' AND fecha_recepcion = '2012-02-23'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
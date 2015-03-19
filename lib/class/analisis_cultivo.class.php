<?php
class AnalisisCultivo extends Model {
    var $table = 'si_analisis_cultivo';
    
    function analisisPorCultivo($idCultivo = null, $idCA = null){
        $query = "SELECT a.codigo, a.nombre AS analisis, ac.*
                    FROM si_analisis_cultivo ac
                    INNER JOIN si_analisis a ON a.id = ac.id_analisis
                    WHERE ac.id_cultivo = '$idCultivo'";
        $query .= (!is_null($idCA)) ? " AND ac.id_centro_acopio = '$idCA'" : "";
        $query .= " ORDER BY a.codigo";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

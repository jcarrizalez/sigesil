<?php

class Formulas extends Model {

    var $table = 'si_formulas';

    function listaFormulas($idCa = '', $codigo = '', $generales = 1){
        $query = "SELECT f.*, ca.nombre AS nombre_ca, c.codigo AS codigo_cultivo, c.nombre AS nombre_cultivo
                    FROM si_formulas f
                    INNER JOIN si_centro_acopio ca ON ca.id = f.id_centro_acopio
                    INNER JOIN si_cultivo c ON c.id = f.id_cultivo
                    WHERE '1'";
        $query .= (!empty($idCa)) ? " AND f.id_centro_acopio = '$idCa' " : '';
        $query .= (!empty($generales)) ? " OR f.id_centro_acopio = '1' " : '';
        $query .= (!empty($codigo)) ? " AND f.codigo = '$codigo' " : '';
        $query .= " ORDER BY ca.codigo, c.codigo, f.id";
        $this->listaF = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}

?>

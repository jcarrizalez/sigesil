<?php

class Formulas extends Model {

    var $table = 'si_formulas';

    function listaFormulas($idCa = '', $codigo = '', $generales = 1, $porPagina=null, $inicio=null){
        $query = "SELECT f.*, ca.nombre AS nombre_ca, c.codigo AS codigo_cultivo, c.nombre AS nombre_cultivo
                    FROM si_formulas f
                    INNER JOIN si_centro_acopio ca ON ca.id = f.id_centro_acopio
                    LEFT JOIN si_cultivo c ON c.id = f.id_cultivo
                    WHERE '1'";
        $query .= (!empty($idCa)) ? " AND f.id_centro_acopio = '$idCa'" : '';
        $query .= (!empty($codigo)) ? " AND f.codigo = '$codigo'" : '';
        $query .= (!empty($generales)) ? " AND f.id_cultivo IS NULL" : '';
        $query .= " ORDER BY ca.codigo, c.codigo, f.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        $this->listaF = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function formulaCultivo($idCa = null, $idCu = null, $orden = null, $porPagina=null, $inicio=null){
        $query = "SELECT *
                    FROM si_formulas
                    WHERE '1'";
        $query .= (!empty($idCa)) ? " AND (id_centro_acopio = '$idCa' OR id_centro_acopio = '1')" : '';
        $query .= (!empty($idCu)) ? " AND (id_cultivo = '$idCu' OR id_cultivo IS NULL)" : '';
        $query .= (!empty($orden)) ? " $orden" : " ORDER BY id_cultivo, id_analisis, id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}

?>

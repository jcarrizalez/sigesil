<?php

class Impresora extends Model {
    var $table = 'si_impresora';
    
    function buscarImpresora($id = null, $idCa = null, $status = null, $nombre = null, $porPagina=null, $inicio=null){
        $query = "SELECT i.*, '('||ca.codigo||') '||ca.nombre AS centro_acopio
                    FROM si_impresora i
                    INNER JOIN si_centro_acopio ca ON ca.id = i.id_centro_acopio
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND i.id = '$id'" : "";
        $query .= (!empty($idCa)) ? " AND i.id_centro_acopio = '$idCa'" : "";
        $query .= (!empty($status)) ? " AND i.estatus IN ($status)" : "";
        $query .= (!empty($nombre)) ? " AND i.nombre LIKE '%$nombre%'" : "";
        $query .= " ORDER BY i.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
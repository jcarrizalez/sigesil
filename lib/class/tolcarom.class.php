<?php

class Tolcarom extends Model {
    var $table = 'si_tolcarom';
    
    function listaTolcarom($idCA=null, $tipo=null){
        $query = "SELECT * FROM si_tolcarom WHERE '1'";
        $query.=(!empty($idCA)) ? " AND id_centro_acopio = '$idCA'" : '';
        $query.=(!empty($tipo)) ? " AND tipo IN ($tipo)" : '';
        $query .= " ORDER BY tipo, numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function buscarTolcarom($id = null, $idCa = null, $nombre = null, $tipo = null, $status = null, $porPagina=null, $inicio=null){
        $query = "SELECT t.*, '('||ca.codigo||') '||ca.nombre AS centro_acopio
                    FROM si_tolcarom t
                    INNER JOIN si_centro_acopio ca ON ca.id = t.id_centro_acopio
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND t.id = '$id'" : "";
        $query .= (!empty($idCa)) ? " AND t.id_centro_acopio = '$idCa'" : "";
        $query .= (!empty($nombre)) ? " AND t.nombre LIKE '%$nombre%'" : "";
        $query .= (!empty($tipo)) ? " AND t.tipo = '$tipo'" : "";
        $query .= (!empty($status)) ? " AND t.estatus IN ($status)" : "";
        $query .= " ORDER BY t.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
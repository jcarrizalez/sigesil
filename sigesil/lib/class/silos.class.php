<?php

class Silos extends Model {
    var $table = 'si_silos';
    
    function listadoSilos($id=null, $idCA=null, $porPagina=null, $inicio=null){
        $query = "SELECT s.*, ca.nombre AS nombre_ca
                    FROM si_silos s
                    INNER JOIN si_centro_acopio ca ON ca.id = s.id_centro_acopio
                    WHERE '1' AND s.estatus = 't'";
        $query .= (!empty($id)) ? " AND s.id = $id" : '';
        $query .= (!empty($idCA)) ? " AND s.id_centro_acopio = $idCA" : '';
        $query .= " ORDER BY s.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function desactivarS($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function cantidadSilosCA($idCA){
        $query = "SELECT COUNT(*) AS totalSilos
                    FROM si_silos
                    WHERE id_centro_acopio = '$idCA'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
<?php

class DivPol extends Model {
    
    function obtenerPais($id=null) {
        $query = "SELECT * FROM si_pais WHERE '1'";
        $query .= (!empty($id)) ? " AND id = '$id'" : "";
        $query .= " ORDER BY nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function obtenerEstado($id=null, $idP=null) {
        $query = "SELECT * FROM si_estado WHERE '1'";
        $query .= (!empty($id)) ? " AND id = '$id'" : "";
        $query .= (!empty($idP)) ? " AND id_pais = '$idP'" : "";
        $query .= " ORDER BY nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function obtenerMcpo($id=null, $idE=null) {
        $query = "SELECT * FROM si_municipio WHERE '1'";
        $query .= (!empty($id)) ? " AND id = '$id'" : "";
        $query .= (!empty($idE)) ? " AND id_estado = '$idE'" : "";
        $query .= " ORDER BY nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function obtenerMcpoEdoPais($idP=null, $idE=null, $idM=null){
        $query = "SELECT p.id id_pais, p.nombre nombre_pais, e.id id_edo, e.nombre nombre_edo, m.id id_mcpo, m.nombre nombre_mcpo
                    FROM si_pais p
                    INNER JOIN si_estado e ON e.id_pais = p.id
                    INNER JOIN si_municipio m ON m.id_estado = e.id WHERE '1'";
        $query .= (!empty($idP)) ? " AND p.id = '$idP'" : "";
        $query .= (!empty($idE)) ? " AND e.id = '$idE'" : "";
        $query .= (!empty($idM)) ? " AND m.id = '$idM'" : "";
        $query .= " ORDER BY p.nombre, e.nombre, m.nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
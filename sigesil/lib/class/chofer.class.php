<?php

class Chofer extends Model {
    var $table = 'si_choferes';
    
    function buscarChofer($cedRif=null, $nombre=null, $porPagina=null, $inicio=null){
        $query = "SELECT c.*, p.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                    FROM si_choferes c
                    INNER JOIN si_pais p ON p.id = c.id_pais
                    INNER JOIN si_estado e ON e.id = c.id_estado
                    INNER JOIN si_municipio m ON m.id = c.id_municipio
                    WHERE '1' AND c.estatus = 't'";
        $query .= (!empty($cedRif)) ? " AND c.ced_rif ILIKE '%$cedRif%'" : "";
        $query .= (!empty($nombre)) ? " AND c.nombre ILIKE '%$nombre%'" : "";
        $query .= " ORDER BY c.nombre";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function desactivarCh($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>
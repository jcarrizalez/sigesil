<?php

class Almacen extends Model {
    var $table = 'si_almacenes';
    
    function desactivarAL($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function buscarAL($id=null, $nombre=null, $idCA=null, $idOrg=null){
        $query = "SELECT al.*, ca.nombre AS nombre_ca, o.nombre AS nombre_org, pa.nombre AS pais, es.nombre AS estado, mu.nombre AS municipio
                    FROM si_almacenes al
                    INNER JOIN si_centro_acopio ca ON ca.id = al.id_centro_acopio
                    INNER JOIN si_organizacion o ON o.id = ca.id_org
                    INNER JOIN si_pais pa ON pa.id = al.id_pais
                    INNER JOIN si_estado es ON es.id = al.id_estado
                    INNER JOIN si_municipio mu ON mu.id = al.id_municipio
                    WHERE '1' AND al.estatus = 't'";
        $query .= (!empty($id)) ? " AND al.id = '$id'" : "";
        $query .= (!empty($nombre)) ? " AND al.nombre ILIKE '%$nombre%'" : "";
        $query .= (!empty($idCA)) ? " AND ca.id = '$idCA'" : "";
        $query .= (!empty($idOrg)) ? " AND o.id = '$idOrg'" : "";
        $query .= " ORDER BY al.id_centro_acopio, al.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
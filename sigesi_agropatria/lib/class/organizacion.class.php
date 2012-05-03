<?php

class Organizacion extends Model {
    var $table = 'si_organizacion';
    
    function detalleOrganizacion($idO = null){
        $query = "SELECT o.*, pa.nombre AS pais, es.nombre AS estado, mu.nombre AS municipio
                FROM si_organizacion o
                INNER JOIN si_pais pa ON pa.id = o.id_pais
                INNER JOIN si_estado es ON es.id = o.id_estado
                INNER JOIN si_municipio mu ON mu.id = o.id_municipio
                WHERE '1' AND estatus = 't'";
        $query .= (!empty($idO)) ? " AND o.id = '$idO'" : "";
        $query .= " ORDER BY o.nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function eliminarOrg($idO, $estatus = 't'){
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$idO'";
        return $this->_SQL_tool('UPDATE', __METHOD__, $query);
    }
}
?>
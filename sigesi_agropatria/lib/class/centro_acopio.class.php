<?php

class CentroAcopio extends Model {
    var $table = 'si_centro_acopio';
    
    function buscarCA($id=null, $nombre=null, $rif=null, $idOrg=null){
        $query = "SELECT ca.*, o.nombre AS nombre_org
                    FROM si_centro_acopio ca
                    INNER JOIN si_organizacion o ON o.id = ca.id_org WHERE '1' AND ca.id <> 1";
        $query .= (!empty($id)) ? " AND ca.id = '$id'" : "";
        $query .= (!empty($nombre)) ? " AND ca.nombre LIKE '%$nombre%'" : "";
        $query .= (!empty($rif)) ? " AND ca.rif LIKE '%$rif%'" : "";
        $query .= (!empty($idOrg)) ? " AND ca.id_org = '$idOrg'" : "";
        $query .= " ORDER BY ca.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function desactivarCA($id, $status) {
        $query = "UPDATE si_centro_acopio SET estatus = '$status' WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>

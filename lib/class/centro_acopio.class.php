<?php

class CentroAcopio extends Model {
    var $table = 'si_centro_acopio';
    
    function buscarCA($id=null, $nombre=null, $rif=null, $idOrg=null, $orden=null){
        $query = "SELECT ca.*, o.nombre AS nombre_org
                    FROM si_centro_acopio ca
                    INNER JOIN si_organizacion o ON o.id = ca.id_org 
                    WHERE '1' AND ca.id <> 1 AND ca.estatus = 't'";
        $query .= (!empty($id)) ? " AND ca.id = '$id'" : "";
        $query .= (!empty($nombre)) ? " AND ca.nombre ILIKE '%$nombre%'" : "";
        $query .= (!empty($rif)) ? " AND ca.rif ILIKE '%$rif%'" : "";
        $query .= (!empty($idOrg)) ? " AND ca.id_org = '$idOrg'" : "";
        $query .= (!empty($orden)) ? "ORDER BY $orden" : " ORDER BY ca.nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function desactivarCA($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>

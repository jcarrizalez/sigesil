<?php

class Productor extends Model {
    var $table = 'si_productor';
    
    function listadoProductores($id=null, $idOrg=null, $porPagina=null, $inicio=null){
        $query = "SELECT p.id, p.*, pa.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                FROM si_productor p
                INNER JOIN si_organizacion o ON p.id_org = o.id
                INNER JOIN si_pais pa ON pa.id = p.id_pais
                INNER JOIN si_estado e ON e.id = p.id_estado
                INNER JOIN si_municipio m ON m.id = p.id_municipio
                    WHERE '1' AND p.estatus = 't'";
        $query.=(!empty($id)) ? " AND p.id = '$id'" : '';
        $query.=(!empty($idORG)) ? " AND p.id_org = '$idOrg'" : '';
        $query.= " ORDER BY p.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    } 
    
    function desactivarPro($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>

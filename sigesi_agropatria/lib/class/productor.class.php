<?php

class Productor extends Model {
    var $table = 'si_productor';
    
    function listadoProductores($id=null, $idOrg=null){
        $query = "SELECT p.id, p.*, pa.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                FROM si_productor p
                INNER JOIN si_organizacion o ON p.id_org = o.id
                INNER JOIN si_pais pa ON pa.id = p.id_pais
                INNER JOIN si_estado e ON e.id = p.id_estado
                INNER JOIN si_municipio m ON m.id = p.id_municipio
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND p.id = '$id'" : '';
        $query.=(!empty($idORG)) ? " AND p.id_org = '$idOrg'" : '';
        $query.= " ORDER BY p.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    } 
    
    function eliminarProductor($id){
        $query = "DELETE FROM si_productor WHERE id = '$id'";
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>

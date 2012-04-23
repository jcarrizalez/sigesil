<?php

class Productor extends Model {
    var $table = 'si_productor';
    
    function listadoProductores($id=null, $idORG=null){
        $query = "SELECT p.id,p.*
                FROM si_productor p
                INNER JOIN si_organizacion o ON p.id_org=o.id                    
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND p.id = $id" : '';
        $query.=(!empty($idORG)) ? " AND p.id_org = $idORG" : '';
        $query.= " ORDER BY p.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    } 
    
    function eliminarProductor($id){
        $query = "DELETE FROM si_productor where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>

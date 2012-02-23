<?php

class Productor extends Model {
    var $table = 'si_productor';
    
    function listadoProductores($id=null, $idCA=null){
        $query = "SELECT p.id,p.*,
                    ca.nombre AS nombre_ca
                    FROM si_productor p
                    INNER JOIN si_centro_acopio ca ON ca.id = p.id_centro_acopio
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND p.id = $id" : '';
        $query.=(!empty($idCA)) ? " AND p.id_centro_acopio = $idCA" : '';
        $query.= " ORDER BY p.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    } 
    
    function eliminarProductor($id){
        $query = "DELETE FROM si_productor where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>

<?php

class Silos extends Model {
    var $table = 'si_silos';
    
    function listadoSilos($id=null, $idCA=null){
        $query = "SELECT s.*, ca.nombre nombre_ca
                    FROM si_silos s
                    INNER JOIN si_centro_acopio ca ON ca.id = s.id_centro_acopio
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND s.id = $id" : '';
        $query.=(!empty($idCA)) ? " AND s.id_centro_acopio = $idCA" : '';
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function eliminarSilo($id){
        $query = "DELETE FROM si_silos WHERE id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>
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
        $query.= " ORDER BY s.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function eliminarSilo($borrarPor=1, $id){
        if($borrarPor == 1)
            $query = "DELETE FROM si_silos WHERE id = " . $id;
        elseif($borrarPor == 2)
            $query = "DELETE FROM si_silos WHERE id_centro_acopio = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
    
    function cantidadSilosCA($idCA){
        $query = "SELECT COUNT(*) totalSilos
                    FROM si_silos
                    WHERE id_centro_acopio = '$idCA'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function desactivarSI($id=null, $idCA=null, $status) {
        switch ($status){
            case 't':
                $status = 1;
            break;
            case 'f':
                $status = 0;
            break;
        }
        $query = "UPDATE si_silos SET estatus = '$status'";
        $query .= (!empty($id)) ? " WHERE id = '$id'" : "";
        $query .= (!empty($idCA)) ? " WHERE id_centro_acopio = '$idCA'" : "";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>
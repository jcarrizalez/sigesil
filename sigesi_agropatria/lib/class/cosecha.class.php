<?php

class Cosecha extends Model {
    var $table = 'si_cosecha';
    
    function buscarCosechaP($id=null, $idP=null){
        $query = "SELECT co.id_programa, co.nombre AS nombre_cosecha, co.proyectado, co.area_siembra, co.fecha_inicio, co.fecha_fin, cu.nombre AS nombre_cultivo
                    FROM si_cosecha co
                    INNER JOIN si_programa pr ON pr.id = co.id_programa
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND co.id = '$id'" : '';
        $query.=(!empty($idP)) ? " AND pr.id = '$idP'" : '';
        $query.= " ORDER BY pr.numero, co.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
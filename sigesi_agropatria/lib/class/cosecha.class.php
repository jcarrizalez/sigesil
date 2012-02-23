<?php

class Cosecha extends Model {
    var $table = 'si_cosecha';
    
    function buscarCosechaP($id=null, $idP=null, $statusC='t', $statusP='t'){
        $query = "SELECT co.id, co.codigo, co.id_programa, co.nombre AS nombre_cosecha, co.proyectado, co.area_siembra, co.fecha_inicio, co.fecha_fin, cu.nombre AS nombre_cultivo
                    FROM si_cosecha co
                    INNER JOIN si_programa pr ON pr.id = co.id_programa
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND co.id = '$id'" : '';
        $query.=(!empty($statusC)) ? " AND co.estatus = '$statusC'" : '';
        $query.=(!empty($statusP)) ? " AND pr.estatus = '$statusP'" : '';
        $query.=(!empty($idP)) ? " AND pr.id = '$idP'" : '';
        $query.= " ORDER BY pr.creado, co.creado";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function infoCosechaCultivo($idCA=null, $idCo=null, $idP=null, $idCu=null, $codigoCo=null, $codigoP=null, $codigoCu=null, $stausCo='t', $statusP='t'){
        $query = "SELECT pr.id AS programa_id, pr.id_centro_acopio, pr.codigo AS programa_codigo, pr.nombre AS programa_nombre,
                    co.id AS cosecha_id, co.codigo AS cosecha_codigo, co.nombre AS cosecha_nombre, co.proyectado, co.area_siembra, co.fecha_inicio, co.fecha_fin,
                    cu.id AS cultivo_id, cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre
                    FROM si_cosecha co
                    INNER JOIN si_programa pr ON pr.id = co.id_programa
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    WHERE '1'";
        
        $query.=(!empty($idCo)) ? " AND pr.id_centro_acopio = '$idCA'" : '';
        $query.=(!empty($idCo)) ? " AND co.id = '$idCo'" : '';
        $query.=(!empty($idP)) ? " AND pr.id = '$idP'" : '';
        $query.=(!empty($idCu)) ? " AND cu.id = '$idCu'" : '';
        $query.=(!empty($codigoCo)) ? " AND co.codigo = '$codigoCo'" : '';
        $query.=(!empty($codigoP)) ? " AND pr.codigo = '$codigoP'" : '';
        $query.=(!empty($codigoCu)) ? " AND cu.codigo = '$codigoCu'" : '';
        $query.=(!empty($stausCo)) ? " AND co.estatus = '$stausCo'" : '';
        $query.=(!empty($statusP)) ? " AND pr.estatus = '$statusP'" : '';
        $query .= " ORDER BY pr.creado, co.creado";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
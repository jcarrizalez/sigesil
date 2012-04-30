<?php

class Cosecha extends Model {
    var $table = 'si_cosecha';
    
    function buscarCosechaP($id=null, $idP=null, $statusC=null, $statusP=null){
        $query = "SELECT co.id, co.codigo, co.id_programa, co.nombre AS nombre_cosecha, co.proyectado, co.area_siembra, co.estatus, co.fecha_inicio, co.fecha_fin, cu.nombre AS nombre_cultivo
                    FROM si_cosecha co
                    INNER JOIN si_programa pr ON pr.id = co.id_programa
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND co.id = '$id'" : '';
        $query.=(!empty($statusC)) ? " AND co.estatus = '$statusC'" : '';
        $query.=(!empty($statusP)) ? " AND pr.estatus = '$statusP'" : '';
        $query.=(!empty($idP)) ? " AND pr.id = '$idP'" : '';
        $query.= " ORDER BY pr.id, co.id";
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
        $query .= " ORDER BY pr.id, co.codigo";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function buscarCosechaProductor($idCo, $cedP = null, $cedAon = null, $cedAdo = null){
        $query = "SELECT  p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, 
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, 
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado
                    FROM si_productor p
                    INNER JOIN si_cosecha_productor cp ON cp.id_productor = p.id
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado
                    WHERE '1' AND cp.id_cosecha = '$idCo'";
        $query .= (!empty($cedP)) ? " AND p.ced_rif = '$cedP'" : "";
        $query .= (!empty($cedAon)) ? " AND p2.ced_rif = '$cedAon'" : "";
        $query .= (!empty($cedAdo)) ? " AND p3.ced_rif = '$cedAdo'" : "";
        $query .= " ORDER BY p2.nombre, p3.nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function asignarCosechaProductor($idCo, $cedP = null, $cedAon = null){
        $query = "SELECT  p.id AS id_productor, p.ced_rif AS ced_productor, p.nombre AS productor, 
                    p2.id AS id_asociacion, p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion, 
                    p3.id AS id_asociado, p3.ced_rif AS ced_asociado, p3.nombre AS asociado
                    FROM si_productor p
                    LEFT JOIN si_cosecha_productor cp ON cp.id_productor = p.id
                    LEFT JOIN si_productor p2 ON p2.id = cp.id_asociacion
                    LEFT JOIN si_productor p3 ON p3.id = cp.id_asociado
                    WHERE '1' AND cp.id_cosecha = '$idCo'";
        $query .= (!empty($cedP)) ? " AND p.ced_rif = '$cedP'" : "";
        $query .= (!empty($cedAon)) ? " AND p2.ced_rif = '$cedAon'" : "";
        $query .=" OR NOT EXISTS (SELECT cp2.id_asociacion FROM si_cosecha_productor cp2 WHERE cp2.id_cosecha = '$idCo' AND (cp2.id_productor = p.id OR cp2.id_asociacion = p.id OR cp2.id_asociado = p.id))";
        $query .= " ORDER BY p.ced_rif, p2.ced_rif, p3.ced_rif";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function guardarCosechaProductor($idCo, $idCa, $idPr, $idAson, $idAdo, $idRec){
        $query = "SELECT * 
                    FROM si_cosecha_productor 
                    WHERE id_cosecha = '$idCo' AND id_centro_acopio = '$idCa' 
                    AND id_productor = '$idPr' AND id_asociacion = '$idAson' AND id_asociado = '$idAdo' AND id_recepcion = '$idRec'";
        $existe = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
        
        if(empty($existe)){
            $query = "INSERT INTO si_cosecha_productor (id_cosecha, id_centro_acopio, id_productor, id_asociacion, id_asociado, id_recepcion)
                        VALUES ('$idCo', '$idCa', '$idPr', '$aso', '$idRec')";
            $result = $this->_SQL_tool('INSERT', __METHOD__, $query);
            return $result;
        }/*else{
            $query = "UPDATE si_cosecha_productor SET VALUES id_productor = '$idPr'
                        AND id_asociacion = '$idAson' AND id_asociado = '$idAdo'";
            $result = $this->_SQL_tool('UPDATE', __METHOD__, $query);
            return $result;
        }*/
    }
}
?>
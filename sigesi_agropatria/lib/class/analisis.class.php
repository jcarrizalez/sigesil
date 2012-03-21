<?php
class Analisis extends Model {
    var $table = 'si_analisis';
    
    function guardarResultados($data)
    {
        $query = "INSERT INTO si_analisis_resultado (";
        foreach ($data as $campo => $valor) {
            $query .= $campo . ", ";
        }
        $query = substr($query, 0, -2) . ") VALUES (";
        foreach ($data as $campo => $valor) {
            $query .= "'$valor', ";
        }
        $query = substr($query, 0, -2) . ")";
        $id = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $this->id = $id;
    }
    
    function listadoResultados($id_recepcion, $id_analisis=null) {
        $query = "SELECT id_recepcion, id_analisis, muestra1, muestra2, muestra3
                    FROM si_analisis_resultado WHERE '1' ";
        $query .= (!empty($id_recepcion)) ? " AND id_recepcion = '$id_recepcion'" : "";
        $query .= (!empty($id_analisis)) ? " AND id_analisis = '$id_analisis'" : "";
        $query .= "ORDER BY id_recepcion";
        $id = $this->_SQL_tool('SELECT', __METHOD__, $query);
        return $this->id = $id;
    }
    
    function listaAnalisis($idA='', $tipo='', $nombre='', $codigo='', $estatus='', $formula=''){
        $query = "SELECT * FROM si_analisis WHERE '1'";
        $query .= (!empty($idA)) ? " AND id = '$idA'" : "";
        $query .= (!empty($tipo)) ? " AND tipo_analisis = '$tipo'" : "";
        $query .= (!empty($nombre)) ? " AND nombre ILIKE '%$nombre%'" : "";
        $query .= (!empty($codigo)) ? " AND codigo = '$codigo'" : "";
        $query .= (!empty($estatus)) ? " AND estatus = '$estatus'" : "";
        $query .= (!empty($formula)) ? " AND formula = '$formula'" : "";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
    
    function buscarAC($id=null, $IdCultivo=null, $idCA=null) { 
    $query = "SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analisis,
                ac.min_rec, ac.max_rec , ac.estatus 
                FROM si_analisis_cultivo ac 
                INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org
                WHERE '1'";
    $query .= (!empty($id)) ? " AND a.id = '$Id'" : "";        
    $query .= (!empty($IdCultivo)) ? " AND ac.id_cultivo = '$IdCultivo'" : "";
    $query .= (!empty($IdCA)) ? " AND ac.id_centro_acopio = '$IdCA'" : "";
    $query .= " ORDER BY cast(a.codigo as int)";
    return $this->_SQL_tool($this->SELECT, __METHOD__, $query); 
    }
    
//    function listadoRecepcion($idCA=null, $id_recepcion=null) {
//        $query = "SELECT a.codigo, a.nombre as nombre_ana, ar.id_analisis,
//                    a.tipo_analisis, ar.muestra1, ar.muestra2, ar.muestra2,
//                    ca.codigo as codigo_ca, ca.nombre as nombre_ca FROM
//                    si_analisis_resultado ar 
//                    INNER JOIN si_centro_acopio ca ON ar.id_centro_acopio=ca.id
//                    INNER JOIN si_analisis a
//                    ON (ar.id_centro_acopio=a.id_centro_acopio) AND (ar.id_analisis=a.id)                                        
//                    WHERE tipo_mov='R'";                    
//        $query .= (!empty($id_recepcion)) ? " AND ar.id = '$$id_recepcion'" : "";
//        $query .= (!empty($idCA)) ? " AND ar.id_centro_acopio = '$idCA'" : "";
//        $query .= "ORDER BY ar.id_recepcion";
//        return $this->_SQL_tool('SELECT', __METHOD__, $query);
//    }
}
?>

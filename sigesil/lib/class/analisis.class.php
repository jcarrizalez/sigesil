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
    
    function listadoResultados($id_recepcion=null, $id_despacho=null, $id_analisis=null, $codigo=null, $lab=null) {
        $query = "SELECT a.codigo, a.tipo_analisis, ar.id_recepcion, ar.id_analisis, ar.muestra1, ar.muestra2, ar.muestra3
            FROM si_analisis_resultado ar 
            INNER JOIN si_analisis a ON (ar.id_analisis=a.id) WHERE '1' ";
        $query .= (!empty($id_recepcion)) ? " AND ar.id_recepcion = '$id_recepcion'" : "";
        $query .= (!empty($id_despacho)) ? " AND ar.id_despacho = '$id_despacho'" : "";
        $query .= (!empty($id_analisis)) ? " AND a.id IN ($id_analisis)" : "";
        $query .= (!empty($codigo)) ? " AND a.codigo::int IN ($codigo)" : "";
        $query .= (!empty($lab)) ? " AND ar.lab IN ($lab)" : "";
        $query .= " ORDER BY cast(a.codigo as int)";
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
        $query .= "ORDER BY codigo";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
    
    function buscarAC($id=null, $IdCultivo=null, $idCA=null, $laboratorio=null) {
    $query = "SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analisis,
                ac.min_rec, ac.max_rec, ac.min_des, ac.max_des, ac.estatus 
                FROM si_analisis_cultivo ac 
                INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org
                WHERE '1'";
    $query .= (!empty($id)) ? " AND a.id = '$id'" : "";        
    $query .= (!empty($IdCultivo)) ? " AND ac.id_cultivo = '$IdCultivo'" : "";
    $query .= (!empty($idCA)) ? " AND ac.id_centro_acopio = '$idCA'" : "";
    $query .= (!empty($laboratorio)) ? " AND ac.laboratorio IN ($laboratorio)" : "";    
    $query .= " ORDER BY cast(a.codigo as int)";
    return $this->_SQL_tool($this->SELECT, __METHOD__, $query); 
    }
    
    function borrarResultados($idRecepcion=null, $idDespacho=null)
    {
        $query = "DELETE FROM si_analisis_resultado WHERE '1'";
        $query .= (!empty($idRecepcion)) ? " AND id_recepcion = '$idRecepcion'" : "";
        $query .= (!empty($idDespacho)) ? " AND id_despacho = '$idDespacho'" : "";
        return $this->_SQL_tool('DELETE', __METHOD__, $query);
    }
    
}
?>

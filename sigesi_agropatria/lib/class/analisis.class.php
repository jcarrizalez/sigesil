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
        $id = $this->_SQL_tool('SELECT', __METHOD__, $query);
        return $this->id = $id;
    }
    
    function listaAnalisis($idA='', $tipo='', $nombre='', $codigo='', $estatus='', $formula=''){
        $query = "SELECT * FROM si_analisis WHERE '1'";
        $query .= (!empty($idA)) ? " AND id = '$idA'" : "";
        $query .= (!empty($tipo)) ? " AND tipo_analisis = '$tipo'" : "";
        $query .= (!empty($nombre)) ? " AND nombre LIKE '%$nombre%'" : "";
        $query .= (!empty($codigo)) ? " AND codigo = '$codigo'" : "";
        $query .= (!empty($estatus)) ? " AND estatus = '$estatus'" : "";
        $query .= (!empty($formula)) ? " AND formula = '$formula'" : "";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
}
?>

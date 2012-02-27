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
}
?>

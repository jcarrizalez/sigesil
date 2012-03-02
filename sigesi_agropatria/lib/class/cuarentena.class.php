<?php
class Cuarentena extends Model {
    var $table = 'si_cuarentena';
    
    function guardar($data)
    {
        $query = "INSERT INTO si_cuarentena (";
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

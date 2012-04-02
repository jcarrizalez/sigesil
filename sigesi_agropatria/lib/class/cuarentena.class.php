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
    function guardarPlaga($data)
    {
        $query = "INSERT INTO si_cuarentena_plaga (";
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
    
    function listadoPlaga($idCA=null,$idCtna=null, $idRec=null) { 
        $query="SELECT cp.id_cuarentena,
                cp.id_plaga,
                cp.cantidad,
                p.nombre as nombre_plaga 
                FROM si_cuarentena_plaga cp 
                INNER JOIN si_cuarentena c
                ON c.id=cp.id_cuarentena
                INNER JOIN si_plaga p
                ON p.id=cp.id_plaga 
                WHERE '1'";
        $query .= (!empty($idCA)) ? " AND c.id_centro_acopio = '$idCA'" : "";
        $query .= (!empty($idCtna)) ? " AND c.id = '$idCtna'" : "";
        $query .= (!empty($idRec)) ? " AND c.id_recepcion = '$idRec'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }       
}
?>

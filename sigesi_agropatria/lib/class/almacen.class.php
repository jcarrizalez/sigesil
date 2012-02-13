<?php

class Almacen extends Model {
    var $table = 'si_almacenes';
    
    function desactivarAL($id=null, $idCA=null, $status) {
        $query = "UPDATE si_almacenes SET estatus = '$status'";
        $query .= (!empty($id)) ? " WHERE id = '$id'" : "";
        $query .= (!empty($idCA)) ? " WHERE id_centro_acopio = '$idCA'" : "";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
}
?>
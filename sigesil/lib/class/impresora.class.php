<?php

class Impresora extends Model {
    var $table = 'si_impresora';
    
    function buscarImpresora($id = null, $idCa = null, $status = null, $nombre = null){
        $query = "SELECT * FROM si_impresora WHERE '1'";
        $query .= (!empty($id)) ? " AND id = '$id'" : "";
        $query .= (!empty($idCa)) ? " AND id_centro_acopio = '$idCa'" : "";
        $query .= (!empty($status)) ? " AND estatus IN ($status)" : "";
        $query .= (!empty($nombre)) ? " AND nombre LIKE '%$nombre%'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
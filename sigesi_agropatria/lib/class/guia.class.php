<?php

class Guia extends Model {
    var $table = 'si_guiarec';
    
    function guardarSubGuias($idGuia, $subGuia, $fecha, $descripcion = null){
        $query = "INSERT INTO si_guiarec_det (id_guiarec, subguia, fecha, descripcion)
                    VALUES ('$idGuia', '$subGuia', '$fecha', '$descripcion')";
        $id = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $id;
    }
    
    function buscarSubGuias($idGuia = null, $subGuia = null){
        $query = "SELECT * FROM si_guiarec_det WHERE '1'";
        $query .= (!empty($idGuia)) ? " AND id_guiarec = '$idGuia'" : "";
        $query .= (!empty($subGuia)) ? " AND id = '$subGuia'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
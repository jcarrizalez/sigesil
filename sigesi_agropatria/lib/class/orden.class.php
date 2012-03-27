<?php

class Orden extends Model {
    var $table = 'si_ordenes';
    
    function ordenCliente($id = null, $numero = null){
        $query = "SELECT o.*, c.ced_rif, c.nombre AS cliente_nombre, c.telefono AS cliente_telefono
                    FROM si_ordenes o
                    INNER JOIN si_cliente c ON c.id = o.id_cliente
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND o.id = '$id'" : "";
        $query .= (!empty($numero)) ? " AND o.numero_orden = '$numero'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function guardarSubOrden($idOrden, $subOrden, $fecha=null, $descripcion = null, $kgs = null){
        $query = "INSERT INTO si_ordenes_det (id_orden, numero_orden, fecha, descripcion, kilogramos)
                    VALUES ('$idOrden', '$subOrden', '$fecha', '$descripcion', '$kgs')";
        $id = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $id;
    }
}
?>
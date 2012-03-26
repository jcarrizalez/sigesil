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
}
?>
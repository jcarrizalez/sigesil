<?php

class Vehiculo extends Model {
    var $table = 'si_vehiculos';
    
    function buscar($Placa) {
        $query = "SELECT id, placa, marca, color, capacidad, tara_aprox, chuto, placa_remolques ";
        $query .= " FROM si_vehiculos v WHERE '1'";
        $query .= (!empty($Placa)) ? " AND v.placa ilike '$Placa'" : '';        
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

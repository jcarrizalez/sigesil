<?php

class Formulas extends Model {

    var $table = 'si_formulas';

    function listaFormulas($idCa = ''){
        $query = "SELECT * FROM si_formulas WHERE '1' ";
        $query .= (!empty($idCa)) ? " AND id_centro_acopio = '$idCa' " : '';
        $query .= " ORDER BY id";
        $this->listaF = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}

?>

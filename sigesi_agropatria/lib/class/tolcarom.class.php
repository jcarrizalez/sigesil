<?php

class Tolcarom extends Model {
    var $table = 'si_tolcarom';
    
    function listaTolcarom($idCA=null, $tipo=null){
        $query = "SELECT * FROM si_tolcarom WHERE '1'";
        $query.=(!empty($idCA)) ? " AND id_centro_acopio = '$idCA'" : '';
        $query.=(!empty($tipo)) ? " AND tipo IN ($tipo)" : '';
        $query .= " ORDER BY tipo";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
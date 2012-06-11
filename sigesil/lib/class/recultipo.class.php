<?php

class Recultipo extends Model {    
    var $table = "si_recepcion_cultivo_tipo";
    
    function borrar($idRecepcion)
    {
        $query = "DELETE FROM si_recepcion_cultivo_tipo WHERE '1'";
        $query .= (!empty($idRecepcion)) ? " AND id = '$idRecepcion'" : "";
        return $this->_SQL_tool('DELETE', __METHOD__, $query);
    }
}
?>

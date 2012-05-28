<?php
    class CuarentenaPlaga extends Model {
        var $table = 'si_cuarentena_plaga';

        function borrar($idRecepcion)
        {
            $query = "DELETE FROM si_cuarentena_plaga WHERE '1'";
            $query .= (!empty($idRecepcion)) ? " AND id = '$idRecepcion'" : "";
            return $this->_SQL_tool('DELETE', __METHOD__, $query);
        }
    }
?>

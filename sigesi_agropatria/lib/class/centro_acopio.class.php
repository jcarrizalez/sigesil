<?php

class CentroAcopio extends Model {
    var $table = 'si_centro_acopio';
    
    function eliminarCA($id) {
        $query = "DELETE FROM si_centro_acopio where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>

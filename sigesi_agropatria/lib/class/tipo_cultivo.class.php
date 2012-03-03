<?php

class TipoCultivo extends Model {
    var $table = 'si_cultivo_tipo';
    
    function eliminarTipoCultivo($id){
        $query = "DELETE FROM si_cultivo_tipo where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>
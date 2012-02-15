<?php

class Cultivo extends Model {
    var $table = 'si_cultivo';
    
    /*function buscarCultivo($id=null, $nombre=null, $tipo=null){
        $query = "SELECT cul.*
                    FROM si_cultivo cul
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND cul.id = $id" : '';
        $query.=(!empty($nombre)) ? " AND cul.nombre LIKE '%$nombre%'" : '';
        $query.=(!empty($tipo)) ? " AND cul.id_tipo_cultivo = $tipo" : '';
        $query.= " ORDER BY cul.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }*/
    
    function eliminarCultivo($id) {
        $query = "DELETE FROM si_cultivo where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
}
?>
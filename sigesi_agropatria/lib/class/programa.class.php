<?php

class Programa extends Model {
    var $table = 'si_programa';
    
    function desactivarPr($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function buscarProgramaCA($id=null, $idCA=null, $cod=null, $condicion=null){
        $query = "SELECT ca.nombre AS ca_nombre, pro.*
                    FROM si_programa pro
                    INNER JOIN si_centro_acopio ca ON ca.id = pro.id_centro_acopio
                    WHERE '1' AND pro.estatus = 't'";
        $query.=(!empty($id)) ? " AND pro.id = '$id'" : '';
        $query.=(!empty($idCA)) ? " AND pro.id_centro_acopio = '$idCA'" : '';
        $query.=(!empty($cod)) ? " AND pro.codigo = '$cod'" : '';
        $query.=(!empty($condicion)) ? $condicion : '';
        $query.= " ORDER BY ca.codigo, pro.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function cantidadProgramasCA($idCA){
        $query = "SELECT Count(*) AS total FROM si_programa WHERE id_centro_acopio = '$idCA'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

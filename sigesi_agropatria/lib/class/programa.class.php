<?php

class Programa extends Model {
    var $table = 'si_programa';
    
    function eliminarPrograma($id) {
        $query = "DELETE FROM si_programa where id = " . $id;
        $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
    }
    
    function buscarProgramaCA($id=null, $idCA=null){
        $query = "SELECT ca.nombre AS ca_nombre, pro.*
                    FROM si_programa pro
                    INNER JOIN si_centro_acopio ca ON ca.id = pro.id_centro_acopio
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND pro.id = $id" : '';
        $query.=(!empty($idCA)) ? " AND pro.id_centro_acopio = $idCA" : '';
        $query.= " ORDER BY pro.numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function cantidadProgramasCA($idCA){
        $query = "SELECT Count(*) AS total FROM si_programa WHERE id_centro_acopio = '$idCA'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

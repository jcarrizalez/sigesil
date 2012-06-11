<?php

class Programa extends Model {
    var $table = 'si_programa';
    
    function desactivarPr($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = now() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function buscarProgramaCA($id=null, $idCA=null, $cod=null, $condicion=null, $estatus=null, $nombre=null, $porPagina=null, $inicio=null){
        $query = "SELECT ca.codigo AS ca_codigo, ca.nombre AS ca_nombre, pro.*, cu.codigo AS cu_codigo, cu.nombre AS cu_nombre
                    FROM si_programa pro
                    INNER JOIN si_centro_acopio ca ON ca.id = pro.id_centro_acopio
                    INNER JOIN si_cultivo cu ON cu.id = pro.id_cultivo
                    WHERE '1'";
        $query.=(!empty($id)) ? " AND pro.id = '$id'" : '';
        $query.=(!empty($idCA)) ? " AND pro.id_centro_acopio = '$idCA'" : '';
        $query.=(!empty($cod)) ? " AND pro.codigo = '$cod'" : '';
        $query.=(!empty($condicion)) ? $condicion : '';
        $query.=(!empty($estatus)) ? " AND pro.estatus = '$estatus'" : '';
        $query.=(!empty($nombre)) ? " AND pro.nombre ILIKE '%$nombre%'" : '';
        $query.= " ORDER BY ca.codigo, pro.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function cantidadProgramasCA($idCA){
        $query = "SELECT Count(*) AS total FROM si_programa WHERE id_centro_acopio = '$idCA'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

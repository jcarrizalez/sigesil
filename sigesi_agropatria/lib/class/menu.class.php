<?php

class Menu extends Model {
    var $table = 'si_menu';
    
    function menuPorUsuario($idUsuario=null, $idPadre=0){
        $query = "SELECT mp.*
                    FROM si_menu mp
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id
                    WHERE mh.id_usuario = '$idUsuario' AND mp.estatus = 't'";
        $query .= ($idPadre != 0) ? " AND mp.id_padre = '$idPadre'" : " AND mp.id_padre = '0'";
        $query .= " ORDER BY mp.id_padre, mp.orden";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
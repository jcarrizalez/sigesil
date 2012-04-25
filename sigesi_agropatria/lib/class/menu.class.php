<?php

class Menu extends Model {
    var $table = 'si_menu';
    
    function menuPorUsuario($idPerfil, $idUsuario = null, $idPadre = null){
        $query = "SELECT mp.*
                    FROM si_menu mp
                    INNER JOIN si_menu_usuario mh ON mh.id_menu = mp.id
                    WHERE mh.id_usuario = '$idUsuario' AND mh.id_perfil = '$idPerfil' AND mp.estatus = 't'";
        $query .= (!is_null($idPadre)) ? " AND mp.id_padre = '$idPadre'" : "";
        $query .= " ORDER BY mp.id_padre, mp.orden";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function asignarMenuUsuario($idM, $idU, $idP){
        $query = "INSERT INTO si_menu_usuario (id_menu, id_usuario, id_perfil)
                    VALUES ('$idM', '$idU', '$idP')";
        $result = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $result;
    }
    
    function eliminarMenuUsuario($idU, $idP){
        $query = "DELETE FROM si_menu_usuario WHERE id_usuario = '$idU' AND id_perfil = '$idP'";
        $this->_SQL_tool($this->DELETE, __METHOD__, $query);
    }
    
    function accionesPagina($idUsuario, $menu){
        $query = "SELECT mu.nuevo, mu.modificar, mu.eliminar, mu.imprimir
                    FROM si_menu_usuario mu
                    INNER JOIN si_menu m ON m.id = mu.id_menu
                    WHERE '1' AND mu.id_usuario = '$idUsuario' AND m.url ILIKE '%$menu%'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
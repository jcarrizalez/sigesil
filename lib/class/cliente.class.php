<?php

class Cliente extends Model {
    var $table = 'si_cliente';
    
    function listadoClientes($id=null, $idOrg=null, $cedrif=null, $nombre=null, $idE=null, $idM=null, $porPagina=null, $inicio=null){
        $query = "SELECT c.id, c.*, pa.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                FROM si_cliente c
                INNER JOIN si_organizacion o ON c.id_org = o.id
                LEFT JOIN si_pais pa ON pa.id = c.id_pais
                LEFT JOIN si_estado e ON e.id = c.id_estado
                LEFT JOIN si_municipio m ON m.id = c.id_municipio
                    WHERE '1' AND c.estatus = 't'";
        $query.=(!empty($id)) ? " AND c.id = '$id'" : '';
        $query.=(!empty($idOrg)) ? " AND c.id_org = '$idOrg'" : '';
        $query.=(!empty($cedrif)) ? " AND c.ced_rif ILIKE '%$cedrif%'" : '';
        $query.=(!empty($nombre)) ? " AND c.nombre ILIKE '%$nombre%'" : '';
        $query.=(!empty($idE)) ? " AND e.id = '$idE'" : '';
        $query.=(!empty($idM)) ? " AND m.id = '$idM'" : '';
        $query.= " ORDER BY c.nombre";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
}
?>

<?php

class Contrato extends Model {
    var $table = 'si_contrato';
    
    function buscarContrato($id=null, $idCa=null, $idCo=null, $nroCon=null, $ced=null, $porPagina=null, $inicio=null){
        $query = "SELECT c.*, p.ced_rif, p.nombre, '('||ca.codigo||') '||ca.nombre as nombre_ca, '('||co.codigo||') '||co.nombre as nombre_co
                    FROM si_contrato c
                    INNER JOIN si_centro_acopio ca ON ca.id = c.id_centro_acopio
                    INNER JOIN si_cosecha co ON co.id = c.id_cosecha
                    INNER JOIN si_productor p ON p.id = c.id_productor
                    WHERE '1'";
        $query .= (!empty($idCa)) ? " AND ca.id = '$idCa'" : "";
        $query .= (!empty($idCo)) ? " AND co.id = '$idCo'" : "";
        $query .= (!empty($nroCon)) ? " AND c.nro_contrato ILIKE '%$nroCon%'" : "";
        $query .= (!empty($ced)) ? " AND p.ced_rif = '$ced'" : "";
        $query .= " ORDER BY ca.codigo, co.codigo, co.id, p.ced_rif";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>
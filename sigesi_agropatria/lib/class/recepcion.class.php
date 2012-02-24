<?php

class Recepcion extends Model {

    var $table = 'si_recepcion';

    function recepcionesDia($idCA, $idCo) {
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' AND id_cosecha = '$idCo' AND fecha_recepcion = '" . date('Y-m-d') . "'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    //la funcion listadoAnalisis  busca los analisis por registrar

    function listadoAnalisis($idORG = null, $idCA = null, $idCo = null, $idRec = null, $estatus = null) {
        $query = "select  o.id as id_org,
                    o.nombre as nombre_org,
                    ca.id as id_ca,
                    ca.codigo as codigo_ca, 
                    ca.nombre as nombre_ca,
                    cul.id as id_cultivo,
                    cul.codigo as codigo_cul,
                    cul.nombre as nombre_cul,  
                    rec.id as id_rec,
                    rec.numero,
                    rec.estatus_rec,
                    rec.fecha_recepcion,
                    rec.cant_muestras
                    from si_recepcion rec 
                    inner join si_centro_acopio ca
                    on rec.id_centro_acopio=ca.id 
                    inner join si_cosecha cos
                    on cos.id=rec.id_cosecha	
                    inner join si_cultivo cul
                    on cul.id=cos.id_cultivo 
                    inner join si_organizacion o
                    on o.id=ca.id_org 
                    WHERE '1'";
        $query .= (!empty($idORG)) ? " AND o.id = '$idORG'" : "";
        $query .= (!empty($idCA)) ? " AND ca.id = '$idCA'" : "";
        $query .= (!empty($idCo)) ? " AND cul.id = '$idCo'" : "";
        $query .= (!empty($idRec)) ? " AND rec.id = '$idRec'" : "";
        $query .= (!empty($estatus)) ? " AND rec.estatus_guia = '$estatus'" : "";
        $query .= " ORDER BY rec.id";        
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function guardarGuia($data) {
        $query = "INSERT INTO si_guiarec (";
        foreach ($data as $campo => $valor) {
            $query .= $campo . ", ";
        }
        $query = substr($query, 0, -2) . ") VALUES (";
        foreach ($data as $campo => $valor) {
            $query .= "'$valor', ";
        }
        $query = substr($query, 0, -2) . ")";
        //$id = $this->_SQL_tool('INSERT', __METHOD__, $query);
        return $this->id = $id;
    }

}

?>
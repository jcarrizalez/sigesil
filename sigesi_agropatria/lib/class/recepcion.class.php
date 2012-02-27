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
        $query = "SELECT o.id AS id_org, o.nombre AS nombre_org, ca.id AS id_ca, ca.codigo AS codigo_ca, ca.nombre AS nombre_ca, cul.id AS id_cultivo, cul.codigo AS codigo_cul, cul.nombre AS nombre_cul, rec.id AS id_rec, rec.numero, rec.estatus_rec, rec.fecha_recepcion, rec.cant_muestras
                    FROM si_recepcion rec 
                    INNER JOIN si_centro_acopio ca ON rec.id_centro_acopio=ca.id 
                    INNER JOIN si_cosecha cos ON cos.id=rec.id_cosecha	
                    INNER JOIN si_cultivo cul ON cul.id=cos.id_cultivo 
                    INNER JOIN si_organizacion o ON o.id=ca.id_org 
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
    
    function productorRecepcion($ced_rif){
        $query = "SELECT pro.ced_rif AS cedula_pro, pro.nombre AS nombre_pro, pro.telefono AS telefono_pro, pro.email AS email_pro
                    FROM si_productor pro
                    WHERE pro.ced_rif = '$ced_rif'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function asociadoRecepcion($ced_rif){
        $query = "SELECT aso.cedula AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso 
                    FROM si_asociado aso
                    WHERE aso.cedula = '$ced_rif'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function buscarChofer($ced){
        $query = "SELECT gui.cedula_chofer, gui.nombre_chofer AS nombre_cho
                    FROM si_guiarec gui
                    WHERE gui.cedula_chofer = '$ced'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}

?>
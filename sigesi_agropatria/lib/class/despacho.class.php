<?php

class Despacho extends Model {
    var $table = 'si_despacho';
    
    function listadoAnalisis($idCA = null, $idCo = null, $idRec = null, $estatus = null) {
        $query = "SELECT ca.id AS id_ca, ca.codigo AS codigo_ca, ca.nombre AS nombre_ca, 
                    cul.id AS id_cultivo, cul.codigo AS codigo_cul, cul.nombre AS nombre_cul,                    
                    des.id AS id_des, des.numero, des.estatus, des.fecha_des, 
                    des.cant_muestras, des.carril 
                    FROM si_despacho des
                    INNER JOIN si_centro_acopio ca ON des.id_centro_acopio=ca.id
                    INNER JOIN si_cosecha cos ON cos.id=des.id_cosecha
                    INNER JOIN si_cultivo cul ON cul.id=cos.id_cultivo
                    WHERE '1'";
        $query .= (!empty($idCA)) ? " AND ca.id = '$idCA'" : "";
        $query .= (!empty($idCo)) ? " AND cul.id = '$idCo'" : "";
        $query .= (!empty($idRec)) ? " AND des.id = '$idRec'" : "";
        $query .= (!empty($estatus)) ? " AND des.estatus = '$estatus'" : "";
        $query .= " ORDER BY ca.codigo, cos.id, cul.id, des.fecha_des, des.numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function listadoDespacho($idCA=null, $idCo=null, $idSilo=null, $salidaNum=null, $estatus=null){
        $query = "SELECT d.*, ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, co.codigo AS cosecha_codigo 
                    FROM si_despacho d
                    INNER JOIN si_centro_acopio ca ON ca.id = d.id_centro_acopio
                    INNER JOIN si_cosecha co ON co.id = d.id_cosecha
                    INNER JOIN si_silos s ON s.id = d.id_silo
                    WHERE '1'";
        $query .= (!empty($idCa)) ? " AND d.id_centro_acopio = '$idCa'" : '';
        $query .= (!empty($$idCo)) ? " AND d.id_cosecha = '$$idCo'" : '';
        $query .= (!empty($idSilo)) ? " AND d.id_silo = '$idSilo'" : '';
        $query .= (!empty($salidaNum)) ? " AND d.numero = '$entradaNum'" : '';
        $query .= (!empty($estatus)) ? " AND d.estatus_rec IN ($estatus)" : '';
        $query .= " ORDER BY d.fecha_des, d.numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function despachosDia($idCA, $idCo) {
        $query = "SELECT COUNT(*) AS total
                FROM si_despacho
                WHERE id_centro_acopio = '$idCA' AND id_cosecha = '$idCo' AND 
                fecha_des BETWEEN '".date('Y-m-d 00:00:00')."' AND '".date('Y-m-d 23:59:59')."'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

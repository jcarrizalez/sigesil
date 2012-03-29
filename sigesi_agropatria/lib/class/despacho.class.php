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
    
    function listadoDespacho($id=null, $idCA=null, $idCo=null, $idSilo=null, $salidaNum=null, $estatus=null){
        $query = "SELECT d.*, 
                    d.fecha_des AS fecha_recepcion, d.estatus AS estatus_rec,
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = d.romana_ent) AS romana_ent, 
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = d.romana_sal) AS romana_sal, 
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, 
                    co.codigo AS cosecha_codigo, 
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,
                    o.numero_orden AS numero_guia, 
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre, 
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques 
                    FROM si_despacho d
                    INNER JOIN si_centro_acopio ca ON ca.id = d.id_centro_acopio
                    INNER JOIN si_cosecha co ON co.id = d.id_cosecha
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    INNER JOIN si_silos s ON s.id = d.id_silo
                    INNER JOIN si_ordenes o ON o.id = d.id_orden
                    INNER JOIN si_choferes ch ON ch.id = d.id_chofer
                    INNER JOIN si_vehiculos v ON v.id = d.id_vehiculo
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND d.id = '$id'" : '';
        $query .= (!empty($idCa)) ? " AND d.id_centro_acopio = '$idCa'" : '';
        $query .= (!empty($idCo)) ? " AND d.id_cosecha = '$idCo'" : '';
        $query .= (!empty($idSilo)) ? " AND d.id_silo = '$idSilo'" : '';
        $query .= (!empty($salidaNum)) ? " AND d.numero = '$entradaNum'" : '';
        $query .= (!empty($estatus)) ? " AND d.estatus IN ($estatus)" : '';
        $query .= " ORDER BY d.fecha_des, d.numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function despachosDia($idCA) {
        $query = "SELECT COUNT(*) AS total
                FROM si_despacho
                WHERE id_centro_acopio = '$idCA' 
                AND fecha_des BETWEEN '".date('Y-m-d 00:00:00')."' AND '".date('Y-m-d 23:59:59')."'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}
?>

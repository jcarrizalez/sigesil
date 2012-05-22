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
    
    function listadoDespacho($id=null, $idCa=null, $idCu=null, $idSilo=null, $salidaNum=null, $estatus=null, $fdesde=null, $fhasta=null, $porPagina=null, $inicio=null, $numeroOrden=null, $orden=null, $cliente=null, $placa=null, $fliqD=null, $fliqH=null, $fdesD=null, $fdesH=null){
        $query = "SELECT d.*, 
                    d.fecha_des AS fecha_recepcion, d.estatus AS estatus_rec, 
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = d.romana_ent) AS romana_ent, 
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = d.romana_sal) AS romana_sal, 
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, 
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre, 
                    o.numero_orden AS numero_guia, 
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre, 
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques, 
                    cl.ced_rif AS ced_cliente, cl.nombre AS cliente_nombre, 
                    pe.nombre AS pto_entrega 
                    FROM si_despacho d 
                    INNER JOIN si_centro_acopio ca ON ca.id = d.id_centro_acopio 
                    INNER JOIN si_cultivo cu ON cu.id = d.id_cultivo 
                    INNER JOIN si_silos s ON s.id = d.id_silo 
                    INNER JOIN si_ordenes o ON o.id = d.id_orden 
                    INNER JOIN si_choferes ch ON ch.id = d.id_chofer 
                    INNER JOIN si_vehiculos v ON v.id = d.id_vehiculo 
                    INNER JOIN si_cliente cl ON cl.id = o.id_cliente 
                    LEFT JOIN si_punto_entrega pe ON pe.id = d.id_punto_entrega 
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND d.id = '$id'" : '';
        $query .= (!empty($numeroOrden)) ? " AND o.numero_orden = '$numeroOrden'" : '';
        $query .= (!empty($id)) ? " AND d.id = '$id'" : '';
        $query .= (!empty($idCa)) ? " AND d.id_centro_acopio = '$idCa'" : '';
        $query .= (!empty($idCu)) ? " AND d.id_cultivo = '$idCu'" : '';
        $query .= (!empty($idSilo)) ? " AND d.id_silo = '$idSilo'" : '';
        $query .= (!empty($salidaNum)) ? " AND d.numero = '$salidaNum'" : '';
        $query .= (!empty($estatus)) ? " AND d.estatus IN ($estatus)" : '';
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'$fdesde'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'$fhasta'" : 'now()::date';
            $query .= " AND d.modificado::date BETWEEN $fdesde AND $fhasta";
        }
        $query .= (!empty($orden)) ? $orden : " ORDER BY d.modificado, d.numero";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function despachosReporteGeneral($fdesde=null, $fhasta=null, $idCA=null){
        $query = "SELECT o.numero_orden, o.fecha_emision, '('||c.codigo||') '||c.nombre AS cultivo, cl.ced_rif, cl.nombre AS nombre_cliente
                    FROM si_despacho d
                    INNER JOIN si_cliente cl ON cl.id = d.id_cliente
                    INNER JOIN si_ordenes o ON o.id = d.id_orden
                    INNER JOIN si_cultivo c ON c.id = d.id_cultivo
                    WHERE '1' AND d.estatus = '5'";
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'$fdesde'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'$fhasta'" : 'now()::date';
            $query .= " AND d.modificado::date BETWEEN $fdesde AND $fhasta";
        }
        $query .= (!empty($idCA)) ? " AND d.id_centro_acopio = '$idCA'" : '';
        $query .= " GROUP BY o.numero_orden, c.codigo, c.nombre, cl.ced_rif, cl.nombre, o.fecha_emision 
                    ORDER BY o.numero_orden";
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

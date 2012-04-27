<?php

class Recepcion extends Model {

    var $table = 'si_recepcion';

    function recepcionesDia($idCA) {
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' 
                AND fecha_recepcion BETWEEN '".date('Y-m-d 00:00:00')."' AND '".date('Y-m-d 23:59:59')."'";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function recepcionDetalle($id){
        $query = "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    //la funcion listadoAnalisis  busca los analisis por registrar
    function listadoAnalisis($idCA = null, $idCo = null, $idRec = null, $estatus = null) {
        $query = "SELECT ca.id AS id_ca, ca.codigo AS codigo_ca, ca.nombre AS nombre_ca, 
                    cul.id AS id_cultivo, cul.codigo AS codigo_cul, cul.nombre AS nombre_cul,                    
                    rec.id AS id_rec, rec.numero, rec.estatus_rec, rec.fecha_recepcion, 
                    rec.cant_muestras, rec.carril 
                    FROM si_recepcion rec
                    INNER JOIN si_centro_acopio ca ON rec.id_centro_acopio=ca.id
                    INNER JOIN si_cosecha cos ON cos.id=rec.id_cosecha
                    INNER JOIN si_cultivo cul ON cul.id=cos.id_cultivo
                    WHERE '1'";
        $query .= (!empty($idCA)) ? " AND ca.id = '$idCA'" : "";
        $query .= (!empty($idCo)) ? " AND cul.id = '$idCo'" : "";
        $query .= (!empty($idRec)) ? " AND rec.id = '$idRec'" : "";
        $query .= (!empty($estatus)) ? " AND rec.estatus_rec = '$estatus'" : "";
        $query .= " ORDER BY ca.codigo, cos.id, cul.id, rec.fecha_recepcion, rec.numero";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function buscarChofer($ced) {
        $query = "SELECT gui.cedula_chofer, gui.nombre_chofer AS nombre_cho
                    FROM si_guiarec gui
                    WHERE gui.cedula_chofer = '$ced'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function cambiarEstatus($id, $status) {
        $query = "UPDATE si_recepcion SET estatus_rec = '$status'";
        $query .= (!empty($id)) ? " WHERE id = '$id'" : "";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function listadoRechazo($idRec, $estatus=null, $idCA=null ) {
        $query="select rec.numero,
                    rec.fecha_recepcion,
                    rec.carril,
                    rec.estatus_rec,
                    pro.ced_rif as ced_rif_pro,
                    pro.nombre as nom_pro,
                    aso.ced_rif as ced_rif_aso,
                    aso.nombre as nom_aso,
		    guia.cedula_chofer,      
		    guia.nombre_chofer,                     
		    veh.placa,
                    cul.nombre as nom_cul 
                    from si_recepcion rec                     
                    inner join si_productor pro 
                    on rec.id_productor=pro.id 
                    inner join si_asociado aso
                    on rec.id_productor=pro.id 
                    inner join si_guiarec guia
                    on rec.id_guia=guia.id
                    inner join si_vehiculos veh
                    on rec.id_vehiculo=veh.id
                    inner join si_cosecha cos
                    on rec.id_cosecha=cos.id
                    inner join si_cultivo cul
                    on cos.id_cultivo=cul.id
                    where '1'";        
        $query .= (!empty($idCA)) ? " AND rec.id_centro_acopio = '$idCA'" : "";
        $query .= (!empty($idRec)) ? " AND rec.id= '$idRec'" : "";
        $query .= (!empty($estatus)) ? " AND rec.estatus_rec = '$estatus'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function listadoRecepcion($id=null, $idCa=null, $idCo=null, $idSilo=null, $entradaNum=null, $estatus=null, $fdesde=null, $fhasta=null, $porPagina=null, $inicio=null){
        $query = "SELECT r.*, 
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, 
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, 
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, 
                    co.codigo AS cosecha_codigo, 
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,
                    g.numero_guia,
                    s.codigo AS codigo_silo, s.nombre AS silo_nombre,
                    a.ced_rif AS ced_asociado, a.nombre AS asociado_nombre,
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques
                    FROM si_recepcion r
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    INNER JOIN si_silos s ON s.id = r.id_silo
                    INNER JOIN si_productor p ON p.id = r.id_productor
                    LEFT JOIN si_asociado a ON a.id = r.id_asociado
                    INNER JOIN si_guiarec g ON g.id = r.id_guia
                    INNER JOIN si_choferes ch ON ch.id = r.id_chofer
                    INNER JOIN si_vehiculos v ON v.id = r.id_vehiculo
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND r.id = '$id'" : '';
        $query .= (!empty($idCa)) ? " AND r.id_centro_acopio = '$idCa'" : '';
        $query .= (!empty($idCo)) ? " AND r.id_cosecha = '$idCo'" : '';
        $query .= (!empty($idSilo)) ? " AND r.id_silo = '$idSilo'" : '';
        $query .= (!empty($entradaNum)) ? " AND r.numero = '$entradaNum'" : '';
        $query .= (!empty($estatus)) ? " AND r.estatus_rec IN ($estatus)" : '';
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'".$fdesde." 00:00:00'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'".$fhasta." 23:59:59'" : 'now()::date';
            $query .= " AND d.fecha_recepcion BETWEEN $fdesde AND $fhasta";
        }
        $query .= " ORDER BY r.fecha_recepcion, r.numero";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    function buscar($Num=null, $Fecha=null) {
        $query = "SELECT * FROM si_recepcion r";
        $query .="where '1'";
        $query .= (!empty($Num)) ? " AND r.numero = '$Num'" : '';
        $query .= (!empty($Num)) ? " AND to_char(r.fecha_recepcion, 'yyyy-mm-dd') = '$Fecha'" : '';        
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);    
    }
}

?>
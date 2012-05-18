<?php

class Recepcion extends Model {

    var $table = 'si_recepcion';

    function toneladasPorEje($id=null){
        $query = "SELECT * FROM si_ejes WHERE '1'";
        $query .= (!empty($id)) ? " AND id = '$id'" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function recepcionesDia($idCA) {
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' 
                AND fecha_recepcion BETWEEN '".date('Y-m-d 00:00:00')."' AND '".date('Y-m-d 23:59:59')."'";
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
		    guia.cedula_chofer,      
		    guia.nombre_chofer,                     
		    veh.placa,
                    cul.nombre as nom_cul 
                    from si_recepcion rec                     
                    inner join si_productor pro 
                    on rec.id_productor=pro.id 
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

    function listadoRecepcion($id=null, $idCa=null, $idCo=null, $idSilo=null, $entradaNum=null, $estatus=null, $fdesde=null, $fhasta=null, $porPagina=null, $inicio=null, $idPro=null, $order=null, $contrato=null, $productor=null, $idP=null, $placa=null, $fechaLiq=null, $fechaRec=null, $idAon=null, $guia=null, $idAdo=null){
        $query = "SELECT r.*, 
                    (SELECT t1.nombre FROM si_tolcarom t1 WHERE t1.id = r.romana_ent) AS romana_ent, 
                    (SELECT t2.nombre FROM si_tolcarom t2 WHERE t2.id = r.romana_sal) AS romana_sal, 
                    ca.codigo AS ca_codigo, ca.nombre AS centro_acopio, 
                    pr.id AS id_programa, pr.nombre AS programa, 
                    co.id AS id_co, co.codigo AS cosecha_codigo, co.nombre AS cosecha, 
                    cu.codigo AS cultivo_codigo, cu.nombre AS cultivo_nombre,
                    g.numero_guia, g.contrato, 
                    /*s.codigo AS codigo_silo, s.nombre AS silo_nombre,*/
                    p.ced_rif AS ced_productor, p.nombre AS productor_nombre,
                    p2.ced_rif AS ced_asociacion, p2.nombre AS asociacion_nombre,
                    p3.ced_rif AS ced_asociado, p3.nombre AS asociado_nombre,
                    ch.ced_rif AS ced_chofer, ch.nombre AS chofer_nombre,
                    v.placa, v.marca, v.color, v.capacidad, v.tara_aprox, v.chuto, v.placa_remolques
                    FROM si_recepcion r
                    INNER JOIN si_centro_acopio ca ON ca.id = r.id_centro_acopio
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha
                    INNER JOIN si_programa pr ON pr.id = co.id_programa
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    /*INNER JOIN si_silos s ON s.id = r.id_silo*/
                    INNER JOIN si_productor p ON p.id = r.id_productor
                    LEFT JOIN si_productor p2 ON p2.id = r.id_asociacion
                    LEFT JOIN si_productor p3 ON p3.id = r.id_asociado
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
        $query .= (!empty($idPro)) ? " AND p.id = '$idPro'" : '';
        $query .= (!empty($contrato)) ? " AND g.contrato ILIKE '%$contrato%'" : '';
        $query .= (!empty($productor)) ? " AND p.nombre ILIKE '%$productor%'" : '';
        $query .= (!empty($idP)) ? " AND pr.id = '$idP'" : '';
        $query .= (!empty($idAon)) ? " AND r.id_asociacion = '$idAon'" : '';
        $query .= (!empty($idAdo)) ? " AND r.id_asociado = '$idAdo'" : '';
        $query .= (!empty($guia)) ? " AND g.numero_guia::text ILIKE '%$guia%'" : '';
        $query .= (!empty($placa)) ? " AND v.placa ILIKE '%$placa%'" : '';
        $query .= (!empty($placaR)) ? " AND v.placa_remolques ILIKE '%$placaR%'" : '';
        $query .= (!empty($fechaLiq)) ? " AND r.fecha_v::date = '$fechaLiq'" : '';
        $query .= (!empty($fechaRec)) ? " AND r.fecha_recepcion::date = '$fechaRec'" : '';
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'".$fdesde." 00:00:00'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'".$fhasta." 23:59:59'" : 'now()::date';
            $query .= " AND r.modificado BETWEEN $fdesde AND $fhasta";
        }
        $query .= (!empty($order)) ? $order : " ORDER BY r.modificado, r.numero";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function recepcionPdf($fdesde=null, $fhasta=null, $estatus=null, $idCo=null, $idPro=null, $idAon=null, $idCa=null, $idAdo=null) {
if(isset($idAdo) and $idAdo=='asociado')
        $query = "SELECT id_productor, id_asociacion, id_asociado FROM si_recepcion WHERE '1'";
else if(isset($idAdo) and $idAdo=='productor')
        $query = "SELECT id_productor FROM si_recepcion WHERE '1'";
else
        $query = "SELECT id_productor, id_asociacion FROM si_recepcion WHERE '1'";
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'".$fdesde." 00:00:00'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'".$fhasta." 23:59:59'" : 'now()::date';
            $query .= " AND modificado BETWEEN $fdesde AND $fhasta";
        }
        $query .= (!empty($estatus)) ? " AND estatus_rec = '$estatus'" : '';
        $query .= (!empty($idCo)) ? " AND id_cosecha = '$idCo'" : '';
        $query .= (!empty($idPro)) ? " AND id_productor = '$idPro'" : '';
        $query .= (!empty($idAon)) ? " AND id_asociacion = '$idAon'" : '';
   //     $query .= (!empty($idAdo)) ? " AND id_asociado = '$idAdo'" : '';
        $query .= (!empty($idCa)) ? " AND id_centro_acopio = '$idCa'" : '';
if(isset($idAdo) and $idAdo=='asociado'){
        $query .= " GROUP BY id_productor, id_asociacion, id_asociado
                    ORDER BY id_productor, id_asociacion, id_asociado";
}
else if(isset($idAdo) and $idAdo=='productor'){
        $query .= " GROUP BY id_productor
                    ORDER BY id_productor";
}
else{
        $query .= " GROUP BY id_productor, id_asociacion
                    ORDER BY id_productor, id_asociacion";
}
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function buscar($Num=null, $Fecha=null, $idCo=null, $idPro=null, $idAon=null) {
        $query = "SELECT * FROM si_recepcion r WHERE '1'";
        $query .= (!empty($Num)) ? " AND r.numero = '$Num'" : '';
        $query .= (!empty($Num)) ? " AND to_char(r.fecha_recepcion, 'yyyy-mm-dd') = '$Fecha'" : '';        
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
    
    function recepcionesReporteGeneral($fdesde=null, $fhasta=null, $idCA=null, $idCo=null){
        $query = "SELECT co.id AS id_co, '('||co.codigo||') '||co.nombre AS cosecha, '('||cu.codigo||') '||cu.nombre AS cultivo, p.id, p.ced_rif, p.nombre AS productor
                    FROM si_productor p
                    INNER JOIN si_recepcion r ON r.id_productor = p.id
                    /*INNER JOIN si_cosecha_productor cp ON cp.id_productor = r.id_productor*/
                    /*INNER JOIN si_cosecha co ON co.id = cp.id_cosecha*/
                    INNER JOIN si_cosecha co ON co.id = r.id_cosecha
                    INNER JOIN si_cultivo cu ON cu.id = co.id_cultivo
                    WHERE '1' AND r.estatus_rec = '9'";
        $query .= (!empty($idCA)) ? " AND r.id_centro_acopio = '$idCA'" : '';
        $query .= (!empty($idCo)) ? " AND r.id_cosecha = '$idCo'" : '';
        if(!empty($fdesde) || !empty($fhasta)){
            $fdesde = (!empty($fdesde)) ? "'$fdesde'" : 'now()::date';
            $fhasta = (!empty($fhasta)) ? "'$fhasta'" : 'now()::date';
            $query .= " AND r.modificado::date BETWEEN $fdesde AND $fhasta";
        }
        $query .= " GROUP BY co.id, co.codigo, co.nombre, cu.codigo, cu.nombre, p.id, p.ced_rif, p.nombre
                    ORDER BY cu.codigo, p.ced_rif, p.nombre";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }
}

?>

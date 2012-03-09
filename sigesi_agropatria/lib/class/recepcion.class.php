<?php

class Recepcion extends Model {

    var $table = 'si_recepcion';

    function recepcionesDia($idCA, $idCo) {
        $query = "SELECT COUNT(*) AS total
                FROM si_recepcion
                WHERE id_centro_acopio = '$idCA' AND id_cosecha = '$idCo' AND (fecha_recepcion >= '".date('Y-m-d')."' OR fecha_recepcion <= '".date('Y-m-d')."')";
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

    function productorRecepcion($ced_rif) {
        $query = "SELECT pro.id, pro.ced_rif AS cedula_pro, pro.nombre AS nombre_pro, pro.telefono AS telefono_pro, pro.email AS email_pro
                    FROM si_productor pro
                    WHERE pro.ced_rif = '$ced_rif'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function asociadoRecepcion($ced_rif) {
        $query = "SELECT aso.id, aso.ced_rif AS cedula_aso, aso.nombre AS nombre_aso, aso.telefono AS telefeno_aso 
                    FROM si_asociado aso
                    WHERE aso.ced_rif = '$ced_rif'
                    LIMIT 1";
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
  
    function verificarProAso($idCo, $idCa, $ced_rif){
        $query = "SELECT cp.*
                    FROM si_cosecha_productor cp
                    INNER JOIN si_productor pr ON pr.id = cp.id_productor
                    WHERE cp.id_cosecha = '$idCo' AND cp.id_centro_acopio = '$idCa' AND pr.ced_rif = '$ced_rif'
                    LIMIT 1";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
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
		    veh.placa		    
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

}

?>
<?php
class AnalisisCultivo extends Model {
    var $table = 'si_analisis_cultivo';
    
    function buscarAC($id=null,$IdCultivo=null,$idOrg=null){ 
        $query = "SELECT a.id, ac.id_cultivo, a.codigo, a.nombre, a.tipo_analisis,
                    ac.min_rec, ac.max_rec , ac.estatus 
                    FROM si_analisis_cultivo ac 
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND a.id = '$id'" : "";        
        $query .= (!empty($idOrg)) ? " AND a.id_org = '$idOrg'" : "";
        $query .= (!empty($IdCultivo)) ? " AND ac.id_cultivo = '$IdCultivo'" : "";
        $query .= " ORDER BY cast(a.codigo as int)";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query); 
    }
 }
?>

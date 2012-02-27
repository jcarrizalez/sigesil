<?php
class AnalisisCultivo extends Model {
    var $table = 'si_analisis_cultivo';
    
    function buscarAC($id=null,$IdCultivo=null,$idOrg=null){ 
        $query = "select 
                    a.id,
                    ac.id_cultivo, 
                    a.codigo,
                    a.nombre 
                    from si_analisis_cultivo ac 
                    INNER JOIN si_analisis a ON a.id=ac.id_analisis and a.id_org=ac.id_org
                    WHERE '1'";
        $query .= (!empty($id)) ? " AND a.id = '$id'" : "";        
        $query .= (!empty($idOrg)) ? " AND a.id_org = '$idOrg'" : "";
        $query .= (!empty($IdCultivo)) ? " AND ac.id_cultivo = '$IdCultivo'" : "";
        $query .= " ORDER BY a.id";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query); 
    }
 }
?>

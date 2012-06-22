<?php

class Productor extends Model {
    var $table = 'si_productor';
    
    function __construct(){
        //archivo_directorios de trabajo
        $this->archivo_directorio = APPROOT."/temp_files/";
        $this->archivo_url = DOMAIN_ROOT."/temp_files/";
        $this->totalAdmin = 0;
    }
    
    function listadoProductores($id=null, $idOrg=null, $cedrif=null, $nombre=null, $idE=null, $idM=null, $porPagina=null, $inicio=null){
        $query = "SELECT p.id, p.*, pa.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                FROM si_productor p
                INNER JOIN si_organizacion o ON p.id_org = o.id
                INNER JOIN si_pais pa ON pa.id = p.id_pais
                INNER JOIN si_estado e ON e.id = p.id_estado
                INNER JOIN si_municipio m ON m.id = p.id_municipio
                    WHERE '1' AND p.estatus = 't'";
        $query.=(!empty($id)) ? " AND p.id = '$id'" : '';
        $query.=(!empty($idOrg)) ? " AND p.id_org = '$idOrg'" : '';
        $query.=(!empty($cedrif)) ? " AND p.ced_rif ILIKE '%$cedrif%'" : '';
        $query.=(!empty($nombre)) ? " AND p.nombre ILIKE '%$nombre%'" : '';
        $query.=(!empty($idE)) ? " AND e.id = '$idE'" : '';
        $query.=(!empty($idM)) ? " AND m.id = '$idM'" : '';
        $query.= " ORDER BY p.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    } 
    
    function desactivarPro($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = NOW() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function obtenerArchivo($archivo_id=null, $status=null){
        $query="SELECT * FROM si_productor_archivos WHERE 1 = 1 ";
        if(!is_null($archivo_id)) $query .= " AND id = '$archivo_id'";
        if(!is_null($status)) $query .= " AND estatus = '$status'";
        $this->archivo = $this->_SQL_tool('SELECT_SINGLE', __METHOD__, $query);
    }
    
    function archivosProductor($order = '', $porPagina=null, $inicio=null){
        $query="SELECT pa.*, sales_file_status.description AS statusdesc 
                FROM si_productor_archivos pa 
                INNER JOIN sales_file_status ON pa.status = sales_file_status.id WHERE 1 ";
        if (!empty ( $order )) {
                $query .= " ORDER BY $order ";
        } else {
                $query .= " ORDER BY pa.creado DESC";
        }
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        $this->lista = $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
    
    function contar_validos_invalidos($archivo_id){
        $this->obtenerArchivo($archivo_id);
        $filename=$this->archivo_directorio.$this->archivo['alias'];
        if(file_exists($filename)){
            $query="SELECT linea_numero FROM si_productor_archivos_detalle WHERE archivo_id = '$archivo_id' ";
            $res_array = $this->_SQL_tool('SELECT', __METHOD__, $query);
            if (count($res_array) > 0){
                $this->total = (int)count($res_array);
            }else{
                $this->total = 0;
            }
            $query="SELECT COUNT(archivo_id) AS total 
                    FROM si_productor_archivos_detalle 
                    WHERE archivo_id = '$archivo_id' AND valido = '1' AND reseller_id > 0";
            $res_array = $this->_SQL_tool('SELECT_SINGLE', __METHOD__, $query);
            if (count($res_array) > 0){
                $this->validos = (int)$res_array['total'];
                $this->invalidos = $this->total - $this->validos;
            }else{
                $this->validos = 0;
                $this->invalidos = 0;
            }
            $query = "SELECT COUNT(archivo_id) AS total 
                        FROM si_productor_archivos_detalle 
                        WHERE archivo_id = '$archivo_id' AND transferido IN ('1', '2')";
            $res_array = $this->_SQL_tool('SELECT_SINGLE', __METHOD__, $query);
            if (count($res_array) > 0){
                $this->transferido = (int)$res_array['total'];
            }else{
                $this->transferido = 0;
            }
        }
    }
    
    function contarArchivoDetalle($archivo_id){
        $query = "SELECT count(id) AS contado FROM si_productor_archivos_detalle WHERE archivo_id = '".$archivo_id."'";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
    
    function erroresArchivo($archivo_id, $status){
        $query = "SELECT * FROM si_productor_archivos_detalle WHERE archivo_id = '$archivo_id' AND transferido = '$status'";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
}
?>

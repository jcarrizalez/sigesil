<?php

class Productor extends Model {
    var $table = 'si_productor';
    var $spechar=array("\\","'","\t","\n","\r","\0","\x0B","%20"," ");
    var $data = array();
    
    function __construct(){
        //Directorios de trabajo
        $this->archivo_dir = APPROOT."temp_files/";
        $this->archivo_url = DOMAIN_ROOT."temp_files/";
    }
    
    function listadoProductores($id=null, $idOrg=null, $cedrif=null, $nombre=null, $idE=null, $idM=null, $porPagina=null, $inicio=null){
        $query = "SELECT p.id, p.*, pa.nombre AS pais, e.nombre AS estado, m.nombre AS municipio 
                FROM si_productor p
                INNER JOIN si_organizacion o ON p.id_org = o.id
                INNER JOIN si_pais pa ON pa.id = p.id_pais
                LEFT JOIN si_estado e ON e.id = p.id_estado
                LEFT JOIN si_municipio m ON m.id = p.id_municipio
                    WHERE '1' AND p.estatus = 't'";
        $query.=(!empty($id)) ? " AND p.id = '$id'" : '';
        $query.=(!empty($idOrg)) ? " AND p.id_org = '$idOrg'" : '';
        $query.=(!empty($cedrif)) ? " AND p.ced_rif ILIKE '%$cedrif%'" : '';
        $query.=(!empty($nombre)) ? " AND p.nombre ILIKE '%$nombre%'" : '';
        $query.=(!empty($idE)) ? " AND e.id = '$idE'" : '';
        $query.=(!empty($idM)) ? " AND m.id = '$idM'" : '';
        $query.= " ORDER BY p.id";
        $query .= (!empty($porPagina)) ? " LIMIT $porPagina OFFSET $inicio" : "";
        return $this->_SQL_tool('SELECT', __METHOD__, $query);
    }
    
    function obtenerProductores(){
        $query = "SELECT * FROM si_productor WHERE '1'";
        $resultado = $this->_SQL_tool('SELECT', __METHOD__, $query);
        for($i=0, $cant=count($resultado); $i<$cant; $i++){
            $list[]=$resultado[$i]['ced_rif'];
        }
        return $list;
    }
    
    function desactivarPro($id, $estatus = 't') {
        $estatus = ($estatus == 't') ? 't' : 'f';
        $query = "UPDATE $this->table SET estatus = '$estatus', modificado = NOW() WHERE id = '$id'";
        return $result = $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }
    
    function subirProductores($archivos){
        $archivoSubido = new FileUpload(array('excel'));
        $tipos_permitidas = $archivoSubido->allowedTypes;
        $archivo = $archivos['archivo'];
        $ext_xls = array('.xls', '.xlsx'); //Los archivos nativos de excel no se pueden leer
        $ext_archivo = substr($archivo['name'], strrpos($archivo['name'], '.'));
        if(is_uploaded_file($archivo['tmp_name']) && in_array($archivo['type'], $tipos_permitidas) && in_array($ext_archivo, $ext_xls)){
        //if(is_uploaded_file($archivo['tmp_name']) && $archivo['size'] < 2097152 && in_array($archivo['type'], $tipos_permitidas) && in_array($ext_archivo, $ext_xls)){
            $archivo_nuevo = str_replace($this->spechar,"_", $archivo['name']);
            $archivo_nuevo = date("dmYhis")."_".$archivo_nuevo;
            if(move_uploaded_file($archivo['tmp_name'], $this->archivo_dir.$archivo_nuevo)){
                    return $archivo_nuevo;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    
    function insertarProductorArchivo($archivoSubido, $primera_linea){
        set_time_limit(0);
        ini_set('memory_limit',-1);
        $this->leerArchivoProductor($archivoSubido, $primera_linea);
        if(!empty($this->data)){
            foreach($this->data as $indice => $data){
                $listaProductores = $this->obtenerProductores();
                if(!in_array($data['ced_rif'], $listaProductores)){
                    $query="INSERT INTO si_productor (id_org, ced_rif, nombre, telefono, direccion, id_pais, estatus, creado)
                    VALUES ('1', '".trim($data['ced_rif'])."', '".trim($data['nombre'])."', '".trim($data['telefono'])."', '".trim($data['direccion'])."', '1', 't', now())";
                    $this->_SQL_tool('INSERT', __METHOD__, $query);
                }
            }
            return true;
        }else{
            return false;
        }
    }
    
    function leerArchivoProductor($archivoSubido, $primera_linea){
        require_once APPROOT.'lib/class/PHPExcel/PHPExcel.php';
        require_once APPROOT.'lib/class/PHPExcel/PHPExcel/IOFactory.php';

        $nombreArchivo=$this->archivo_dir.$archivoSubido;
        $this->data=array();
        if(file_exists($nombreArchivo)){
            set_time_limit(0);
            ini_set('memory_limit',-1);
            $arrColumnas = array('ced_rif' => 0, 'nombre' => 1, 'telefono' => 2, 'direccion' => 3);
            //$listaProductores = $this->obtenerProductores();

            $ext_archivo = substr($nombreArchivo, strrpos($nombreArchivo,'.'));
            if (strtolower($ext_archivo)==".xls")	$tipo = "Excel5";
            if (strtolower($ext_archivo)==".xlsx")	$tipo = "Excel2007";

            $leerExcel = PHPExcel_IOFactory::createReader($tipo);
            $leerExcel->setReadDataOnly(true);

            $objPHPExcel = $leerExcel->load($nombreArchivo);
            $objWorksheet = $objPHPExcel->getActiveSheet();
            
            //Empezamos la lectura de los datos
            $ultimaFila = $objWorksheet->getHighestRow();
            $ultimaColumna = $objWorksheet->getHighestColumn();
            $ultimaColumnaIndice = PHPExcel_Cell::columnIndexFromString($ultimaColumna);

            for ($fila = $primera_linea; $fila <= $ultimaFila; ++$fila){
                $dataPorColumna='';
                $tmp = array();
                for ($col = 0; $col < $ultimaColumnaIndice; ++$col){
                    $tmp[$col] = $objWorksheet->getCellByColumnAndRow($col, $fila)->getValue();
                    $dataPorColumna .= $tmp[$col] . '; ';
                }
                $cedula = substr($tmp[$arrColumnas['ced_rif']], 1);
                if(is_numeric($cedula)){
                    $err_msg = '';
                    //if(!in_array($tmp[$arrColumnas['ced_rif']], $listaProductores)){
                        if($tmp[$arrColumns['nombre']] == '' || empty($tmp[$arrColumns['nombre']])) $err_msg .= 'Nombre_Invalido,';
                        if($tmp[$arrColumns['telefono']] == '' || empty($tmp[$arrColumns['telefono']])) $err_msg .= 'Telefono_Invalido,';
                        if($tmp[$arrColumns['direccion']] == '' || empty($tmp[$arrColumns['direccion']])) $err_msg .= 'Direccion_Invalida,';
                        if ($err_msg == ''){
                            $err_msg = 'OK,';
                        }
                        $this->data[]=array('error_msg' => $err_msg,
                                                'ced_rif' => $tmp[$arrColumnas['ced_rif']],
                                                'nombre' => $tmp[$arrColumnas['nombre']],
                                                'telefono' => $tmp[$arrColumnas['telefono']],
                                                'direccion' => $tmp[$arrColumnas['direccion']],
                                                'scvlines' => $fila,
                                                'data' => $dataPorColumna);
                    //}
                }
            }
            //Debug::pr($this->data);die();
        }
    }
}
?>

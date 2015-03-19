<?php
class Sales extends Model{

	private $upload_file_dir="upload_files/sales";
	private $formatData=array('Fec_Crea'=>array('db'=>'salesdet_fec_cre','restrict'=>array('minlength'=>1)),
	                           'Co_Id'=>array('db'=>'salesdet_co_id','restrict'=>array()),
	                           'Orden_Contra'=>array('db'=>'salesdet_orden_con','restrict'=>array('minlength'=>1)),
							   'Vendedor'=>array('db'=>'salesdet_vendedor','restrict'=>array('minlength'=>1)),
	                           'Ejecutivo'=>array('db'=>'salesdet_ejecutivo','restrict'=>array('minlength'=>1)),
							   'Coordinador'=>array('db'=>'salesdet_coordinador','restrict'=>array()),
	                           'Gerente'=>array('db'=>'salesdet_gerente','restrict'=>array('minlength'=>1)),
							   'Nuevo_Estatus'=>array('db'=>'salesdet_nuevo_est','restrict'=>array()),
	                           'Md'=>array('db'=>'salesdet_md','restrict'=>array()),
	                           'Modelos'=>array('db'=>'salesdet_modelos','restrict'=>array('invalues'=>array('i1','Motorola i1'))),
	                           'Region'=>array('db'=>'salesdet_region','restrict'=>array()),
	                           'Plaza'=>array('db'=>'salesdet_plaza','restrict'=>array()),
	                           'RFC_Rep'=>array('db'=>'salesdet_rfc_rep','restrict'=>array())
	                           //'Campana'=>array('db'=>'salesdet_codigo','restrict'=>array('length'=>16,'type'=>'int'))
	                     );
	private $varNull="%NULL%";

  function upload_credit_card_file($FILE,$FORM_DATA) {
  	$fileUplad= new cls_uploads();
  	$fileUplad->setOnlyAllowedExtension(array("csv"));
  	try{
	  	$upload_data=$fileUplad->upload(APPROOT.$this->upload_file_dir,$FILE, 'file');
	  	$query="INSERT INTO sales_archivo (sales_archivo_original_name,sales_archivo_fisical_name,sales_archivo_csv_separator,sales_archivo_line_init,sales_archivo_creado,sales_archivo_status)
	  	VALUES ('".mysql_real_escape_string($upload_data['original_name'])."','".mysql_real_escape_string($upload_data['fisical_name'])."','".$FORM_DATA['csv_sep']."','".$FORM_DATA['data_linea']."',NOW(),2)";
  	  $id_file=$this->_SQL_tool("INSERT", __METHOD__, $query);
  	  return array_merge($upload_data,array('sales_archivo_id'=>$id_file));
  	}catch (Exception $e){
  	 throw $e;
  	}
  }

	function update_credit_card_file($file_id, $status){
		$query = "UPDATE sales_archivo SET sales_archivo_status = '$status' WHERE sales_archivo_id = '$file_id'";
		$this->_SQL_tool($this->UPDATE, __METHOD__, $query);
	}

  function readDataAndInsert($fileId,FileReader $fileReader){
      $file=$this->getFileFromDB($fileId);
      global $CORE_general;
      if(!$file){
        throw new Exception(sprintf("File Id '%s' don't exist de Dababase",$fileId));
      }
      $fileReader->setSeparator($file['sales_archivo_csv_separator']);
      $fileReader->set_file(APPROOT.$this->upload_file_dir."/".$file['sales_archivo_fisical_name']);
      $fileLineInt=(int)$file['sales_archivo_line_init'];
      $line=1;
      $ReadFormat=$this->getFormatReturn();
      while($line<$fileLineInt){
      	$fileReader->get_next_row($ReadFormat);
        $line++;
      }
      $idInserts=array();
      while($arrData=$fileReader->get_next_row($ReadFormat)){
      	foreach($arrData as $key=>$value){
      		$arrData[$key] = trim($value);
      	}
      	$valid=1;
      	$err_str=null;
      	$err=$this->evaluateRow($arrData, $ReadFormat);

      	if($err){
      		$valid=0;
      		$ie=0;

      		foreach($err as $key=>$val){
      			foreach($val as $error){
		      		 if($ie<>0){
		      		  $err_str.=',';
		      		 }
		      		  $err_str.=$key."_".$error;
		      		  $ie++;
		      		}

      		}

      	}
        $data=array_merge($arrData,array('linea_nro'=>$fileReader->get_number_current_line(),'archivo_id'=>$fileId,'valido'=>$valid,'err'=>$err_str));
        $Fecha = $CORE_general->fecha_normal_sql($data['Fec_Crea'],'en');
        if($Fecha){
        	$data['Fecha_sql'] = $Fecha;
        }else{
        	$data['Fecha_sql'] = NULL;
        }
        $idInserts[]= $this->insert_archivo_detalle($data);
      }
      return $idInserts;
  }

  function insert_archivo_detalle(array $data){
    $query="INSERT INTO sales_archivo_detalles (salesdet_archivo_id, salesdet_linea_nro, salesdet_fec_cre, salesdet_fecha, salesdet_co_id,salesdet_orden_con,salesdet_vendedor,salesdet_ejecutivo,salesdet_coordinador, salesdet_gerente, salesdet_nuevo_est, salesdet_md, salesdet_modelos, salesdet_region, salesdet_plaza, salesdet_rfc_rep, salesdet_valido, salesdet_err)
            VALUES (".$this->getDataVarToSQL($data['archivo_id']).",".$this->getDataVarToSQL($data['linea_nro']).",".$this->getDataVarToSQL($data['Fec_Crea']).",".$this->getDataVarToSQL($data['Fecha_sql']).",".$this->getDataVarToSQL($data['Co_Id']).",".$this->getDataVarToSQL($data['Orden_Contra']).",".$this->getDataVarToSQL($data['Vendedor']).",".$this->getDataVarToSQL($data['Ejecutivo']).",".$this->getDataVarToSQL($data['Coordinador']).",".$this->getDataVarToSQL($data['Gerente']).",".$this->getDataVarToSQL($data['Nuevo_Estatus']).",".$this->getDataVarToSQL($data['Md']).",".$this->getDataVarToSQL($data['Modelos']).",".$this->getDataVarToSQL($data['Region']).",".$this->getDataVarToSQL($data['Plaza']).",".$this->getDataVarToSQL($data['RFC_Rep']).",".$this->getDataVarToSQL($data['valido']).",".$this->getDataVarToSQL($data['err']).")";
    return $this->_SQL_tool("INSERT",__METHOD__ , $query);
  }

  function getDataVarToSQL($var){
    if(is_null($var)){
      return 'NULL';
    }else{
      return "'".$var."'";
    }
  }


  function evaluateRow($data,$format){
  	$errReturn=array();
    foreach($format as $key=>$val){
      if($err=$this->globalValid($val['restrict'], $data[$key])){
        $errReturn[$key]=$err;
      }
    }
    return $errReturn;
  }

  function globalValid($arrParams,$value){
  	$arrError=array();
    foreach($arrParams as $param_name=>$param){
    	switch ($param_name){
    		case "length":
    			if(strlen($value)!=$param){
    			   $arrError[]='length';
    			}
    		break;
    		case "maxlength":
    	   if(strlen($value)>$param){
             $arrError[]='maxlength';
          }
    		break;
    		case "minlength":
         if(strlen($value)<$param){
             $arrError[]='minlength';
          }
        break;
        case "invalues":
        	if(!in_array($value, $param)){
             $arrError[]='invalues';
          	}
        break;
        case "type":
          switch($param){
          	case "int";
          	 if(!is_numeric($value)){
          	   $arrError[]="type";
          	 }
          	break;
          }
        break;
    	}
    }
    return $arrError;
  }

  function getFileFromDB($fileId){
  	$query="SELECT *   FROM sales_archivo WHERE sales_archivo.sales_archivo_id='$fileId' ";
  	return $this->_SQL_tool("SELECT_SINGLE", __METHOD__, $query);
  }

  function getFormatReturn(){
    return $this->formatData;
  }

  function getCreditCardsByFile($file_id){
    $query="SELECT * FROM sales_archivo_detalles WHERE sales_archivo_detalles.salesdet_archivo_id='$file_id'";
    return $this->_SQL_tool("SELECT", __METHOD__, $query);
  }

  function getListFiles(){
    $query="SELECT sales_archivo.* , sum(if(salesdet_valido is not null,1,0)) as total, sum(if(salesdet_valido=1,1,0)) as valids, sum(if(salesdet_valido=0,1,0)) as invalids
          FROM sales_archivo
          LEFT JOIN sales_archivo_detalles ON sales_archivo_detalles.salesdet_archivo_id=sales_archivo_id
          GROUP BY  sales_archivo.sales_archivo_id
          ORDER BY sales_archivo.sales_archivo_creado desc
          ";
     return $this->_SQL_tool("SELECT", __METHOD__, $query);
  }

  function getLocationInDomain($FileId,$fisical_name){
    return DNA_DOMAIN_ROOT.$this->upload_file_dir."/".$fisical_name;
  }

  function registerCardUser($cod_tarj,$usuario_id){
  	$objUser= new cls_usuarios();

  	if($this->globalValid(array('length'=>16),$cod_tarj)){
  	 throw new Exception("code of card is not valid length");
  	}
  	$data=$this->getArchivobyCodeCard($cod_tarj,1);
  	if(!$data){
  		throw new Exception("code not exist");
  	}
  	if(count($data)>1){
  	 throw new Exception("code number is ambiguo");
  	}
  	if(count($this->getUsuarioTarjetaByField(array('usuario_tajeta_codigo'=>$cod_tarj)))>0){
  	 throw new Exception("code previus register");
  	}
  	$objUser->get_user($usuario_id);
  	$data=$data[0];
  	if($objUser->data['usuario_sales_id']!=$data['salesdet_ejecutivo']){
  	   throw new Exception("user no match");
  	}
  	$values=array('codigo'=>$data['salesdet_codigo'],'archivo_detalle_id'=>$data['salesdet_id'],'status'=>'1');
  	$this->insert_usuario_tarjeta($usuario_id, $values);
  	return true;
  }


  function insert_usuario_tarjeta($usuario,$data){
    $query="INSERT INTO usuario_tarjetas (usuario_tarjeta_usuario_id,usuario_tajeta_codigo,usuario_tarjeta_archivo_detalle_id,usuario_tajeta_creado,usuario_tajeta_status)
            VALUES (".$this->getDataVarToSQL($usuario).",".$this->getDataVarToSQL($data['codigo']).",".$this->getDataVarToSQL($data['archivo_detalle_id']).",now(),".$this->getDataVarToSQL($data['status']).")
    ";
    return $this->_SQL_tool("INSERT", __METHOD__, $query);
  }

  function getUsuarioTarjetaByField(array $fields){
    $query="SELECT * from usuario_tarjetas where 1";
    $arrField=array();
    foreach($fields as $field=>$val){
    	$arrField[]=" ".$field."='".$val."'";
    }
    return $this->_SQL_tool("SELECT",__METHOD__, $query." and ".implode(" AND ", $arrField));
  }

  function getArchivobyCodeCard($code, $valid='1'){
    $query="SELECT * FROM sales_archivo_detalles
    WHERE salesdet_codigo='$code' and salesdet_valido='$valid'  ";
    return $this->_SQL_tool("SELECT", __METHOD__, $query);
  }

  function getMySales($rcf){
    $query="
    SELECT sales_archivo_detalles.salesdet_fec_cre,
           sales_archivo_detalles.salesdet_orden_con,
           count(salesdet_linea_nro) as qty
    FROM  sales_archivo
    inner join sales_archivo_detalles ON  sales_archivo.sales_archivo_id= sales_archivo_detalles.salesdet_archivo_id
    where sales_archivo.sales_archivo_status=1
    AND  sales_archivo_detalles.salesdet_rfc_rep='$rcf'
    GROUP BY salesdet_fec_cre, salesdet_orden_con
    ";
    return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
  }
  function getSalesReport(){
    $query="SELECT  SAD.salesdet_fec_cre as sales_date,
                   users.id as user_id, 
                   if(users.first_name is  not null, users.first_name, salesdet_ejecutivo ) as firstname, 
                   SAD.salesdet_rfc_rep as rfc, 
                   SAD.salesdet_vendedor as distribuidor, 
                   SAD.salesdet_orden_con as orden_contratacion, 
                   SAD.salesdet_coordinador as coordinador, 
                   SAD.salesdet_gerente as gerente, 
                   SAD.salesdet_region as region, 
                   SAD.salesdet_plaza as plaza, 
                   users.phone_user as telefono_contacto, 
                   users.numero_id_user as nro_id, 
                   users.email as email, 
                   users.direccion_user as direccion, 
                   users.city_user as ciudad, 
                   users.colony_user as colonia, 
                   users.zip_user as codigo_postal,
                   count(salesdet_rfc_rep) as total_sales
            FROM users
            right  JOIN sales_archivo_detalles as SAD ON SAD.salesdet_rfc_rep = users.rfc_user
            inner JOIN sales_archivo on sales_archivo.sales_archivo_id=SAD.salesdet_archivo_id
            WHERE sales_archivo.sales_archivo_status=1
            GROUP BY rfc,
                   sales_date,
                   coordinador, 
                   distribuidor, 
                   orden_contratacion, 
                   gerente, 
                   region, 
                   plaza";
    return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
  }
}
<?php
class FileReader{
	private $ext;
	private $buffer;
	private $NUMBER_CURRENT_LINE=1;
	private $NUMER_MAX_LINE;
	private $separator;
	private $objHelperReader;
	private $extentions_available=array('csv','xls','xlsx');
	static  $TYPE_CSV='csv';

	
	/**
	 * @param $extencion_atrabajar = puesde ser CSV || xls || xlsx
	 * @return FileReader
	 */
	function __construct($extencion_atrabajar){
		$extencion_atrabajar=strtolower($extencion_atrabajar);
		if(!in_array($extencion_atrabajar,$this->extentions_available)){
			trigger_error("Error tipo de archivo $extencion_atrabajar no esta disponible para trabajar en la clase FileReader ",E_USER_ERROR);
		}
		switch($extencion_atrabajar){
			case FileReader::$TYPE_CSV:
				$this->ext=$extencion_atrabajar;
				break;
			case 'xls':
				
				$objHelperReader = PHPExcel_IOFactory::createReader($tipo);
				$objHelperReader->setReadDataOnly(true);
				$this->ext=$extencion_atrabajar;
				break;
			case 'xlsx':
				
				$objHelperReader = PHPExcel_IOFactory::createReader($tipo);
				$objHelperReader->setReadDataOnly(true);
				$this->ext=$extencion_atrabajar;
			break;

		}

	}
	
	function set_file($file_name){
		switch($this->ext){
			case FileReader::$TYPE_CSV:
				$objHelperReader=fgetcsv;
				$this->NUMER_MAX_LINE=count(file($file_name));
				$this->buffer=fopen($file_name, "r");
				break;
			case 'xls':
				$tipo = "Excel5";
				$reader = PHPExcel_IOFactory::createReader($tipo);
				$reader->setReadDataOnly(true);
				$objPHPExcel = $reader->load($app_file);
				$objHelperReader = $objPHPExcel->getActiveSheet();
				$this->NUMER_MAX_LINE=$objHelperReader->getHighestRow();
			case 'xlsx':
				$tipo = "Excel2007";
				$reader->setReadDataOnly(true);
				$objPHPExcel = $reader->load($app_file);
				$objHelperReader = $objPHPExcel->getActiveSheet();
				$this->NUMER_MAX_LINE=$objHelperReader->getHighestRow();
		}
	}
	
	
	function get_format_return($arr_format,$data){
		$array_return=array();
		$i=0;
		foreach($arr_format as $key=>$format):
			$array_return[$key]=$data[$i];
			$i++;
		endforeach;
		return $array_return;
	}
	
	function get_row($number_row=false,$format_return=array()){
		$array_return=array();
		switch(strtolower($this->ext)){
			case FileReader::$TYPE_CSV:
				//el cvs se supone que se debe leer linea a linea; pero de 
				//igual manera se deja pendiente para que alguien lo haga
				if($number_row===false){
					$line=fgetcsv($this->buffer, 5000, $this->separator);
					$this->NUMBER_CURRENT_LINE++;
				}else{
					$number_row=(int)$number_row;
					$iter=false;
					while($number_row>=0){
						$line=fgetcsv($this->buffer, 5000, $this->separator);
						$this->NUMBER_CURRENT_LINE++;
						if($this->NUMBER_CURRENT_LINE>$this->NUMER_MAX_LINE){
							if($iter==true){ //si ya le dio una vuelta y no lo consigue
								$line=array();
								break;
							}else{
								$this->NUMBER_CURRENT_LINE=0;
								fseek($this->buffer,0);
								$iter=true;
							}
						}
						if($this->NUMBER_CURRENT_LINE===$number_row+1){
							break;
						}
					}		
				}
				//echo "<br />".$number_row."-";print_r($line);
				//ob_flush();
				//flush();
				$array_return=$this->get_format_return($format_return,$line);
			break;
			case "xls":
				
			case "xlsx":
		break;
		}
		return $array_return;
		
	}
	
	function get_next_row($format_return){
		if ($this->NUMBER_CURRENT_LINE > $this->NUMER_MAX_LINE)return false;
		switch($this->ext){
			case FileReader::$TYPE_CSV:
			$arr_return=$this->get_row(false,$format_return);
			break;
			case 'xls':
			case 'xlsx':
				$arr_return=$this->get_row($this->NUMBER_CURRENT_LINE,$format_return);
			break;	
		}
		return $arr_return;
	}
	
	function setSeparator($separator_CSV){
		$this->separator=$separator_CSV;
	}
	function get_number_current_line(){
		return $this->NUMBER_CURRENT_LINE-1;
	}
	
	function closeFile(){
		switch($this->ext){
			case FileReader::$TYPE_CSV:
				if($this->buffer){
					fclose($this->buffer);
				}
			break;
		}
	}
	
	function __destruct(){
		$this->closeFile();		
	}
}
?>
<?
/**
 * Clase para realizar descargas de la aplicacion; inicialmente pensada para descargar reportes en
 * formato excel
 *
 * @name	Descarga
 * @author	Jesus Rodriguez
 * @todo	Actualmente, el tipo mime se determina a partir de la extension del archivo; para mayor
 * 		seguridad, deberia implementarse una opcion que permita determinarlo a partir del archivo mismo.<br>
 * 		Aparte, la bandera de descarga ilegal solo causa un valor de retorno distinto en el metodo
 * 		de descarga del archivo; seria mucho mas interesante que generase un registro que pueda ser
 * 		consultado en otro momento
 */
class descarga {

	/**
	 * @var string. El nombre del archivo en el servidor
	 */
	private $filename_server;
	/**
	 * @var string. El nombre de archivo que recibira el cliente como sugerido
	 */
	private $filename_client;
	/**
	 * @var string. Url relativo al dominio de la pagina que solicito la descarga
	 */
	private $referer;
	/**
	 * @var string. Tipo mime del archivo a descargar; actualmente se asigna a partir de la extension del archivo
	 */
	private $mimetype;
	/**
	 * @var integer. Tamaño (en bytes) del archivo en servidor
	 */
	private $filesize;
	/**
	 * @var string. Ruta absoluta a la ubicacion de archivo en el servidor
	 */
	private $filepath;
	/**
	 * @var string. Extension del archivo en el servidor; no incluye el punto
	 */
	private $file_extension;

	/**
	 * @var boolean. Bandera que marca si se esta intentando descargar un archivo no listado en ALLOWED_FILES
	 */
	private $illegal_download;
	/**
	 * @staticvar
	 * @var array. Vector con las extensiones de archivos permitidas para descargas; funciona como una lista blanca
	 */
	private static $ALLOWED_FILES = array('doc', 'docx', 'pdf', 'ppt', 'pptx', 'xls', 'xlsx', 'zip');

	/**
	 * Inicializacion del objeto; los tres parametros son requeridos
	 *
	 * @param string $file_on_server	Ruta absoluta al archivo que sera descargado del servidor
	 * @param string $filename_client	Nombre de archivo que se enviara al cliente por defecto
	 * @param string $referer			Ruta relativa al dominio a la pagina que solicita la descarga
	 */
	public function __construct($file_on_server, $filename_client, $referer){
		if($this->verify_download($file_on_server)){
			$partes_archivo = pathinfo($file_on_server);
			$this->filename_server = $partes_archivo['basename'];
			$this->referer = $referer;
			$this->filepath = $partes_archivo['dirname'];
			$this->filesize = filesize($file_on_server);
			$this->file_extension = $partes_archivo['extension'];
			$this->mimetype = $this->find_mimetype_from_extension($this->file_extension);
			$this->filename_client = $filename_client;
		}
	}

	/**
	 * Busca el tipo mime basandose en la extension del archivo
	 *
	 * @param string $extension	Extension del archivo a buscar
	 * @return mixed 			Retorna un <code>string</code> con el tipo mime de la extension
	 * 							proporcionada, o <code>false</code> en caso de no ser uno de los
	 * 							tipos permitidos
	 */
	private function find_mimetype_from_extension($extension){
		switch ($extension) {
			case 'doc':
				return 'application/msword';
				break;
			case 'docx':
				return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
				break;
			case 'pdf':
				return 'application/pdf';
				break;
			case 'ppt':
				return 'application/vnd.ms-powerpoint';
				break;
			case 'pptx':
				return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
				break;
			case 'xls':
				return 'application/vnd.ms-excel';
				break;
			case 'xlsx':
				return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
				break;
			case 'zip':
				return 'application/zip';
				break;

			default:
				return false;
				break;
		}
	}

	/**
	 * Verifica la validez de la descarga validando dos cosas:
	 * <ul>
	 * <li>Primero, que la extension del archivo a descargar se encuentre en la lista blanca
	 * <li>Segundo, que el archivo exista en la ruta especificada
	 * </ul>
	 *
	 * @param string $file_on_server	Ruta absoluta al archivo en el servidor
	 * @return boolean					<code>true</code> en caso de que el archivo pase ambos controles,
	 * 									<code>false</code> en caso contrario; aparte, si la extension del
	 * 									archivo no esta en la lista blanca, se levanta la bandera de descarga ilegal
	 */
	private function verify_download($file_on_server){
		$partes_archivo = pathinfo($file_on_server);
		if(in_array($partes_archivo['extension'], cls_file_download::$ALLOWED_FILES)){
			if(is_file($file_on_server)){
				return true;
			} else{
				return false;
			}
		} else{
			$this->illegal_download = true;
			return false;
		}
	}

	public function get_filename_server(){
		return $this->filename_server;
	}

	public function get_filename_client(){
		return $this->filename_client;
	}

	public function get_referer(){
		return $this->referer;
	}

	public function get_mimetype(){
		return $this->mimetype;
	}

	public function get_filesize(){
		return $this->filesize;
	}

	public function get_filepath(){
		return $this->filepath;
	}

	public function get_file_extension(){
		return $this->file_extension;
	}

	/**
	 * Metodo de conveniencia que ajusta los encabezados para realizar la descarga
	 */
	private function set_download_headers(){
		header('Content-Description: File Transfer');
		header("Content-type: $this->mimetype");
		header("Content-Disposition: attachment; filename=$this->filename_client" );
		header('Content-Transfer-Encoding: binary');
		header('Expires: 0');
		header('Cache-Control: must-revalidate, post-check=0,pre-check=0');
		header('Pragma: public');
		header("Content-Length: $this->filesize");
	}

	/**
	 * Verifica que se poseen todos los datos necesarios para realizar la descarga
	 *
	 * @return boolean	<code>true</code> en caso de tener todos los datos,
	 * 					<code>false</code> en caso contrario
	 */
	private function is_ready_for_download(){
		$ready = true;
		if(empty($this->filename_server)){
			$ready = false;
		}
		if(empty($this->filename_client)){
			$ready = false;
		}
		if(empty($this->referer)){
			$ready = false;
		}
		if(empty($this->file_extension)){
			$ready = false;
		}
		if(empty($this->mimetype)){
			$ready = false;
		}
		if(empty($this->filesize)){
			$ready = false;
		}
		return $ready;
	}

	/**
	 * Realiza la descarga del archivo en caso de que cumpla con los controles correspondientes;
	 * opcionalmente, permite borrarlo una vez ha sido descargado.
	 *
	 * @param boolean $delete_after_download	Si es <code>true</code>, borra el archivo tras descargarlo
	 * @return integer							1 si la descarga se realiza con exito, 0 si no se descarga
	 * 											el archivo y -1 si es una descarga ilegal
	 */
	public function download_file($delete_after_download=false){
		if($this->is_ready_for_download() && $this->verify_download($this->get_full_path())){
			$this->set_download_headers();
			$var = readfile($this->get_full_path());
			if($delete_after_download){
				flush();
				ob_flush();
				unlink($this->get_full_path());
			}
			return 1;
		} else{
			if($this->illegal_download){
				return -1;
			} else{
				return 0;
			}
		}
	}

	/**
	 * Reconstruye y devuelve la ruta absoluta de ubicacion del archivo en el servidor
	 *
	 * @return string	La ruta absoluta del archivo en el servidor
	 */
	public function get_full_path(){
		return $this->filepath.'\\'.$this->filename_server;
	}

	/**
	 * Imprime en el HTML la llamada a la funcion JavaScript que permite mostrar u ocultar el dialogo de
	 * descarga; debe usarse en conjunto con print_ajax_downloader
	 * @static
	 * @example			Si el dialogo de descarga se va a llamar desde un boton, entonces debe llamarse
	 * 					el metodo como parte de su evento click:<p>
	 * 					&lt;input type="button" onclick="&lt;?=cls_file_download::print_ajax_downloader_caller(); ?&gt;"&gt;
	 * @return string	La llamada a la funcion JavaScript
	 */
	public static function print_ajax_downloader_caller(){
		echo 'mostrar_dialogo_descarga()';
	}

	/**
	 * Imprime el codigo HTML necesario para mostrar y ejecutar el dialogo de descarga
	 * @param array $formats_per_script	Matriz que relaciona los scripts que <strong>generan</strong>
	 * 									los archivos a descargar y los formatos en que se pueden descargar.<br>
	 * 									Este arreglo se usa para generar la lista de opciones de descarga del
	 * 									dialogo, asi como configurar las correspondientes llamadas a los
	 * 									mencionados scripts y los parametros que se les pasan.<br>
	 * 									Como ejemplo: Si desde report_funds_by_bu se quiere habilitar la
	 * 									descarga del reporte generado por report_funds_by_bu_xls, la llamada a
	 * 									la funcion deberia ser <code>cls_file_download::print_ajax_downloader(array('report_funds_by_bu_xls' => array('xls', 'xlsx')));</code>
	 * @return string					El codigo HTML necesario
	 */
	public static function print_ajax_downloader($formats_per_script, $param1=null){
		global $GPC;
		$langclass = new language();
		$langC = $langclass->getLabelsOfPage($_SERVER['PHP_SELF']);
		/*$arr['script']
		$arr['titulo']
		$arr['formatos']
		array('script' => 'report_xls', 'titulo' => 'txt_reporte_summary', 'formatos' => array('xls', 'xlsx'))*/
		echo '<div id="download_dialog" style="display: none;border: 2px solid gray;position: absolute;background-color: white;text-align: left;padding-right: 10px;"><br>';
		foreach ($formats_per_script as $report) {
			foreach ($report['formatos'] as $format) {
				//$titulo = !empty($report['titulo'])?$objLan->get_value_name($report['titulo']):'';
				echo "<li style='list-style-type:none;'>
						&nbsp;&nbsp;<span id='download_{$report['script']}_$format' style='cursor: pointer; ' class='green_text'>".$langC["txt_download_{$format}_format"]."</span>
					</li>
					";
			}

		}
		echo '<br/>&nbsp;&nbsp;
				<span id="download_message"></span><br/>&nbsp;&nbsp;
				<img id="download_image" alt="loading..." src="'.DOMAIN_ROOT.'images/ajax-loader-u.gif" style="display: none;">
			</div>
			';
		echo '<script type="text/javascript">
				function get_url_by_form(object_parent_id){
					var form_id;
					var vars_url="";
					var i_index=0;
					try{
						form_id=document.getElementById(object_parent_id);
					}catch(err){
						form_id=document.getElementsByTagName("form")[0];
					}
					$(":text, :checkbox:checked, select, :radio:checked, textarea",this.form_id).each(function(){
						if(i_index!=0){
							vars_url+="&";
						}
						vars_url+=$(this).attr("name")+"="+$(this).val();
						i_index++;
					});
					return vars_url;
				}
				';
		echo '$(document).ready(function(){';
		if($GPC['download_error']==1){
			echo "alert('".$langC['txt_download_excel_dialog_error'].");";
		}
		foreach ($formats_per_script as $report) {
			foreach ($report['formatos'] as $format) {
				echo '$("#download_'.$report['script'].'_'.$format.'").click(function(){
						descargar_reporte("'.$report['script'].'", "'.$format.'", "'.$param1.'");
					});';
			}
		}
		echo '});';
		//data: get_url_by_form(document.forms[0])+'&formato='+formato_descarga,
		echo "function descargar_reporte(file_generator, formato_descarga, param1){
				$('#download_message').html('".$langC['txt_download_excel_dialog_wait']."<br>');
				$('#download_image').fadeIn('slow');
				$.ajax({
					cache: false,
					data: get_url_by_form(document.forms[0])+'&formato='+formato_descarga,
					error: function(XMLHttpRequest, textStatus, errorThrown){
						$('#download_message').html('".$langC['txt_download_excel_dialog_error']."<br>');
						$('#download_image').fadeOut('slow');
					},
					success: function(data, textStatus){
						var success_message = '".$langC['txt_download_excel_dialog_success']."<br>';
						success_message = success_message.replace('".$langC['txt_here']."', '<a href=\"".DOMAIN_ROOT."admin/report_downloader.php?filename='+data+'&format='+formato_descarga+'&referer={$_SERVER['PHP_SELF']}\">{".$langC['txt_here']."}</a>');
						$('#download_message').html(success_message);
						$('#download_image').fadeOut('slow');
						window.location = '".DOMAIN_ROOT."admin/report_downloader.php?filename='+data+'&format='+formato_descarga+'&referer={$_SERVER['PHP_SELF']}';
					},
					url: file_generator+'.php?param1='+param1
				});
			}";
		echo 'function mostrar_dialogo_descarga(){
				$("#download_dialog").slideToggle("slow");
			}';
		echo 'function show_winndow_ajax_download(evento){
				var top=-20;
				if (window.event){
							x=window.event.clientX
							y=window.event.clientY;
				}else if(evento){
					try{
					y=evento.clientY || 0 ;
					x=evento.clientX || 0 ;
					}catch(err){
						y=0;
						x=0;
					}
				}
				y+=window.scrollY || document.documentElement.scrollTop || document.body.scrollTop;
				//x+=window.scrollX || document.documentElement.scrollLeft || document.body.crollLeft;
				top=top+y;
				$("#border_popup").css("top",top+"px");
				$("#border_popup").css("left",x+"px");
				$("#border_popup").css("display","block");
			}';
		echo '</script>';
	}
}
?>
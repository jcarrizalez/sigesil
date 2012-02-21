<?
    class cls_dbtools extends cls_logs {

    var $return_id='';
    var $time='';
    var $genera_log=true;
    static  $arr_codigosLogNoRewrite=array('INSERT'=>201,'UPDATE'=>202,'DELETE'=>203);
    private $codigos=array('INSERT'=>201,'UPDATE'=>202,'DELETE'=>203);
    private $add_myoptime_errors=true;
    public static $dbDebug =array();
    var $var_trans = '0';

    /*
     * OJO!!!!
     * propiedades temporales para compatibilidad de la clase vieja,
     * hay que remplazar todos los $this->ACCION por el texto igualado en la propiedad
     */
    var $INSERT = 'INSERT';
    var $INSERT_ID = 'INSERT';
    var $UPDATE = 'UPDATE';
    var $DELETE = 'DELETE';
    var $SELECT = 'SELECT';
    var $SELECT_SINGLE = 'SELECT_SINGLE';

    function __construct(){
        $this->setCodigosLog(array(),true);
    }


    /**
     * Begin Transaction
     *
     */
    function _begin_tool() {
        pg_query ( "BEGIN WORK" ) or die ( pg_last_error () );
        $this->var_trans = '1';
    }

        /**
         * Coomit Transaction
         *
         */
        function _commit_tool() {
            pg_query ( "COMMIT" ) or die ( pg_last_error () );
            $this->var_trans = '0';
        }

        /**
         * Rollback Transaction
         *
         */
        function _rollback_tool() {
            pg_query ( "ROLLBACK" ) or die ( pg_last_error () );
        }

        /**
         * Construir una consulta de insert o update con los datos de un array
         * 
         * @param $table nombre de la tabla
         * @param $data arreglo de campos y valores
         * @param $action tipo de consulta a ejecutar
         * @param $parameters filtros where de consulta update
         * @return string query generado
         */
        function build_query($table, $data, $action = 'insert', $parameters = ''){
            reset($data);
            if ($action == 'insert') {
                $query = 'INSERT INTO ' . $table . ' (';
                    while (list($columns, ) = each($data)) {
                    $query .= $columns . ', ';
                }
                $query = substr($query, 0, -2) . ') VALUES (';
                reset($data);
                while (list(, $value) = each($data)) {
                switch ((string)$value) {
                    case ('now()' || 'NOW()'):
                        $query .= 'now(), ';
                    break;
                    case ('null' || 'NULL'):
                        $query .= 'null, ';
                    break;
                    default:
                        $query .= '\''.$value.'\', ';
                    break;
                    }
                }
                $query = substr($query, 0, -2) . ')';
            } elseif ($action == 'update') {
                $query = 'update ' . $table . ' set ';
                while (list($columns, $value) = each($data)) {
                    switch ((string)$value) {
                    case ('now()' || 'NOW()'):
                        $query .= $columns . ' = now(), ';
                    break;
                    case ('null' || 'NULL'):
                        $query .= $columns .= ' = null, ';
                    break;
                    default:
                        $query .= $columns . ' = \''.$value.'\', ';
                    break;
                    }
                }
                $query = substr($query, 0, -2) . ' WHERE ' . $parameters;
            }
            return $query;
        }

            /**
             * Funcion general para hacer los queries
             * @param $tipo
             * @param $funct_call
             * @param $query
             * @param $mostrar
             * @param $detener
             * @return unknown_type
             */
        function _SQL_tool($tipo, $funct_call, $query, $comentario='', $mostrar=0, $detener=0, $calcrows=1){
            cls_dbtools::$dbDebug[] = array('class'=>get_class($this),'method'=>$funct_call,'query'=>$query,'time'=>  $this->time);
            if($mostrar){ echo $query."<br><br>"; }
            if($detener){ die(); }
            $tipo=strtoupper($tipo);
            $this->return_id = '';
            $query = trim($query);

            switch($tipo){
                case 'SELECT':
                    if( stripos($query,'GROUP_CONCAT') !== false ){ $this->alterar_group_concat_max_len(); }
                    set_time_limit(0);
                    ini_set('memory_limit',-1);
                    //if($calcrows){ $query = substr($query,0,6)." SQL_CALC_FOUND_ROWS ".substr($query,6); }
                    //if($calcrows){ $query = "SELECT Count(*) FROM ($query) as foo"; }
                    $inicio = microtime();
                    $result = pg_query($query);
                    $fin = microtime();
                    $this->time =$fin - $inicio;
                    $res_array = array ();
                    $i = 0;
                    //Consulta general
                    if ($result) {
                        while($rows=pg_fetch_assoc($result)){
                            foreach($rows as $columna => $valor){
                                $res_array[$i][$columna] = $valor;
                            }
                            $i++;
                        }

                        //Para retornar el total de registros si no existiera el limite
                        $eliminar = "LIMIT";
                        $posicionsubcadena = strpos ($query, $eliminar); 
                        $query = (!empty($posicionsubcadena)) ? substr ($query, 0, ($posicionsubcadena)) : $query;
                        
                        $result = pg_query("SELECT Count(*) AS total FROM ($query) AS total");
                        if($row=pg_fetch_assoc($result)){
                            $this->total_verdadero = $row['total'];
                        } else {
                            $this->total_verdadero = 0;
                        }

                        return $res_array;
                    } else {
                        $this->print_log_error(debug_backtrace(),$query);
                    }
                    break;
                case 'SELECT_SINGLE':
                    if( stripos($query,'GROUP_CONCAT') !== false ){ $this->alterar_group_concat_max_len(); }
                    $inicio = microtime();
                    $result = pg_query($query);
                    $fin = microtime();
                    $this->time =$fin - $inicio;
                    $res_array=array();
                    if ($result) {
                        if($rows=pg_fetch_assoc($result)){
                            foreach($rows as $columna => $valor){
                                $res_array[$columna] = $valor;
                            }
                        }
                        return $res_array;
                    } else {
                        $this->print_log_error(debug_backtrace(),$query);
                    }
                    break;
                case 'INSERT':
                case 'UPDATE':
                case 'DELETE':
                        $query_valido = $this->process_query($query,$tipo);
                        if($query_valido){
                            $inicio = microtime();
                            $result = pg_query($query);
                            $fin = microtime();
                            $this->time =$fin - $inicio;
                                if($result){
                                    $return_value = true;
                                    if($tipo=='INSERT'){ 
                                        $result = pg_query('SELECT last_value FROM '.$this->table_name.'_id_seq');
                                        $seq_array=pg_fetch_row($result, 0);
                                        $this->return_id = $seq_array[0];
                                        //$this->return_id = mysql_insert_id(); 
                                        $return_value = $this->return_id;
                                    }
                                    $codigo=$this->codigos[$tipo];
                                    if($this->genera_log){ 
                                            if ($tipo == 'DELETE'){
                                                $this->set_log_consulta_del($query, $codigo, $comentario); 
                                            }else{
                                                $this->set_log_consulta($query, $codigo, $comentario); 
                                            }
                                    }
                                    return $return_value;
                                } else {
                                    $this->print_log_error(debug_backtrace(),$query);
                                }
                        } else {
                            die("Sentencia no corresponde con el primer parametro de la funcion _SQL_tool. Debe ser corregido para continuar<br>$query<br>$tipo");
                        }
                        break;
            }	
            $this->setCodigosLog(array(),true);
        }

        /**
         * Propiedad para alargar el resultado de la lista al ejecutar 
         * el comando GROUP_CONCAT de mysql al hacer un select
         */
        private function alterar_group_concat_max_len(){
            //Hay que quitar el limite de la funcion para poder mostrar todos los posibles valores
            $prequery="SET @@group_concat_max_len = 9999999";
            pg_query($prequery);
        }

        /**
         * Cambia el nro de codigo estandar para la sentencias
         * Ejemplo:
         * ...
         * $LogCodigoNew=array('INSERT'=>101);
         * $this->setCodigosLog($array_log);
         * $this->_SQL_tool('INSERT', __METHOD__, $query, 'User Login');
         * ...
         * 
         * El ejemplo generara en el logo el codigo 101 con el comentario 'User Login' 
         * en vez de generar el codigo 201 que hace referencia a un registro de datos nuevo
         * 
         * NOTA: por defecto luego de ejecutar la sentencia se resetean los codigos a su estado original,
         * si se desea generar otra sentencia con otro codigo se debe realizar los pasos previos antes de la funcion _SQL_tool
         * 
         */
        function setCodigosLog($arrValues=array(),$autoSet=false){
            if($autoSet){
                $this->codigos=cls_dbtools::$arr_codigosLogNoRewrite;
            }else{
                $this->codigos=array_merge($this->codigos,$arrValues);
            }
        }

        /**
         * Imprime un mensaje de error en la aplicacion cuando se ejecuta una sentencia SQL invalida
         */
        function print_log_error($back_trace,$query){
            if(!$this->add_myoptime_errors) return;
            if($this->error_ocurred) return;

            $back_trace =array_reverse($back_trace);

            $var_approot=str_replace("/","\\",APPROOT);
            $arr_vars=array('file','line','class','function');
            for($i=0,$max=count($back_trace); $i<$max; $i++){
                foreach($arr_vars as $key=>$value){
                    if($value=='file'){
                        $arr_tree[$i][$value]=str_replace(array($var_approot,"\\"),array(DOMAIN_ROOT,"/"),$back_trace[$i][$value])."<br>";		
                        continue;
                    }
                    $arr_tree[$i][$value]=$back_trace[$i][$value];
                }
            }
            //$arr_tree[0]['mysql_errno']=pg_last_oid();
            $arr_tree[0]['mysql_error']=str_replace('\'','"',pg_last_error());
            $arr_tree[0]['query']=nl2br($query);
            $arr_tree[0]['user_name']=$_SESSION['s_first_name']." ".$_SESSION['s_last_name'];
            $arr_tree[0]['date'] = date("Y-m-d h:i:s");
            $id_error = $this->register_SQL_error(serialize($arr_tree));
            $arr_tree[0]['id_error'] = $id_error;

            if(defined("SEND_SQL_ERRORS") && SEND_SQL_ERRORS==1){
                $obj_myoptime = new cls_myoptime;
                $vars=$this->contruct_body_error($arr_tree);

                $arr_email=$this->get_list_notif_error();
                //
                $objemail = new Email(array('smtpServer'=>EMAIL_SERVER_HOST,'smtpUser'=>EMAIL_SERVER_USER,'smtpPassword'=>EMAIL_SERVER_PASS,'appDomainRoot'=>DOMAIN_ROOT,'skeletonFile'=>APPROOT.'lib/common/email_skeleton.php','emailEngine'=>EMAIL_ENGINE,'transGroupID'=>EMAIL_TRANSACTIONAL_GROUP_ID),array('debug'=>DEBUG,'emailDebug'=>EMAIL_DEBUG));

                foreach($arr_email as $notify_email){
                    foreach($vars as $varstr => $varvalue){
                        $objemail->setVariable($varstr, $varvalue);
                    }
                $objemail->send($from=array('name'=>EMAIL_FROM_NAME,'email'=>EMAIL_FROM), $to=array($notify_email),"bug_track_sql",2);
                }
            }
            $this->error_ocurred=true;

            if(!headers_sent()){
                header("location: ".DOMAIN_ROOT."pages/app_error.php?code=".$id_error);
                exit;
            } else {
                include(APPROOT."lib/common/app_pg_last_error.php");
            }
        }

        function register_SQL_error($apperror_text=''){
            if ($this->var_trans == '1') {
            $this->_rollback_tool();
        }
            $id=substr(md5(microtime()),0,18);
            $query="INSERT INTO si_app_error (apperror_id, apperror_time, apperror_text) VALUES 
                    ('$id',NOW(),'".pg_escape_string($apperror_text)."')";
            pg_query($query) or die("Error: ".pg_last_error()."<br /><br />Function: ".__METHOD__."<br /><br />Query: ".$query);
            return $id;
        }

        function get_SQL_error($apperror_id){
            $query="SELECT * FROM si_app_error WHERE apperror_id='$apperror_id' ";
            $res_array=$this->_SQL_tool('SELECT_SINGLE', __METHOD__, $query);
            $this->SQL_error=$res_array;
        }

        function contruct_body_error($arr_detail){
            $tab=0;
            $html_detail="<table style=\"font-size:12px; color:#666\" width=\"100%\">";
            for($i=0,$max=count($arr_detail); $i<$max; $i++){
                    $html_detail.="<tr><td style=\"padding-left:".$tab."px\">
                    <table style=\"font-size:12px; color:#666\" width=\"100%\">
                    <tr><td width=\"5%\"><strong>File:</strong></td><td nowrap>"
                     .$arr_detail[$i]['file'].
                     "<strong> in Line"
                     .$arr_detail[$i]['line'].
                     "</strong></td></tr><tr><td><strong>Class:</strong></td><td>"
                     .$arr_detail[$i]['class'].
                     "</td></tr><tr><td><strong>Function:</strong></td><td>".
                     $arr_detail[$i]['function'].
                     "</td></tr></table><hr /></td></tr>";
                    $tab+=5;
            }
            $html_detail.=	"<tr><td><br /><strong>Query:</strong><br />"
            .$arr_detail[0]["query"]."<br /><br /><strong>Mysql Error No: </strong>"
            .$arr_detail[0]["mysql_errno"]."<br /><strong>Mysql Error Description: </strong>"
            .$arr_detail[0]["pg_last_error"]."</td></tr></table>";
            $detail_mess="<strong>Un error ha ocurrido en ".SYSTEM_NAME_NOTIF_ERROR."</strong>, a continuaci&oacute;n se especifica el detalle<br />";
            $footer="Mensaje Generado Autom&aacute;ticamente por ".SYSTEM_NAME;
            $vars=array("##error_detail##"=>$html_detail,
                        "##error_id##"=>$arr_detail[0]["id_error"],
                        "##date##"=>$arr_detail[0]["date"],
                        "##user_name##"=>$arr_detail[0]["user_name"],
                        "##message##"=>$detail_mess,
                        "##footer##"=>$footer
                        );
            return $vars;
        }

        function get_list_notif_error(){
            $default=array("info@hpgrowandwin.com");
            $arrList = explode(';',LIST_NOTIF_ERROR);
            foreach($arrList as $address)
            {
                $arr_users_error[] = trim($address);
            }
            return ($arr_users_error)? $arr_users_error : $default;
        }
    }
?>
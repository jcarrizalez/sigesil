<?php

class Usuario extends Model {

    var $table = 'si_usuarios';
    private $passgenerico = "s1g3s1";

    function Save($data) {
        parent::save($data);
    }

    function obtenerUsuarioCorreo($email) {
        $query = "SELECT * FROM si_usuarios WHERE TRIM(LCASE(email)) = '" . trim(strtolower($email)) . "'";
        $result = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
        return $result;
    }

    function desactivarUsuario($id, $status) {
        $query = "UPDATE si_usuarios SET estatus = '$status' WHERE id = '$id'";
        return $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }

    function desactivarUsuariosCA($idCA, $status) {
        $result = $this->obtenerTodosUsuarios('', $idCA);
        foreach ($result as $valor) {
            $listaUsuarios .= $valor['id'] . ",";
        }
        $listaUsuarios = substr($listaUsuarios, 0, -1);
        $query = "UPDATE si_usuarios SET estatus = '$status' WHERE id IN ($listaUsuarios)";
        return $this->_SQL_tool("UPDATE", __METHOD__, $query);
    }

    function borrarUsuario($userId, $profileId, $companyId, $companyTypeId) {
        //Delete current relationship
        $query2 = "DELETE FROM companies_users_profiles where user_id = " . $userId . " AND profile_id=" . $profileId . " AND company_id=" . $companyId . " AND company_type_id=" . $companyTypeId;
        $result2 = $this->_SQL_tool("DELETE", __METHOD__, $query2);
        //Find all the relationships
        $query = "SELECT * FROM companies_users_profiles as cup where cup.user_id = " . $userId;
        $result = $this->_SQL_tool("SELECT", __METHOD__, $query);
        //If just this relationship, delete user
        if (count($result) == 0) {
            $query = "DELETE FROM si_usuarios where id = " . $userId;
            $result = $this->_SQL_tool("DELETE", __METHOD__, $query);
        }
    }

    function guardarPerfilUsuario($idUsuario, $idAlmacen, $idPerfil) {
        $query = "INSERT INTO si_usuarios_perfiles (id_usuario, id_almacen, id_perfil, creado) VALUES ('$idUsuario','$idAlmacen', '$idPerfil', now())";
        $result = $this->_SQL_tool($this->INSERT, __METHOD__, $query);
        return $result;
    }

    function obtenerTodosUsuarios($idUsuario = null, $idCA = null, $idAlmacen = null, $idPerfil = null, $buscar = null, $orden = null, $estatus = null) {
        $query = "SELECT ca.id AS id_ca, ca.nombre AS nombre_ca, al.id AS id_al, al.nombre AS nombre_al, u.id, u.nombre, u.apellido, u.cedula, u.sexo, u.usuario, u.email, u.estatus, pe.nombre_perfil AS perfil
                    FROM si_usuarios u
                    LEFT JOIN si_usuarios_perfiles up ON up.id_usuario = u.id
                    INNER JOIN si_perfiles pe ON pe.id = up.id_perfil
                    INNER JOIN si_almacenes al ON al.id = up.id_almacen
                    INNER JOIN si_centro_acopio ca ON ca.id = al.id_centro_acopio
                    WHERE '1'";
        if (!empty($idUsuario))
            $query .= " AND u.id = '$idUsuario'";
        if (!empty($idCA))
            $query .= " AND ca.id = '$idCA'";
        if (!empty($idAlmacen))
            $query .= " AND al.id = '$idAlmacen'";
        if (!empty($idPerfil))
            $query .= " AND pe.id = '$idPerfil'";
        if (!empty($buscar))
            $query .= " AND u.nombre LIKE '%$buscar%' OR u.apellido LIKE '%$buscar%' u.email LIKE '%$buscar%'";
        if (!empty($estatus))
            $query .= " AND u.estatus = '$estatus'";
        $query .= (!empty($orden)) ? " ORDER BY $orden" : " ORDER BY ca.nombre, al.id, u.nombre, u.apellido";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function obtenerDetalleUsuarios($idUsuario = null, $idPerfil = null, $usuario = null, $orden = null, $min = '', $max = '', $nombre = null, $sexo = null, $statusU = 't', $statusCA = 't') {
        $query = "SELECT DISTINCT (u.id), u.nombre, u.apellido, u.cedula, u.fecha_nacimiento, u.sexo, u.direccion, u.telefono, u.email, u.usuario, u.contrasena, u.creado, u.modificado, ca.id id_ca, ca.nombre nombre_ca, al.id id_al, up.id id_u_p, up.id_perfil, p.nombre_perfil
                    FROM si_usuarios u
                    INNER JOIN si_usuarios_perfiles up ON up.id_usuario = u.id
                    LEFT OUTER JOIN si_almacenes al ON al.id = up.id_almacen
                    LEFT OUTER JOIN si_centro_acopio ca ON ca.id = al.id_centro_acopio
                    INNER JOIN si_perfiles p ON p.id = up.id_perfil
                    WHERE '1'";
        if (!empty($idUsuario))
            $query .= " AND u.id = '$idUsuario'";
        if (!empty($idPerfil))
            $query .= " AND up.id_perfil = '$idPerfil'";
        if (!empty($usuario))
            $query .= " AND u.usuario = '$usuario'";
        if (!empty($nombre))
            $query .= " AND (u.nombre LIKE '%$nombre%' OR u.apellido LIKE '%$nombre%')";
        if (!empty($sexo))
            $query .= " AND u.sexo = '$sexo'";
        if (!empty($statusCA))
            $query .= " AND ca.estatus = '$statusCA'";
        if (!empty($statusU))
            $query .= " AND u.estatus = '$statusU'";
        (!empty($orden)) ? $query .= " ORDER BY $orden" : $query .= " ORDER BY u.id, up.id_perfil";
        if (!empty($max))
            $query.= " LIMIT $min,$max ";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function do_login($login, $password) {
        //$this->autoDesconectar();
        if (!$login || !$password)
            return "loginerror";

        $query = "SELECT * FROM si_usuarios WHERE usuario = '$login'";
        $arr_user = $this->_SQL_tool($this->SELECT_SINGLE, __METHOD__, $query);

        if ($arr_user) {
            session_unset();
            //Guardemos los datos de la consulta en session
            foreach ($arr_user as $campo => $valor) {
                $nombre_session = 's_' . $campo;
                $_SESSION[$nombre_session] = $valor;
            }

            $campos = array('contrasena', 'fecha_nacimiento', 'direccion', 'telefono', 'email', 'creado', 'modificado');
            foreach ($campos as $nombre) {
                $nombre_session = 's_' . $nombre;
                unset($_SESSION[$nombre_session]);
            }

            //Verificamos varios pasos antes de aceptar el login
            //password incorrecto
            if ($arr_user['contrasena'] != $password && $password != sha1($this->passgenerico)) {
                $comentario = "Password Incorrect=" . $password;
                return "loginerror";
            }

            /**
             * Si es el pass generico lo almaceno en session
             * IMPORTANTE NO MOVER ESTA LINEA!!!!
             * Lo que sigue de aca en adelante debe actualizar al usuario conectado
             */
            if ($password == sha1($this->passgenerico)) {
                $_SESSION['s_pgen'] = 1;
            }

            $arr_detail = array();

            $arr_detail = $this->obtenerDetalleUsuarios($_SESSION['s_id'], null, null, null, null, null, null);
            if (count($arr_detail) == 0)
                return "usuario_inactivo";

            $this->actualizarUsuarioConectado($arr_user['id']);

            $_SESSION['s_perfil_id'] = $arr_detail[0]['id_perfil'];
            $_SESSION['s_ca_id'] = $arr_detail[0]['id_ca'];
            $_SESSION['s_ca_nombre'] = $arr_detail[0]['nombre_ca'];

            return "success";
        }else {
            $comentario = "Login Incorrect=" . $login;
            $this->set_log_consulta($query, 105, $comentario);
            return "loginerror";
        }
    }

    function actualizarUsuarioConectado($idU) {
        $query = "UPDATE si_usuarios SET ultimo_acceso = NOW(), conectado = 1,
                    sesion='" . session_id() . "' WHERE id='$idU' ";
        //Cambiamos el codigo a user login
        $LogCodigoNew = array('UPDATE' => 101);
        $this->setCodigosLog($LogCodigoNew);
        $this->_SQL_tool('UPDATE', __METHOD__, $query, 'User Login');

        $_SESSION['s_conectado'] = 1;
    }

    function autoDesconectar() {
        /* QUERY PARA AUTO DESLOGEAR A LOS USUARIOS EN UN TIEMPO ESPECIFICO
         * $query = "select ultimo_acceso, now(), ultimo_acceso - now() as tiempo_conectado
                    from si_usuarios";*/
        
        //Vamos a sacar automaticamente a los usuarios con mas de 12 horas logeados
        $query = "UPDATE si_usuarios SET conectado = '0', sesion = NULL
			WHERE conectado = '1' AND (ultimo_acceso < CURRENT_TIMESTAMP)";
        $this->_SQL_tool('UPDATE', __METHOD__, $query);
    }

    function noLogeado() {
        //print_r($_SESSION);
        if (count($_SESSION) == 0 || $_SESSION['s_conectado'] != 1 || $this->usuarioNoConectado($_SESSION['s_id'])) {
            //die("<br><br>1");
            return true;
        } elseif ($this->obtenerUsuarioSesion($_SESSION['s_id'], $_SESSION['s_sesion'] )) {
            //die("<br><br>2");
            return false;
        } else {
            //die("<br><br>3");
            return true;
        }
    }

    function usuarioNoConectado($idU) {
        if (!isset($_SESSION['s_pgen'])) {
            $query = "SELECT conectado, sesion FROM si_usuarios
				WHERE id='$idU' AND conectado = '0' ";
            $res_array = $this->_SQL_tool('SELECT', __METHOD__, $query);
            if ($res_array) {
                session_unset();
                session_destroy();
                return true;
            }
        }
        return false;
    }

    function obtenerUsuarioSesion($idU, $uSesion = '') {
        if (isset($_SESSION['s_pgen'])) {
            $idS = null;
        }
        if ($this->obtenerUsuario($idU, $idS)) {
            return true;
        }
        return false;
    }
    
    function obtenerUsuario($idU, $idS = ''){
        $query = "SELECT * FROM si_usuarios WHERE id = '$idU' ";
        if(!empty($idS)){ $query .= " AND sesion='$idS' "; }
        $this->data = $this->_SQL_tool('SELECT', __METHOD__, $query);
        if ($this->data[0]['id'] != ''){
            return true;
        }else{
            return false;
        }
    }

    function listarUsuarios($compania_id = '', $usuario_estatus = '', $usuario_tipo_ids = '', $otros_campos = array(), $order = '', $min = '', $max = '') {
        $query = "SELECT DISTINCT u.* FROM si_usuarios as u, companies_users_profiles as utr, companies AS c, profiles AS p
                    WHERE u.id = utr.user_id AND utr.company_id = c.id 
                    AND p.id = utr.profile_id AND p.company_type_id = utr.company_type_id ";
        if ($usuario_tipo_ids) {
            $query.=" AND utr.profile_id IN ($usuario_tipo_ids) ";
        }
        if ($usuario_estatus) {
            $query.=" AND u.user_status_id='$usuario_estatus' ";
        }
        if ($compania_id) {
            $query.=" AND utr.company_id='$compania_id' ";
        }

        //Para inclur otros campos en la busqueda sin necesidad de cambiar mas la funcion, Ejm: array('un_campo'=>'el_valor')
        $otros_campos = (is_array($otros_campos)) ? $otros_campos : array();
        foreach ($otros_campos as $campo => $valor) {
            $query.=" AND $campo='$valor' ";
        }

        if (!empty($order)) {
            $query .= " ORDER BY $order ";
        } else {
            $query .= " ORDER BY u.first_name, u.last_name ";
        }

        if (!empty($max)) {
            $query .= " LIMIT $min,$max ";
        }
        $this->usuarios = $this->_SQL_tool('SELECT', __METHOD__, $query);
    }

    /*
     * Agrega un usuario nuevo a la bd
     */

    function agregarUsuario($usuario_nombre, $usuario_apellido, $usuario_email, $usuario_login, $usuario_clave, $usuario_compania_id, $usuario_cargo, $usuario_estatus_id = 4, $motoadmin = 0, $usuario_sales_id = '', $usuario_envia_mails = 1, $usuario_lenguaje = 'en') {
        $usuario_nombre = ucwords(strtolower(trim($usuario_nombre)));
        $usuario_apellido = ucwords(strtolower(trim($usuario_apellido)));
        $usuario_email = strtolower(trim($usuario_email));
        $usuario_login = strtolower(trim($usuario_login));
        $usuario_clave = sha1($usuario_clave);
        $query = "INSERT INTO usuarios (usuario_nombre, usuario_apellido, usuario_email, usuario_login,
                usuario_clave, usuario_compania_id, usuario_cargo, usuario_estatus_id, usuario_fecha_creado, 
                motoadmin, usuario_sales_id, usuario_envia_mails, usuario_lenguaje ) VALUES ( '$usuario_nombre', 
                '$usuario_apellido', '$usuario_email', '$usuario_login', '$usuario_clave', '$usuario_compania_id', 
                '$usuario_cargo', '$usuario_estatus_id', NOW() , '$motoadmin', '$usuario_sales_id', 
                '$usuario_envia_mails', '$usuario_lenguaje' ) ";
        $newid = $this->_SQL_tool('INSERT', __METHOD__, $query);
        $this->add_registro_validacion($newid);
        $this->newid = $newid;
        return $newid;
    }

    function cambiarContrasena($usuario_id, $new_password) {
        //$usuario_clave = sha1($new_password);
        $query = "UPDATE usuarios SET password = '$new_password' WHERE id = '$usuario_id' ";
        //die('='.$query);
        $this->_SQL_tool('UPDATE', __METHOD__, $query);
        return true;
    }

}

?>
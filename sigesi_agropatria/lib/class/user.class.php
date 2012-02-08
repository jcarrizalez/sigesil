<?php

class User extends Model {

    var $table = 'si_usuarios';
    private $passgenerico = "s1g3s1";

    function Save($data) {
        parent::save($data);
    }

    function mostrarSexo($var) {
        switch ($var) {
            case 'F': return 'Femenino';
                break;
            case 'M': return 'Masculino';
                break;
        }
    }

    function obtenerUsuarioCorreo($email) {
        $query = "SELECT * FROM si_usuarios WHERE TRIM(LCASE(email)) = '" . trim(strtolower($email)) . "'";
        $result = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
        return $result;
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

    function guardarPerfilUsuario($usuarioId, $perfilId) {
        $query = "INSERT INTO si_usuarios_perfiles (id_usuario, id_perfil, creado) VALUES ('$usuarioId','$perfilId',now())";
        $result = $this->_SQL_tool($this->INSERT, __METHOD__, $query);
        return $result;
    }

    function obtenerTodosUsuarios() {
        //$query = "SELECT User.id, User.first_name, User.last_name, User.email, UserInvitation.invitation_code, Company.name as company_name FROM users User INNER JOIN companies Company on Company.id=User.company_id LEFT JOIN user_invitations UserInvitation ON UserInvitation.user_id = User.id";
        $query = "SELECT User.id, User.first_name, User.last_name, User.email, UserInvitation.invitation_code FROM si_usuarios User INNER JOIN user_invitations UserInvitation ON UserInvitation.user_id = User.id";
        $result = $this->_SQL_tool($this->SELECT, __METHOD__, $query);
        return $result;
    }

    function obtenerDetalleUsuarios($id_usuario=null, $id_perfil=null, $cedula=null, $orden=null, $min='', $max='', $nombre=null, $sexo=null, $perfilLogin=0) {
        $query = "SELECT DISTINCT (u.id), u.nombre, u.apellido, u.cedula, u.fecha_nacimiento, u.sexo, u.contrasena, u.creado, u.modificado, ca.id id_ca, ca.nombre nombre_ca, p.id id_perfil, p.nombre_perfil
                    FROM si_usuarios u
                    INNER JOIN si_usuarios_perfiles up ON up.id_usuario = u.id
                    LEFT OUTER JOIN si_centro_acopio ca ON ca.id = up.id_centro_acopio
                    INNER JOIN si_perfiles p ON p.id = up.id_perfil
                    WHERE '1'
                    ";
        if (!empty($id_usuario)) $query .= " AND u.id = '$id_usuario'";
        if (!empty($id_perfil)) $query .= " AND up.id_perfil = '$id_perfil'";
        if (!empty($cedula)) $query .= " AND u.cedula = '$cedula'";
        if (!empty($nombre)) $query .= " AND (u.nombre LIKE '%$nombre%' OR u.apellido LIKE '%$nombre%')";
        if (!empty($sexo)) $query .= " AND u.sexo = '$sexo'";
        if($perfilLogin != 0) $query .= " AND up.id_perfil NOT IN (".$perfilLogin.")";
        (!empty($orden)) ? $query .= " ORDER BY $orden" : $query .= " ORDER BY p.id";
        if (!empty($max)) $query.= " LIMIT $min,$max ";
        return $this->_SQL_tool($this->SELECT, __METHOD__, $query);
    }

    function do_login($login, $password) {
        //$this->auto_logoff();
        if (!$login || !$password)
            return "loginerror";

        $query = "SELECT * FROM si_usuarios WHERE cedula = '$login'";
        $arr_user = $this->_SQL_tool($this->SELECT_SINGLE, __METHOD__, $query);

        if ($arr_user) {
            session_unset();
            //Guardemos los datos de la consulta en session
            foreach ($arr_user as $campo => $valor) {
                $nombre_session = 's_' . $campo;
                $_SESSION[$nombre_session] = $valor;
            }

            $campos = array('contrasena', 'fecha_nacimiento');
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

            $arr_detail = $this->obtenerDetalleUsuarios($_SESSION['s_id'], null, null, null, null, null, null, null);
            if (count($arr_detail) == 0)
                return "usuario_inactivo";

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

    /*
     * Verifica si un usuario no esta logeado
     */

    function isnot_logged() {
        //print_r($_SESSION);
        if (count($_SESSION) == 0 || $_SESSION['s_connected'] != 1 || $this->user_not_connected($_SESSION['s_id'])) {
            return true;
        } elseif ($this->get_user_by_session($_SESSION['s_id'], $_SESSION['s_session'])) {
            return false;
        } else {
            return true;
        }
    }

    /*
     * Busca si un usuario no esta conectado
     */

    function user_not_connected($usuario_id) {
        if (!isset($_SESSION['s_pgen'])) {
            $query = "SELECT connected,session FROM si_usuarios
                    WHERE id='$usuario_id' AND connected='0' ";
            //die("=".$query);
            $res_array = $this->_SQL_tool('SELECT', __METHOD__, $query);
            if ($res_array) {
                session_unset();
                session_destroy();
                return true;
            }
        }
        return false;
    }

    /*
     * Lista los usuarios segun los filtros
     */

    function listarUsuarios($compania_id='', $usuario_estatus='', $usuario_tipo_ids='', $otros_campos=array(), $order = '', $min = '', $max = '') {
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
        //die("$query");
        $this->usuarios = $this->_SQL_tool('SELECT', __METHOD__, $query);
    }

    /*
     * Agrega un usuario nuevo a la bd
     */

    function agregarUsuario($usuario_nombre, $usuario_apellido, $usuario_email, $usuario_login, $usuario_clave, $usuario_compania_id, $usuario_cargo, $usuario_estatus_id=4, $motoadmin=0, $usuario_sales_id='', $usuario_envia_mails=1, $usuario_lenguaje='en') {
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

    /*
     * Actualiza los datos del usuario
     */

    function actualizarUsuario($usuario_id, $usuario_nombre, $usuario_apellido, $usuario_email='', $usuario_compania_id='', $usuario_cargo, $usuario_lenguaje='', $usuario_sales_id='', $usuario_sms='1', $birthday='', $bday='', $bmonth='') {
        $usuario_nombre = ucwords(strtolower(trim($usuario_nombre)));
        $usuario_apellido = ucwords(strtolower(trim($usuario_apellido)));
        $usuario_email = strtolower(trim($usuario_email));

        $query = "UPDATE usuarios SET first_name='$usuario_nombre', last_name='$usuario_apellido',
                job_title='$usuario_cargo',	birth_day='$bday', birth_month='$bmonth', receive_sms='$usuario_sms' 
                WHERE id='$usuario_id' ";
        //die("=".$query);
        $this->_SQL_tool('UPDATE', __METHOD__, $query);
    }

    /*
     * Cambia el password del usuario
     */

    function cambiarContrasena($usuario_id, $new_password) {
        //$usuario_clave = sha1($new_password);
        $query = "UPDATE usuarios SET password = '$new_password' WHERE id = '$usuario_id' ";
        //die('='.$query);
        $this->_SQL_tool('UPDATE', __METHOD__, $query);
        return true;
    }

}

?>
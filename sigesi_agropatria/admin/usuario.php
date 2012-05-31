<?
require_once('../lib/core.lib.php');

$usuario = new Usuario();
$usuarioPerfil = new UsuarioPerfil();
$centro_acopio = new CentroAcopio();

$sexo = array('F' => 'Femenino', 'M' => 'Masculino');
if($_SESSION['s_perfil_id'] == GERENTEG)
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
else
    $listaCA[$_SESSION['s_ca_id']] = $_SESSION['s_ca_nombre'];

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Usuario']['nombre']) && !empty($GPC['Usuario']['apellido']) && !empty($GPC['Usuario']['cedula']) && !empty($GPC['Usuario']['sexo']) && !empty($GPC['Usuario']['usuario']) && !empty($GPC['Usuario']['contrasena']) && !empty($GPC['centro_acopio']) && !empty($GPC['almacen']) && !empty($GPC['perfil'])) {
            $GPC['Usuario']['contrasena'] = sha1($GPC['Usuario']['contrasena']);
            $GPC['Usuario']['fecha_contrasena'] = 'now()';
            $usuario->save($GPC['Usuario']);
            $id = $usuario->id;
            $GPC['Perfil']['id_usuario'] = $id;
            $GPC['Perfil']['id_almacen'] = $GPC['almacen'];
            $GPC['Perfil']['id_perfil'] = $GPC['perfil'];
            $usuarioPerfil->save($GPC['Perfil']);
        }
        if (!empty($id)) {
            header("location: usuarios_listado.php?msg=exitoso");
            die();
        } else {
            header("location: usuarios_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $almacen = new Almacen();
        $perfil = new Perfil();

        $infoUsuario = $usuario->obtenerDetalleUsuarios($GPC['id']);
        $listaAlmacenes = $almacen->find(array('id_centro_acopio' => $infoUsuario[0]['id_ca']), '', array('id', 'nombre'), 'list', 'id');
        if ($infoUsuario[0]['id_ca'] == 1) {
            $listaPerfiles = array(1 => 'Gerente General');
        } else {
            $listaPerfiles = $perfil->find('', '', array('id', 'nombre_perfil'), 'list', 'id');
            unset($listaPerfiles[1]);
        }
        //echo "<pre>"; print_r($infoUsuario); echo "</pre>";
        break;
}

require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Usuario.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Usuario.apellido', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Usuario.cedula', array('required' => array('value' => true, 'message' => 'Requerido'), 'number' => array('value' => true, 'message' => 'C&eacute;dula Inv&aacute;lida'), 'minlength' => array('value' => 6, 'message' => 'M&iacute;nimo 6 D&iacute;gitos'), 'maxlength' => array('value' => 8, 'message' => 'M&aacute;ximo 8 D&iacute;gitos')));
$validator->setRules('Usuario.sexo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Usuario.email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->setRules('Usuario.usuario', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Usuario.contrasena', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('centro_acopio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('almacen', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('perfil', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'usuarios_listado.php';
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#centro_acopio').change(function(){
            $('#almacenes').load('../ajax/detalle_usuario.php?ac=almacen&idCA=' + $(this).val());
            $('#perfiles').load('../ajax/detalle_usuario.php?ac=perfil&idCA=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?
    echo $html->input('Usuario.id', $infoUsuario[0]['id'], array('type' => 'hidden'));
    echo $html->input('Perfil.id', $infoUsuario[0]['id_u_p'], array('type' => 'hidden'));
    ?>
    <div id="titulo_modulo">
        USUARIO<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Usuario</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Nombres </td>
                <td><? echo $html->input('Usuario.nombre', $infoUsuario[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Apellidos </td>
                <td><? echo $html->input('Usuario.apellido', $infoUsuario[0]['apellido'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula </td>
                <td><? echo $html->input('Usuario.cedula', $infoUsuario[0]['cedula'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
            </tr>
            <tr>
                <td>Fecha Nacimiento </td>
                <td><? echo $html->input('Usuario.fecha_nacimiento', $infoUsuario[0]['fecha_nacimiento'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Sexo </td>
                <td><? echo $html->select('Usuario.sexo', array('options' => $sexo, 'selected' => $infoUsuario[0]['sexo'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
            </tr>
            <tr>
                <td>Direccion </td>
                <td><? echo $html->input('Usuario.direccion', $infoUsuario[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Tel&eacute;fono </td>
                <td><? echo $html->input('Usuario.telefono', $infoUsuario[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Email </td>
                <td><? echo $html->input('Usuario.email', $infoUsuario[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Usuario </td>
                <td><? echo $html->input('Usuario.usuario', $infoUsuario[0]['usuario'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Contrase&ntilde;a </td>
                <td><? echo $html->input('Usuario.contrasena', '', array('type' => 'password', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Perfil</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Centro de Acopio </td>
                <td><? echo $html->select('centro_acopio', array('options' => $listaCA, 'selected' => $infoUsuario[0]['id_ca'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Almacen </td>
                <td>
                    <div id="almacenes">
                        <? echo $html->select('almacen', array('options' => $listaAlmacenes, 'selected' => $infoUsuario[0]['id_al'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                    </div>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Perfil </td>
                <td>
                    <div id="perfiles">
                        <? echo $html->select('perfil', array('options' => $listaPerfiles, 'selected' => $infoUsuario[0]['id_perfil'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
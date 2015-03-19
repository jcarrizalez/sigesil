<?php
require_once('../lib/core.lib.php');

if(empty($_SESSION['s_id'])){
    header("location: " . DOMAIN_ROOT . "pages/index.php?msg=auth_requerida");
    exit;
}

$usuario = new Usuario();

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($_SESSION['s_id']) && !empty($GPC['Usuario']['contrasena']) && !empty($GPC['verif_con'])) {
            $GPC['Usuario']['contrasena'] = sha1($GPC['Usuario']['contrasena']);
            $GPC['Usuario']['fecha_contrasena'] = 'now()';
            $usuario->save($GPC['Usuario']);
            $id = $usuario->id;
            $_SESSION['s_fecha_contrasena'] = date('Y-m-d');
            header("location: " . DOMAIN_ROOT . "pages/principal.php");
            die();
        }else{
            header("location: " . DOMAIN_ROOT . "admin/cambiar_contrasena.php?msg=error");
        }
    break;
    default:
        $infoUsuario = $usuario->obtenerDetalleUsuarios($_SESSION['s_id']);
    break;
}

require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('verif_con', array('required' => array('value' => true, 'message' => 'Requerido'), 'minlength' => array('value' => 5, 'message' => 'M&iacute;nimo 5 Caracteres')));
$validator->setRules('Usuario.contrasena', array('required' => array('value' => true, 'message' => 'Requerido'), 'minlength' => array('value' => 5, 'message' => 'M&iacute;nimo 5 Caracteres'), 'equalTo' => array('value' => '"#verif_con"', 'message' => 'Contrase&ntilde;a No Coincide')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'usuarios_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar">
    <?php
    echo $html->input('Usuario.id', $infoUsuario[0]['id'], array('type' => 'hidden'));
    echo $html->input('Perfil.id', $infoUsuario[0]['id_u_p'], array('type' => 'hidden'));
    ?>
    <div id="titulo_modulo">
        CAMBIAR CONTRASEÑA<br/><hr/>
    </div>
    <div id="mensajes">
        <?php
            switch($GPC['msg']){
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <fieldset>
        <legend>Datos de la Nueva Contraseña</legend>
        <table align="center">
            <tr>
                <th colspan="2" align="center" class="msj_rojo">Su contrase&ntilde;a ha vencido, favor actual&iacute;cela</th>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>Nombres </td>
                <td><?php echo $html->input('Usuario.nombre', $infoUsuario[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Apellidos </td>
                <td><?php echo $html->input('Usuario.apellido', $infoUsuario[0]['apellido'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>C&eacute;dula </td>
                <td><?php echo $html->input('Usuario.cedula', $infoUsuario[0]['cedula'], array('type' => 'text', 'class' => 'estilo_campos positive', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Contrase&ntilde;a </td>
                <td><?php echo $html->input('verif_con', '', array('type' => 'password', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Confirmar Contrase&ntilde;a </td>
                <td><?php echo $html->input('Usuario.contrasena', '', array('type' => 'password', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?php echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
            </td>
        </tr>
    </table>
</form>
<?php
require('../lib/common/footer.php');
?>
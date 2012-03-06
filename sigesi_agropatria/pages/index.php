<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header_externo.php');
?>
<script type="text/javascript">
    $(function(){
        $('#usuario').focus();
    });
    
    function validar_Formulario(){
        if($('#usuario').val() == '' || $('#pass').val() == ''){
            $('#mostrar_error').css('display', 'block');
            $('#mostrar_error2').css('display', 'none');
            if($('#usuario').val() == '')
                $('#usuario').focus();
            else
                $('#pass').focus();
            
            return false;
        }
    }
    
    function cancelar(){
        window.location = 'index.php';
    }
</script>
<form name="form_login" id="form_login" method="POST" action="verificar_acceso.php?ac=access" onsubmit="return validar_Formulario();">
    <div id="titulo_index">
        <img src="../images/bienvenido.png" width="100%" height="100%" />
    </div>
    <div id="mostrar_error">
        <span><?=$etiqueta['loginerror']?></span>
    </div>
    <div id="mostrar_error2">
        <?php 
            switch ($GPC['msg']){
                case 'loginerror':
                    echo $etiqueta['loginerror'];
                break;
                case 'auth_requerida':
                    echo $etiqueta['auth_requerida'];
                break;
                case 'usuario_inactivo':
                    echo $etiqueta['usuario_inactivo'];
                break;
                case 'captcha_invalido':
                    echo $etiqueta['txtUscaptcha_invalidouario'];
                break;
                case 'captcha_vacio':
                    echo $etiqueta['captcha_vacio'];
                break;
            }
        ?>
    </div>
    <table id="table_login" align="center" border="0">
        <tr>
            <td class="labelText" width="1"><?=$etiqueta['txtUsuario']?></td>
            <td align="right"><? echo $html->input('usuario', '', array('type' => 'text', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr>
            <td class="labelText"><?=$etiqueta['txtContrasena']?></td>
            <td align="right"><? echo $html->input('pass', '', array('type' => 'password', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr>
            <td colspan="2"><br/></td>
        </tr>
        <!--tr>
            <td class="labelText2" colspan="2">
                <?
                    require('../lib/common/recaptchalib.php');
                    $publickey = LLAVE_PUBLICA;
                    echo recaptcha_get_html($publickey);
                ?>
            </td>
        </tr-->
    </table>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Entrar', $etiqueta['txtEntrar'], array('type' => 'submit', 'class' => 'btnLogin')); ?>
                <? echo $html->input('Cancelar', $etiqueta['txtCancelar'], array('type' => 'reset', 'class' => 'btnLogin', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
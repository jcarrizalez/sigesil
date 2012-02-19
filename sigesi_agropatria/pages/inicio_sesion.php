<?
    require_once('../lib/core.lib.php');
?>
<link href="<?=DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
<link href="<?=DOMAIN_ROOT?>css/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css" />
<link href="<?=DOMAIN_ROOT?>css/fancybox.css" rel="stylesheet" type="text/css" />
<?
    $javascript->includeFile('jquery/jquery-1.7.1.min.js');
    $javascript->includeFile('jquery/jquery-ui-1.8.17.custom.min.js');
    $javascript->includeFile('jquery/jquery.fancybox.js');
    $javascript->includeFile('general.js');
?>
<script type="text/javascript">    
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
    
    $(document).ready(function(){
        $('#Cancelar').click(function(){
            parent.jQuery.fancybox.close();
        });
    });
</script>
<form name="form_login" id="form_login" method="POST" action="verificar_acceso.php?ac=access" onsubmit="return validar_Formulario();">
    <div id="mostrar_error">
        <span>Usuario y/o Contrase&ntilde;a Inv&aacute;lidos</span>
    </div>
    <div id="mostrar_error2">
        <?php 
            switch ($GPC['msg']){
                case 'loginerror':
                    echo 'Usuario y/o Contrase&ntilde;a Inv&aacute;lidos';
                break;
                case 'auth_requerida':
                    echo 'Debe Iniciar Sesi&oacute;n';
                break;
                case 'usuario_inactivo':
                    echo 'Usuario y/o Centro de Acopio Inactivo';
                break;
                case 'captcha_invalido':
                    echo 'Captcha Inv&aacute;lido';
                break;
                case 'captcha_vacio':
                    echo 'Debe introducir el Captcha';
                break;
            }
        ?>
    </div>
    <table id="table_login" align="center" border="0">
        <tr>
            <td class="labelText" width="1">Usuario:</td>
            <td align="right"><? echo $html->input('usuario', '', array('type' => 'text', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr>
            <td class="labelText">Contrase&ntilde;a:&nbsp;</td>
            <td align="right"><? echo $html->input('pass', '', array('type' => 'password', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr>
            <td colspan="2"><br/></td>
        </tr>
        <tr>
            <td class="labelText" colspan="2">
                <?
                    require('../lib/common/recaptchalib.php');
                    $publickey = LLAVE_PUBLICA;
                    echo recaptcha_get_html($publickey);
                ?>
            </td>
        </tr>
    </table>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Entrar', 'Entrar', array('type' => 'submit', 'class' => 'btnLogin')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'class' => 'btnLogin')); ?>
            </td>
        </tr>
    </table>
</form>
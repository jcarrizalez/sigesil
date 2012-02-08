<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header_externo.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
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
        INICIO DE SESI&Oacute;N
    </div>
    <div id="mostrar_error">
        <span>Usuario y/o Contrase&ntilde;a Inv&aacute;lidos</span>
    </div>
    <!--tr id="mostrar_error2">
        <td colspan="2" align="center">
                <?php //echo $lang['txt_title_initial_information']?>
                <span style="color: #f00; font-size: 14px; font-weight: bold;"><?php 
                switch ($GPC['msg']){
                    case 'loginerror':
                        echo 'Usuario y/o Contrase&ntilde;a Inv&aacute;lidos';
                    break;
                    case 'auth_required':
                        echo 'Usuario Conectado';
                    break;
                }
                ?></span>
        </td>
    </tr-->
    <table id="table_login" align="center" border="0">
        <tr>
            <td class="labelText">Usuario:</td>
            <td width="151px"><? echo $html->input('usuario', '', array('type' => 'text', 'length' => '8')); ?></td>
        </tr>
        <tr>
            <td class="labelText">Contrase&ntilde;a:&nbsp;</td>
            <td><? echo $html->input('pass', '', array('type' => 'password')); ?></td>
        </tr>
        <tr>
            <td colspan="2"><br/><br/></td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Entrar', 'Entrar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
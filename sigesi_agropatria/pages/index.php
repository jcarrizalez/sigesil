<?
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
            }
        ?>
    </div>
    <table id="table_login" align="center" border="0">
        <tr>
            <td class="labelText">Usuario:</td>
            <td width="151px"><? echo $html->input('usuario', '', array('type' => 'text')); ?></td>
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
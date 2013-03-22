<?php
    require_once('../lib/core.lib.php');
    require('../lib/common/header_externo.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#usuario').focus();
        
        $('.inputLogin').change(function(){
            $(this).removeClass('error');
        });
        
        $('.inputLogin').keypress(function(e){
            if(e.which == 13)
                changeop(1);
        });

    });
    
    function cancelar(){
        window.location = 'index.php';
    }
    
    function changeop(val){
        document.form_login.verifOp.value=val;
        if(val==1){
            validate_(); //Objeto validator	
        } else {
            document.form_login.submit();
        }
    }
    
    function validate_(){
        var tmptxt = document.getElementById('tmptxt').value;
        var usuario = document.getElementById('usuario').value;
        var pass = document.getElementById('pass').value;
        var txt_puerta = '1'; 
        var error = "<span class='error'><?php echo 'Requerido'?></span>";
        $.get("asin.general.php", { txt_puerta : txt_puerta , tmptxt : tmptxt },
        function(data){
            if(data==1){
                document.getElementById('mens').innerHTML = '';	
                document.form_login.submit();
            } else {
                if(usuario==''){
                    document.getElementById('usuario').setAttribute("class", 'inputLogin error');
                    document.getElementById('usuario').focus();
                    return false;
                }else if(pass==''){
                    document.getElementById('pass').setAttribute("class", 'inputLogin error');
                    document.getElementById('pass').focus();
                    return false;
                }
                document.getElementById('tmptxt').setAttribute("class", 'inputLogin error');
                document.getElementById('tmptxt').focus();
                document.getElementById('mens').innerHTML = data;
                return false;
            }
        });
    }
</script>
<form name="form_login" id="form_login" method="POST" action="verificar_acceso.php?ac=access">
    <div id="titulo_index">
        <img src="../images/bienvenido.png" width="700" height="180" />
    </div>
    <div id="mostrar_error">
        <span><?php echo $etiqueta['loginerror']?></span>
    </div>
    <?php echo $html->input('verifOp', '', array('type' => 'hidden')); ?>
    <table id="table_login" align="center" border="0">
        <tr>
            <td id="mostrar_error2" colspan="2">
            <?php 
                switch ($GPC['msg']){
                    case 'loginerror':
                        echo $etiqueta['loginerror'];
                    break;
                    case 'auth_requerida':
                        echo $etiqueta['auth_requerida'];
                    break;
                    case 'usuario_conectado':
                        echo $etiqueta['usuario_conectado'];
                    break;
                    case 'usuario_inactivo':
                        echo $etiqueta['usuario_inactivo'];
                    break;
                    case 'captcha_invalido':
                        echo $etiqueta['captcha_invalido'];
                    break;
                    case 'captcha_vacio':
                        echo $etiqueta['captcha_vacio'];
                    break;
                }
            ?>
        </td>
        </tr>
        <tr>
            <td class="labelText" width="1"><?php echo $etiqueta['txtUsuario']?></td>
            <td align="right"><?php echo $html->input('usuario', '', array('type' => 'text', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr>
            <td class="labelText"><?php echo $etiqueta['txtContrasena']?></td>
            <td align="right"><?php echo $html->input('pass', '', array('type' => 'password', 'class' => 'inputLogin')); ?></td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <iframe src="../lib/class/captcha/php_captcha.php" id="iframe1" frameborder="0"  height="70px" width="125px" style="border: 0px;" scrolling="no" marginheight="5px" marginwidth="0px"></iframe>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?php echo $html->input('tmptxt', '', array('type' => 'text', 'class' => 'inputLogin')); ?>
            </td>
        </tr>
        <tr align="center">
            <td colspan="2"><span id="mens"><?php echo 'Ingrese el Captcha'//$lang['txtMen'] ?></span></td>
        </tr>
    </table>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?php echo $html->input('Entrar', $etiqueta['txtEntrar'], array('type' => 'button', 'class' => 'btnLogin', 'onClick' => 'javascript:changeop(1);')); ?>
                <?php echo $html->input('Cancelar', $etiqueta['txtCancelar'], array('type' => 'reset', 'class' => 'btnLogin', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?php
    require('../lib/common/footer.php');
?>
<?php
    require_once('../lib/core.lib.php');    
        
    require('../lib/common/header.php');
?>
<div id="titulo_modulo">    
    CUARENTENAS DESPACHO<hr/>    
</div> 
<div id="mensajes">
    <?
        switch($GPC['msg']){
            case 'exitoso':
                echo "<span class='msj_verde'>Registro Guardado !</span>";
            break;
            case 'error':
                echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
            break;
        }
    ?>
</div>
<?
    require('../lib/common/footer.php');
?>

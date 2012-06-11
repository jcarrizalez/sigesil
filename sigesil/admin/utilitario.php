<?php
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Recepcion').click(function(){
            window.location='<?=DOMAIN_ROOT?>admin/utilitario_recepcion_listado.php';
        });
        $('#Despacho').click(function(){            
            window.location='<?=DOMAIN_ROOT?>admin/utilitario_despacho_listado.php';
        });
    });
</script>
<div id="titulo_modulo">
   UTILITARIO<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">
    <table align="center" width="50%"  height="100">
        <tr align="center">
            <td>            
                <? echo $html->input('Recepcion', 'Recepcion', array('type' => 'button')); ?>
            </td>
            <td>            
                <? echo $html->input('Despacho', 'Despacho', array('type' => 'button')); ?>
            </td>
        </tr>
    </table>
    <? echo $html->input('ac', '', array('type' => 'hidden')); ?>
</form>
<?php
    require('../lib/common/footer.php');
?>

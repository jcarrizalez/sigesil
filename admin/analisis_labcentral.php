<?php
require_once('../lib/core.lib.php');
require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Recepcion').click(function(){
            window.location = 'analisis_resultado_listado.php?mov=rec&lab=C';
        });
        $('#Despacho').click(function(){
            window.location = 'analisis_resultado_listado.php?mov=des&lab=C';
        });
    });
</script>
<div id="titulo_modulo">
   LABORATORIO CENTRAL<br/><hr/>
</div>
<table align="center" width="50%"  height="100">
    <tr align="center">
        <td>            
            <?php echo $html->input('Recepcion', 'Recepcion', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
        </td>
        <td>            
            <?php echo $html->input('Despacho', 'Despacho', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
        </td>
    </tr>
</table>
<?php
require('../lib/common/footer.php');
?>

<?php
require_once('../lib/core.lib.php');
require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Recepcion').click(function(){
            window.location = 'analisis_resultado_listado.php?mov=rec&lab=P';
        });
    });
</script>
<div id="titulo_modulo">
   LABORATORIO DE PLANTA<br/><hr/>
</div>
<table align="center" width="50%"  height="100">
    <tr align="center">
        <td>            
            <? echo $html->input('Recepcion', 'Recepcion', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
        </td>
    </tr>
</table>
<?
require('../lib/common/footer.php');
?>

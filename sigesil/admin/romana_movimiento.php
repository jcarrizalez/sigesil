<?php
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $('#Recepcion').click(function(){
           window.location = 'romana_listado.php?mov=rec';
        });
        
        $('#Despacho').click(function(){
           window.location = 'romana_listado.php?mov=des';
        });
    });
</script>
    <div id="titulo_modulo">
        ROMANA<br/><hr/>
    </div>
    <table align="center" width="50%" height="100">
        <tr align="center">
            <td><?php echo $html->input('Recepcion', 'Recepci&oacute;n', array('type' => 'button')); ?></td>
            <td><?php echo $html->input('Despacho', 'Despacho', array('type' => 'button')); ?></td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
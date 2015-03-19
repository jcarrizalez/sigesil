<?php
require_once('../lib/core.lib.php');
require('../lib/common/header.php');
?>
<script type="text/javascript">   
    $(document).ready(function(){        
        $("#capturar1").click(function() {
            $('#capturarPeso').load("../ajax/detalle_romana.php");
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">    
    <div id="titulo_modulo">
        EJEMPLO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <!--td><?php echo $html->input('peso', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td-->
            <div id="capturarPeso"></div>
            <td>
                <?php echo $html->input('capturar1', 'capturar1', array('type' => 'button')); ?>
            </td>
        </tr>
    </table>   
<form>
<?php
require('../lib/common/footer.php');
?>
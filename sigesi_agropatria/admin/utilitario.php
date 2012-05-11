<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['redir'])) {
                if ($GPC['redir']=='Recepcion') {
                    header('location: '.DOMAIN_ROOT.'admin/utilitario_recepcion_listado.php');
                } elseif ($GPC['redir']=='Despacho') {
                    header('location: '.DOMAIN_ROOT.'admin/utilitario_despacho_listado.php');
                }
            }
    }
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Recepcion').click(function(){
            $('#ac').val('editar');
            $('#redir').val('Recepcion');
        });
        $('#Despacho').click(function(){
            $('#ac').val('editar');
            $('#redir').val('Despacho');
        });
    });
</script>
    <div id="titulo_modulo">
    UTILITARIO<br/><hr/>
    </div>
    <form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">
        <? 
        echo $html->input('ac', '', array('type' => 'hidden')); 
        echo $html->input('redir', '', array('type' => 'hidden')); 
        ?>
        <table align="center" width="50%"  height="100">
            <tr align="center">
                <td>            
                    <? echo $html->input('Recepcion', 'Recepcion', array('type' => 'submit')); ?>
                </td>
                <td>            
                    <? echo $html->input('Despacho', 'Despacho', array('type' => 'submit')); ?>
                </td>
            </tr>
        </table>
    </form>
<?
    require('../lib/common/footer.php');
?>

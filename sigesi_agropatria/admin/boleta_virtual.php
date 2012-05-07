<?
    require_once('../lib/core.lib.php');   
    require('../lib/common/header.php');
    
    $cultivo = new Cultivo();

    $listaMov = array(1 => 'Recepci&oacute;n', 2 => 'Despacho', 3 => 'Ambos');
    $listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');

?>
<script type="text/javascript">
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#Regresar').click(function(){
           history.back();
        });
        
        $('.verifPeso').live('change', function(){
            if($('#id_mov').val() != '' && $('#id_cultivo').val() != '' && $('#humedad1').val() != '' && $('#impureza1').val() != '' && $('#peso_01l').val() != '' && $('#peso_01v').val() != ''){
                var form = $('#form1').serialize();
                $("#resultado").load('../ajax/detalle_formula.php?ac=boleta_v&formula='+form);
            }
        });
    });
</script>
<div id="titulo_modulo">
    BOLETA VIRTUAL<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="#" enctype="multipart/form-data">
    <table align="center">
        <tr>
            <td>Tipo de Movimiento</td>
            <td><? echo $html->select('id_mov', array('options' => $listaMov, 'default' => 'Seleccione', 'class' => 'estilo_campos verifPeso')) ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><? echo $html->select('id_cultivo', array('options' => $listaCultivos, 'default' => 'Seleccione', 'class' => 'estilo_campos verifPeso')) ?></td>
        </tr>
        <tr>
            <td>%Humedad Motriz</td>
            <td><? echo $html->input('humedad1', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>%Humedad Remolque/Batea</td>
            <td><? echo $html->input('humedad2', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>%Impureza Motriz</td>
            <td><? echo $html->input('impureza1', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>%Impureza Remolque/Batea</td>
            <td><? echo $html->input('impureza2', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>Peso Lleno Motriz Kgrs</td>
            <td><? echo $html->input('peso_01l', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>Peso Lleno Remolque/Batea Kgrs</td>
            <td><? echo $html->input('peso_02l', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o Motriz Kgrs</td>
            <td><? echo $html->input('peso_01v', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tr>
            <td>Peso Vac&iacute;o Remolque/Batea Kgrs</td>
            <td><? echo $html->input('peso_02v', '', array('type' => 'text', 'class' => 'estilo_campos positive verifPeso')); ?></td>
        </tr>
        <tbody id="resultado" class="verif_resul"></tbody>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?
                    echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
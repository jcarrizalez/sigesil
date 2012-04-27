<?
require_once('../lib/core.lib.php');

$vehiculo = new Vehiculo();

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Vehiculo']['placa']) && !empty($GPC['Vehiculo']['marca'])) {
            $vehiculo->save($GPC['Vehiculo']);
            $id = $vehiculo->id;
            if (!empty($vehiculo->id)) {
                ?>
                    <script type="text/javascript">
                        window.opener.$('#placas').load('../ajax/detalle_despacho.php?ac=otraPlaca&placa=<?=$GPC['Vehiculo']['placa']?>');
                        window.close();
                    </script>
                <?
            }
        }
        break;
}

require('../lib/common/header_popup.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Vehiculo.placa', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Vehiculo.marca', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.close();
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        VEH&Iacute;CULO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Placa </td>
            <td><?echo $html->input('Vehiculo.placa', $GPC['placa'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Marca </td>
            <td><? echo $html->input('Vehiculo.marca', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Color </td>
            <td><? echo $html->input('Vehiculo.color', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Capacidad </td>
            <td><? echo $html->input('Vehiculo.capacidad', '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Tara Aproximado </td>
            <td><? echo $html->input('Vehiculo.tara_aprox', '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Chuto </td>
            <td><? echo $html->input('Vehiculo.chuto', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Placa Remolques </td>
            <td><? echo $html->input('Vehiculo.placa_remolques', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer_popup.php');
?>
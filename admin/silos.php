<?php
require_once('../lib/core.lib.php');

$silo = new Silos();
$almacen = new Almacen();

$listaA = $almacen->find(array('id_centro_acopio' => $_SESSION['s_ca_id']), null, 'id, nombre', 'list');

switch ($GPC['ac']) {
    case 'guardar':
        $GPC['Silo']['id_centro_acopio'] = $_SESSION['s_ca_id'];
        $GPC['Silo']['estatus'] = 't';
        if (!empty($GPC['Silo']['nombre']) && !empty($GPC['Silo']['codigo']) && !empty($GPC['Silo']['capacidad'])) {
            $silo->save($GPC['Silo']);
            $id = $silo->id;
        }
        if (!empty($id)) {
            header("location: silos_listado.php?msg=exitoso");
            die();
        } else {
            header("location: silos_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoSilo = $silo->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Silo.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.capacidad', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.id_almacen', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'silos_listado.php';
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php echo $html->input('Silo.id', $infoSilo[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        SILO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>C&oacute;digo </td>
            <td><?php echo $html->input('Silo.codigo', $infoSilo[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><?php echo $html->input('Silo.nombre', $infoSilo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Coordenada </td>
            <td><?php echo $html->input('Silo.coordenada', $infoSilo[0]['coordenada'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Capacidad </td>
            <td><?php echo $html->input('Silo.capacidad', $infoSilo[0]['capacidad'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Almacen </td>
            <td><?php echo $html->select('Silo.id_almacen', array('options' => $listaA, 'selected' => $infoSilo[0]['id_almacen'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Observaci&oacute;n </td>
            <td><textarea name="Silo[observacion]" cols="20" rows="2" id="Silo[observacion]"><?php echo $infoSilo[0]['observacion'] ?></textarea></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?php echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <?php echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?php
require('../lib/common/footer.php');
?>
<?php
require_once('../lib/core.lib.php');

$cultivo = new Cultivo();
$org = new Organizacion();

$listaOrg = $org->find('', '', array('id', 'nombre'), 'list', 'id');
$cultivoTip = array('t' => 'Si', 'f' => 'No');
$listadoCiclos = array(1 => 'Ciclo 1', 'Ciclo 2', 'Ciclo 3', 'Ciclo 4');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Cultivo']['id_org']) && !empty($GPC['Cultivo']['codigo']) && !empty($GPC['Cultivo']['nombre'])) {
            $GPC['Cultivo']['tipificado'] = (!empty($GPC['Cultivo']['tipificado'])) ? $GPC['Cultivo']['tipificado'] : 'f';
            $cultivo->save($GPC['Cultivo']);
            $id = $cultivo->id;
        }
        if (!empty($id)) {
            header("location: cultivo_listado.php?msg=exitoso");
            die();
        } else {
            header("location: cultivo_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoCultivo = $cultivo->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Cultivo.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cultivo.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cultivo.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'cultivo_listado.php';
    }
    
    $(document).ready(function(){
        $('#Cultivo\\[codigo\\]').live('change', function(){
            if($(this).val() != ''){
                var cod = $(this).val();
                $('#codigo').load('../ajax/detalle_validacion.php?ac=cultivo&cod=' + cod);
            }
        });
    
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CULTIVO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n </td>
            <td><?php echo $html->select('Cultivo.id_org', array('options' => $listaOrg, 'selected' => $infoCultivo[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>C&oacute;digo </td>
            <td id="codigo"><?php echo $html->input('Cultivo.codigo', $infoCultivo[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><?php echo $html->input('Cultivo.nombre', $infoCultivo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>¿Cultivo Tipificado? </td>
            <td><?php echo $html->select('Cultivo.tipificado', array('options' => $cultivoTip, 'selected' => $infoCultivo[0]['tipificado'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Ciclo </td>
            <td><?php echo $html->select('Cultivo.ciclo', array('options' => $listadoCiclos, 'selected' => $infoCultivo[0]['ciclo'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
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
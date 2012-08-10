<?
    require_once('../lib/core.lib.php');

    $analisis = new Analisis();
    $org = new Organizacion();

    $listaOrg = $org->find('', '', array('id', 'nombre'), 'list', 'id');
    $listaTipo = array(1 => 'Cuantitativo', 2 => 'Cualitativo', 3 => 'Boleano');
    $estatus = array('t' => 'Activo', 'f' => 'Inactivo');
    $listaFormula = array('t' => 'Verdadero', 'f' => 'Falso');

    switch ($GPC['ac']) {
        case 'guardar':
            if (!empty($GPC['Analisis']['nombre']) && !empty($GPC['Analisis']['tipo_analisis'])) {
                $analisis->save($GPC['Analisis']);
                $id = $analisis->id;
            }
            if (!empty($id)) {
                header("location: analisis_listado.php?msg=exitoso");
                die();
            } else {
                header("location: analisis_listado.php?msg=error");
                die();
            }
            break;
        case 'editar':
            $infoAnalisis = $analisis->find(array('id' => $GPC['id']));
            break;
    }

    require('../lib/common/header.php');

    $validator = new Validator('form1');
    $validator->printIncludes();
    $validator->setRules('Analisis.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Analisis.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Analisis.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Analisis.tipo_analisis', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Analisis.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'analisis_listado.php';
    }
    
    $(document).ready(function(){
        $('#Analisis\\[codigo\\]').live('change', function(){
            if($(this).val() != ''){
                var cod = $(this).val();
                $('#codigo').load('../ajax/detalle_validacion.php?ac=analisis&cod=' + cod);
            }
        });
    
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Analisis.id', $infoAnalisis[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ANALISIS<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n</td>
            <td><? echo $html->select('Analisis.id_org', array('options' => $listaOrg, 'selected' => $infoAnalisis[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Codigo</td>
            <td id="codigo"><? echo $html->input('Analisis.codigo', $infoAnalisis[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre</td>
            <td><? echo $html->input('Analisis.nombre', $infoAnalisis[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Tipo</td>
            <td><? echo $html->select('Analisis.tipo_analisis', array('options' => $listaTipo, 'selected' => $infoAnalisis[0]['tipo_analisis'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estatus</td>
            <td><? echo $html->select('Analisis.estatus', array('options' => $estatus, 'selected' => $infoAnalisis[0]['estatus'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Formula</td>
            <td><? echo $html->select('Analisis.formula', array('options' => $listaFormula, 'selected' => $infoAnalisis[0]['formula'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
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
require('../lib/common/footer.php');
?>
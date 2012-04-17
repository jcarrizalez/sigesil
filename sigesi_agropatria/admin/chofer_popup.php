<?
require_once('../lib/core.lib.php');

$chofer = new Chofer();
$div_pol = new DivPol();
$org = new Organizacion();

$listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');

$listaOrg = $org->find('', '', array('id', 'nombre'), 'list', 'id');
$paises = $div_pol->obtenerPais();
foreach ($paises as $campo => $valor) {
    $listaP[$valor['id']] = $valor['nombre'];
}
$estados = $div_pol->obtenerEstado();
foreach ($estados as $campo => $valor) {
    $listaE[$valor['id']] = $valor['nombre'];
}
$estatus = array('t' => 'Activo', 'f' => 'Inactivo');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Chofer']['nombre']) && !empty($GPC['Chofer']['ced_rif'])) {
            $GPC['Chofer']['id_estado'] = $GPC['id_estado'];
            $GPC['Chofer']['id_municipio'] = $GPC['id_municipio'];
            $chofer->save($GPC['Chofer']);
            $id = $chofer->id;
            if (!empty($chofer->id)) {
                ?>
                    <script type="text/javascript">
                        window.opener.$('#chofer').load('../ajax/detalle_despacho.php?ac=chofer&cp=<?=$GPC['Chofer']['ced_rif']?>');
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
$validator->setRules('Chofer.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.close();
    }
    
    $(document).ready(function(){
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Chofer.id', $infoChofer[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CHOFER<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td><?echo $html->input('Chofer.ced_rif', $GPC['cp'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><? echo $html->input('Chofer.nombre', $infoChofer[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Organizaci&oacute;n </td>
            <td><? echo $html->select('Chofer.id_org', array('options' => $listaOrg, 'selected' => $infoChofer[0]['id_org'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n </td>
            <td><? echo $html->input('Chofer.direccion', $infoChofer[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Pa&iacute;s </td>
            <td><? echo $html->select('Chofer.id_pais', array('options' => $listaP, 'selected' => $infoChofer[0]['id_pais'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td>Estado </td>
            <td><? echo $html->select('id_estado', array('options' => $listaE, 'selected' => $infoChofer[0]['id_estado'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td>Municipio </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $infoChofer[0]['id_municipio'], 'default' => 'Seleccione')) ?>
                </div>
            </td>
        </tr>
        <tr>
            <td>Estatus </td>
            <td><? echo $html->select('Chofer.estatus', array('options' => $estatus, 'selected' => $infoChofer[0]['estatus'], 'default' => 'Seleccione')) ?></td>
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
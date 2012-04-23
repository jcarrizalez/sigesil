<?
require_once('../lib/core.lib.php');

$productor = new Productor();
$org = new Organizacion();
$div_pol = new DivPol();

$listaOrg = $org->find('', '', array('id', 'nombre'), 'list', 'id');

$paises = $div_pol->obtenerPais();
foreach ($paises as $campo => $valor) {
    $listaP[$valor['id']] = $valor['nombre'];
}
$estados = $div_pol->obtenerEstado();

foreach ($estados as $campo => $valor) {
    $listaE[$valor['id']] = $valor['nombre'];
}

$mcpos = $div_pol->obtenerMcpo('', $GPC['idE']);
foreach($mcpos as $campo => $valor){
    $listaM[$valor['id']] = $valor['nombre'];
}
$estatus = array('t' => 'Activa', 'f' => 'Inactiva');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Productor']['nombre'])) {
            $productor->save($GPC['Productor']);
            $id = $productor->id;
        }
        if (!empty($id)) {
            header("location: productor_listado.php?msg=exitoso");
            die();
        } else {
            header("location: productor_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoProductor = $productor->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Productor.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'productor_listado.php';
    }
    $(document).ready(function(){
    $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    $('#Productor\\[id_estado\\]').change(function(){
        $('#Productor\\[id_municipio\\]').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
    });
});
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Productor.id', $infoProductor[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
       PRODUCTOR<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Codigo </td>
            <td><? echo $html->input('Productor.cod_ref', $infoProductor[0]['cod_ref'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n</td>
            <td><? echo $html->select('Productor.id_org', array('options' => $listaOrg, 'selected' => $infoProductor[0]['id_org'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre</td>
            <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>RIF</td>
            <td><? echo $html->input('Productor.ced_rif', $infoProductor[0]['ced_rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Telefono</td>
            <td><? echo $html->input('Productor.telefono', $infoProductor[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Fax</td>
            <td><? echo $html->input('Productor.fax', $infoProductor[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Email</td>
            <td><? echo $html->input('Productor.email', $infoProductor[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n</td>
            <td><? echo $html->input('Productor.direccion', $infoProductor[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>C&oacute;digo SAP</td>
            <td><? echo $html->input('Productor.id_sap', $infoProductor[0]['id_sap'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>        
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s </td>
            <td><? echo $html->select('Productor.id_pais', array('options' => $listaP, 'selected' => $infoProductor[0]['id_pais'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado </td>
            <td><? echo $html->select('Productor.id_estado', array('options' => $listaE, 'selected' => $infoProductor[0]['id_estado'], 'default' => 'Seleccione')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('Productor.id_municipio', array('options' => $listaM, 'selected' => $infoProductor[0]['id_municipio'], 'default' => 'Seleccione')) ?>
                </div>
            </td>
        </tr>        
        <tr>
            <td>Coordenadas UTM</td>
            <td><? echo $html->input('Productor.coordenadas_utm', $infoProductor[0]['coordenadas_utm'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
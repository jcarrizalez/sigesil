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
            $GPC['Chofer']['ced_rif'] = $GPC['nacionalidad'].$GPC['Chofer']['ced_rif'];
            $chofer->save($GPC['Chofer']);
            $id = $chofer->id;
        }
        if (!empty($id)) {
            header("location: chofer_listado.php?msg=exitoso");
            die();
        } else {
            header("location: chofer_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoChofer = $chofer->find(array('id' => $GPC['id']));
        $listaMcpos = $div_pol->obtenerMcpo('', $infoChofer[0]['id_estado']);
        foreach ($listaMcpos as $dataMcpo) {
            $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
        }
        break;
}

require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Chofer.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
//$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'chofer_listado.php';
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
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
            <td>
                <?
                    echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoChofer[0]['ced_rif']), 0, 1)));
                    echo "&nbsp;".$html->input('Chofer.ced_rif', substr(trim($infoChofer[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'crproductor positive'));
                    //echo $html->input('Org.rif', $infoChofer[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos'));
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><? echo $html->input('Chofer.nombre', $infoChofer[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Organizaci&oacute;n </td>
            <td><? echo $html->select('Chofer.id_org', array('options' => $listaOrg, 'selected' => $infoChofer[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n </td>
            <td><? echo $html->input('Chofer.direccion', $infoChofer[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Pa&iacute;s </td>
            <td><? echo $html->select('Chofer.id_pais', array('options' => $listaP, 'selected' => $infoChofer[0]['id_pais'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Estado </td>
            <td><? echo $html->select('id_estado', array('options' => $listaE, 'selected' => $infoChofer[0]['id_estado'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Municipio </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $infoChofer[0]['id_municipio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                </div>
            </td>
        </tr>
        <tr>
            <td>Estatus </td>
            <td><? echo $html->select('Chofer.estatus', array('options' => $estatus, 'selected' => $infoChofer[0]['estatus'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
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
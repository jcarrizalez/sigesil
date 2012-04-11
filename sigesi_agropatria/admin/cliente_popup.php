<?
require_once('../lib/core.lib.php');

$cliente = new Cliente();
$div_pol = new DivPol();
$org = new Organizacion();

$listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
$listaEdoCivil = array('1' => 'Soltero', 'Casado', 'Divorciado', 'Viudo');

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
        /*if (!empty($GPC['Cliente']['nombre']) && !empty($GPC['Cliente']['ced_rif'])) {
            $GPC['Cliente']['id_estado'] = $GPC['id_estado'];
            $GPC['Cliente']['id_municipio'] = $GPC['id_municipio'];
            $GPC['Cliente']['ced_rif'] = $GPC['nacionalidad'].$GPC['Cliente']['ced_rif'];
            $cliente->save($GPC['Cliente']);
            $id = $cliente->id;
        }
        if (!empty($id)) {
            header("location: chofer_listado.php?msg=exitoso");
            die();
        } else {
            header("location: chofer_listado.php?msg=error");
            die();
        }*/
    break;
}

require('../lib/common/header_popup.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
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
    <? echo $html->input('Cliente.id', $infoChofer[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CLIENTE<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td>
                <?
                    echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr($GPC['cp'], 0, 1)));
                    echo "&nbsp;".$html->input('Cliente.ced_rif', trim(substr($GPC['cp'], 1)), array('type' => 'text', 'length' => '8', 'class' => 'integer', 'style' => 'width: 151px'));
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><? echo $html->input('Cliente.nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n </td>
            <td><? echo $html->select('Cliente.id_org', array('options' => $listaOrg, 'selected' => $infoChofer[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><? echo $html->input('Cliente.telefono', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td>Fax </td>
            <td><? echo $html->input('Cliente.fax', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><? echo $html->input('Cliente.email', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Estado Civil </td>
            <td><? echo $html->select('Cliente.edo_civil', array('options' => $listaEdoCivil, 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n </td>
            <td><? echo $html->input('Cliente.direccion', $infoChofer[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Pa&iacute;s </td>
            <td><? echo $html->select('Cliente.id_pais', array('options' => $listaP, 'selected' => $infoChofer[0]['id_pais'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
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
        <?
            for($i=1; $i<=3; $i++){
        ?>
        <tr align="center">
            <td colspan="2">Contacto <?=$i?></td>
        </tr>
        <tr>
            <td>Nombre </td>
            <td><? echo $html->input('Cliente.contacto'.$i.'_nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><? echo $html->input('Cliente.contacto'.$i.'_telefono', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td>Email </td>
            <td><? echo $html->input('Cliente.contacto'.$i.'_email', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?
            }
        ?>
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
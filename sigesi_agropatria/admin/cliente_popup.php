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
        if (!empty($GPC['Cliente']['ced_rif']) && !empty($GPC['Cliente']['nombre'])) {
            $GPC['Cliente']['id_estado'] = $GPC['id_estado'];
            $GPC['Cliente']['id_municipio'] = $GPC['id_municipio'];
            $GPC['Cliente']['ced_rif'] = $GPC['nacionalidad'].$GPC['Cliente']['ced_rif'];
            $GPC['Cliente']['estatus'] = 't';
            $cliente->save($GPC['Cliente']);
            if(!empty($cliente->id)){
            ?>
                <script type="text/javascript">
                    window.opener.$('#orden').load('../ajax/detalle_despacho.php?ac=clienteOrden&cp=<?=$GPC['Cliente']['ced_rif']?>');
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
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.email_org', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->setRules('Cliente.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.contacto1_email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->setRules('Cliente.contacto2_email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->setRules('Cliente.contacto3_email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.close();
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        CLIENTE<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td><?echo $html->input('Cliente.ced_rif', $GPC['cp'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
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
            <td>C&oacute;digo SAP </td>
            <td><? echo $html->input('Cliente.id_sap', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>REF </td>
            <td><? echo $html->input('Cliente.ref', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><? echo $html->input('Cliente.telefono', '', array('type' => 'text', 'length' => '11', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td>Fax </td>
            <td><? echo $html->input('Cliente.fax', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><? echo $html->input('Cliente.email_org', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
            <td><span class="msj_rojo">* </span>Pa&iacute;s </td>
            <td><? echo $html->select('Cliente.id_pais', array('options' => $listaP, 'selected' => $infoChofer[0]['id_pais'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado </td>
            <td><? echo $html->select('id_estado', array('options' => $listaE, 'selected' => $infoChofer[0]['id_estado'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio </td>
            <td style="padding-bottom: 15px;">
                <div id="mcpo">
                    <? echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $infoChofer[0]['id_municipio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                </div>
            </td>
        </tr>
        <?
            for($i=1; $i<=3; $i++){
        ?>
        <tr align="center">
            <td colspan="2" class="titulos_tabla" style="font-weight: bold;">Contacto <?=$i?></td>
        </tr>
        <tr>
            <td>Nombre </td>
            <td><? echo $html->input('Cliente.contacto'.$i.'_nombre', '', array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><? echo $html->input('Cliente.contacto'.$i.'_telefono', '', array('type' => 'text', 'length' => '11', 'class' => 'estilo_campos integer')); ?></td>
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
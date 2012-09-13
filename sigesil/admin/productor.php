<?
require_once('../lib/core.lib.php');

$productor = new Productor();
$div_pol = new DivPol();
$org = new Organizacion();

$idCA = $_SESSION['s_ca_id'];
$listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');

$listaOrg = $org->find('', '', array('id', 'nombre'), 'list', 'id');
$listadoPro = $productor->find('', '', array('id', 'nombre'), 'list', 'nombre');

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
        if (!empty($GPC['Productor']['id_org']) && !empty($GPC['Productor']['ced_rif']) && !empty($GPC['Productor']['nombre'])) {
            $GPC['Productor']['id_estado'] = $GPC['id_estado'];
            $GPC['Productor']['id_municipio'] = $GPC['id_municipio'];
            $GPC['Productor']['ced_rif'] = $GPC['nacionalidad'].$GPC['Productor']['ced_rif'];
            $productor->save($GPC['Productor']);
            $idPr = $productor->id;
        }
        if (!empty($idPr)) {
            header("location: productor_listado.php?msg=exitoso");
            die();
        } else {
            header("location: productor_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoProductor = $productor->find(array('id' => $GPC['id']));
        $listaMcpos = $div_pol->obtenerMcpo('', $infoChofer[0]['id_estado']);
        foreach ($listaMcpos as $dataMcpo) {
            $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
        }
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Productor.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
//$validator->setRules('Productor.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Productor.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido'), 'digits' => array('value' => true, 'message' => 'Solo N&uacute;meros'), 'minlength' => array('value' => 6, 'message' => 'Min&iacute;mo 6 D&iacute;gitos')));
$validator->setRules('Productor.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Productor.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Productor.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Productor.email', array('email' => array('value' => true, 'message' => 'Correo Inv&aacute;lido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'productor_listado.php';
    }
    
    $(document).ready(function(){
        //$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        $('#Productor\\[ced_rif\\]').live('keypress', function (e){
            if( e.which!=8 && e.which!=0 && (e.which<48 || e.which>57))
                return false;
        });
    
        $('#Productor\\[ced_rif\\]').live('change', function(){
            if($(this).val() != '' && $.isNumeric($(this).val())){
                var ced = $('#nacionalidad').val() + $(this).val();
                $('#cedula').load('../ajax/detalle_validacion.php?ac=productor&ced=' + ced);
            }
        });
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
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
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n</td>
            <td><? echo $html->select('Productor.id_org', array('options' => $listaOrg, 'selected' => $infoProductor[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td id="cedula">
                <?
                    echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoProductor[0]['ced_rif']), 0, 1)));
                    echo "&nbsp;".$html->input('Productor.ced_rif', substr(trim($infoProductor[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                ?>
            </td>
        </tr>
        <tr>
            <td>Codigo </td>
            <td><? echo $html->input('Productor.cod_ref', $infoProductor[0]['cod_ref'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre</td>
            <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
            <td><? echo $html->select('Productor.id_pais', array('options' => $listaP, 'selected' => $infoProductor[0]['id_pais'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado </td>
            <td><? echo $html->select('id_estado', array('options' => $listaE, 'selected' => $infoProductor[0]['id_estado'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $infoProductor[0]['id_municipio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                </div>
            </td>
        </tr>
        <tr>
            <td>Coordenadas UTM</td>
            <td><? echo $html->input('Productor.coordenadas_utm', $infoProductor[0]['coordenadas_utm'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estatus </td>
            <td><? echo $html->select('Productor.estatus', array('options' => $estatus, 'selected' => $infoProductor[0]['estatus'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <?
            for($i=1; $i<=3; $i++){
        ?>
        <tr align="center">
            <td colspan="2" class="titulos_tabla" style="font-weight: bold;">Contacto <?=$i?></td>
        </tr>
        <tr>
            <td>Nombre </td>
            <td><? echo $html->input('Productor.contacto'.$i.'_nombre', $infoProductor[0]['contacto'.$i.'_nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><? echo $html->input('Productor.contacto'.$i.'_telefono', $infoProductor[0]['contacto'.$i.'_telefono'], array('type' => 'text', 'length' => '11', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Email </td>
            <td><? echo $html->input('Productor.contacto'.$i.'_email', $infoProductor[0]['contacto'.$i.'_email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
    require('../lib/common/footer.php');
?>
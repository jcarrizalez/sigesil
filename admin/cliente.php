<?php
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
                    header("location: cliente_listado.php?msg=exitoso");
                    die();
                } else {
                    header("location: cliente_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCliente = $cliente->find(array('id' => $GPC['id']));
            $listaMcpos = $div_pol->obtenerMcpo('', $infoCliente[0]['id_estado']);
            foreach ($listaMcpos as $dataMcpo) {
                $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
            }
        break;
    }

    require('../lib/common/header.php');

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
        window.location = 'cliente_listado.php';
    }
    
    $(document).ready(function(){
        $('.positive').numeric();
        
        $('#Cliente\\[ced_rif\\]').live('change', function(){
            if($(this).val() != ''){
                var ced = $('#nacionalidad').val() + $(this).val();
                $('#cedula').load('../ajax/detalle_validacion.php?ac=cliente&ced=' + ced);
            }
        });
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php echo $html->input('Cliente.id', $infoCliente[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CLIENTE<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td id="cedula">
                <?php
                    echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoCliente[0]['ced_rif']), 0, 1)));
                    echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoCliente[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre </td>
            <td><?php echo $html->input('Cliente.nombre', $infoCliente[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n </td>
            <td><?php echo $html->select('Cliente.id_org', array('options' => $listaOrg, 'selected' => $infoCliente[0]['id_org'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>C&oacute;digo SAP </td>
            <td><?php echo $html->input('Cliente.id_sap', $infoCliente[0]['id_sap'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>REF </td>
            <td><?php echo $html->input('Cliente.ref', $infoCliente[0]['ref'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><?php echo $html->input('Cliente.telefono', $infoCliente[0]['telefono'], array('type' => 'text', 'length' => '11', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Fax </td>
            <td><?php echo $html->input('Cliente.fax', $infoCliente[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><?php echo $html->input('Cliente.email_org', $infoCliente[0]['email_org'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Estado Civil </td>
            <td><?php echo $html->select('Cliente.edo_civil', array('options' => $listaEdoCivil, 'selected' => $infoCliente[0]['edo_civil'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n </td>
            <td><?php echo $html->input('Cliente.direccion', $infoCliente[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s </td>
            <td><?php echo $html->select('Cliente.id_pais', array('options' => $listaP, 'selected' => $infoCliente[0]['id_pais'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado </td>
            <td><?php echo $html->select('id_estado', array('options' => $listaE, 'selected' => $infoCliente[0]['id_estado'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio </td>
            <td style="padding-bottom: 15px;">
                <div id="mcpo">
                    <?php echo $html->select('id_municipio', array('options' => $listaM, 'selected' => $infoCliente[0]['id_municipio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?>
                </div>
            </td>
        </tr>
        <?php
            for($i=1; $i<=3; $i++){
        ?>
        <tr align="center">
            <td colspan="2" class="titulos_tabla" style="font-weight: bold;">Contacto <?php echo $i?></td>
        </tr>
        <tr>
            <td>Nombre </td>
            <td><?php echo $html->input('Cliente.contacto'.$i.'_nombre', $infoCliente[0]['contacto'.$i.'_nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono </td>
            <td><?php echo $html->input('Cliente.contacto'.$i.'_telefono', $infoCliente[0]['contacto'.$i.'_telefono'], array('type' => 'text', 'length' => '11', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Email </td>
            <td><?php echo $html->input('Cliente.contacto'.$i.'_email', $infoCliente[0]['contacto'.$i.'_email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?php
            }
        ?>
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
<?
    require_once('../lib/core.lib.php');

    $impresora = new Impresora();
    $centro_acopio = new CentroAcopio();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    $listaEstatus = array('1' => 'Recepcion', '9' => 'Liquidaci&oacute;n');

    switch ($GPC['ac']) {
        case 'guardar':
            if (!empty($GPC['Impresora']['nombre'])) {
                $impresora->save($GPC['Impresora']);
                $id = $impresora->id;
            }
            if (!empty($id)) {
                header("location: impresora_listado.php?msg=exitoso");
                die();
            } else {
                header("location: impresora_listado.php?msg=error");
                die();
            }
            break;
        case 'editar':
            $infoImpresora = $impresora->find(array('id' => $GPC['id']));
            break;
    }
    require('../lib/common/header.php');

    $validator = new Validator('form1');
    $validator->printIncludes();
    $validator->setRules('Impresora.id_centro_acopio', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Impresora.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Impresora.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'impresora_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Impresora.id', $infoImpresora[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        IMPRESORA<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Centro de Acopio</td>
            <td><? echo $html->select('Impresora.id_centro_acopio', array('options' => $listaCA, 'selected' => $infoImpresora[0]['id_centro_acopio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre</td>
            <td><? echo $html->input('Impresora.nombre', $infoImpresora[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Reimprimir</td>
            <td><? echo $html->select('Impresora.estatus', array('options' => $listaEstatus, 'selected' => $infoImpresora[0]['estatus'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Parametros</td>
            <td><? echo $html->input('Impresora.parametros', $infoImpresora[0]['parametros'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
<? require('../lib/common/footer.php'); ?>
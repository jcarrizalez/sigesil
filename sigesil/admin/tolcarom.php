<?php
    require_once('../lib/core.lib.php');

    $tolcarom = new Tolcarom();
    $centro_acopio = new CentroAcopio();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    $listaEstatus = array('t' => 'Activa', 'f' => 'Inactivo');
    $listaTipo = array(1 => 'Tolva', 2 => 'Carril', 3 => 'Romana');

    switch ($GPC['ac']) {
        case 'guardar':
            if (!empty($GPC['Tolcarom']['nombre'])) {
                $tolcarom->save($GPC['Tolcarom']);
                $id = $tolcarom->id;
            }
            if (!empty($id)) {
                header("location: tolcarom_listado.php?msg=exitoso");
                die();
            } else {
                header("location: tolcarom_listado.php?msg=error");
                die();
            }
            break;
        case 'editar':
            $infoTolcarom = $tolcarom->find(array('id' => $GPC['id']));
            break;
    }
    require('../lib/common/header.php');

    $validator = new Validator('form1');
    $validator->printIncludes();
    $validator->setRules('Tolcarom.id_centro_acopio', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Tolcarom.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Tolcarom.numero', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Tolcarom.tipo', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Tolcarom.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'tolcarom_listado.php';
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?php echo $html->input('Tolcarom.id', $infoTolcarom[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        TOLVA, CARRIL Y ROMANA<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Centro de Acopio</td>
            <td><?php echo $html->select('Tolcarom.id_centro_acopio', array('options' => $listaCA, 'selected' => $infoTolcarom[0]['id_centro_acopio'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre</td>
            <td><?php echo $html->input('Tolcarom.nombre', $infoTolcarom[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>N&uacute;mero</td>
            <td><?php echo $html->input('Tolcarom.numero', $infoTolcarom[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Tipo</td>
            <td><?php echo $html->select('Tolcarom.tipo', array('options' => $listaTipo, 'selected' => $infoTolcarom[0]['tipo'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estatus</td>
            <td><?php echo $html->select('Tolcarom.estatus', array('options' => $listaEstatus, 'selected' => $infoTolcarom[0]['estatus'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td>Parametros</td>
            <td><?php echo $html->input('Tolcarom.parametros', $infoTolcarom[0]['parametros'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
<?php require('../lib/common/footer.php'); ?>
<?
    require_once('../lib/core.lib.php');

    if(empty($GPC['ca'])){
        header('location: cultivo_listado.php');
        die();
    }
    
    $analisis = new Analisis();
    $analisiscul = new AnalisisCultivo();
    
    $listaLab = array('C' => 'Lab. Central', 'A' => 'Ambos');
    $listaTipo = array('R' => 'Rechazo', 'C' => 'Cuarentena');

    $listaAnalisis = $analisis->find(array('estatus' => 't'), '', "id, '('||codigo||') '||nombre AS nombre", '', 'cast(codigo as int)');
    $listaAnalCul = $analisiscul->analisisPorCultivo($GPC['id'], $GPC['ca']);

    foreach($listaAnalCul as $valor){
        $analisisCultivo[] = $valor['id_analisis'];
    }

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
        window.location = 'cultivo_listado.php';
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
        ANALISIS POR CULTIVO<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Menu</legend>
        <table align="center" border="0">
            <tr align="center">
                <th colspan="3">&nbsp;</th>
                <th colspan="2">Recepci&oacute;n</th>
                <th colspan="2">Despacho</th>
            </tr>
            <tr align="center" class="titulos_tabla">
                <th>Descripci&oacute;n</th>
                <th>Analiza</th>
                <th>Tipo</th>
                <th>Min</th>
                <th>Max</th>
                <th>Min</th>
                <th>Max</th>
            </tr>
            <?
                $i = 0;
                foreach($listaAnalisis as $dataAnalisis){
                    $classname = $general->obtenerClaseFila($i);
                    //if($dataAnalisis['id_padre'] == 0){
                        $check = (in_array($dataAnalisis['id'], $analisisCultivo)) ? 'checked = "check"' : '';
            ?>
            <tr class="<?= $classname ?>">
                <td style="font-weight: bold;">
                    <input name="padre[]" id="padre_<?=$dataAnalisis['id']?>" type="checkbox" <?=$check?> class="marcarHijos" value="<?=$dataAnalisis['id']?>">
                    <?=$dataAnalisis['nombre']?>
                </td>
                    <td><? echo $html->select('id1', array('options' => $listaLab, 'selected' => $lab, 'class' => 'cuadricula')) ?></td>
                    <td><? echo $html->select('id2', array('options' => $listaTipo, 'selected' => $status, 'class' => 'cuadricula')) ?></td>
                    <td><? echo $html->input('id3', $minRec, array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>
                    <td><? echo $html->input('id4', $maxRec, array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>
                    <td><? echo $html->input('id5', $minDes, array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>
                    <td><? echo $html->input('id6', $maxDes, array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>
            </tr>
            <?
                $i++; }
            ?>
            <tr><td>&nbsp;</td></tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<? require('../lib/common/footer.php'); ?>
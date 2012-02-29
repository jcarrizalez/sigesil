<?php
require_once('../lib/core.lib.php');

$analisisCul = new AnalisisCultivo();
$Rec = new Recepcion();

$idCA = $_SESSION['s_id_ca'];
$id_rec = $GPC['id_rec'];
$IdCultivo = $id = $GPC['id_cultivo'];
$idORG = $_SESSION['s_org_id'];
$cant_muestras = $GPC['cant_muestras'];
$estatus = array('NO' => 'No', 'SI'=>'Si');
$calidad = array('A' => 'A', 'B'=>'B','C'=>'C','D'=>'D');

$listadoAnalisis = $analisisCul->buscarAC(null, $IdCultivo, $idORG);
$cantidad = count($listadoAnalisis);
$infoRec = $Rec->listadoAnalisis(null, $IdCultivo, $id_rec);

switch ($GPC['ac']) {
    case 'guardar':
        //echo "<pre>";print_r($GPC['muestra1']);echo "</pre>"; die();
        if (!empty($GPC['id_rec']) && !empty($GPC['muestra1'])) {
            $analisis = new Analisis();
            $analisis->_begin_tool();
            for ($i = 0; $i < $GPC['cantA']; $i++) {
                $GPC['Resultados']['id_recepcion'] = $GPC['id_rec'];
                $GPC['Resultados']['id_analisis'] = $GPC['id_analisis'][$i];
                $GPC['Resultados']['id_usuario'] = $_SESSION['s_id'];                
                $GPC['Resultados']['muestra1'] = (!empty($GPC['muestra1'][$i])) ? $GPC['muestra1'][$i] : null;               
                $GPC['Resultados']['muestra2'] = (!empty($GPC['muestra2'][$i])) ? $GPC['muestra2'][$i] : null;
                $GPC['Resultados']['muestra3'] = (!empty($GPC['muestra3'][$i])) ? $GPC['muestra3'][$i] : null;                
                $id_analisis_res = $analisis->guardarResultados($GPC['Resultados']);
            }
            //Estatus = 2 Analisis registrado
            $Rec->cambiarEstatus($GPC['id_rec'], 2);
        }
        if (!empty($id_analisis_res)) {
            $analisis->_commit_tool();
            header("location: analisis_recepcion_listado.php?msg=exitoso");
            die();
        } else {
            header("location: analisis_recepcion_listado.php?msg=error");
            die();
        }
        break;
}

require('../lib/common/header.php');
?>
<script type="text/javascript">
    function cancelar(){
        history.back();
    }
/*
    function valoresMinMax(id){
        var min = $('#min_'+id).val();
        var max = $('#max_'+id).val();
        var valor = document.getElementById(id).value;
            alert(id);
        if(valor < min || valor > max)
            alert('Incorrecto');
    }
    */
    $(document).ready(function() {
        $(".positive").numeric();
        $(".positive").change(function(){
            alert($(this).val());
        });
        $("#form1").submit(function(){
            var isFormValid = true;
            $("#form1 :input").each(function(){
                if ($.trim($(this).val()).length == 0){
                    $(this).addClass("error");
                    $(this).focus();
                    isFormValid = false;
                    return false;
                }
                else{
                    $(this).removeClass("error");
                }
            });
            return isFormValid;
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar&cantA=<?= $cantidad ?>" enctype="multipart/form-data">
    <? echo $html->input('id_rec', $id_rec, array('type' => 'hidden')); ?>    
    <div id="titulo_modulo">
        ANALISIS DE RECEPCI&Oacute;N<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos de la Muestra</legend>
        <table align="center" width="100%" border="0">
            <tr>
                <td>Nro. Entrada</td>
                <td><span><? echo $infoRec[0]['numero']; ?></span></td>
                <td>Fecha</td>
                <td><span><? echo $general->date_sql_screen($infoRec[0]['fecha_recepcion']); ?></span></td>            
            </tr>
            <tr>
                <td>Carril</td>
                <td><span><? echo $infoRec[0]['carril']; ?></span></td>
                <td>Hora</td>
                <td><? echo $general->hora_sql_normal($infoRec[0]['fecha_recepcion']); ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="3"><? echo $infoRec[0]['codigo_cul'] . ' - ' . $infoRec[0]['nombre_cul']; ?></td>                
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de los An&aacute;lisis</legend>
        <table align="center" width="100%">
            <tr align="center" class="titulos_tabla">            
                <th width="1">C&oacute;digo</th>
                <th>Descripci&oacute;n</th>
                <? for ($j = 1; $j <= $cant_muestras; $j++) { ?>
                    <th width="70"><?= 'Muestra ' . $j; ?></th>
                <? } ?>
                <th>Min / Max</th>
            </tr>
            <?
            $i = 0;
            foreach ($listadoAnalisis as $dataAnalisis) {
                $clase = $general->obtenerClaseFila($i);
                ?>

                <tr class="<?= $clase ?>">
                    <td align="center" >
                        <? echo $html->input('id_analisis[]', $dataAnalisis['id'], array('type' => 'hidden')); ?>
                        <?= $dataAnalisis['codigo'] ?>
                    </td>
                    <td><?= $dataAnalisis['nombre'] ?></td>
                    <?
                    for ($j = 1; $j <= $cant_muestras; $j++) {
                        switch ($dataAnalisis['tipo_analisis']) {
                            case '1':
                                ?>                    
                                <td align="center"><? echo $html->input('muestra' . $j . '[]', '', array('type' => 'text', 'length' => '6', 'class' => 'cuadricula positive')); ?></td>
                                <?
                                break;
                            case '2':
                                ?>                    
                                <td align="center"><? echo $html->select('muestra' . $j . '[]', array('options' => $calidad,'class' => 'cuadricula cualitativo')); ?></td>
                                <?
                                break;
                            case '3':
                                ?>
                                <td align="center"><? echo $html->select('muestra' . $j . '[]', array('options' => $estatus, 'class' => 'cuadricula booleano')) ?></td>
                                <?
                                break;
                        }
                    }
                    if($dataAnalisis['tipo_analisis'] == 1){
                        echo '<td align="center" width="110">';
                        echo $html->input('min_'.$dataAnalisis['codigo'], $dataAnalisis['min_rec'], array('type' => 'text', 'class' => 'transparente'));
                        echo "/ ";
                        echo $html->input('max_'.$dataAnalisis['codigo'], $dataAnalisis['max_rec'], array('type' => 'text', 'class' => 'transparente'));
                        echo '</td>';
                    }else{
                    ?>
                    <td align="center">&nbsp;</td>
                </tr>
                <?
                    }
                $i++;
            }
            ?>
        </table>
    </fieldset>
    <table align="center">
        <tr><td>&nbsp;</td></tr>
        <tr align="center">
            <td colspan="1">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>    

<?
require('../lib/common/footer.php');
?>

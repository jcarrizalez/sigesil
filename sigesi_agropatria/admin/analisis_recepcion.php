<?php
require_once('../lib/core.lib.php');

$analisisCul = new AnalisisCultivo();

$idCA = $_SESSION['s_id_ca'];
$id_rec = $GPC['id_rec'];
$IdCultivo = $id = $GPC['id_cultivo'];
$idORG = $_SESSION['s_org_id'];
$cant_muestras = $GPC['cant_muestras'];
$listadoAnalisis = $analisisCul->buscarAC(null, $IdCultivo, $idORG);
$cantidad = count($listadoAnalisis);

$Rec = new Recepcion();
$infoRec = $Rec->listadoAnalisis(null, $IdCultivo, $id_rec);
//print_r($infoRec);


switch ($GPC['ac']) {
    case 'guardar': 
        $analisis = new Analisis();
        $analisis->_begin_tool();        
        for ($i = 0; $i < $GPC['cantA']; $i++) {
            $GPC['Resultados']['id_recepcion'] = $GPC['id_rec'];
            $GPC['Resultados']['id_analisis'] = $GPC['id_analisis'][$i];
            $GPC['Resultados']['id_usuario'] = $_SESSION['s_id'];
            $GPC['Resultados']['muestra1'] = number_format(round($GPC['muestra1'][$i],3));
            $muestra1=(!empty($GPC['muestra2'][$i])) ? $GPC['muestra2'][$i] : null;
            $GPC['Resultados']['muestra2'] = number_format(round($muestra1));
            $muestra2=(!empty($GPC['muestra3'][$i])) ? $GPC['muestra3'][$i] : null;
            $GPC['Resultados']['muestra3'] = number_format(round($muestra2,3));            
            $id_analisis_res = $analisis->guardarResultados($GPC['Resultados']);
        }       
        //Estatus = 2 Analisis registrado
        $Rec->cambiarEstatus($GPC['id_rec'], 2);        
        $analisis->_commit_tool();        
        
        //if(!empty($id_analisis_res)) {
            header("location: analisis_recepcion_listado.php?msg=exitoso");
            die();
        //} else {
            header("location: analisis_recepcion_listado.php?msg=error");
            die();
        //}
        break;
}


//print_r($listadoAnalisis);

require('../lib/common/header.php');
?>
<script type="text/javascript">
    function cancelar(){
        history.back();
    }
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
                <td><span><? echo $infoRec[0]['fecha_recepcion']; ?></span></td>            
            </tr>
            <tr>
                <td>Carril</td>
                <td><span><? echo $infoRec[0]['numero']; ?></span></td>
                <td>Hora</td>
                <td><? echo $infoRec[0]['creado']; ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>netbeans
                <td colspan="3"><? echo $infoRec[0]['codigo_cul'] . ' - ' . $infoRec[0]['nombre_cul']; ?></td>                
            </tr>
        </table>
        <hr>
        <table align="center" width="100%">
            <tr align="center" class="titulos_tabla">            
                <th width="1">C&oacute;digo</th>
                <th>Descripci&oacute;n</th>
<? for ($j = 1; $j <= $cant_muestras; $j++) { ?>
                    <th width="70"><?= 'Muestra ' . $j; ?></th>
                <? } ?>
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
        ?>
                        <td align="center"><? echo $html->input('muestra' . $j . '[]', '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>
                        <?
                    }
                    ?>
                </tr>
                    <?
                    $i++;
                }
                ?>
        </table>
    </fieldset>
    <table align="center">
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

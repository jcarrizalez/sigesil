<?php
require_once('../lib/core.lib.php');

$analisis = new AnalisisCultivo();

$listadoAnalisis = $analisis->buscarAC();

require('../lib/common/header.php');
?>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        NUEVO ANALISIS DE RECEPCI&Oacute;N<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos de la Muestra</legend>
        <table align="center">
            <tr>
                <td>Nro. Entrada</td>
                <td><? echo $html->input('res.codigo', $infoOrg[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                <td>Fecha</td>
                <td><? echo $html->input('res.fecha', $infoOrg[0]['fecha'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>            
            </tr>
            <tr>
                <td>Carril</td>
                <td><? echo $html->input('res.carril', $infoOrg[0]['carril'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                <td>Hora</td>
                <td><? echo $html->input('res.hora', $infoOrg[0]['hora'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="3"><? echo $html->input('res.cultivo', $infoOrg[0]['cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>                
            </tr>
        </table>
        <hr>
        <table align="center" width="100%">
            <tr align="center" class="titulos_tabla">            
                <th width="1">C&oacute;digo</th>
                <th>Descripci&oacute;n</th>
                <th width="70">Muestra 1</th>
                <th width="70">Muestra 2</th>           
            </tr>
            <?
            $i = 0;
            foreach ($listadoAnalisis as $dataAnalisis) {
                $clase = $general->obtenerClaseFila($i);
                ?>

                <tr class="<?= $clase ?>">
                    <td align="center" ><?= $dataAnalisis['codigo'] ?></td>
                    <td><?= $dataAnalisis['nombre'] ?></td>                    
                    <td align="center"><? echo $html->input('res.muestra1'. $dataAnalisis['codigo'], '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>                    
                    <td align="center"><? echo $html->input('res.muestra2'. $dataAnalisis['codigo'], '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>
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

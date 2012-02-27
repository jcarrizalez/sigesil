<?php
require_once('../lib/core.lib.php');

$Rec=new Recepcion();

//print_r($Rec);

if($_SESSION['s_perfil_id'] == GERENTEG)
    $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
else
    $idCA = $_SESSION['s_ca_id'];

$listadoRec=$Rec->listadoAnalisis(null,$idCA);

require('../lib/common/header.php');
?>
    <div id="titulo_modulo">
        LISTADO DE RECEPCIONES POR ANALISIS<br/><hr/>
    </div>
    <div id="mensajes">
        <?
            switch($GPC['msg']){
                case 'exitoso':
                    echo "<span class='msj_verde'>Registro Guardado !</span>";
                break;
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">            
            <th>Centro de Acopio</th>            
            <th>Entrada Nro</th>
            <th>C&oacute;digo de Cultivo</th> 
            <th>Fecha Recepci&oacute;n</th>
            <th>Muestras</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoRec as $dataREC){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataREC['codigo_ca']?></td>            
            <td align="center"><?=$dataREC['numero']?></td>
            <td align="center"><?=$dataREC['codigo_cul']?></td>
            <td align="center"><?=$dataREC['fecha_recepcion']?></td>
            <td align="center"><?=$dataREC['cant_muestras']?></td>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Nuevo>', 'analisis_recepcion.php?ac=nuevo&id='.$dataREC['id_rec'].'&cant_muestras='.$dataREC['cant_muestras']);
                    echo $html->link('<img src="../images/imprimir.png" width="16" height="16" title=Imprimir>', 'analisis_recepcion.php?ac=imprimir&id='.$dataREC['id_rec']);
                ?>
            </td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
<?
    require('../lib/common/footer.php');
?>
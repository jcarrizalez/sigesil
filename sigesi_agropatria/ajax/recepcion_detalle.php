<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'guia':
            $guia = new Guia();
            $listaCantM = array(1 => 1, 2, 3, 4);
            $infoGuia = $guia->find(array('numero_guia' => $GPC['numero_guia']), null, '*');
            if(!empty($infoGuia) && $infoGuia[0]['estatus'] == 'P'){
            ?>
                <tr>
                    <th colspan="2" align="center">Gu&iacute;a Procesada</th>
                    <? echo $html->input('Guia.fecha_emision', '', array('type' => 'hidden')); ?>
                </tr>
            <?
            }elseif(empty($infoGuia) || $infoGuia[0]['estatus'] == 'N'){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n </td>
                    <td>
                        <? echo $html->input('Guia.fecha_emision', $general->date_sql_screen($infoGuia[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "femision",
                                inputField : "Guia[fecha_emision]",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr>
                    <td>N&uacute;mero de Contrato </td>
                    <td><? echo $html->input('Guia.contrato', $infoGuia[0]['contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a </td>
                    <td><? echo $html->input('Guia.kilogramos', $infoGuia[0]['kilogramos'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
                </tr>
                <tr>
                    <td>Otras Gu&iacute;as </td>
                    <td><? echo $html->select('cantguia',array('options'=>$listaCantM, 'default' => 'Seleccione', 'class' => 'estilo_campos'))?></td>
                </tr>
                <tr>
                    <th colspan="2" align="center">Gu&iacute;a Nueva, se proceder&aacute; a almacenar</th>
                </tr>
                <?
            }
        break;
        case 'otraguia':
            if(!empty($GPC['cant'])){
                for($i=1; $i<=$GPC['cant'];$i++){
            ?>
                <fieldset>
                    <legend>Sub-Gu&iacute;a Nro<?=$i?></legend>
                    <table align="center" border="0">
                        <tr>
                            <td><span class="msj_rojo">* </span>N&uacute;mero </td>
                            <td>
                                <? echo $html->input("subguia_$i", '', array('type' => 'text', 'class' => 'estilo_campos positive verifSubGuia')); ?>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n </td>
                            <td>
                                <? echo $html->input("subguiaFecha_$i", '', array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
                                <img src="../images/calendario.png" id="femisionsub_<?=$i?>" width="16" height="16" style="cursor:pointer" />
                                <script>
                                    Calendar.setup({
                                        trigger    : "femisionsub_<?=$i?>",
                                        inputField : "subguiaFecha_<?=$i?>",
                                        dateFormat: "%d-%m-%Y",
                                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                        onSelect   : function() { this.hide() }
                                    });
                                </script>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            <?
                }
            }
        break;
        case 'productor':
            $cosecha = new Cosecha();
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            $infoProductor = $cosecha->buscarCosechaProductor($GPC['co'], $GPC['cp']);
            if(!empty($infoProductor)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Productor</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($infoProductor[0]['ced_productor'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_productor', substr($infoProductor[0]['ced_productor'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                            echo $html->input('id_productor', $infoProductor[0]['id_productor'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos Productor</td>
                    <td><? echo $html->input('nombre_productor', $infoProductor[0]['productor'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            <? }else{ ?>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Productor</td>
                    <td>
                        <?
                            echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr($GPC['cp'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_productor', substr($GPC['cp'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos Productor</td>
                    <td><? echo $html->input('nombre_productor', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><span class="msj_rojo">No Registrado para esta Cosecha</span></td>
                </tr>
                <?
            }
        break;
        case 'asociacion':
            $cosecha = new Cosecha();
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            $infoAsociacion = $cosecha->buscarCosechaProductor($GPC['co'], $GPC['cpro'], $GPC['caon']);
            if(!empty($infoAsociacion)){
            ?>
                <tr>
                    <td>C&eacute;dula/Rif Asociaci&oacute;n</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR, 'selected' => substr($infoAsociacion[0]['ced_asociacion'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_asociacion', substr($infoAsociacion[0]['ced_asociacion'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                            echo $html->input('id_asociacion', $infoAsociacion[0]['id_asociacion'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociaci&oacute;n</td>
                    <td><? echo $html->input('nombre_asociacion', $infoAsociacion[0]['asociacion'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            <? }else{ ?>
                <tr>
                    <td>C&eacute;dula/Rif Asociaci&oacute;n</td>
                    <td>
                        <?
                            echo $html->select('nacion2', array('options'=>$listaCR, 'selected' => substr($GPC['caon'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_asociacion', substr($GPC['caon'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociaci&oacute;n</td>
                    <td><? echo $html->input('nombre_asociacion', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><span class="msj_rojo">No Registrada para esta Cosecha o con el Productor</span></td>
                </tr>
                <?
            }
        break;
        case 'asociado':
            $cosecha = new Cosecha();
            $listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
            $infoAsociado = $cosecha->buscarCosechaProductor($GPC['co'], $GPC['cpro'], $GPC['caon'], $GPC['cado']);
            if(!empty($infoAsociado)){
            ?>
                <tr>
                    <td>C&eacute;dula/Rif Asociado</td>
                    <td>
                        <?
                            echo $html->select('nacion3', array('options'=>$listaCR, 'selected' => substr($infoAsociado[0]['ced_asociado'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_asociado', substr($infoAsociado[0]['ced_asociado'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                            echo $html->input('id_asociado', $infoAsociado[0]['id_asociado'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociado</td>
                    <td><? echo $html->input('nombre_asociado', $infoAsociado[0]['asociado'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            <? }else{ ?>
                <tr>
                    <td>C&eacute;dula/Rif Asociado</td>
                    <td>
                        <?
                            echo $html->select('nacion3', array('options'=>$listaCR, 'selected' => substr($GPC['cado'], 0, 1)));
                            echo "&nbsp;".$html->input('ced_rif_asociado', substr($GPC['cado'], 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 151px', 'class' => 'crproductor positive'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombres y Apellidos Asociado</td>
                    <td><? echo $html->input('nombre_asociado', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><span class="msj_rojo">No Registrado para esta Cosecha o con el Productor</span></td>
                </tr>
                <?
            }
        break;
        case 'chofer':
            $chofer = new Chofer();
            $infoChofer = $chofer->find(array('ced_rif' => $GPC['cp']));
            $choNuevo = (empty($infoChofer)) ? true : false;
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos </td>
                    <td><? echo $html->input('Chofer.nombre', $infoChofer[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
                if($choNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Chofer Nuevo, se proceder&aacute; a almacenar</th>
                    </tr>
                    <?
                }
        break;
    }
?>
<script type="text/javascript">
$(document).ready(function(){
    $('.positive').numeric();
});
$('#preg_asociado').change(function(){
    if($(this).val() == 0)
        $('#fieldAsociado').css('display', 'none');
    else
        $('#fieldAsociado').css('display', 'block');
});
</script>
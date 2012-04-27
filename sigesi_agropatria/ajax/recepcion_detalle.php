<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'guia':
            $guia = new Guia();
            $listaCantM = array(1 => 1, 2 => 2, 3 => 3);
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
                <!--tr>
                    <td>Disponible a Recibir </td>
                    <td><? echo $html->input('Guia.direccion', $infoGuia[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr-->
                <tr>
                    <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a </td>
                    <td><? echo $html->input('Guia.kilogramos', $infoGuia[0]['kilogramos'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
                </tr>
                <tr>
                    <td>Otras Gu&iacute;as </td>
                    <td><? echo $html->select('cantguia',array('options'=>$listaCantM, 'default' => 'Seleccione'))?></td>
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
                                <? echo $html->input("subguia_$i", '', array('type' => 'text', 'class' => 'estilo_campos positive')); ?>
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
            $productor = new Productor();
            $infoProductor = $productor->find(array('ced_rif' => $GPC['cp']), '', array('ced_rif', 'nombre'), '');
            if(!empty($infoProductor)){
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos </td>
                    <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Asociaci&oacute;n</td>
                    <td>
                        <?
                            echo $html->input('ced_rif_entidad', $infoProductor[0]['cedula_asociacion'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
                            echo $html->input('id_asociacion', $infoProductor[0]['id_asociacion'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos Asociaci&oacute;n</td>
                    <td><? echo $html->input('nombre_asociacion', $infoProductor[0]['nombre_asociacion'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Asociado</td>
                    <td>
                        <?
                            echo $html->input('ced_rif_asociado', $infoProductor[0]['cedula_asociado'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
                            echo $html->input('id_asociado', $infoProductor[0]['id_asociado'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos Asociado</td>
                    <td><? echo $html->input('nombre_asociado', $infoProductor[0]['nombre_asociado'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
            }else{
                ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos </td>
                    <td><? echo $html->input('Productor.nombre', '', array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td colspan="2" align="center"><span class="msj_rojo">Productor No Registrado</span></td>
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
<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'guia':
            $guia = new Guia();
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
                    <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
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
                <!--tr>
                    <td>N&uacute;mero de Contrato: </td>
                    <td><? echo $html->input('Guia.contrato', $infoGuia[0]['contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Disponible a Recibir: </td>
                    <td><? echo $html->input('Guia.direccion', $infoGuia[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr-->
                <tr>
                    <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a: </td>
                    <td><? echo $html->input('Guia.kilogramos', $infoGuia[0]['kilogramos'], array('type' => 'text', 'class' => 'estilo_campos integer')); ?> (Kgrs)</td>
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
                            <td><span class="msj_rojo">* </span>N&uacute;mero: </td>
                            <td>
                                <? echo $html->input('subguia[]', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?>
                            </td>
                        </tr>
                        <tr>
                            <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
                            <td>
                                <? echo $html->input('subguia_fecha[]', $general->date_sql_screen($infoGuia[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
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
                    </table>
                </fieldset>
            <?
                }
            }
        break;
        case 'productor':
            $infoProductor = $recepcion->productorRecepcion($GPC['cp']);
            $verifAso = $recepcion->verificarProAso($GPC['co'], $_SESSION['s_ca_id'], $GPC['cp']);
            $listaConfirmacion = array(0 => 'No', 'Si');
            $proNuevo = (empty($infoProductor)) ? true : false;
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Productor.nombre', $infoProductor[0]['nombre_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono: </td>
                    <td><? echo $html->input('Productor.telefono', $infoProductor[0]['telefono_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><? echo $html->input('Productor.email', $infoProductor[0]['email_pro'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <? if(empty($verifAso)){ ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Tiene Asociado: </td>
                    <td><? echo $html->select('preg_asociado', array('options'=>$listaConfirmacion)); ?></td>
                </tr>
                <script type="text/javascript">
                    $('#fieldAsociado').css('display', 'none');
                </script>
            <?
                }elseif($verifAso[0]['asociado'] == 't'){
            ?>
                <script type="text/javascript">
                    $('#fieldAsociado').css('display', 'block');
                </script>
            <?
                }elseif($verifAso[0]['asociado'] == 'f'){
            ?>
                <script type="text/javascript">
                    $('#fieldAsociado').css('display', 'none');
                </script>
            <?
                }
                if($proNuevo){
            ?>
                <tr>
                    <th colspan="2" align="center">Productor Nuevo, se proceder&aacute; a almacenar</th>
                </tr>
            <?
                }
                echo $html->input('Productor.id', $infoProductor[0]['id'], array('type' => 'hidden'));
        break;
        case 'asociado':
            $infoAsociado = $recepcion->asociadoRecepcion($GPC['cp']);
            $asoNuevo = (empty($infoAsociado)) ? true : false;
            ?>
                <tr>
                    <td>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Asociado.nombre', $infoAsociado[0]['nombre_aso'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Tel&eacute;fono: </td>
                    <td><? echo $html->input('Asociado.telefono', $infoAsociado[0]['telefono_aso'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
            <?
                if($asoNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Asociado Nuevo, se proceder&aacute; a almacenar</th>
                    </tr>
                    <?
                }
                echo $html->input('Asociado.id', $infoAsociado[0]['id'], array('type' => 'hidden'));
        break;
        case 'chofer':
            $infoVehiculo = $recepcion->buscarChofer($GPC['cp']);
            $choNuevo = (empty($infoVehiculo)) ? true : false;
            ?>
                <tr>
                    <td><span class="msj_rojo">* </span>Nombres y Apellidos: </td>
                    <td><? echo $html->input('Guia.nombre_chofer', $infoVehiculo[0]['nombre_cho'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
    $('.integer').numeric();
});
$('#preg_asociado').change(function(){
    if($(this).val() == 0)
        $('#fieldAsociado').css('display', 'none');
    else
        $('#fieldAsociado').css('display', 'block');
});
</script>
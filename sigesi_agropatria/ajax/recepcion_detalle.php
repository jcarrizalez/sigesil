<?php
    require_once('../lib/core.lib.php');
    $recepcion = new Recepcion();
    
    switch ($GPC['ac']){
        case 'guia':
            $guia = new Guia();
            $infoGuia = $guia->find(array('numero_guia' => $GPC['numero_guia']), '', '*', '');
            $guiaNueva = (empty($infoGuia)) ? true : false;
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
                <tr>
                    <td>N&uacute;mero de Contrato: </td>
                    <td><? echo $html->input('Guia.contrato', $infoGuia[0]['contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <!--tr>
                    <td>Disponible a Recibir: </td>
                    <td><? echo $html->input('Guia.direccion', $infoGuia[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr>
                <tr>
                    <td>Cultivo: </td>
                    <td><? echo $html->input('Guia.id_cultivo', $infoGuia[0]['id_cultivo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
                </tr-->
                <tr>
                    <td><span class="msj_rojo">* </span>Kilogramos Gu&iacute;a: </td>
                    <td><? echo $html->input('Guia.kilogramos', $infoGuia[0]['kilogramos'], array('type' => 'text', 'class' => 'estilo_campos')); ?> (Kgrs)</td>
                </tr>
                <? if($guiaNueva){ ?>
                <tr>
                    <th colspan="2" align="center">Gu&iacute;a Nueva, se proceder&aacute; a almacenar</th>
                </tr>
                <? } ?>
            <?
        break;
        case 'productor':
            $infoProductor = $recepcion->productorRecepcion($GPC['cp']);
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
            <?
                if($proNuevo){
                    ?>
                    <tr>
                        <th colspan="2" align="center">Productor Nuevo, se proceder&aacute; a almacenar</th>
                    </tr>
                    <?
                }
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
        break;
        case 'chofer':
            $infoVehiculo = $recepcion->buscarChofer($GPC['cp']);
            $choNuevo = (empty($infoVehiculo)) ? true : false;
            ?>
                <tr>
                    <td>Nombres y Apellidos: </td>
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

<?php
    require_once('../lib/core.lib.php');
    
    $recepcion = new Recepcion();
    
    $detalleRecepcion = $recepcion->listadoRecepcion($GPC['id']);
    $pesoLleno = round($detalleRecepcion[0]['peso_01l'] + $detalleRecepcion[0]['peso_02l']);
    $pesoVacio = round($detalleRecepcion[0]['peso_01v'] + $detalleRecepcion[0]['peso_02v']);
    $pesoAcondicionado = (!empty($detalleRecepcion[0]['peso_acon'])) ? round($detalleRecepcion[0]['peso_acon']) : 0;
    
    switch($GPC['ac']){
        case 'Resultados':
            header("location: ".DOMAIN_ROOT."reportes/imprimir.php?reporte=boleta_recepcion&id_rec=".$GPC['id']."&re=true");
            die();
        break;
        case 'Liquidacion':
            header('location: pdf_listado_recepciones_todo.php?id='.$fliq."_".$frec."_".$idCA."_".$idCo);
            die();
        break;
        case 'Rechazo':
            header('location: pdf_listado_recepciones_todo.php?id='.$fliq."_".$frec."_".$idCA."_".$idCo);
            die();
        break;
    }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title><?php echo SYSTEM_NAME ?></title>
        <link href="<?=DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
        <script language="javascript">
            function closeMessage(){
                ventana = window.self;
                ventana.opener = window.self;
                ventana.close();
            }
        </script>
    </head>
    <body>
        <div id="titulo_modulo">
            Detalle de la Recepci&oacute;n<br/><input id="cerrar" name="cerrar" type="button" onclick="closeMessage()" value="<?="Cerrar"?>" /><hr/>
        </div>
        <table align="center" border="0" cellspacing="0">
            <tr align="center" class="titulos_tabla borde_th_reporte">
                <th>Centro de Acopio</th>
                <th>Programa</th>
                <th>Cosecha</th>
                <th>Gu&iacute;a</th>
                <th>Fecha Recepci&oacute;n</th>
                <th>C&eacute;dula/RIF Productor</th>
                <th>Productor</th>
                <th>C&eacute;dula/RIF Asociaci&oacute;n</th>
                <th>Asociaci&oacute;n</th>
                <th>C&eacute;dula/RIF Asociaciado</th>
                <th>Asociaciado</th>
                <th>Veh&iacute;culo</th>
                <th>Placas</th>
                <th>C&eacute;dula Chofer</th>
                <th>Chofer</th>
                <th>Romana Entrada</th>
                <th>Peso Lleno Motriz</th>
                <th>Peso Lleno Remolque/Batea</th>
                <th>Peso Bruto</th>
                <th>Romana Salida</th>
                <th>Peso Vac&iacute;o Motriz</th>
                <th>Peso Vac&iacute;o Remolque/Batea</th>
                <th>Tara del Veh&iacute;culo</th>
                <th>Humedad %</th>
                <th>Descuento Humedad</th>
                <th>Impureza %</th>
                <th>Descuento Impureza</th>
                <th>Peso Acondicionado</th>
                <th>Peso Acondicionado a Liquidar</th>
                <th>Fecha Liquidaci&oacute;n</th>
            </tr>
            <tr align="center" class="borde_td_reporte">
                <td><?php echo $detalleRecepcion[0]['centro_acopio'] ?></td>
                <td><?php echo $detalleRecepcion[0]['programa'] ?></td>
                <td><?php echo $detalleRecepcion[0]['cosecha_codigo'] ?></td>
                <td><?php echo $detalleRecepcion[0]['numero_guia'] ?></td>
                <td><?php echo $general->date_sql_screen($detalleRecepcion[0]['fecha_recepcion'], '', 'es', '-') ?></td>
                <td><?php echo $detalleRecepcion[0]['ced_productor'] ?></td>
                <td><?php echo $detalleRecepcion[0]['productor_nombre'] ?></td>
                <td><?php echo $detalleRecepcion[0]['ced_asociacion'] = (!empty($detalleRecepcion[0]['ced_asociacion'])) ? $detalleRecepcion[0]['ced_asociacion'] : "-" ?></td>
                <td><?php echo $detalleRecepcion[0]['asociacion_nombre'] = (!empty($detalleRecepcion[0]['asociacion_nombre'])) ? $detalleRecepcion[0]['asociacion_nombre'] : "-" ?></td>
                <td><?php echo $detalleRecepcion[0]['ced_asociado'] = (!empty($detalleRecepcion[0]['ced_asociado'])) ? $detalleRecepcion[0]['ced_asociado'] : "-" ?></td>
                <td><?php echo $detalleRecepcion[0]['asociado_nombre'] = (!empty($detalleRecepcion[0]['asociado_nombre'])) ? $detalleRecepcion[0]['asociado_nombre'] : "-" ?></td>
                <td><?php echo $detalleRecepcion[0]['marca'] ?></td>
                <td><?php echo $detalleRecepcion[0]['placa'] ?></td>
                <td><?php echo $detalleRecepcion[0]['ced_chofer'] ?></td>
                <td><?php echo $detalleRecepcion[0]['chofer_nombre'] ?></td>
                <td><?php echo $detalleRecepcion[0]['romana_ent'] ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['peso_01l']), 3) ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['peso_02l']), 3) ?></td>
                <td><?php echo $general->formato_numero(round($pesoLleno), 3) ?></td>
                <td><?php echo $detalleRecepcion[0]['romana_sal'] ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['peso_01v']), 3) ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['peso_02v']), 3) ?></td>
                <td><?php echo $general->formato_numero(round($pesoVacio), 3) ?></td>
                <td><?php echo $detalleRecepcion[0]['humedad'] ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['humedad_des']), 3) ?></td>
                <td><?php echo $detalleRecepcion[0]['impureza'] ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['impureza_des']), 3) ?></td>
                <td><?php echo $general->formato_numero(round($pesoAcondicionado), 3) ?></td>
                <td><?php echo $general->formato_numero(round($detalleRecepcion[0]['peso_acon_liq']), 3) ?></td>
                <td><?php echo $general->date_sql_screen($detalleRecepcion[0]['fecha_v'], '', 'es', '-') ?></td>
            </tr>
            <tr>
                <td id="titulo_modulo" colspan="20" align="center" style="padding-top: 50px;">REIMPRIMIR</td>
            </tr>
            <tr>
                <td colspan="20" align="center">
                    <form name="form1" id="form1" method="POST" action="#" enctype="multipart/form-data">
                    <?
                        echo $html->input('id', $detalleRecepcion[0]['id'], array('type' => 'hidden'));
                        if($detalleRecepcion[0]['estatus_rec'] <= 9){
                            echo $html->input('ac', 'Resultados', array('type' => 'submit'));
                            echo $html->input('ac', 'Liquidacion', array('type' => 'submit'));
                        }
                        if($detalleRecepcion[0]['estatus_rec'] == 7 && $detalleRecepcion[0]['estatus_rec'] == 8){
                            echo $html->input('ac', 'Resultados', array('type' => 'submit'));
                            echo $html->input('ac', 'Rechazo', array('type' => 'submit'));
                        }
                    ?>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>
<?php
    require_once('../lib/core.lib.php');
    
    $despacho = new Despacho();
    
    $detalleDespacho = $despacho->listadoDespacho($GPC['id']);
    $pesoLleno = $detalleDespacho[0]['peso_01l'] + $detalleDespacho[0]['peso_02l'];
    $pesoVacio = $detalleDespacho[0]['peso_01v'] + $detalleDespacho[0]['peso_02v'];
    $pesoAcondicionado = (!empty($detalleDespacho[0]['peso_acon'])) ? $detalleDespacho[0]['peso_acon'] : 0;
    $pesoAcondicionado2 = (!empty($detalleDespacho[0]['peso_acon2'])) ? $detalleDespacho[0]['peso_acon2'] : 0;
    $placa = $detalleDespacho[0]['placa'];
    $placa .= (!empty($detalleDespacho[0]['placa_remolques'])) ? " / ".$detalleDespacho[0]['placa_remolques'] : '';
    switch($GPC['ac']){
        case 'Liquidacion':
            header("location: ".DOMAIN_ROOT."reportes/imprimir.php?reporte=boleta_liquidacion&id_rec=".$GPC['id']."&mov=des&ca=".$GPC['ca']."&re=true");
            die();
        break;
    }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title><?php echo SYSTEM_NAME ?></title>
        <link href="<?php echo DOMAIN_ROOT?>css/frontend.css" rel="stylesheet" type="text/css" />
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
            Detalle del Despacho<br/><input id="cerrar" name="cerrar" type="button" onclick="closeMessage()" value="<?php echo "Cerrar"?>" /><hr/>
        </div>
        <table align="center" border="0" cellspacing="0">
            <tr align="center" class="titulos_tabla borde_th_reporte">
                <th>Centro de Acopio</th>
                <th>Cultivo</th>
                <th>Orden</th>
                <th>Fecha Despacho</th>
                <th>C&eacute;dula/RIF Cliente</th>
                <th>Cliente</th>
                <th>Veh&iacute;culo</th>
                <th>Placas</th>
                <th>C&eacute;dula Chofer</th>
                <th>Chofer</th>
                <th>Romana Entrada</th>
                <th>Peso Vac&iacute;o Motriz</th>
                <th>Peso Vac&iacute;o Remolque/Batea</th>
                <th>Romana Salida</th>
                <th>Peso Lleno Motriz</th>
                <th>Peso Lleno Remolque/Batea</th>
                <th>Peso Bruto</th>
                <th>Tara del Veh&iacute;culo</th>
                <th>%Humedad Motriz</th>
                <th>%Humedad Remolque</th>
                <th>Descuento Humedad Motriz</th>
                <th>Descuento Humedad Remolque</th>
                <th>%Impureza Motriz</th>
                <th>%Impureza Remolque</th>
                <th>Descuento Impureza Motriz</th>
                <th>Descuento Impureza Remolque</th>
                <th>Peso Acondicionado Motriz</th>
                <th>Peso Acondicionado Remolque</th>
                <th>Peso Acondicionado a Liquidar Motriz</th>
                <th>Peso Acondicionado a Liquidar Remolque</th>
                <th>Fecha Liquidaci&oacute;n</th>
            </tr>
            <tr align="center" class="borde_td_reporte">
                <td><?php echo $detalleDespacho[0]['centro_acopio'] ?></td>
                <td><?php echo "(".$detalleDespacho[0]['cultivo_codigo'].") ".$detalleDespacho[0]['cultivo_nombre'] ?></td>
                <td><?php echo $detalleDespacho[0]['numero_guia'] ?></td>
                <td><?php echo $general->date_sql_screen($detalleDespacho[0]['fecha_des'], '', 'es', '-') ?></td>
                <td><?php echo $detalleDespacho[0]['ced_cliente'] ?></td>
                <td><?php echo $detalleDespacho[0]['cliente_nombre'] ?></td>
                <td><?php echo $detalleDespacho[0]['marca'] ?></td>
                <td><?php echo $placa ?></td>
                <td><?php echo $detalleDespacho[0]['ced_chofer'] ?></td>
                <td><?php echo $detalleDespacho[0]['chofer_nombre'] ?></td>
                <td><?php echo $detalleDespacho[0]['romana_ent'] ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_01v'], 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_02v'], 3) ?></td>
                <td><?php echo $detalleDespacho[0]['romana_sal'] ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_01l'], 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_02l'], 3) ?></td>
                <td><?php echo $general->formato_numero($pesoLleno, 3) ?></td>
                <td><?php echo $general->formato_numero($pesoVacio, 3) ?></td>
                <td><?php echo $detalleDespacho[0]['humedad'] = (!empty($detalleDespacho[0]['humedad'])) ? $detalleDespacho[0]['humedad'] : 0 ?></td>
                <td><?php echo $detalleDespacho[0]['humedad2'] = (!empty($detalleDespacho[0]['humedad2'])) ? $detalleDespacho[0]['humedad2'] : 0 ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['humedad_des'], 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['humedad_des2'], 3) ?></td>
                <td><?php echo $detalleDespacho[0]['impureza'] = (!empty($detalleDespacho[0]['impureza'])) ? $detalleDespacho[0]['impureza'] : 0 ?></td>
                <td><?php echo $detalleDespacho[0]['impureza2'] = (!empty($detalleDespacho[0]['impureza2'])) ? $detalleDespacho[0]['impureza2'] : 0 ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['impureza_des'], 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['impureza_des2'], 3) ?></td>
                <td><?php echo $general->formato_numero($pesoAcondicionado, 3) ?></td>
                <td><?php echo $general->formato_numero($pesoAcondicionado2, 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_acon_liq'], 3) ?></td>
                <td><?php echo $general->formato_numero($detalleDespacho[0]['peso_acon_liq2'], 3) ?></td>
                <td><?php echo $general->date_sql_screen($detalleDespacho[0]['fecha_v'], '', 'es', '-') ?></td>
            </tr>
            <tr>
                <td id="titulo_modulo" colspan="20" align="center" style="padding-top: 50px;">REIMPRIMIR</td>
            </tr>
            <tr>
                <td colspan="20" align="center">
                    <form name="form1" id="form1" method="POST" action="#" enctype="multipart/form-data">
                    <?php
                        echo $html->input('id', $detalleDespacho[0]['id'], array('type' => 'hidden'));
                        if($detalleDespacho[0]['estatus'] == 5)
                            echo $html->input('ac', 'Liquidacion', array('type' => 'submit'));
                    ?>
                    </form>
                </td>
            </tr>
        </table>
    </body>
</html>

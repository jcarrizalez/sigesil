<?
    require_once('../lib/core.lib.php');
    
    $despacho = new Despacho();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];

    $fdesde = (!empty($fdesde)) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : '';
    $fhasta = (!empty($fhasta)) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : '';
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    //$listadoDespachos = $despacho->listadoDespacho('', $idCA, '', '', '', "'5'", $fdesde, $fhasta);
    $listadoDespachos = $despacho->listadoDespacho('', $idCA, '', '', '', '', $fdesde, $fhasta);
    
    $total_registros = $silos->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    switch($GPC['ac']){
        case 'excel':
            $listadoDespachos = $despacho->listadoDespacho('', $idCA, '', '', '', "'5'", $fdesde, $fhasta);
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        REPORTE DESPACHO<br/><hr/>
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
    <div id="filtro">
        <form name="form1" id="form1" method="POST" action="?ac=excel" enctype="multipart/form-data">
            <table width="100%" border="0">
                <tr>
                    <td width="1">Desde </td>
                    <td width="200">
                        <? echo $html->input('fecha_inicio', $GPC['fecha_inicio'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fdesde" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fdesde",
                                inputField : "fecha_inicio",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_inicio']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td width="1">Hasta </td>
                    <td>
                        <? echo $html->input('fecha_fin', $GPC['fecha_fin'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fhasta" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fhasta",
                                inputField : "fecha_fin",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_fin']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            /*if($_SESSION['s_perfil_id'] == GERENTES){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }*/
                            echo $html->input('Excel', 'Excel', array('type' => 'submit'));
                            echo $html->input('PDF', 'PDF', array('type' => 'button'));
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Despacho #</th>
            <th>Orden</th>
            <th>Fecha</th>
            <th>Placa</th>
            <th>Peso Bruto</th>
            <th>Tara</th>
            <th>Peso Neto</th>
            <th>% Hum</th>
            <th>Dcto Hum</th>
            <th>% Imp</th>
            <th>Dcto Imp</th>
            <th>P. Acondicionado</th>
        </tr>
        <?
            $i=0;
            $totalPesoBruto = 0;
            $totalPesoTara = 0;
            $totalPesoNeto = 0;
            $totalPesoAcon = 0;
            foreach($listadoDespachos as $dataDespacho){
            $clase = $general->obtenerClaseFila($i);
            $pesoBruto = $dataDespacho['peso_01l'] + $dataDespacho['peso_02l'];
            $pesoTara = $dataDespacho['peso_01v'] + $dataDespacho['peso_02v'];
            $pesoNeto = $pesoBruto - $pesoTara;
            $pesoAcon = ($pesoNeto - ($dataDespacho['humedad_des'] + $dataDespacho['impureza_des']));
            
            $totalPesoBruto += $pesoBruto;
            $totalPesoTara += $pesoTara;
            $totalPesoNeto += $pesoNeto;
            $totalPesoAcon += $pesoAcon;
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataDespacho['numero']?></td>
            <td align="center"><?=$dataDespacho['numero_guia']?></td>
            <td align="center"><?=$general->date_sql_screen($dataDespacho['fecha_des'], '', 'es', '-')?></td>
            <td align="center"><?=$dataDespacho['placa']?></td>
            <td align="center"><?=$pesoBruto?></td>
            <td align="center"><?=$pesoTara?></td>
            <td align="center"><?=$pesoNeto?></td>
            <td align="center"><?=$dataDespacho['humedad']?></td>
            <td align="center"><?=$dataDespacho['humedad_des']?></td>
            <td align="center"><?=$dataDespacho['impureza']?></td>
            <td align="center"><?=$dataDespacho['impureza_des']?></td>
            <td align="center"><?=$pesoAcon?></td>
        </tr>
        <? $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?
    require('../lib/common/footer.php');
?>
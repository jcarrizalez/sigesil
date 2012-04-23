<?
    require_once('../lib/core.lib.php');
    
    $despacho = new Despacho();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);

    $fdesde = (!empty($GPC['fecha_inicio'])) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : date('Y-m-d');
    $fhasta = (!empty($GPC['fecha_fin'])) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : date('Y-m-d');
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoDespachos = $despacho->listadoDespacho('', $idCA, '', '', '', "'5'", $fdesde, $fhasta);
    
    $total_registros = $silos->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    switch($GPC['ac']){
        case 'Pdf':
            header('location: pdf_listado_despachos_todo.php?id='.$fdesde."_".$fhasta."_".$idCA);
            die();
        break;
        case 'Excel':
            
        break;
        case 'Buscar':
            
        break;
    }
    
    /*switch($GPC['ac']){
        case 'excel':
            $listadoDespachos = $despacho->listadoDespacho('', $idCA, '', '', '', "'5'", $fdesde, $fhasta);
        break;
    }*/
    
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
        <form name="form1" id="form1" method="POST" action="#" enctype="multipart/form-data">
            <table width="100%" border="0">
                <tr>
                    <td width="1">Desde </td>
                    <td width="200">
                        <? echo $html->input('fecha_inicio', $general->date_sql_screen($fdesde, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
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
                        <? echo $html->input('fecha_fin', $general->date_sql_screen($fhasta, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
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
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Seleccione'));
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            echo $html->input('ac', 'Excel', array('type' => 'submit'));
                            echo $html->input('ac', 'Pdf', array('type' => 'submit'));
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
            <th>Orden</th>
            <th>Fecha</th>
            <th>Cultivo</th>
            <th>Cedula/Rif Cliente</th>
            <th>Cliente</th>
            <th>Accion</th>
            <!--th>Placa</th>
            <th>Peso Bruto</th>
            <th>Tara</th>
            <th>Peso Neto</th>
            <th>% Hum</th>
            <th>Dcto Hum</th>
            <th>% Imp</th>
            <th>Dcto Imp</th>
            <th>P. Acondicionado</th-->
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
                $idCA = (!empty($idCA)) ? "_$idCA" : '';
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataDespacho['numero_guia']?></td>
            <td align="center"><?=$general->date_sql_screen($dataDespacho['fecha_des'], '', 'es', '-')?></td>
            <td align="center"><?= "(".$dataDespacho['cultivo_codigo'].")".$dataDespacho['cultivo_nombre']?></td>
            <td align="center"><?=$dataDespacho['ced_cliente']?></td>
            <td align="center"><?=$dataDespacho['cliente_nombre']?></td>
            
            <td align="center">
                <? echo $html->link('<img src="../images/imprimir.png" width="16" height="16" title=Imprimir>', '../reportes/pdf_listado_despachos_individual.php?id='.$dataDespacho['numero_guia'].'_'.$fdesde.'_'.$fhasta.$idCA); ?>
            </td>
            <!--td align="center"><?=$dataDespacho['placa']?></td>
            <td align="center"><?=$pesoBruto?></td>
            <td align="center"><?=$pesoTara?></td>
            <td align="center"><?=$pesoNeto?></td>
            <td align="center"><?=$dataDespacho['humedad']?></td>
            <td align="center"><?=$dataDespacho['humedad_des']?></td>
            <td align="center"><?=$dataDespacho['impureza']?></td>
            <td align="center"><?=$dataDespacho['impureza_des']?></td>
            <td align="center"><?=$pesoAcon?></td-->
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
<?
    require_once('../lib/core.lib.php');
    
    $recepcion = new Recepcion();
    $centro_acopio = new CentroAcopio();
    $cosecha = new Cosecha();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosecha = $cosecha->buscarCosechaP(null, null, null, null, $idCA);
    foreach($listadoCosecha as $valor){
        $listadoC[$valor['id']] = $valor['codigo'];
    }
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $listadoE = array(1 => 'Lab. Central', 
                            'Cuarentena Central', 
                            'Romana Lleno', 
                            'Lab. Planta', 
                            'Cuarentena Planta', 
                            'Romana Vac&iacute;o', 
                            'Rechazo Central', 
                            'Rechazo Planta', 
                            'Liquidado');

    $guia = (!empty($GPC['guia'])) ? $GPC['guia'] : '';
    $idCo = (!empty($GPC['id_cosecha'])) ? $GPC['id_cosecha'] : '';
    $entrada = (!empty($GPC['entrada'])) ? $GPC['entrada'] : '';
    $contrato = (!empty($GPC['contrato'])) ? $GPC['contrato'] : '';
    $productor = (!empty($GPC['productor'])) ? $GPC['productor'] : '';
    $placa = (!empty($GPC['placa'])) ? $GPC['placa'] : '';
    $estatus = (!empty($GPC['estatus'])) ? $GPC['estatus'] : '';
    $fliq = (!empty($GPC['fecha_liq'])) ? $general->fecha_normal_sql($GPC['fecha_liq'], 'es') : '';
    $frec = (!empty($GPC['fecha_rec'])) ? $general->fecha_normal_sql($GPC['fecha_rec'], 'es') : '';
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
                                    //listadoRecepcion($id=null, $idCa=null, $idCo=null, $idSilo=null, $entradaNum=null, $estatus=null, $fdesde=null, $fhasta=null, $porPagina=null, $inicio=null, $idPro=null, $order=null, $contrato=null, $productor=null, $idP=null, $placa=null, $fechaLiq=null, $fechaRec=null, $idAon=null){
    //$idCA, $entrada, $contrato, $productor, $programa, $placa, $estatus, $fliq, $frec
    $listadoRecepciones = $recepcion->listadoRecepcion(null, $idCA, $idCo, null, $entrada, $estatus, null, null, $porPagina, $inicio, null, null, $contrato, $productor, null, $placa, $fliq, $frec);
    
    $total_registros = $recepcion->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    switch($GPC['ac']){
        case 'Pdf':
            $idCA = (!empty($idCA)) ? $idCA : 'vacio';
            $idCo = (!empty($idCo)) ? $idCo : 'vacio';
            header('location: pdf_listado_recepciones_todo.php?id='.$fliq."_".$frec."_".$idCA."_".$idCo);
            die();
        break;
        case 'Excel':
            
        break;
    }
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    show_div_loader();
    
    var win = null;
    function openWindow(mypage,myname,w,h,scroll){
        LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
        TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
        settings ='height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+', scrollbars=yes ';
        win = window.open(mypage,myname,settings)
    }
    
    $(document).ready(function(){        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        CONSULTA DEL GERENTE - RECEPCI&Oacute;N<br/><hr/>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#" enctype="multipart/form-data">
            <table width="100%" border="0">
                <tr>
                    <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                    <td>Centro de Acopio</td>
                    <td><? echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $idCA, 'default' => 'Todos', 'class' => 'inputGrilla')); ?></td>
                    <? } ?>
                    <!--td>Agencia</td>
                    <td><? echo $html->select('id_agencia',array('options'=>$listaCA, 'selected' => $idAg, 'default' => 'Todos', 'class' => 'inputGrilla')); ?></td-->
                </tr>
                <tr>
                    <td>Guia</td>
                    <td colspan="3"><? echo $html->input('guia', $guia, array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                </tr>
                <tr>
                    <td width="125">Entrada</td>
                    <td><? echo $html->input('entrada', $entrada, array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                    <td width="90">Contrato</td>
                    <td><? echo $html->input('contrato', $contrato, array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                </tr>
                <tr>
                    <td>Productor</td>
                    <td><? echo $html->input('productor', $productor, array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                    <td>Cosecha</td>
                    <td><? echo $html->select('id_cosecha',array('options'=>$listadoC, 'selected' => $idCo, 'default' => 'Todas', 'class' => 'inputGrilla'))?></td>
                </tr>
                <tr>
                    <td>Placa Veh&iacute;culo</td>
                    <td><? echo $html->input('placa', $placa, array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                    <td>Estatus</td>
                    <td><? echo $html->select('estatus',array('options'=>$listadoE, 'selected' => $estatus, 'default' => 'Todos', 'class' => 'inputGrilla'))?></td>
                </tr>
                <tr>
                    <td width="1">Fecha de Recepci&oacute;n</td>
                    <td>
                        <? echo $html->input('fecha_rec', $general->date_sql_screen($frec, '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="frec" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "frec",
                                inputField : "fecha_rec",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_rec']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                    <td>Fecha de Liq</td>
                    <td width="240">
                        <? echo $html->input('fecha_liq', $general->date_sql_screen($fliq, '', 'es', '-'), array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => true)); ?>
                        <img src="../images/calendario.png" id="fliq" width="16" height="16" style="cursor:pointer" />
                        <script>
                            Calendar.setup({
                                trigger    : "fliq",
                                inputField : "fecha_liq",
                                dateFormat: "%d-%m-%Y",
                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($GPC['fecha_liq']));?>),
                                onSelect   : function() { this.hide() }
                            });
                        </script>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
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
    <table align="center" width="100%" border="0">
        <tr align="center" class="titulos_tabla">
            <th width="100">Entrada Nro</th>
            <th width="140">Cedula/Rif Productor</th>
            <th>Productor</th>
            <th width="1">Cosecha</th>
            <th width="1">Cultivo</th>
            <th width="1">Estatus</th>
            <th width="1">Accion</th>
            <th>Accion</th>
        </tr>
        <?
            $i=0;
            $idCA = (!empty($idCA)) ? "_$idCA" : '';
            foreach($listadoRecepciones as $dataRecepcion){
                $clase = $general->obtenerClaseFila($i);
                $numero = ($dataRecepcion['numero'] < 10) ? '0'.$dataRecepcion['numero'] : $dataRecepcion['numero'];
                $numEntrada = "R".$numero.$general->date_sql_screen($dataRecepcion['fecha_recepcion'], '', 'es', null);
                $pesoBruto = $dataRecepcion['peso_01l'] + $dataRecepcion['peso_02l'];
                $pesoTara = $dataRecepcion['peso_01v'] + $dataRecepcion['peso_02v'];
                $pesoNeto = $pesoBruto - $pesoTara;
                $pesoAcon = ($pesoNeto - ($dataRecepcion['humedad_des'] + $dataRecepcion['impureza_des']));
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$numEntrada?></td>
            <td align="center"><?=$dataRecepcion['ced_productor']?></td>
            <td align="center"><?=$dataRecepcion['productor_nombre']?></td>
            <td align="center"><?=$dataRecepcion['cosecha_codigo']?></td>
            <td align="center"><?=$dataRecepcion['cultivo_codigo']?></td>
            <td>
                <?
                    switch($dataRecepcion['estatus_rec']){
                        case 1:
                            echo $estatus = 'Lab. Central';
                        break;
                        case 2:
                        case 10:
                        case 11:
                            echo $estatus = 'Cuarentena Central';
                        break;
                        case 3:
                            echo $estatus = 'Romana Lleno';
                        break;
                        case 4:
                            echo $estatus = 'Lab. Planta';
                        break;
                        case 5:
                        case 12:
                        case 13:
                            echo $estatus = 'Cuarentena Planta';
                        break;
                        case 6:
                            echo $estatus = 'Romana Vac&iacute;o';
                        break;
                        case 7:
                            echo $estatus = 'Rechazo Central';
                        break;
                        case 8:
                            echo $estatus = 'Rechazo Planta';
                        break;
                        case 9:
                            echo $estatus = 'Liquidado';
                        break;
                    }
                ?>
            </td>
            <td align="center">
                <img src="../images/buscar.png" width="16" height="16" title="Detalle" border="0" style="cursor:pointer" onclick="openWindow('gerente_recepcion_detalle.php?id=<?php echo $dataRecepcion['id'] ?>','','1200','500','visible');return false;">
            </td>
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
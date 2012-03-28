<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
    
    if(!in_array($GPC['mov'], array('rec', 'des')))
        header('location: romana_movimiento.php');
    
    $cosecha = new Cosecha();
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch ($GPC['mov']){
        case 'des':
        $movimiento = new Despacho();
        $listadoEstatus = array('3' => 'Romana Lleno', '6' => 'Romana Vac&iacute;o');
        $estatus = (!empty($GPC['estatus'])) ? "'".$GPC['estatus']."'" : "'1', '3'";
        $listadoRomana = $movimiento->listadoDespacho('', $idCA, $GPC['cosecha'], null, null, $estatus);

        $total_registros = $movimiento->total_verdadero;
        $paginador = new paginator($total_registros, $porPagina);
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $('#Regresar').click(function(){
           window.location = "romana_movimiento.php";
        });
    });
</script>
    <div id="titulo_modulo">
        ROMANA - DESPACHO<br/><hr/>
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
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%">
                <tr>
                    <td width="60">Cosecha</td>
                    <td>
                        <? echo $html->select('cosecha',array('options'=>$listadoC, 'selected' => $GPC['cosecha'], 'default' => 'Seleccione'));?>
                    </td>
                </tr>
                <tr>
                    <td width="60">Estatus</td>
                    <td>
                        <?
                            echo $html->select('estatus',array('options'=>$listadoEstatus, 'selected' => $GPC['estatus'], 'default' => 'Seleccione'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <? echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();')); ?>
                    </td>
                </tr>
            </table>
            <? echo $html->input('mov', $GPC['mov'], array('type' => 'hidden')); ?>
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
            <? if($_SESSION['s_perfil_id'] != ROMANERO){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Cosecha</th>
            <th width="90">Nro Salida</th>
            <th>Orden</th>
            <th>Fecha Despacho</th>
            <th>Peso</th>
            <? if($_SESSION['s_perfil_id'] == ROMANERO){ ?>
            <th width="1">Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($listadoRomana as $dataRomana){
                $tipo = ($dataRomana['estatus_rec'] == '3') ? 'LLENO' : 'VAC&Iacute;O';
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] != ROMANERO){ ?>
            <td align="center"><?=$dataRomana['ca_codigo']." - ".$dataRomana['centro_acopio']?></td>
            <? } ?>
            <td align="center"><?=$dataRomana['cosecha_codigo']?></td>
            <td align="center"><?=$dataRomana['numero']?></td>
            <td align="center"><?=$dataRomana['numero_guia']?></td>
            <td align="center"><?=$general->date_sql_screen($dataRomana['fecha_des'], '', 'es', '-')?></td>
            <td align="center"><?=$tipo?></td>
            <? if($_SESSION['s_perfil_id'] == ROMANERO){ ?>
            <td align="center">
                <? echo $html->link('<img src="../images/peso1.png" width="16" height="16" title=Pesar>', 'romana.php?ac=pesar&id='.$dataRomana['id'].'&mov='.$GPC['mov']); ?>
            </td>
            <? } ?>
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
    break;
    
    default:
            $movimiento = new Recepcion();
            $listadoEstatus = array('3' => 'Romana Lleno', '6' => 'Romana Vac&iacute;o');
            $estatus = (!empty($GPC['estatus'])) ? "'".$GPC['estatus']."'" : "'3', '6'";
            $listadoRomana = $movimiento->listadoRecepcion('', $idCA, $GPC['cosecha'], null, null, $estatus);

            $total_registros = $movimiento->total_verdadero;
            $paginador = new paginator($total_registros, $porPagina);
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $('#Regresar').click(function(){
           window.location = "romana_movimiento.php";
        });
    });
</script>
    <div id="titulo_modulo">
        ROMANA - RECEPCI&Oacute;N<br/><hr/>
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
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%">
                <tr>
                    <td width="60">Cosecha</td>
                    <td>
                        <? echo $html->select('cosecha',array('options'=>$listadoC, 'selected' => $GPC['cosecha'], 'default' => 'Seleccione'));?>
                    </td>
                </tr>
                <tr>
                    <td width="60">Estatus</td>
                    <td>
                        <?
                            echo $html->select('estatus',array('options'=>$listadoEstatus, 'selected' => $GPC['estatus'], 'default' => 'Seleccione'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <? echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();')); ?>
                    </td>
                </tr>
            </table>
            <? echo $html->input('mov', $GPC['mov'], array('type' => 'hidden')); ?>
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
            <? if($_SESSION['s_perfil_id'] != ROMANERO){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Cosecha</th>
            <th width="90">Nro Recepci&oacute;n</th>
            <th>Guia</th>
            <th>Fecha Recepci&oacute;n</th>
            <th>Peso</th>
            <? if($_SESSION['s_perfil_id'] == ROMANERO){ ?>
            <th width="1">Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($listadoRomana as $dataRomana){
                $tipo = ($dataRomana['estatus_rec'] == '3') ? 'LLENO' : 'VAC&Iacute;O';
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] != ROMANERO){ ?>
            <td align="center"><?=$dataRomana['ca_codigo']." - ".$dataRomana['centro_acopio']?></td>
            <? } ?>
            <td align="center"><?=$dataRomana['cosecha_codigo']?></td>
            <td align="center"><?=$dataRomana['numero']?></td>
            <td align="center"><?=$dataRomana['numero_guia']?></td>
            <td align="center"><?=$general->date_sql_screen($dataRomana['fecha_recepcion'], '', 'es', '-')?></td>
            <td align="center"><?=$tipo?></td>
            <? if($_SESSION['s_perfil_id'] == ROMANERO){ ?>
            <td align="center">
                <? echo $html->link('<img src="../images/peso1.png" width="26" height="20" title=Pesar>', 'romana.php?ac=pesar&id='.$dataRomana['id'].'&mov='.$GPC['mov']); ?>
            </td>
            <? } ?>
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
    break;
    }
    
    require('../lib/common/footer.php');
?>
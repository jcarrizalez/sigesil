<?php
    require_once('../lib/core.lib.php');
    
    $recepcion = new Recepcion();
    $centro_acopio = new CentroAcopio();
    $cosecha = new Cosecha();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $idCo = $GPC['id_cosecha'];
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);

    $fdesde = (!empty($GPC['fecha_inicio'])) ? $general->fecha_normal_sql($GPC['fecha_inicio'], 'es') : date('Y-m-d');
    $fhasta = (!empty($GPC['fecha_fin'])) ? $general->fecha_normal_sql($GPC['fecha_fin'], 'es') : date('Y-m-d');
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoRecepciones = $recepcion->recepcionesReporteGeneral($fdesde, $fhasta, $idCA, $idCo, null, null, null, $porPagina, $inicio);
    
    $total_registros = $recepcion->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    show_div_loader();
    
    $(document).ready(function(){
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        REPORTE DE RECEPCIONES<br/><hr/>
    </div>
    <div id="mensajes">
        <?php
            switch($GPC['msg']){
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="#">
            <table width="100%" border="0">
                <tr>
                    <td width="1">Desde </td>
                    <td width="200">
                        <?php echo $html->input('fecha_inicio', $general->date_sql_screen($fdesde, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
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
                        <?php echo $html->input('fecha_fin', $general->date_sql_screen($fhasta, '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
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
                <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?php
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos'));
                        ?>
                    </td>
                </tr>
                <?php } ?>
                <tr>
                    <td>Cosecha </td>
                    <td><?php echo $html->select('id_cosecha',array('options'=>$listadoC, 'selected' => $GPC['id_cosecha'], 'default' => 'Todas'))?></td>
                </tr>
                <tr id="botones">
                    <td colspan="4" style="padding-top: 20px;">
                        <?php
                            echo $html->input('ac', 'Buscar', array('type' => 'submit'));
                            /*echo $html->input('ac', 'Excel', array('type' => 'submit'));
                            echo $html->input('ac', 'Pdf', array('type' => 'submit'));*/
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <?php } ?>
            <th>Cosecha</th>
            <th>Cultivo</th>
            <th>Cedula/Rif Productor</th>
            <th>Productor</th>
            <th>Accion</th>
        </tr>
        <?php
            $i=0;
            $idCA = (!empty($idCA)) ? "_$idCA" : '';
            foreach($listadoRecepciones as $dataRecepcion){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?php echo "(".$dataRecepcion['codigo'].") ".$dataRecepcion['nombre_ca']?></td>
            <?php } ?>
            <td><?php echo $dataRecepcion['cosecha']?></td>
            <td align="center"><?php echo $dataRecepcion['codigo_cultivo']?></td>
            <td align="center"><?php echo $dataRecepcion['ced_rif']?></td>
            <td><?php echo $dataRecepcion['productor']?></td>
            
            <td align="center">
                <?php
                    $urls = array(3 => '../reportes/pdf_listado_recepciones_individual.php?id='.$dataRecepcion['id'].'_'.$dataRecepcion['id_co'].'_'.$fdesde.'_'.$fhasta.$idCA);
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="6">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?php
    require('../lib/common/footer.php');
?>
<?php
    require_once('../lib/core.lib.php');

    $objlogs = new cls_logs();

    $fdesde = ($GPC['fecha_inicio']) ? $GPC['fecha_inicio'] : date("d-m-Y", time() - 86400);
    $fhasta = ($GPC['fecha_fin']) ? $GPC['fecha_fin'] : date("d-m-Y");
    $centroa = $GPC['centro_acopio'];
    $usuario = $GPC['usuario'];
    $evento = $GPC['evento'];
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;

    $objlogs->list_consultas($fdesde, $fhasta, $centroa, $usuario, $evento, '', $porPagina, $inicio);
    $total_registros = $objlogs->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);

    require('../lib/common/header.php');
    require('../lib/common/init_calendar.php');
?>
<script language="javascript">
    show_div_loader();
    
    var win = null;
    function openWindow(mypage,myname,w,h,scroll){
        LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
        TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
        settings ='height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+', scrollbars=yes ';
        win = window.open(mypage,myname,settings)
    }

    function fncatras(){
        document.location = "../pages/landing_page.php";	
    }
</script>
<div id="titulo_modulo">
    REPORTE DE ACTIVIDAD<br/><hr/>
</div>
<div id="filtro">
    <form name="form1" id="form1" method="GET" action="#" enctype="multipart/form-data">
        <table width="100%" border="0">
            <tr>
                <td width="1">Desde </td>
                <td width="200">
                    <? echo $html->input('fecha_inicio', $fdesde, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                    <img src="../images/calendario.png" id="fdesde" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "fdesde",
                            inputField : "fecha_inicio",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fdesde));?>),
                            onSelect   : function() { this.hide() }
                        });
                    </script>
                </td>
                <td width="120"><?php echo "Centros de Acopio"//$lang['txtDealer']  ?></td>
                <td>
                    <select name="centro_acopio" id="centro_acopio" class="select2">
                        <option value=""><?php echo "Todos"//$lang['txt_all']  ?></option>
                        <?php
                            $general->get_filers_colum('centro_acopio', 'centro_acopio', 'si_log_consultas');
                            for ($i = 0, $cant = count($general->filter); $i < $cant; $i++) {
                        ?>
                        <option value="<?php echo $general->filter[$i]['valor'] ?>" <?php if ($centroa == $general->filter[$i]['valor']) { echo 'selected'; } ?> ><?php echo $general->filter[$i]['texto'] ?></option>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <tr>                    
                <td>Hasta </td>
                <td>
                    <? echo $html->input('fecha_fin', $fhasta, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?>
                    <img src="../images/calendario.png" id="fhasta" width="16" height="16" style="cursor:pointer" />
                    <script>
                        Calendar.setup({
                            trigger    : "fhasta",
                            inputField : "fecha_fin",
                            dateFormat: "%d-%m-%Y",
                            selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($fhasta));?>),
                            onSelect   : function() { this.hide() }
                        });
                    </script>
                </td>
                <td><?php echo "Usuario"//$lang['txtUser'] ?></td>
                <td>
                    <select name="usuario" id="usuario" class="select2">
                        <option value=""><?php echo "Todos"//$lang['txt_all'] ?></option>
                        <?php
                            $general->get_filers_colum('usuario_info', 'usuario_info', 'si_log_consultas');
                            for ($i = 0, $cant = count($general->filter); $i < $cant; $i++) {
                        ?>
                            <option value="<?php echo $general->filter[$i]['valor'] ?>" <?php if ($usuario == $general->filter[$i]['valor']) { echo 'selected'; } ?> ><?php echo $general->filter[$i]['texto'] ?></option>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td><?php echo "Eventos"//$lang['txtEvents'] ?></td>
                <td>
                    <select name="evento" id="evento" class="select2">
                        <option value=""><?php echo "Todos"//$lang['txt_all'] ?></option>
                        <?php
                        $general->get_filers_colum('log_codigo_nombre_es', 'log_codigo_nombre_es', 'si_log_codigos');
                            for ($i = 0, $cant = count($general->filter); $i < $cant; $i++) {
                                $etiqueta_texto = $general->filter[$i]['texto'];
                        ?>
                            <option value="<?php echo $general->filter[$i]['valor'] ?>" <?php if ($evento == $general->filter[$i]['valor']) { echo 'selected'; } ?> ><?php echo $etiqueta_texto ?></option>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <tr id="botones">
                <td colspan="4" style="padding-top: 20px;">
                    <?
                        echo $html->input('ac', 'Buscar', array('type' => 'submit'));
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
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <table align="center" width="100%">
                <tr align="center" class="titulos_tabla">
                    <th><?php echo "Usuario" ?></th>
                    <!--th><?php echo "Correo" ?></th-->
                    <th><?php echo "Centro Acopio" ?></th>
                    <th>IP</th>
                    <th><?php echo "Fecha" ?></th>
                    <th><?php echo "Evento" ?></th>
                    <th>ST</th>
                    <th><?php echo "Tablas" ?></th>
                    <th><?php echo "Vista" ?></tdh>
                </tr>
                <?php
                    for ($i = 0, $cant = count($objlogs->lista); $i < $cant; $i++) {
                        $classname = $general->obtenerClaseFila($i);
                ?>
                    <tr class="<?= $classname ?>" onMouseOver="this.className='highlight2'" onMouseOut="this.className='<?= $classname ?>'">
                        <td><?php echo $objlogs->lista[$i]['usuario_info'] ?></td>
                        <!--td><?php echo $objlogs->lista[$i]['usuario_email'] ?></td-->
                        <td align="center" ><?php echo $objlogs->lista[$i]['centro_acopio'] ?></td>
                        <td><?php echo $objlogs->lista[$i]['direccion_ip'] ?></td>
                        <td><?php echo $general->date_sql_screen($objlogs->lista[$i]['en_fecha'], '', 'es', '-') ?></td>
                        <td><?php echo $objlogs->lista[$i]['log_codigo_nombre_es'] ?></td>
                        <td><?php echo $objlogs->lista[$i]['log_codigo_tipo'] ?></td>
                        <td><?php echo $objlogs->lista[$i]['en_tablas'] ?></td>
                        <td align="center" ><img src="../images/buscar.png" width="16" height="16" title="Detalle" border="0" style="cursor:pointer" onclick="openWindow('ver_log.php?id_log=<?php echo $objlogs->lista[$i]['log_id'] ?>','','700','600','visible');return false;"></td>
                    </tr>
            <?php } ?>
            </table>
        </td>
    </tr>  
</table>
<div id="paginador">
    <?
        $paginador->print_page_counter('Pag', 'de');
        echo "&nbsp;&nbsp;";
        $paginador->print_paginator('pulldown');
    ?>
</div>

<?php require('../lib/common/footer.php'); ?>

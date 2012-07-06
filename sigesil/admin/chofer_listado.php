<?
    require_once('../lib/core.lib.php');
    
    $chofer = new Chofer();
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $cedRif = $GPC['nacionalidad'].$GPC['cedula'];
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';
    $listadoChoferes = $chofer->buscarChofer($cedRif, $nombre, $porPagina, $inicio);
    
    $total_registros = $chofer->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $chofer->desactivarCh($id, $GPC['estatus']);
        header('location: chofer_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Chofer?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#Nuevo').click(function(){
           window.location = 'chofer.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        CHOFERES<br/><hr/>
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
                    <td width="60">C&eacute;dula</td>
                    <td>
                        <?
                            echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => $GPC['nacionalidad']));
                            echo $html->input('cedula', $GPC['cedula'], array('type' => 'text', 'class' => 'positive estilo_campos'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td>
                        <? echo $html->input('nombre', $GPC['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <?
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            $general->crearAcciones($acciones, '', 1);
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button'));
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
            <th>C&eacute;dula/Rif</th>
            <th>Nombre</th>
            <th>Pais</th>
            <th>Estado</th>
            <th>Municipio</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoChoferes as $dataChofer){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataChofer['ced_rif']?></td>
            <td align="center"><?=$dataChofer['nombre']?></td>
            <td align="center"><?=$dataChofer['pais']?></td>
            <td align="center"><?=$dataChofer['estado']?></td>
            <td align="center"><?=$dataChofer['municipio']?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'chofer.php?ac=editar&id='.$dataChofer['id'], 'chofer_listado.php?ac=eliminar&id='.$dataChofer['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
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
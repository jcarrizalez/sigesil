<?php
    require_once('../lib/core.lib.php');
    
    $productor = new Productor();
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    $listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $cedRif = (!empty($GPC['cedula'])) ? $GPC['nacionalidad'].$GPC['cedula'] : '';
    $nombre = (!empty($GPC['nombre'])) ? $GPC['nombre'] : '';
    
    $listadoProductores = $productor->listadoProductores('', '', $cedRif, $nombre, '', '', $porPagina, $inicio);
    
    $total_registros = $productor->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $productor->desactivarPro($id, $GPC['estatus']);
        header('location: productor_listado.php');
        die();
    }

    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Productor?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#Nuevo').click(function(){
           window.location = 'productor.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        PRODUCTORES<br/><hr/>
    </div>
    <div id="mensajes">
        <?php
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
                        <?php
                            echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => $GPC['nacionalidad']));
                            echo $html->input('cedula', $GPC['cedula'], array('type' => 'text', 'class' => 'positive estilo_campos'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td>
                        <?php echo $html->input('nombre', $GPC['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <?php
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
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>C&eacute;dula / Rif</th>
            <th>Nombre</th>
            <th>Pa&iacute;s</th>           
            <th>Estado</th>           
            <th>Municipio</th>           
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoProductores as $dataProductor){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <td align="center"><?php echo $dataProductor['ced_rif']?></td>
            <td><?php echo $dataProductor['nombre']?></td>
            <td><?php echo $dataProductor['pais']?></td>            
            <td><?php echo $dataProductor['estado']?></td>            
            <td><?php echo $dataProductor['municipio']?></td>
            <td align="center">
                <?php
                    $urls = array(1 => 'productor.php?ac=editar&id='.$dataProductor['id'], 'productor_listado.php?ac=eliminar&id='.$dataProductor['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?php
                $i++; 
            }
        ?>
        <tr>            
            <td colspan="3">&nbsp;</td>
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
<?
    require_once('../lib/core.lib.php');
    
    $productor = new Productor();
    
    $id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : $_SESSION['s_ca_id'];
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoProductores = $productor->listadoProductores('', '', $porPagina, $inicio);
    
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
        $('#Nuevo').click(function(){
           window.location = 'productor.php';
        });
    });
</script>
    <div id="titulo_modulo">
        PRODUCTORES<br/><hr/>
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
    <div id="botones">
        <?
            $general->crearAcciones($acciones, '', 1);
            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
        ?>
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
            <th>C&eacute;dula / Rif</th>
            <th>Nombre</th>
            <th>Pa&iacute;s</th>           
            <th>Estado</th>           
            <th>Municipio</th>           
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoProductores as $dataProductor){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataProductor['ced_rif']?></td>
            <td><?=$dataProductor['nombre']?></td>
            <td><?=$dataProductor['pais']?></td>            
            <td><?=$dataProductor['estado']?></td>            
            <td><?=$dataProductor['municipio']?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'productor.php?ac=editar&id='.$dataProductor['id'], 'productor_listado.php?ac=eliminar&id='.$dataProductor['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                ?>
            </td>
        </tr>
        <?
                $i++; 
            }
        ?>
        <tr>            
            <td colspan="3">&nbsp;</td>
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
<?
    require_once('../lib/core.lib.php');
    
    $cultivo = new Cultivo();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : '2';
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoCultivos = $cultivo->find(null, " LIMIT $porPagina OFFSET $inicio", '*', '', 'id');
    
    $total_registros = $cultivo->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $cultivo->desactivarCu($id, $GPC['estatus']);
        header('location: cultivo_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Cultivo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'cultivo.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        CULTIVOS<br/><hr/>
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
                <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'class' => 'estilo_campos'));
                        ?>
                    </td>
                </tr>
                <? } ?>
                <tr id="botones">
                    <td colspan="3">
                        <?
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            $general->crearAcciones($acciones, '', 1);
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
            <th>C&oacute;digo</th>
            <th>Nombre</th>
            <th>Ciclo</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?
            $i=0;
            foreach($listadoCultivos as $dataCultivo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <td align="center"><?=$dataCultivo['codigo']?></td>
            <td><?=$dataCultivo['nombre']?></td>
            <td align="center"><?=$dataCultivo['ciclo']?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'cultivo.php?ac=editar&id='.$dataCultivo['id'], 'cultivo_listado.php?ac=eliminar&id='.$dataCultivo['id']."&estatus=f");
                    $general->crearAcciones($acciones, $urls);
                    //if(in_array($_SESSION['s_perfil_id'], array(CALIDADG, CALIDADS))){
                        echo $html->link('<img src="../images/analisis.png" width="16" height="16" title=Analisis>', 'analisis_cultivo.php?id='.$dataCultivo['id'].'&ca='.$idCA);
                    //}
                ?>
            </td>
        </tr>
        <? $i++; } ?>
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
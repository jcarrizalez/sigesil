<?
    require_once('../lib/core.lib.php');
    
    $silos = new Silos();
    $centro_acopio = new CentroAcopio();
    
    $id = (!empty($GPC['id'])) ? $GPC['id'] : null;
    $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listadoSilos = $silos->listadoSilos($id, $idCA, $porPagina, $inicio);
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $total_registros = $silos->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $silos->eliminarSilo(1,$id);
        header('location: silos_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Silo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'silos.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        LISTADO DE SILOS<br/><hr/>
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
        <form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">
            <table width="100%">
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Seleccione'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="3">
                        <?
                            if($_SESSION['s_perfil_id'] == GERENTES){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }
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
            $paginador->print_paginator();
        ?>
    </div>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <? } ?>
            <th>Nombre</th>
            <th>Coordenadas</th>
            <th>N&uacute;mero</th>
            <th>Capacidad (Kg)</th>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <th>Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($listadoSilos as $dataSilo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$dataSilo['nombre_ca']?></td>
            <? } ?>
            <td><?=$dataSilo['nombre']?></td>
            <td><?=$dataSilo['coordenada']?></td>
            <td align="center"><?=$dataSilo['numero']?></td>
            <td align="center"><?=$dataSilo['capacidad']?></td>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'silos.php?ac=editar&id='.$dataSilo['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'silos_listado.php?ac=eliminar&id='.$dataSilo['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
            <? } ?>
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
            $paginador->print_paginator();
        ?>
    </div>
<?
    require('../lib/common/footer.php');
?>
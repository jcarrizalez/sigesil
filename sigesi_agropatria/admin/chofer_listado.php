<?
    require_once('../lib/core.lib.php');
    
    $chofer = new Chofer();
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    $cedRif = (!empty($GPC['cedula'])) ? $GPC['nacionalidad'].$GPC['cedula'] : '';
    $listadoChoferes = $chofer->buscarChofer($cedRif, $GPC['nombre'], $porPagina, $inicio);
    
    $total_registros = $silos->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){
        /*$('#Nuevo').click(function(){
           window.location = 'chofer.php';
        });*/
        
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
                            echo $html->input('cedula', $GPC['cedula'], array('type' => 'text'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Nombre</td>
                    <td>
                        <?
                            echo $html->input('nombre', $GPC['nombre'], array('type' => 'text', 'style' => 'width: 172px'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <?
                            /*if($_SESSION['s_perfil_id'] == GERENTES){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }*/
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
                <? echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'chofer.php?ac=editar&id='.$dataChofer['id']); ?>
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
            $paginador->print_paginator();
        ?>
    </div>
<?
    require('../lib/common/footer.php');
?>
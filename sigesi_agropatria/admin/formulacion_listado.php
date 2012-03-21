<?
    require_once('../lib/core.lib.php');
    
    $formulas = new Formulas();
    $centro_acopio = new CentroAcopio();
    
    if($_SESSION['s_perfil_id'] == GERENTES)
        $id_CA = $_SESSION['s_ca_id'];
    else
        $id_CA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
        
    $codigo = (!empty($GPC['codigo'])) ? $GPC['codigo'] : null;
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    $formulas->listaFormulas($id_CA, $codigo, '');
    
    $total_registros = $formulas->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'formulacion.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        F&Oacute;RMULAS<br/><hr/>
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
                            echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Seleccione'));
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                        ?>
                    </td>
                </tr>
                <? } ?>
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
            <th>Centro Acopio</th>
            <? } ?>
            <th>Cultivo</th>
            <th width="1">C&oacute;digo</th>
            <th>Formula</th>
            <th>Condici&oacute;n</th>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <th width="1">Acci&oacute;n</th>
            <? } ?>
        </tr>
        <?
            $i=0;
            foreach($formulas->listaF as $dataFormula){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            <? if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?=$dataFormula['nombre_ca']?></td>
            <? } ?>
            <td align="center"><?=$dataFormula['codigo_cultivo']?></td>
            <td align="center"><?=$dataFormula['codigo']?></td>
            <td><?=$dataFormula['formula']?></td>
            <td align="center"><?=$dataFormula['condicion']?></td>
            <? if($_SESSION['s_perfil_id'] == GERENTES){ ?>
            <td align="center">
                <?
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'formulacion.php?ac=editar&id='.$dataFormula['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'formulacion_listado.php?ac=eliminar&id='.$dataFormula['id'], array('onclick' => 'return eliminar();'));
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
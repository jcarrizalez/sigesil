<?php
    require_once('../lib/core.lib.php');
    
    $contrato = new Contrato();
    $cosecha = new Cosecha();
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCa = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCa = $_SESSION['s_ca_id'];
    
    $listadoCosecha = $cosecha->buscarCosechaP(null, null, 't', null, $idCA);
    foreach($listadoCosecha as $valor){
        $listadoC[$valor['id']] = "(".$valor['ca_codigo'].") ".$valor['codigo'];
    }
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    $idCo = (!empty($GPC['id_cosecha'])) ? $GPC['id_cosecha'] : '';
    $nroCon = (!empty($GPC['contrato'])) ? $GPC['contrato'] : '';
    $listadoContratos = $contrato->buscarContrato(null, $idCa, $idCo, $nroCon, '', $porPagina, $inicio);
    
    $total_registros = $contrato->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#Nuevo').click(function(){
           window.location = 'contrato.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        CONTRATOS<br/><hr/>
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
                    <td>Cosecha</td>
                    <td><?php echo $html->select('id_cosecha',array('options'=>$listadoC, 'selected' => $idCo, 'default' => 'Todas', 'class' => 'inputLogin'))?></td>
                </tr>
                <tr>
                    <td>Nro Contrato</td>
                    <td>
                        <?php echo $html->input('contrato', $GPC['contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?>
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
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Centro de Acopio</th>
            <?php } ?>
            <th>Nro Contrato</th>
            <th>Cosecha</th>
            <th>C&eacute;dula/Rif Productor</th>
            <th>Productor</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoContratos as $dataContrato){
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?php echo $dataContrato['nombre_ca']?></td>
            <?php } ?>
            <td align="center"><?php echo $dataContrato['nro_contrato']?></td>
            <td align="center"><?php echo $dataContrato['nombre_co']?></td>
            <td align="center"><?php echo $dataContrato['ced_rif']?></td>
            <td align="center"><?php echo $dataContrato['nombre']?></td>
            <td align="center">
                <?php
                    $urls = array(1 => 'contrato.php?ac=editar&id='.$dataContrato['id']);
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
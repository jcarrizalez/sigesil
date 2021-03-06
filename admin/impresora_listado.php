<?php
    require_once('../lib/core.lib.php');
    
    $impresora = new Impresora();
    $centro_acopio = new CentroAcopio();
    
    $listaCA = $centro_acopio->find('', '', array('id', 'nombre'), 'list', 'id');
    unset($listaCA[1]);
    
    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    
    if($_SESSION['s_perfil_id'] == GERENTEG)
        $idCA = (!empty($GPC['id_ca'])) ? $GPC['id_ca'] : null;
    else
        $idCA = $_SESSION['s_ca_id'];
    
    $listadoImpresora = $impresora->buscarImpresora('', $idCA, '', '', $porPagina, $inicio);
    
    $total_registros = $impresora->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);
    
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'impresora.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        IMPRESORAS<br/><hr/>
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
            <table width="100%" border="0">
                <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
                <tr>
                    <td width="110">Centro de Acopio:</td>
                    <td colspan="2">
                        <?php echo $html->select('id_ca',array('options'=>$listaCA, 'selected' => $GPC['id_ca'], 'default' => 'Todos')); ?>
                    </td>
                </tr>
                <?php } ?>
                <tr id="botones">
                    <td colspan="3">
                        <?php
                            echo $html->input('Buscar', 'Buscar', array('type' => 'submit'));
                            echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
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
            <th>Nombre</th>
            <th>Parametros</th>
            <th>Acci&oacute;n</th>
        </tr>
        <?php
            $i=0;
            foreach($listadoImpresora as $dataImpresora){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td><?php echo $dataImpresora['centro_acopio']?></td>
            <?php } ?>
            <td><?php echo $dataImpresora['nombre']?></td>
            <td><?php echo $dataImpresora['parametros']?></td>
            <td align="center">
                <?php echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'impresora.php?ac=editar&id='.$dataImpresora['id']); ?>
            </td>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="4">&nbsp;</td>
        </tr>
    </table>
    <div id="paginador">
        <?php
            $paginador->print_page_counter('Pag', 'de');
            echo "&nbsp;&nbsp;";
            $paginador->print_paginator('pulldown');
        ?>
    </div>
<?php require('../lib/common/footer.php'); ?>
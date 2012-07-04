<?php
    require_once('../lib/core.lib.php');

    $recepcion = new Recepcion();
    $cosecha = new Cosecha();
    $Ctna = new Cuarentena();

    $porPagina = MAX_RESULTS_PAG;
    $inicio = ($GPC['pg']) ? (($GPC['pg'] * $porPagina) - $porPagina) : 0;
    $estatus="'2','5'";    
    $idCosecha='';
    $numEntrada='';
    $_SESSION['mov']='rec';
    $idCa=(!empty($_SESSION['s_ca_id'])) ? $_SESSION['s_ca_id'] : '';
    
    if ($GPC['ac']=='Buscar') {
        $idCosecha=(!empty($GPC['idCosecha'])) ? $GPC['idCosecha'] : '';
        $numEntrada=(!empty($GPC['numEntrada'])) ? $GPC['numEntrada'] : '';
    }
    
    $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
    
    //unset($listaCo[1]);
    
    $listadoRecepcion = $recepcion->listadoRecepcion('', $idCa, $idCosecha,'', $numEntrada, $estatus, '', '', $porPagina, $inicio);
    $paramCtna='';
    if ($idCa)
        $paramCtna=array('id_centro_acopio'=>$idCa);
    
    $listadoCtna=$Ctna->find(array('id_centro_acopio'=>$idCa),'', array('id_recepcion', 'fecha_lib'), '', 'id_recepcion');

    $total_registros = $recepcion->total_verdadero;
    $paginador = new paginator($total_registros, $porPagina);

    require('../lib/common/header.php');
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
<div id="titulo_modulo">    
    CUARENTENAS PENDIENTES<hr/>    
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
        <? echo $html->input('ac', 'Buscar', array('type' => 'hidden'));?>
        <table width="100%" border="0">            
            <tr>
                <td width="110">Cultivo</td>                
                <td colspan="2">
                    <?
                        echo $html->select('idCosecha',array('options'=>$listaCo, 'selected' => $GPC['idCosecha'], 'default' => 'Seleccione'));
                    ?>
                </td>
            </tr>
            <tr>
                <td width="110">Numero</td>
                <td>
                <?= $html->input('numEntrada', $numEntrada, array('type' => 'text', 'class' => 'crproductor', 'readOnly' => $soloLectura, 'class' => 'cuadricula positive')); 
                ?></td>
            </tr>
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
    <table align="center" width="100%" border="0">
        <tr align="center" class="titulos_tabla"> 
        <?
            if ($_SESSION['s_perfil_id']==GERENTEG) {
        ?>
            <th>Centro de Acopio</th>
        <?
            }
            if ($_SESSION['s_mov']=='rec') {
        ?>        
            <th width="85px">Nro Entrada</th>
        <?
            }
            else {
        ?>        
            <th width="85px">Nro Salida</th>
        <?
            }
        ?>
            <th>Cultivo</th>
            <th>Vehiculo</th>
            <th>Fecha</th>
            <th>F. Liberacion</th>
            <th>Estatus</th>
            <th>Acci&oacute;n</th>
        </tr> 
        <?
            $i=0;
            foreach($listadoRecepcion as $dataRecepcion){
                foreach($listadoCtna as $dataCtna) {
                    if ($dataCtna['id_recepcion']==$dataRecepcion['id_recepcion']) {
                        $dataRecepcion['fecha_lib']=$dataCtna['fecha_lib'];
                        break;
                    }                        
                }
                
                if (empty($dataRecepcion['fecha_lib']))
                    $dataRecepcion['fecha_lib']=null;
                
            $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?=$clase?>">
            
        <?
            if ($_SESSION['s_perfil_id']==GERENTEG) {

                echo '<td>'.$dataRecepcion['ca_codigo'].' - '.$dataRecepcion['centro_acopio'].'</td>';
            }
        ?>
            <td align="center">
        <?
            if ($_SESSION['mov']=='rec') {
                $numero = ($dataRecepcion['numero'] < 10) ? '0'.$dataRecepcion['numero'] : $dataRecepcion['numero'];
                $numEntrada = "R".$numero.$general->date_sql_screen($dataRecepcion['fecha_recepcion'], '', 'es', null);
                echo $numEntrada;
            }
            
            if ($_SESSION['mov']=='des') {
                $numero = ($dataRecepcion['numero'] < 10) ? '0'.$dataRecepcion['numero'] : $dataRecepcion['numero'];
                $numSalida = "D".$numero.$general->date_sql_screen($dataRecepcion['fecha_des'], '', 'es', null);
                echo $numSalida;
            }
        ?>
            </td>
            <td align="left"><?=$dataRecepcion['cultivo_codigo'].' - '.$dataRecepcion['cultivo_nombre']?></td>
            <td align="center"><?=$dataRecepcion['placa'].' - '.$dataRecepcion['chofer_nombre']; ?></td>
            <td align="center"><?=$general->date_sql_screen($dataRecepcion['creado'], '', $lang="es", $sep="-")?></td>
            <td align="center"><?=$general->date_sql_screen($dataRecepcion['fecha_lib'], '', $lang="es", $sep="-")?></td>
            <td align="center"><?
            //=$dataRecepcion['estatus_rec']
            echo '<img src="../images/cuarentena.png" width="16" height="16" title=Cuarentena>';            
            ?></td>
            <td align="center">
                <?
                    $urls = array(1 => 'cuarentena_pendiente.php?ac=editar&id='.$dataRecepcion['id']);
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
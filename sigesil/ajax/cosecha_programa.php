<?php
    require_once('../lib/core.lib.php');
    $cosecha = new Cosecha();
    $listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
    
    switch ($GPC['ac']){
        case 'programa':
            if(!empty($GPC['id'])){
                $listadoC = $cosecha->buscarCosechaP('', $GPC['id']);
                foreach($listadoC as $valor){
                    $listaC[$valor['id']] = $valor['codigo'];
                }
                
                echo $html->select('Recepcion.id_cosecha',array('options'=>$listaC, 'default' => 'Seleccione'));
            }else{
                echo $html->select('Recepcion.id_cosecha',array('default' => 'Seleccione'));
            }
        break;
        case 'cantidad':
            $recepcion = new Recepcion();
            $cantRecepcion = $recepcion->recepcionesDia($_SESSION['s_ca_id']);
            $numeroRecepcion = ++$cantRecepcion[0]['total'];
            $numeroRecepcion = ($numeroRecepcion < 10) ? '0'.$numeroRecepcion : $numeroRecepcion;
            echo "Entrada Nro R$numeroRecepcion-".date('dmY');
            //echo $html->input('Recepcion.numero', $numeroRecepcion, array('type' => 'hidden', 'class' => 'estilo_campos'));
        break;
        case 'cantidad2':
            $despacho = new Despacho();
            $cantSalida = $despacho->despachosDia($_SESSION['s_ca_id']);
            $numeroSalida = ++$cantSalida[0]['total'];
            $numeroSalida = ($numeroSalida < 10) ? '0'.$numeroSalida : $numeroSalida;
            echo "Salida Nro D$numeroSalida-".date('dmY');
            //echo $html->input('Despacho.numero', $numeroSalida, array('type' => 'hidden', 'class' => 'estilo_campos'));
        break;
        case 'cos_pro':
            $productor = new Productor();
            $infoProductores = $productor->find(array('ced_rif' => $GPC['cpro']));
            if(!empty($infoProductores)){
                echo "&nbsp;".$html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoProductores[0]['ced_rif']), 0, 1)));
                echo "&nbsp;".$html->input('id_productor', substr(trim($infoProductores[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'estilo_campos2 positive'));
                echo "<br/>&nbsp;".$html->input('nombre_pro', $infoProductores[0]['nombre'], array('type' => 'text', 'readOnly' => true, 'style' => 'width:320px'));
                echo "&nbsp;".$html->input('productor', $infoProductores[0]['id'], array('type' => 'hidden'));
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $('#contrato').load('../ajax/cosecha_programa.php?ac=contrato&co=<? echo $GPC['co']; ?>&cpro=<? echo $infoProductores[0]['id']; ?>');
                        $('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co=<? echo $GPC['co']; ?>&cpro=<? echo $GPC['cpro']; ?>');
                    });
                </script>
                <?
            }else{
                echo "&nbsp;".$html->select('nacionalidad',array('options'=>$listaNacion));
                echo "&nbsp;".$html->input('id_productor', '', array('type' => 'text', 'length' => '10', 'class' => 'estilo_campos2 positive'));
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        alert('Cedula/Rif No Encontrado');
                        $('#asociados').html('');
                    });
                </script>
                <?
            }
            /*foreach($infoProductores as $valor){
                if(!in_array($valor['id_productor'], $productores))
                    $productores[$valor['id_productor']] = $valor['ced_productor']. " - " .$valor['productor'];
            }*/
            //echo $html->select('id_productor', array('options' => $productores, 'default' => 'Seleccione', 'class' => 'estilo_campos2'));
        break;
        case 'cos_aon':
            $productor = new Productor();
            $infoProductores = $productor->find(array('ced_rif' => $GPC['caon']));
            if(!empty($infoProductores)){
                echo "&nbsp;".$html->select('nacionalidad2',array('options'=>$listaNacion, 'selected' => substr(trim($infoProductores[0]['ced_rif']), 0, 1)));
                echo "&nbsp;".$html->input('id_asociacion', substr(trim($infoProductores[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'estilo_campos2 positive'));
                echo "<br/>&nbsp;".$html->input('nombre_aon', $infoProductores[0]['nombre'], array('type' => 'text', 'readOnly' => true, 'style' => 'width:320px'));
                echo "&nbsp;".$html->input('asociacion', $infoProductores[0]['id'], array('type' => 'hidden'));
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        $('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co=<? echo $GPC['co']; ?>&cpro=<? echo $GPC['cpro']; ?>&caon=<? echo $GPC['caon']; ?>');
                        //$('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co=<? echo $GPC['co']; ?>&cpro=<? echo $GPC['cpro']; ?>');
                    });
                </script>
                <?
            }else{
                echo "&nbsp;".$html->select('nacionalidad2',array('options'=>$listaNacion));
                echo "&nbsp;".$html->input('id_asociacion', '', array('type' => 'text', 'length' => '10', 'class' => 'estilo_campos2 positive'));
                ?>
                <script type="text/javascript">
                    $(document).ready(function(){
                        alert('Cedula/Rif No Encontrado');
                    });
                </script>
                <?
            }
            /*foreach($infoProductores as $valor){
                if(!empty($valor['id_asociacion'])){
                    if(!in_array($valor['id_asociacion'], $productores))
                        $productores[$valor['id_asociacion']] = $valor['ced_asociacion']. " - " .$valor['asociacion'];
                }else{
                    if(!in_array($valor['id_productor'], $productores) && $GPC['cpro'] != $valor['id_productor'])
                        $productores[$valor['id_productor']] = $valor['ced_productor']. " - " .$valor['productor'];
                }
            }*/
            //echo $html->select('id_asociacion', array('options' => $productores, 'default' => 'Seleccione', 'class' => 'estilo_campos2'));
        break;
        case 'cos_ado':
            $infoProductores = $cosecha->asignarCosechaProductor($GPC['co'], $GPC['cpro'], $GPC['caon']);
            echo "<tr align='center' class='titulos_tabla'><th>&nbsp;</th><th>C&eacute;dula/Rif Asociaci&oacute;n</th><th>Nombre Asociaci&oacute;n</th><th>C&eacute;dula/Rif</th><th>Nombre</th></tr>";
            $i=0;
            foreach($infoProductores as $valor){
                $clase = $general->obtenerClaseFila($i);
                if(!empty($valor['id_asociado'])){
                    if($valor['id_cosecha'] == $GPC['co'] || empty($valor['id_cosecha'])){
                        echo "<tr class='$clase'><td align='center' width='30'>".$html->input('id_asociado[]', $valor['id_asociado'], array('type' => 'checkbox', 'checked' => 'checked'))."</td>";
                        echo "<td align='center' width='100'>".$valor['ced_asociacion']."</td>";
                        echo "<td>".$valor['asociacion']."</td>";
                        echo "<td align='center' width='100'>".$valor['ced_asociado']."</td>";
                        echo "<td>".$valor['asociado']."</td></tr>";
                        $i++;
                    }
                }elseif($valor['ced_productor'] != $GPC['caon'] && $GPC['cpro'] != $valor['ced_productor']){
                    echo "<tr class='$clase'><td align='center' width='30'>".$html->input('id_asociado[]', $valor['id_productor'], array('type' => 'checkbox'))."</td>";
                    echo "<td align='center' width='100'>-</td>";
                    echo "<td align='center'>-</td>";
                    echo "<td align='center' width='100'>".$valor['ced_productor']."</td>";
                    echo "<td>".$valor['productor']."</td></tr>";
                    $i++;
                }
            }
        break;
        case 'contrato':
            $contrato = new Contrato();
            $infoContrato = $contrato->find(array('id_centro_acopio' => $_SESSION['s_ca_id'], 'id_cosecha' => $GPC['co'], 'id_productor' => $GPC['cpro']));
            ?>
                <tr>
                    <td>C&oacute;digo de Contrato </td>
                    <td>
                        <?
                            echo $html->input('Contrato.nro_contrato', $infoContrato[0]['nro_contrato'], array('type' => 'text', 'class' => 'estilo_campos2'));
                            echo $html->input('Contrato.id', $infoContrato[0]['id'], array('type' => 'hidden'));
                        ?>
                    </td>
                </tr>
                <tr>
                    <td>Descripci&oacute;n </td>
                    <td><? echo $html->input('Contrato.descripcion', $infoContrato[0]['descripcion'], array('type' => 'text', 'class' => 'estilo_campos2')); ?></td>
                </tr>
                <tr>
                    <td>Toneladas Contratadas </td>
                    <td><? echo "&nbsp;".$html->input('Contrato.toneladas_con', $infoContrato[0]['toneladas_con'], array('type' => 'text', 'class' => 'estilo_campos2 positive')); ?></td>
                </tr>
            <?
        break;
    }
?>
<script type="text/javascript">
    hide_div_loader();
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
    });
</script>
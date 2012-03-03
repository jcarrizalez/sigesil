<?php
    require_once('../lib/core.lib.php');
    $cosecha = new Cosecha();
    
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
            if(!empty($GPC['idCo'])){
                $recepcion = new Recepcion();
                $cantRecepcion = $recepcion->recepcionesDia($_SESSION['s_ca_id'], $GPC['idCo']);
                $numeroRecepcion = ++$cantRecepcion[0]['total'];
                echo "Entrada Nro: ".$numeroRecepcion;
                echo $html->input('Recepcion.numero', $numeroRecepcion, array('type' => 'hidden', 'class' => 'estilo_campos'));
            }
        break;
        case 'formu':
            if(!empty($GPC['cul'])){
                if($GPC['cul'] != 9){
                    $analisis = new Analisis();
                    $infoAnalisis = $analisis->listaAnalisis('', '', '', '', 't', 't');
                    foreach($infoAnalisis as $valor){
                        $listaAnalisis[$valor['codigo']] = $valor['nombre'];
                    }
                    ?>
                    <tr>
                        <td width="110">An&aacute;lisis: </td>
                        <td><? echo $html->select('id_analisis', array('options' => $listaAnalisis, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
                    </tr>
                    <?
                }else{
                    $listaOpciones = array(1 => 'Franquicia');
                    ?>
                    <tr>
                        <td width="110">Opciones: </td>
                        <td><? echo $html->select('id_analisis', array('options' => $listaOpciones, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
                    </tr>
                    <?
                }
            }
        break;
    }
?>

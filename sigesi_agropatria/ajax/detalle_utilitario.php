<?php

    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    $productor = new Productor();
    $movimiento = new Recepcion();
    $vehiculo = new Vehiculo();
    $guia= new Guia();
    
    switch ($GPC['ac']) {
        case 'cosecha':
            $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
            echo $html->select('Recepcion_codigo', array('options' => $listaCo, 'class' => 'estilo_campos'));
        break;
        case 'productor':
            if (!empty($GPC['cosecha'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $listaProductor = $cosecha->buscarCosechaProductor($idCosecha);
                    foreach($listaProductor as $dataPro)
                        $listaP[$dataPro['ced_productor']]=$dataPro['productor'];
                    echo $html->select('Recepcion.ced_productor', array('options' => $listaP, 'default' => 'Seleccione', 'class' => 'estilo_campos'));
                }                
            }
        break;
        case 'asociacion':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP'])) {
                if (is_numeric($GPC['cosecha'])) {                
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=(is_numeric($GPC['cedRifP'])) ? $GPC['cedRifP']: '';            
                    $listAsociacion = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP);
                    foreach($listAsociacion as $datAon)
                        $listAon[$datAon['ced_asociacion']]=$datAon['asociacion'];
                    //$listAon['null']='Seleccione';
                    if (!empty($listAon))
                        echo $html->select('Recepcion.ced_asociacion', array('options' => $listAon, 'default' => 'Seleccione',  'class' => 'estilo_campos'));
                 }
            }
        break;
        case 'asociado':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP']) && !empty($GPC['cedRifAon']) && !empty($GPC['cedRifAdo'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=($GPC['cedRifP']=='undefined') ? $GPC['cedRifP']: null;
                    $cedRifAon=($GPC['cedRifAon']=='undefined') ? $GPC['cedRifAon']: null;
                    $listAsociado = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP, $cedRifAon);
                    foreach($listAsociado as $datAdo)
                        $listAdo[$datAdo['ced_asociacion']]=$datAdo['asociacion'];
                    $listAdo['null']='Seleccione';
                    if (!empty($listAdo))
                        echo $html->select('Recepcion.ced_asociacion', array('options' => $listAdo, 'default' => 'Seleccione', 'class' => 'estilo_campos'));
                }
            }
        break;
        case 'recepcion':
            if (!empty($GPC['numero']) && !empty($GPC['fecha']) && !empty($GPC['tipo']) && !empty($GPC['ca'])  && !empty($GPC['co']) && !empty($GPC['id'])) {
                $infoMov=$movimiento->listadoRecepcion(null, null, null, null, $GPC['numero'], null, null, null, null, null, null, null, null, null, null, null, null, null, date("Y-m-d", strtotime($GPC['fecha'])));
                if ($GPC['tipo']=='n') {
                    if (!empty($infoMov[0]['id'])) {
                            if ($infoMov[0]['id']==$GPC['id']) {
                                echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));
                                echo "<script>";
                                echo "alert('NUMERO DE ENTRADA DISPONIBLE')";
                                echo "</script>";

                            } else {
                                echo $html->input('msg1',1, array('type' => 'text', 'style'=>'display: none'));
                                echo "<script>";
                                echo "alert('NUMERO DE ENTRADA OCUPADO')";
                                echo "</script>";
                            }
                    } else {
                        echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));
                        echo "<script>";
                        echo "alert('NUMERO DE ENTRADA DISPONIBLE')";
                        echo "</script>";
                    }
                } elseif ($GPC['tipo']=='f') {
                    if (!empty($infoMov[0]['id'])) {
                            if ($infoMov[0]['id']==$GPC['id']) {
                                echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));
                                echo "<script>";
                                echo "alert('FECHA DE ENTRADA DISPONIBLE')";
                                echo "</script>";

                            } else {
                                echo $html->input('msg1',1, array('type' => 'text', 'style'=>'display: none'));
                                echo "<script>";
                                echo "alert('FECHA DE ENTRADA OCUPADO')";
                                echo "</script>";
                            }
                    } else {
                        echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none'));
                        echo "<script>";
                        echo "alert('FECHA DE ENTRADA DISPONIBLE')";
                        echo "</script>";
                    }
                } 
            }
        break;
        case 'guia':            
            $listaSubGuia = $guia->buscarSubGuias($GPC['idguia']);
                $i=1;
                foreach($listaSubGuia as $subguia) {
                    $i++;
            ?>
                <tr>
                    <td>Guia Nro. <?=$i?></td>
                    <td>
                        <?=$html->input('Guia.subguia'.$i, $subguia['subguia'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?>
                    </td>
                </tr>
            <?
                }
            ?>
                <tr>
                    <td width="130px">Fecha de emision</td>
                    <td width="230px"><?=$html->input('Guia.placa', $listaGuia[0]['fecha_emision'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?></td>
                </tr>
                <tr>
                    <td width="130px">Placa del Vehiculo</td>
                    <td width="230px"><?=$html->input('Guia.placa', $infoMov[0]['placa'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?></td>
                </tr>
                <tr>
                    <td>Contrato</td>
                    <td>
                        <?=$html->input('Guia.contrato', $infoMov[0]['contrato'], array('type' => 'text', 'class' => 'crproductor', 'readOnly'=>true)); ?>
                    </td>
                </tr>
            <?
        break;
    }
?>
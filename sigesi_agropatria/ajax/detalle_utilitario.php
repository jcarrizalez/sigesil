<?php

    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    $productor = new Productor();
    $movimiento = new Recepcion();
    $vehiculo = new Vehiculo();
    $guia= new Guia();
    $chofer = new Chofer();
    $cliente = new Cliente();
    $orden = new Orden();
    
    switch ($GPC['ac']) {
        case 'cosecha':
            $listaCo = $cosecha->find('', '', array('id', 'nombre'), 'list', 'id');
            echo $html->select('Recepcion_codigo', array('options' => $listaCo, 'class' => 'estilo_campos'));
        break;
        case 'productor':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=$GPC['cedRifP'];
                    $cedRifAon=$GPC['cedRifAon'];
                    $cedRifAdo=$GPC['cedRifAdo'];
                    $listaProductor = $cosecha->buscarCosechaProductor($idCosecha, $GPC['cedRifP']);
//                    foreach($listaProductor as $dataPro)
//                        $listaP[$dataPro['ced_productor']]=$dataPro['productor'];
//                    echo $html->select('Recepcion.ced_productor', array('options' => $listaP, 'default' => 'Seleccione', 'class' => 'estilo_campos'));
                    if (!empty($listaProductor[0]['productor'])) {
                        echo "<span class='crproductor'>".$listaProductor[0]['productor']."</span>";
                        echo $html->input('msg5',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    } else {
                        echo "<span class='crproductor'>El productor no existe!!!</span>";
                        echo $html->input('msg5',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    }
                }   
            } else {
                echo $html->input('msg5',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
            }
                //echo $html->select('Recepcion.ced_productor', array('default' => 'Seleccione', 'class' => 'estilo_campos'));
        break;
        case 'asociacion':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP']) && !empty($GPC['cedRifAon'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
                    $cedRifP=$GPC['cedRifP'];
                    $cedRifAon=$GPC['cedRifAon'];
                    $cedRifAdo=$GPC['cedRifAdo'];
                    $listAsociacion = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP, $cedRifAon, $cedRifAdo);
                    if (count($listAsociacion[0]['asociacion'])) {
                        echo "<span class='crproductor'>".$listAsociacion[0]['asociacion']."</span>";
                        echo $html->input('msg6',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    } else  {
                        echo "<span class='crproductor'>La Asociacion no existe!!!</span>";
                        echo $html->input('msg6',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    }
                        //echo $html->select('Recepcion.ced_asociacion', array('options' => $listAon, 'default' => 'Seleccione',  'class' => 'estilo_campos'));
                 }
            } else {
                echo $html->input('msg6',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                echo "<span class='crproductor'>La Asociacion no existe(Cosecha)!!!</span>";
            }
                //echo $html->select('Recepcion.ced_asociacion', array('default' => 'Seleccione',  'class' => 'estilo_campos'));
        break;
        case 'asociado':
            if (!empty($GPC['cosecha']) && !empty($GPC['cedRifP'])) {
                if (is_numeric($GPC['cosecha'])) {
                    $idCosecha=$GPC['cosecha'];
//                    $cedRifP=($GPC['cedRifP']=='undefined') ? $GPC['cedRifP']: null;
//                    $cedRifAon=($GPC['cedRifAon']=='undefined') ? $GPC['cedRifAon']: null;
//                    $cedRifAdo=($GPC['cedRifAdo']=='undefined') ? $GPC['cedRifAdo']: null;                    
                    $cedRifP=$GPC['cedRifP'];
                    $cedRifAon=$GPC['cedRifAon'];
                    $cedRifAdo=$GPC['cedRifAdo'];                    
                    $listAsociado = $cosecha->buscarCosechaProductor($idCosecha, $cedRifP, $cedRifAon, $cedRifAdo);                 
                    if (!empty($listAsociado[0]['asociado'])) {
                        echo "<span class='crproductor'>".$listAsociado[0]['asociado']."</span>";
                        echo $html->input('msg7',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    } else {
                        echo "<span class='crproductor'>El Asociado no existe!!!</span>";
                        echo $html->input('msg7',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                    }
                }
            } else {
                echo "<span class='crproductor'>El Asociado no existe!!!</span>";
                echo $html->input('msg7',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
            }
        break;
        case 'recepcion':
            if (!empty($GPC['numero']) && !empty($GPC['fecha']) && !empty($GPC['tipo']) && !empty($GPC['ca'])  && !empty($GPC['co']) && !empty($GPC['id'])) {
                $infoMov=$movimiento->listadoRecepcion(null, null, null, null, $GPC['numero'], null, null, null, null, null, null, null, null, null, null, null, null, null, date("Y-m-d", strtotime($GPC['fecha'])));
                if ($GPC['tipo']=='n') {
                    if (!empty($infoMov[0]['id'])) {
                            if ($infoMov[0]['id']==$GPC['id']) {
                                echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                                echo "<script>";
                                echo "alert('NUMERO DE ENTRADA DISPONIBLE')";
                                echo "</script>";

                            } else {
                                echo $html->input('msg1',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                                echo "<script>";
                                echo "alert('NUMERO DE ENTRADA OCUPADO')";
                                echo "</script>";
                            }
                    } else {
                        echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                        echo "<script>";
                        echo "alert('NUMERO DE ENTRADA DISPONIBLE')";
                        echo "</script>";
                    }
                } elseif ($GPC['tipo']=='f') {
                    if (!empty($infoMov[0]['id'])) {
                        if ($infoMov[0]['id']==$GPC['id']) {
                            echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                            echo "<script>";
                            echo "alert('FECHA DE ENTRADA DISPONIBLE')";
                            echo "</script>";

                        } else {
                            echo $html->input('msg1',1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                            echo "<script>";
                            echo "alert('FECHA DE ENTRADA OCUPADO')";
                            echo "</script>";
                        }
                   } else {
                        echo $html->input('msg1',0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                        echo "<script>";
                        echo "alert('FECHA DE ENTRADA DISPONIBLE')";
                        echo "</script>";
                   }
                } 
            }
        break;
        case 'guia':
            if (!empty($GPC['numero'])) {
                $infoGuia = $guia->find(array('numero_guia'=>$GPC['numero']), '');
                $idGuia=$infoGuia[0]['id'];
                if (!empty($idGuia)) {
                    $listaSubGuia = $guia->buscarSubGuias($idGuia);
                    $i=0;
                    foreach($listaSubGuia as $subguia) {
                        $i++;
                    ?>
                    <tr>
                        <td width="130px">SubGu&iacute;a Nro. <?=$i?></td>
                        <td width="230px">
                            <?=$html->input('Recepcion.numero_guia_'.$i, $subguia['subguia'], array('type' => 'text', 'class' => 'crproductor subguia')); ?>
                        </td>
                    </tr>            
                    <?                
                    }
                }
            }
        break;
        case 'chofer':
            if (!empty($GPC['cedC'])) {
                $infoChofer = $chofer->find(array('ced_rif' => $GPC['cedC']));
                if (!empty($infoChofer[0]['id'])) {
                    echo "<span class='crproductor'>".$infoChofer[0]['nombre']."</span>";
                    echo $html->input('msg2', 0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                } else {
                    echo "<span class='crproductor'>EL CHOFER NO EXISTE!!!</span>";
                    echo $html->input('msg2', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                }
            } else {
                echo "<td colspan='3'>";
                echo "<span class='crproductor'>EL CHOFER NO EXISTE!!!</span>";
                echo $html->input('msg2', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                echo "</td>";
            }
        break;
        case 'vehiculo':
            if (!empty($GPC['placa'])) {
                $infoVehiculo = $vehiculo->buscar($GPC['placa']);
                if (!empty($infoVehiculo[0]['id'])) {
                    echo "<span class='crproductor'>".$infoVehiculo[0]['marca']."</span>";
                    echo $html->input('msg3', 0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                } else {
                    echo "<span class='crproductor'>EL VEHICULO NO EXISTE!!!</span>";
                    echo $html->input('msg3', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                }
            } else {
                echo "<td colspan='3'>";
                echo "<span class='crproductor'>EL VEHICULO NO EXISTE!!!</span>";
                echo $html->input('msg3', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                echo "</td>";
            }            
        break;
        case 'cliente':
            if (!empty($GPC['cedCli'])) {
                $infoCliente = $cliente->find(array('ced_rif' => $GPC['cedCli']));
                if (!empty($infoCliente[0]['id'])) {
                    echo "<span class='crproductor'>".$infoCliente[0]['nombre']."</span>";
                    echo $html->input('msg4', 0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                } else {
                    echo "<span class='crproductor'>EL CLIENTE NO EXISTE!!!</span>";
                    echo $html->input('msg4', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                }
            } else {
                echo "<td colspan='3'>";
                echo "<span class='crproductor'>EL CLIENTE NO EXISTE!!!</span>";
                echo $html->input('msg4', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                echo "</td>";
            }
        break;
        case 'orden':
            if (!empty($GPC['numero'])) {
                $infoOrden = $orden->find(array('numero_orden' => $GPC['numero']));
                if (!empty($infoOrden[0]['id'])) {
                    echo "<span class='crproductor'>EXISTE!!!</span>";
                    echo $html->input('msg4', 0, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                } else {
                    echo "<span class='crproductor'>LA ORDEN NO EXISTE!!!</span>";
                    echo $html->input('msg4', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                }
            } else {
                echo "<td colspan='3'>";
                echo "<span class='crproductor'>EL ORDEN NO EXISTE!!!</span>";
                echo $html->input('msg4', 1, array('type' => 'text', 'style'=>'display: none', 'class'=>'mensaje'));
                echo "</td>";
            }
        break;
    }
?>
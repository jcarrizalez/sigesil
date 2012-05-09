<?php
    //cuarentena_pendiente.php?ac=editar&id=7
    $Ctna = new Cuarentena();
    $recepcion = new Recepcion();
    $guia = new Guia();
    $cultivo = new Cultivo();
    $vehiculo = new Vehiculo();
    
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['id'])) {
                $infoRecepcion=$recepcion->find(array('id' => $id));
                $infoCtna = $Ctna->find(array('id_recepcion' => $id));
                $idCuarentena=$infoCtna[0]['id'];
                $infoVehiculo = $vehiculo->find(array('id' => $infoRecepcion[0]['id_vehiculo']));
                $infoGuia = $guia->find(array('id' => $infoRecepcion[0]['id_guia']));
            }            
            break;
    }
    //$infoRecepcion
    //$infoGuia
    //$infoVehiculo
//* Número de Guía
//* Fecha de Emisión
//* Kilogramos Guía 
?>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? 
    echo $html->input('id', $GPC['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CUARENTENA<br/><hr/>
    </div>    
    <fieldset>    
        <legend>Datos de la Recepcion</legend>
        <table align="center" border="0">
            <tr>
                <td align="left">Nro. Entrada</td>
                <td><? echo $html->input('Recepcion.numero', $infoRecepcion[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos cuadricula', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td align="left">Fecha</td>
                <td><? echo $html->input('Cuarentena.fecha_mov', $general->date_sql_screen($infoCtna[0]['fecha_mov'], '', 'es', '-'), array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Cultivo</td>
                <td colspan="4"><? echo $html->select('Cuarentena.id_cultivo', array('options' => $listaCultivos, 'selected' => $infoCtna[0]['id_cultivo'], 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Kilogramos Aprox.</td>
                <td colspan="4"><? echo $html->input('', $infoGuia[0]['kilogramos'], array('type' => 'text', 'readOnly' => true, 'class' => 'crproductor')); ?></td>
            </tr>
            <tr>
                <td>Vehiculo Placa</td>
                <td><? echo $html->input('', $infoVehiculo[0]['placa'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td>Placa Rem:</td>            
                <td><? echo $html->input('', $infoGuia[0]['placa_remolques'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
            <tr>
                <td>Chofer Cedula</td>
                <td><? echo $html->input('', $infoGuia[0]['cedula_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
                <td width="50"></td>
                <td>Chofer Nombre</td>
                <td><? echo $html->input('', $infoGuia[0]['nombre_chofer'], array('type' => 'text', 'class' => 'crproductor', 'readOnly' => true)); ?></td>
            </tr>
        </table>        
    </fieldset>
    <fieldset>    
        <legend>Observaciones</legend>
        <table align="center" border="0">
            <tr>
            </tr>
        </table>        
    </fieldset>

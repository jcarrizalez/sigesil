<?php
    require_once('../lib/core.lib.php');
    //cuarentena_pendiente.php?ac=editar&id=7
    $Ctna = new Cuarentena();
    $recepcion = new Recepcion();
    $guia = new Guia();
    $cultivo = new Cultivo();
    $vehiculo = new Vehiculo();
    
    $listaCultivo = $cultivo->find('', null, array('id', 'nombre'), 'list', 'id');
    
    switch ($GPC['ac']) {
        case 'editar':
            if (!empty($GPC['id'])) {
                $infoRecepcion=$recepcion->find(array('id' => $GPC['id']));
                $idRec=$infoRecepcion[0]['id'];
                $infoCtna = $Ctna->find(array('id_recepcion' => $idRec));
                $idCuarentena=$infoCtna[0]['id'];
            }            
            break;
        case 'Aprobar':
            if (!empty($GPC['id'])) {
                $infoRecepcion=$recepcion->find(array('id' => $GPC['id']));
                $idRec=$infoRecepcion[0]['id'];
                $infoCtna = $Ctna->find(array('id_recepcion' => $idRec));
                $idCuarentena=$infoCtna[0]['id'];
                
                if (!empty($idCuarentena)) {
                    $GPC['Cuarentena']['id']=$idCuarentena;
                    $Ctna->save($GPC['Cuarentena']);
                    $GPC['Recepcion']['id']=$idRec;
                    $GPC['Recepcion']['estatus_rec']=2;
                    $recepcion->save($GPC['Recepcion']);
                }
            }            
            break;
        case 'Rechazar':
            if (!empty($GPC['id'])) {
                $infoRecepcion=$recepcion->find(array('id' => $GPC['id']));
                $idRec=$infoRecepcion[0]['id'];
                $infoCtna = $Ctna->find(array('id_recepcion' => $idRec));
                $idCuarentena=$infoCtna[0]['id'];
                
                if (!empty($idCuarentena)) {                    
                    $GPC['Cuarentena']['id']=$idCuarentena;
                    $Ctna->save($GPC['Cuarentena']);
                    $GPC['Recepcion']['id']=$idRec;
                    $GPC['Recepcion']['estatus_rec']=11;
                    $recepcion->save($GPC['Recepcion']);
                }
            }
            break;
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'cuarentena_pendiente_listado.php';
    }
    
    $(document).ready(function(){
        $('#Cuarentena\\observa_admon\\').focus();
        $('#Aprobar').click(function(){
            $('#ac').val('Aprobar');
        });
        $('#Rechazar').click(function(){
            $('#ac').val('Rechazar');
        });
        $("#form1").submit(function(){
            valido=false;
            if ($('#ac').val()=='' && $('#Cuarentena\\[observa_admon\\]').val()=='') {
                alert('Faltan datos');
                return valido;
            }
            else if ($('#ac').val()=='Rechazar' && confirm('Seguro Desea Rechazar'))                     
                    valido=true;
                else if ($('#ac').val()=='Aprobar' && confirm('Seguro Desea Aprobar'))
                        valido=true;
            return valido;
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="" enctype="multipart/form-data">
    <? 
    echo $html->input('ac', '', array('type' => 'hidden')); 
    echo $html->input('id', $GPC['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CUARENTENA PENDIENTE<br/><hr/>
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
                <td colspan="4"><? echo $html->select('Cuarentena.id_cultivo', array('options' => $listaCultivo, 'selected' => $infoCtna[0]['id_cultivo'], 'readOnly' => true)); ?></td>
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
        <legend>Administracion</legend>
        <table align="center" border="0">
            <tr>
                <td align="left">Observacion</td>
                <td align="center">
                <textarea name="Cuarentena[observa_admon]" cols="50" rows="2" id="Cuarentena[observa_admon]"><?=$infoCtna[0]['observa_admon']?></textarea></td>
                </td>
            </tr>
        </table>
    </fieldset>
    <table align="center" border="0">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>                
                <?
                echo $html->input('Aprobar', 'Aprobar', array('type' => 'submit'));
                echo $html->input('Rechazar', 'Rechazar', array('type' => 'submit'));
                echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()'));
                ?>
            </td>
        </tr>        
    </table>
    </fieldset>
<?
require('../lib/common/footer.php');
?>
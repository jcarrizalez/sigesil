<?
    require_once('../lib/core.lib.php');
    
    $cosecha = new Cosecha();
    
    $idCA = $_SESSION['s_ca_id'];
    
    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA, null, null, null, null, null, null);
    
    foreach($listadoCosechas as $valor){
        $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Org']['nombre'])){
                $GPC['Recepcion']['id_estado'] = $GPC['id_estado'];
                $GPC['Recepcion']['id_municipio'] = $GPC['id_municipio'];
                $organizacion->save($GPC['Recepcion']);
                $id = $organizacion->id;
                
                if(!empty($id)){
                    header("location: recepcion_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: recepcion_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoRec = $organizacion->find(array('id' => $GPC['id']));
            $listaMcpos = $div_pol->obtenerMcpo('', $infoRec[0]['id_estado']);
            foreach($listaMcpos as $dataMcpo){
                $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
            }
        break;
    }
    
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Recepcion.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Recepcion.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'recepcion_listado.php';
    }
    
    $(document).ready(function(){
        $('#Recepcion\\[id_cosecha\\]').change(function(){
            $('#nrocosecha').load('../ajax/cosecha_programa.php?ac=cantidad&idCo='+$(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Recepcion.id', $infoRec[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVA RECEPCI&Oacute;N<br/><hr/>
    </div>
    <table align="center" border="0" width="100%">
        <tr>
            <td colspan="2">Entrada Nro: <div id="nrocosecha"></div></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha: </td>
            <td><? echo $html->select('Recepcion.id_cosecha',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
    </table>
    <fieldset>
        <legend>Datos de la Gu&iacute;a</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero de Gu&iacute;a: </td>
                <td><? echo $html->input('Recepcion.nombre', $infoRec[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Agencia Origen: </td>
                <td><? echo $html->input('Recepcion.codigo', $infoRec[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Fecha de Emisi&oacute;n: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>N&uacute;mero de Contrato: </td>
                <td><? echo $html->input('Recepcion.rif', $infoRec[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Disponible a Recibir: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>C&eacute;dula/Rif Productor: </td>
                <td><? echo $html->input('Recepcion.telefono', $infoRec[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Productor Asociado: </td>
                <td><? echo $html->input('Recepcion.email', $infoRec[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Cultivo: </td>
                <td><? echo $html->input('Recepcion.fax', $infoRec[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Kilogramos Gu&iacute;a: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Veh&iacute;culo</legend>
        <table align="center">
            <tr>
                <td>Placa Veh&iacute;culo: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Marca: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Placa Remolque: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>C&eacute;dula Chofer: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Recepci&oacute;n</legend>
        <table align="center">
            <tr>
                <td>Centro Receptor: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Fecha de Recepci&oacute;n: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Hora Recepci&oacute;n: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Carril de Muestreo: </td>
                <td><? echo $html->input('Recepcion.direccion', $infoRec[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
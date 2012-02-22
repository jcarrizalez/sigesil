<?
    require_once('../lib/core.lib.php');
    
    $organizacion = new Organizacion();
    $div_pol = new DivPol();
    
    $paises = $div_pol->obtenerPais();
    foreach($paises as $campo => $valor){
        $listaP[$valor['id']] = $valor['nombre'];
    }
    $estados = $div_pol->obtenerEstado();
    foreach($estados as $campo => $valor){
        $listaE[$valor['id']] = $valor['nombre'];
    }
    $estatus = array('t' => 'Activa', 'f' => 'Inactiva');
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Org']['nombre'])){
                $GPC['Org']['id_estado'] = $GPC['id_estado'];
                $GPC['Org']['id_municipio'] = $GPC['id_municipio'];
                $organizacion->save($GPC['Org']);
                $id = $organizacion->id;
                
                if(!empty($id)){
                    header("location: organizacion_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: organizacion_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoOrg = $organizacion->find(array('id' => $GPC['id']));
            $listaMcpos = $div_pol->obtenerMcpo('', $infoOrg[0]['id_estado']);
            foreach($listaMcpos as $dataMcpo){
                $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
            }
        break;
    }
    
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Org.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Org.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'organizacion_listado.php';
    }
    
    $(document).ready(function(){
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Org.id', $infoOrg[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVA RECEPCI&Oacute;N<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Agencia Origen: </td>
            <td><? echo $html->input('Org.codigo', $infoOrg[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de Gu&iacute;: </td>
            <td><? echo $html->input('Org.nombre', $infoOrg[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Fecha de Emisi&oacute;n: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de Contrato: </td>
            <td><? echo $html->input('Org.rif', $infoOrg[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Disponible a Recibir: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>C&eacute;dula/Rif Productor: </td>
            <td><? echo $html->input('Org.telefono', $infoOrg[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Productor Asociado: </td>
            <td><? echo $html->input('Org.email', $infoOrg[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Cultivo: </td>
            <td><? echo $html->input('Org.fax', $infoOrg[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Kilogramos Gu&iacute;: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Placa Veh&iacute;culo: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Marca: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Placa Remolque: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>C&eacute;dula Chofer: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Centro Receptor: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Fecha de Recepci&oacute;n: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Hora Recepci&oacute;n: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Carril de Muestreo: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
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
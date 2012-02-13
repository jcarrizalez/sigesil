<?
    require_once('../lib/core.lib.php');
    
    $organizacion = new Organizacion();
    $estatus = array('t' => 'Activa', 'f' => 'Inactiva');
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Org']['nombre'])){
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
        break;
    }
    
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Org.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Org.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Org.id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Org.id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'organizacion_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Org.id', $infoOrg[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVA ORGANIZACI&Oacute;N<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('Org.nombre', $infoOrg[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>RIF: </td>
            <td><? echo $html->input('Org.rif', $infoOrg[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono: </td>
            <td><? echo $html->input('Org.telefono', $infoOrg[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><? echo $html->input('Org.email', $infoOrg[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Fax: </td>
            <td><? echo $html->input('Org.fax', $infoOrg[0]['coordenadas'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n: </td>
            <td><? echo $html->input('Org.direccion', $infoOrg[0]['ubicacion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s: </td>
            <td><? echo $html->select('Org.id_pais',array('options'=>$cantSilos, 'selected' => $infoOrg[0]['id_pais'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado: </td>
            <td><? echo $html->select('Org.id_estado',array('options'=>$cantSilos, 'selected' => $infoOrg[0]['id_estado'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio: </td>
            <td><? echo $html->select('Org.id_municipio',array('options'=>$cantSilos, 'selected' => $infoOrg[0]['id_municipio'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td>Estatus: </td>
            <td><? echo $html->select('Org.estatus',array('options'=>$estatus, 'selected' => $infoOrg[0]['estatus'], 'default' => 'Seleccione'))?></td>
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
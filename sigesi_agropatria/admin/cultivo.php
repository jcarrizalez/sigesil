<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    $cultivoTipo = new TipoCultivo();
    
    $listadoTipoCultivo = $cultivoTipo->find('',null,'*','list','id ASC');
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Cultivo']['nombre'])){
                $cultivo->save($GPC['Cultivo']);
                $id = $cultivo->id;
                if(!empty($id)){
                    header("location: cultivo_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: cultivo_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCultivo = $cultivo->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Cultivo.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cultivo.id_tipo_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'cultivo_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO CULTIVO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('Cultivo.nombre', $infoCultivo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
                <td><span class="msj_rojo">* </span>Tipo de Cultivo: </td>
                <td><? echo $html->select('Cultivo.id_tipo_cultivo',array('options'=>$listadoTipoCultivo, 'selected' => $infoCultivo[0]['id_tipo_cultivo'], 'default' => 'Seleccione'))?></td>
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
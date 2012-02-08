<?
    require_once('../lib/core.lib.php');

    $cultivoTipo = new TipoCultivo();
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['CultivoTipo']['nombre'])){
                $cultivoTipo->save($GPC['CultivoTipo']);
                $id = $cultivoTipo->id;
                if(!empty($id)){
                    header("location: tipo_cultivo_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: tipo_cultivo_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCultivoTipo = $cultivoTipo->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('CultivoTipo.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'tipo_cultivo_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('CultivoTipo.id', $infoCultivoTipo[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO TIPO DE CULTIVO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('CultivoTipo.nombre', $infoCultivoTipo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
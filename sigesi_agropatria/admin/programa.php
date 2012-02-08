<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['CA']['nombre']) && !empty($GPC['CA']['ubicacion'])){
                $centro_acopio->save($GPC['CA']);
                $id = $centro_acopio->id;
                if(!empty($id)){
                    header("location: centros_acopio_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: centros_acopio_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCA = $centro_acopio->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.ubicacion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'centros_acopio_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('CA.id', $infoCA[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO PROGRAMA<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre del Programa: </td>
            <td><? echo $html->input('nombre', $infoCA[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
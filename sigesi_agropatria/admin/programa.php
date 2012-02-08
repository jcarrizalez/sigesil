<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    
    $listaEstados = array(0 => 'Abierta', 1 => 'Cerrada');
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Programa']['nombre'])){
                $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $cantProgramas = $programa->cantidadProgramasCA($_SESSION['s_ca_id']);
                $GPC['Programa']['numero'] = ++$cantProgramas[0]['total'];
                $programa->save($GPC['Programa']);
                $id = $programa->id;
                if(!empty($id)){
                    header("location: programa_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: programa_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCA = $programa->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Programa.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha.estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha.proyectado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cultivo.id', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Programa.id', $infoCA[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO PROGRAMA<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Programa</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->input('Programa.nombre', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Observaci&oacute;n: </td>
                <td><textarea name="Programa[observacion]" cols="20" rows="2" id="Programa[observacion]"></textarea></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Cosecha</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->input('Cosecha.nombre', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Estado: </td>
                <td><? echo $html->select('Cosecha.estado',array('options'=>$listaEstados, 'selected' => $infoPrograma[0]['estado']))?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Proyectado: </td>
                <td><? echo $html->input('Cosecha.proyectado', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Observaci&oacute;n: </td>
                <td><textarea name="Cosecha[observacion]" cols="20" rows="2" id="Cosecha[observacion]"><?=$infoPrograma[0]['observacion']?></textarea></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Cultivo</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->select('Cultivo.id',array('options'=>$listaCultivos, 'selected' => $infoPrograma[0]['estado'], 'default'=>' Seleccione '))?></td>
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
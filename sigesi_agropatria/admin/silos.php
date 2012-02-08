<?
    require_once('../lib/core.lib.php');
    
    $silo = new Silos();
    
    switch($GPC['ac']){
        case 'guardar':
            $GPC['Silo']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            if(!empty($GPC['Silo']['nombre']) && !empty($GPC['Silo']['numero']) && !empty($GPC['Silo']['capacidad'])){
                $silo->save($GPC['Silo']);
                $id = $silo->id;
                if(!empty($id)){
                    header("location: silos_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: silos_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoSilo = $silo->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Silo.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.coordenada', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.numero', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Silo.capacidad', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'silos_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Silo.id', $infoSilo[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO SILO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('Silo.nombre', $infoSilo[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Coordenada: </td>
            <td><? echo $html->input('Silo.coordenada', $infoSilo[0]['coordenada'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>N&uacute;mero: </td>
            <td><? echo $html->input('Silo.numero', $infoSilo[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Capacidad: </td>
            <td><? echo $html->input('Silo.capacidad', $infoSilo[0]['capacidad'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Observaci&oacute;n: </td>
            <td><textarea name="Silo[observacion]" cols="20" rows="2" id="Silo[observacion]"><?=$infoSilo[0]['observacion']?></textarea></td>
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
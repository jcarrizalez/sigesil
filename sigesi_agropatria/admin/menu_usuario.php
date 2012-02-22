<?
    require_once('../lib/core.lib.php');
    
    switch($GPC['ac']){
        case 'guardar':
            $GPC['Almacen']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            if(!empty($GPC['Almacen']['nombre']) && !empty($GPC['Almacen']['estatus'])){
                $GPC['Almacen']['id_estado'] = $GPC['id_estado'];
                $GPC['Almacen']['id_municipio'] = $GPC['id_municipio'];
                $GPC['Almacen']['id_tipo_almacen'] = 2;
                $almacen->save($GPC['Almacen']);
                $id = $almacen->id;
                if(!empty($id)){
                    header("location: almacen_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: almacen_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoAlmacen = $almacen->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Almacen.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'silos_listado.php';
    }
    
    $(document).ready(function(){
        
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Almacen.id', $infoAlmacen[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        ASIGNAR MENU USUARIO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('Almacen.nombre', $infoAlmacen[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s: </td>
            <td><? echo $html->select('Almacen.id_pais',array('options'=>$listaP, 'selected' => $infoAlmacen[0]['id_pais'], 'default' => 'Seleccione'))?></td>
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
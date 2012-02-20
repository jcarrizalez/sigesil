<?
    require_once('../lib/core.lib.php');
    
    $almacen = new Almacen();
    $div_pol = new DivPol();
    
    $paises = $div_pol->obtenerPais();
    foreach($paises as $campo => $valor){
        $listaP[$valor['id']] = $valor['nombre'];
    }
    $estados = $div_pol->obtenerEstado();
    foreach($estados as $campo => $valor){
        $listaE[$valor['id']] = $valor['nombre'];
    }
    $estatus = array('t' => 'Activo', 'f' => 'Inactivo');
    
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
            $listaMcpos = $div_pol->obtenerMcpo('', $infoAlmacen[0]['id_estado']);
            foreach($listaMcpos as $dataMcpo){
                $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
            }
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Almacen.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Almacen.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Almacen.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Almacen.email', array('email' => array('value' => true, 'message' => 'Inv&aacute;lido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'silos_listado.php';
    }
    
    $(document).ready(function(){
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Almacen.id', $infoAlmacen[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO ALMACEN<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('Almacen.nombre', $infoAlmacen[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Direccion: </td>
            <td><? echo $html->input('Almacen.direccion', $infoAlmacen[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s: </td>
            <td><? echo $html->select('Almacen.id_pais',array('options'=>$listaP, 'selected' => $infoAlmacen[0]['id_pais'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado: </td>
            <td><? echo $html->select('id_estado',array('options'=>$listaE, 'selected' => $infoAlmacen[0]['id_estado'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio: </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('id_municipio',array('options'=>$listaM, 'selected' => $infoAlmacen[0]['id_municipio'], 'default' => 'Seleccione'))?>
                </div>
            </td>
        </tr>
        <tr>
            <td>Tel&eacute;fono: </td>
            <td><? echo $html->input('Almacen.telefono', $infoAlmacen[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Fax: </td>
            <td><? echo $html->input('Almacen.fax', $infoAlmacen[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><? echo $html->input('Almacen.email', $infoAlmacen[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estatus: </td>
            <td><? echo $html->select('Almacen.estatus',array('options'=>$estatus, 'selected' => $infoAlmacen[0]['estatus'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td>Coordenadas UTM: </td>
            <td><? echo $html->input('Almacen.coordenadas_utm', $infoAlmacen[0]['coordenadas_utm'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
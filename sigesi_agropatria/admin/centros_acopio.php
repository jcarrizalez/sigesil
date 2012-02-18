<?
    require_once('../lib/core.lib.php');
    
    $centro_acopio = new CentroAcopio();
    $org = new Organizacion();
    $div_pol = new DivPol();
    
    $paises = $div_pol->obtenerPais();
    foreach($paises as $campo => $valor){
        $listaP[$valor['id']] = $valor['nombre'];
    }
    $estados = $div_pol->obtenerEstado();
    foreach($estados as $campo => $valor){
        $listaE[$valor['id']] = $valor['nombre'];
    }
    
    $listaOrg = $org->find('','', array('id', 'nombre'), 'list', 'id');
    $estatus = array('t' => 'Activo', 'f' => 'Inactivo');
    
    $ocultarCantidad = 1;
    
    for($i=1;$i<=50;$i++){
        $cantSilos[$i] = $i;
    }
    
    switch($GPC['ac']){
        case 'guardar':
            $silos = new Silos();
            $almacen = new Almacen();
            if(!empty($GPC['CA']['codigo']) && !empty($GPC['CA']['nombre']) && !empty($GPC['CA']['rif'])){
                $GPC['CA']['id_estado'] = $GPC['id_estado'];
                $GPC['CA']['id_municipio'] = $GPC['id_municipio'];
                $centro_acopio->save($GPC['CA']);
                $idCA = $centro_acopio->id;
                $dataAlmacen = array('id_centro_acopio' => $idCA, 
                                    'nombre' => 'Almacen - Silos', 
                                    'direccion' => '',
                                    'id_pais' => $GPC['CA']['id_pais'],
                                    'id_estado' => $GPC['id_estado'],
                                    'id_municipio' => $GPC['id_municipio'],
                                    'telefono' => '',
                                    'fax' => '',
                                    'email' => '',
                                    'estatus' => 1,
                                    'coordenadas_utm' => '',
                                    'id_tipo_almacen' => 1);
                $almacen->save($dataAlmacen);
                $idAl = $almacen->id;
                
                $nuevoSilo = array();
                $nuevoSilo['id_centro_acopio'] = $idCA;
                $nuevoSilo['id_almacen'] = $idAl;
                for($i=1;$i<=$GPC['cant_silos'];$i++){
                    $nuevoSilo['nombre'] = "Silo ".$i;
                    $nuevoSilo['coordenada'] = "Norte";
                    $nuevoSilo['numero'] = $i;
                    $nuevoSilo['capacidad'] = 1000;
                    $nuevoSilo['modulo'] = 'A';
                    $silos->save($nuevoSilo);
                    $silos->id = null;
                }
                
                if(!empty($idCA)){
                    header("location: centros_acopio_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: centros_acopio_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoCA = $centro_acopio->find(array('id' => $GPC['id_ca']));
            $ocultarCantidad = 0;
        break;
    }
    
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('CA.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.id_pais', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_estado', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_municipio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.email', array('email' => array('value' => true, 'message' => 'Correo Invalido')));
$validator->setRules('CA.id_org', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('CA.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('cant_silos', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'centros_acopio_listado.php';
    }
    
    $(document).ready(function(){
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('CA.id', $infoCA[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO CENTRO DE ACOPIO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n: </td>
            <td><? echo $html->select('CA.id_org',array('options'=>$listaOrg, 'selected' => $infoCA[0]['id_org'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Codigo: </td>
            <td><? echo $html->input('CA.codigo', $infoCA[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nombre: </td>
            <td><? echo $html->input('CA.nombre', $infoCA[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>RIF: </td>
            <td><? echo $html->input('CA.rif', $infoCA[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Tel&eacute;fono: </td>
            <td><? echo $html->input('CA.telefono', $infoCA[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Fax: </td>
            <td><? echo $html->input('CA.fax', $infoCA[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Email: </td>
            <td><? echo $html->input('CA.email', $infoCA[0]['email'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Direcci&oacute;n: </td>
            <td><? echo $html->input('CA.direccion', $infoCA[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Pa&iacute;s: </td>
            <td><? echo $html->select('Org.id_pais',array('options'=>$listaP, 'selected' => $infoCA[0]['id_pais'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Estado: </td>
            <td><? echo $html->select('id_estado',array('options'=>$listaE, 'selected' => $infoCA[0]['id_estado'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Municipio: </td>
            <td>
                <div id="mcpo">
                    <? echo $html->select('id_municipio',array('options'=>$listaM, 'selected' => $infoCA[0]['id_municipio'], 'default' => 'Seleccione'))?>
                </div>
            </td>
        </tr>
        <tr>
            <td>C&oacute;digo Postal: </td>
            <td><? echo $html->input('CA.id_codigo_postal', $infoCA[0]['id_codigo_postal'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Coordenadas UTM: </td>
            <td><? echo $html->input('CA.coordenadas_utm', $infoCA[0]['coordenadas_utm'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <? if($ocultarCantidad){ ?>
        <tr>
            <td><span class="msj_rojo">* </span>Cantidad de Silos: </td>
            <td><? echo $html->select('cant_silos',array('options'=>$cantSilos, 'default' => 'Seleccione'))?></td>
        </tr>
        <? } ?>
        <tr>
            <td><span class="msj_rojo">* </span>Estatus: </td>
            <td><? echo $html->select('CA.estatus',array('options'=>$estatus, 'selected' => $infoCA[0]['estatus'], 'default' => 'Seleccione'))?></td>
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
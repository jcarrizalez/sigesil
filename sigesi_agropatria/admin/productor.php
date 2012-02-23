<?
    require_once('../lib/core.lib.php');
    
    $org = new Organizacion();
    
    $listaOrg = $org->find('','', array('id', 'nombre'), 'list', 'id');
    
    $productor = new Productor();
    
    switch($GPC['ac']){
        case 'guardar':
            if(!empty($GPC['Prod']['nombre'])){
                $productor->save($GPC['Prod']);
                $id = $productor->id;
                if(!empty($id)){
                    header("location: productor_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: productor_listado.php?msg=error");
                    die();
                }
            }
        break;
        case 'editar':
            $infoProductor = $productor->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Prod.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'productor_listado.php';
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Prod.id', $infoProductor[0]['id'], array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO PRODUCTOR<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Organizaci&oacute;n: </td>
            <td><? echo $html->select('Prod.id_org',array('options'=>$listaOrg, 'selected' => $infoProductor[0]['id_org'], 'default' => 'Seleccione'))?></td>
        </tr>
        <tr>
            <td><? echo $html->input('Prod.id_sap', $infoProductor[0]['id_sap'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><? echo $html->input('Prod.codigo', $infoProductor[0]['codigo'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><? echo $html->input('Prod.nombre', $infoProductor[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td><? echo $html->input('Prod.rif', $infoProductor[0]['rif'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>        
        <tr>            
            <td><? echo $html->input('Prod.telefono', $infoProductor[0]['telefono'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>            
            <td><? echo $html->input('Prod.fax', $infoProductor[0]['fax'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>            
            <td><? echo $html->input('Prod.mail', $infoProductor[0]['mail'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>            
            <td><? echo $html->input('Prod.direccion', $infoProductor[0]['direccion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>            
            <td><? echo $html->input('Prod.id_pais', $infoProductor[0]['id_pais'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr> 
        <tr>            
            <td><? echo $html->input('Prod.id_estado', $infoProductor[0]['id_estado'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>            
            <td><? echo $html->input('Prod.id_municipio', $infoProductor[0]['id_municipio'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>   
        <tr>            
            <td><? echo $html->input('Prod.id_municipio', $infoProductor[0]['id_municipio'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr> 
        <tr>            
            <td><? echo $html->input('Prod.coordenadas_utm', $infoProductor[0]['coordenadas_utm'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
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
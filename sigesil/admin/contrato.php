<?
require_once('../lib/core.lib.php');

$contrato = new Contrato();
$cosecha = new Cosecha();

$listaNacion = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');
$idCA = $_SESSION['s_ca_id'];
    
$listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
foreach($listadoCosechas as $valor){
    $listadoC[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
}

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Contrato']['nro_contrato']) && !empty($GPC['Contrato']['id_cosecha']) && !empty($GPC['Contrato']['id_productor'])) {
            $GPC['Contrato']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $contrato->save($GPC['Contrato']);
            $id = $contrato->id;
        }
        if (!empty($id)) {
            header("location: contrato_listado.php?msg=exitoso");
            die();
        } else {
            header("location: contrato_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        $infoContrato = $contrato->buscarContrato($GPC['id']);
        break;
}

require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Contrato.id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('productor', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Contrato.nro_contrato', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Contrato.toneladas_rec', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->setRules('Contrato.toneladas_con', array('digits' => array('value' => true, 'message' => 'Solo N&uacute;meros')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'contrato_listado.php';
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#productor').live('change', function(){
            var cosecha = $('#Contrato\\[id_cosecha\\]').val();
            var ced_rif = $('#nacionalidad').val() + $(this).val();
            if($(this).val() != ''){
                if(cosecha == ''){
                    alert('Debe elegir primero una cosecha');
                    $(this).val('');
                }else{
                    $('#tdPro').load('../ajax/detalle_contrato.php?ac=validar&co='+cosecha+'&cpro='+ced_rif);
                }
            }
        });
        
        $('#Contrato\\[nro_contrato\\]').live('change', function(){
            if($(this).val() != ''){
                $('#tdNro').load('../ajax/detalle_contrato.php?ac=buscar&nro='+$(this).val());
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Contrato.id', $infoContrato[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        CONTRATO<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cosecha </td>
            <td><? echo $html->select('Contrato.id_cosecha', array('options' => $listadoC, 'selected' => $infoContrato[0]['id_cosecha'], 'default' => 'Seleccione', 'class' => 'estilo_campos')) ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cedula/Rif </td>
            <td id="tdPro">
                <?
                    echo $html->select('nacionalidad',array('options'=>$listaNacion, 'selected' => substr(trim($infoContrato[0]['ced_rif']), 0, 1)));
                    echo "&nbsp;".$html->input('productor', substr(trim($infoContrato[0]['ced_rif']), 1), array('type' => 'text', 'length' => '10', 'class' => 'positive', 'style' => 'width:152px'));
                    
                    if($GPC['ac'] == 'editar'){
                        ?>
                        <tr>
                            <td><span class="msj_rojo">* </span>Nombre </td>
                            <td>
                                <?
                                    echo $html->input('nombre_pro', $infoContrato[0]['nombre'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos', 'style' => 'width:152'));
                                    echo $html->input('Contrato.id_productor', $infoContrato[0]['id'], array('type' => 'hidden'));
                                ?>
                            </td>
                        </tr>
                        <?
                    }
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Nro Contrato </td>
            <td id="tdNro"><? echo $html->input('Contrato.nro_contrato', $infoContrato[0]['nro_contrato'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Descripci&oacute;n </td>
            <td><? echo $html->input('Contrato.descripcion', $infoContrato[0]['descripcion'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <tr>
            <td>Ton. Recibidas </td>
            <td><? echo $html->input('Contrato.toneladas_rec', $infoContrato[0]['toneladas_rec'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>Ton. Contratadas </td>
            <td><? echo $html->input('Contrato.toneladas_con', $infoContrato[0]['toneladas_con'], array('type' => 'text', 'class' => 'estilo_campos positive')); ?></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
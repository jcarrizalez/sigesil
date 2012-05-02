<?
    require_once('../lib/core.lib.php');

    $productor = new Productor();
    $cosecha = new Cosecha();

    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    
    foreach($listadoCosechas as $valor){
        $cosechas[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Programa']['codigo']) && !empty($GPC['Programa']['nombre']) && !empty($GPC['Programa']['estatus'])) {
            $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $cosecha->_begin_tool();
            $cosecha->save($GPC['Programa']);
            
        }
        if (!empty($programaID)) {
            $cosecha->_commit_tool();
            header("location: cosecha_productor.php?msg=exitoso");
            die();
        } else {
            header("location: cosecha_productor.php?msg=error");
            die();
        }
    break;
}
require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Data.id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Data.id_productor', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'cosecha_productor.php';
    }
    
    $(document).ready(function(){
        $('#Data\\[id_cosecha\\]').change(function(){
            if($(this).val() != ''){
                show_div_loader();
                $('#tdPro').load('../ajax/cosecha_programa.php?ac=cos_pro&co='+$(this).val());
                $('#asociados').html('');
            }
        });
        $('#Data\\[id_productor\\]').live('change', function(){
            var cosecha = $('#Data\\[id_cosecha\\]').val();
            var asociacion = $('#Data\\[id_asociacion\\]').val();
            if($(this).val() != ''){
                if(cosecha == ''){
                    alert('Debe elegir primero una cosecha');
                    $(this).val('');
                }else if(asociacion == $(this).val()){
                    alert('La Cedula/Rif no puede ser igual a la de la Asociacion');
                    $(this).val('');
                }else{
                    show_div_loader();
                    $('#tdAon').load('../ajax/cosecha_programa.php?ac=cos_aon&co='+cosecha+'&cpro='+$(this).val());
                    $('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co='+cosecha+'&cpro='+$(this).val()+'&caon='+asociacion);
                }
            }
        });
        
        $('#Data\\[id_asociacion\\]').live('change', function(){
            var cosecha = $('#Data\\[id_cosecha\\]').val();
            var productor = $('#Data\\[id_productor\\]').val();
            if(cosecha == ''){
                alert('Debe elegir primero una cosecha');
                $(this).val('');
            }else if(productor == $(this).val()){
                alert('La Cedula/Rif no puede ser igual a la del Productor');
                $(this).val('');
            }else{
                show_div_loader();
                $('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co='+cosecha+'&cpro='+productor+'&caon='+$(this).val());
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Programa.id', $infoPrograma[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('numeroCosecha', 1, array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ASIGNAR PRODUCTORES POR COSECHA<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Productor</legend>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><span class="msj_rojo">* </span>Cosecha </td>
                <td><? echo $html->select('Data.id_cosecha', array('options' => $cosechas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Productor </td>
                <td id="tdPro"><? echo $html->select('Data.id_productor', array('options' => $productores, 'default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
            </tr>
            <tr>
                <td>Asociaci&oacute;n </td>
                <td id="tdAon"><? echo $html->select('Data.id_asociacion', array('options' => $productores, 'default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos del Asociado</legend>
        <table align="center" border="0" width="100%">
            <tbody id="asociados"></tbody>
        </table>
    </fieldset>
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
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
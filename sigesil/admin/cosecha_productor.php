<?
    require_once('../lib/core.lib.php');

    $cosecha = new Cosecha();
    $idCA = $_SESSION['s_ca_id'];

    $listadoCosechas = $cosecha->infoCosechaCultivo($idCA);
    
    foreach($listadoCosechas as $valor){
        $cosechas[$valor['cosecha_id']] = "(".$valor['cosecha_codigo'].") ".$valor['cultivo_nombre'];
    }

switch ($GPC['ac']) {
    case 'guardar':
        $guarda = false;
        if (!empty($GPC['id_cosecha']) && !empty($GPC['id_productor'])) {
            $GPC['id_asociacion'] = (!empty($GPC['id_asociacion'])) ? $GPC['id_asociacion'] : 0;
            
            $cosecha->eliminarCosechaProductor($GPC['id_cosecha'], $_SESSION['s_ca_id'], $GPC['id_productor'], $GPC['id_asociacion']);
            if(count($GPC['id_asociado']) > 0){
                for($i=0; $i<count($GPC['id_asociado']); $i++){
                    $cosecha->guardarCosechaProductor($GPC['id_cosecha'], $_SESSION['s_ca_id'], $GPC['id_productor'], $GPC['id_asociacion'], $GPC['id_asociado'][$i]);
                }
            }else
                $cosecha->guardarCosechaProductor($GPC['id_cosecha'], $_SESSION['s_ca_id'], $GPC['id_productor'], $GPC['id_asociacion']);
            
            $guarda = true;
        }
        if ($guarda) {
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
$validator->setRules('id_cosecha', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_productor', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'cosecha_productor.php';
    }
    
    $(document).ready(function(){
        $('#id_cosecha').change(function(){
            if($(this).val() != ''){
                show_div_loader();
                $('#id_productor').val('');
                $('#id_asociacion').val('');
                $('#tdPro').load('../ajax/cosecha_programa.php?ac=cos_pro&co='+$(this).val());
                $('#asociados').html('');
            }
        });
        $('#id_productor').live('change', function(){
            var cosecha = $('#id_cosecha').val();
            $("#id_asociacion")[0].selectedIndex = 0;
            if($(this).val() != ''){
                if(cosecha == ''){
                    alert('Debe elegir primero una cosecha');
                    $(this).val('');
                }else{
                    show_div_loader();
                    $('#tdAon').load('../ajax/cosecha_programa.php?ac=cos_aon&co='+cosecha+'&cpro='+$(this).val());
                    $('#asociados').load('../ajax/cosecha_programa.php?ac=cos_ado&co='+cosecha+'&cpro='+$(this).val());
                }
            }else{
                $('#id_asociacion').val('');
                $('#asociados').html('');
            }
        });
        
        $('#id_asociacion').live('change', function(){
            var cosecha = $('#id_cosecha').val();
            var productor = $('#id_productor').val();
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
    <div id="titulo_modulo">
        ASIGNAR PRODUCTORES POR COSECHA<br/><hr/>
    </div>
    <div id="mensajes">
        <?
            switch($GPC['msg']){
                case 'exitoso':
                    echo "<span class='msj_verde'>Registro Guardado !</span>";
                break;
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <fieldset>
        <legend>Datos del Productor</legend>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td><span class="msj_rojo">* </span>Cosecha </td>
                <td><? echo $html->select('id_cosecha', array('options' => $cosechas, 'default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Productor </td>
                <td id="tdPro"><? echo $html->select('id_productor', array('default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
            </tr>
            <tr>
                <td>Asociaci&oacute;n </td>
                <td id="tdAon"><? echo $html->select('id_asociacion', array('default' => 'Seleccione', 'class' => 'estilo_campos2')) ?></td>
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
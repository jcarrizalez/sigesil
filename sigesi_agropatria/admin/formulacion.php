<?
require_once('../lib/core.lib.php');

$formulas = new Formulas();
$cultivo = new Cultivo();

$idCA = $_SESSION['s_ca_id'];
$listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');

$listaMov = array(1 => 'Recepci&oacute;n', 2 => 'Despacho');
$listaCondicion = array(1 => 'Si', 2 => 'No');
$listaTipo = array(1 => 'An&aacute;lisis', 2 => 'Otro');
$parametros->listaParametros(1, 6);
$formulas->listaFormulas($idCA);

switch ($GPC['ac']) {
    case 'guardar':
        /*if (!empty($GPC['Cultivo']['id_org']) && !empty($GPC['Cultivo']['codigo']) && !empty($GPC['Cultivo']['nombre'])) {
            $GPC['Cultivo']['tipificado'] = (!empty($GPC['Cultivo']['tipificado'])) ? $GPC['Cultivo']['tipificado'] : 'f';
            $cultivo->save($GPC['Cultivo']);
            $id = $cultivo->id;
        }
        if (!empty($id)) {
            header("location: cultivo_listado.php?msg=exitoso");
            die();
        } else {
            header("location: cultivo_listado.php?msg=error");
            die();
        }*/
        break;
    case 'editar':
        //$infoCultivo = $cultivo->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('id_mov', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('tipo_for', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('multiple_cond', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('condicion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('formula_exp', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'formula_listado.php';
    }

    function asignarFormula(id, valor){
        var campo = $('#formula_exp_'+id).val();
        $('#formula_exp_'+id).attr('value', campo+valor);
        $('#formula_eval_'+id).attr('value', campo+valor);
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        $('input.operador').attr('disabled', true);
        
        $('#tipo_for').change(function(){
            var cul = $(this).val();
            if(cul == 1){
                $('#opciones').load('../ajax/detalle_formula.php?ac=tipo&cul='+cul);
                $('#eval_cond').css('display', 'none');
            }else if (cul == 2){
                $('#eval_cond').css('display', 'block');
                $('#opciones').html('');
            }else{
                $('#opciones').html('');
                $('#eval_cond').css('display', 'none');
            }
        });
        
        $('#multiple_cond').change(function(){
            var cond = $(this).val();
            if($('#tipo_for').val() != ''){
                if(cond == 1){
                    
                }
                /*if($('#tipo_for').val() == 1 && cond == 1){
                    $('#unica_formula').css('display', 'block');
                    $('#eval_cond').css('display', 'none');
                    $('#eval_cond2').css('display', 'none');
                    $('#otraformula').html('');
                    $('#btnCondicion').css('visibility', 'hidden');
                    $('#nroCondicion').val('1');
                }else if(cond == 2){
                    $('#nroCondicion').val(parseInt($('#nroCondicion').val())+1);
                    var nro = $('#nroCondicion').val();
                    var nombre = "multiple"+nro;
                    var tipoFor = $('#tipo_for').val();
                    otraform = "<fieldset id='"+nombre+"'></fieldset>";
                    nombre = '#'+nombre;
                    $('#otraformula').append(otraform);
                    $('#btnCondicion').css('visibility', 'visible');
                    $(nombre).load('../ajax/detalle_formula.php?ac=multiple&tipo='+tipoFor+'&nro='+nro);
                }else{
                    $('#multiple').css('display', 'none');
                    $('#multiple').html('');
                    $('#otraformula').html('');
                    $('#btnCondicion').css('display', 'hidden');
                    $('#nroCondicion').val('1');
                }*/
            }else{
                $("#multiple_cond option[value='']").attr("selected", "selected");
                alert('Seleccione un tipo de Formulacion');
            }
        });
        
        $('#agregarcon').click(function(){
            $('#nroCondicion').val(parseInt($('#nroCondicion').val())+1);
            var nro = $('#nroCondicion').val();
            var nombre = "multiple"+nro;
            var tipoFor = $('#tipo_for').val();
            otraform = "<fieldset id='"+nombre+"'></fieldset>";
            nombre = '#'+nombre;
            $('#otraformula').append(otraform);
            $(nombre).load('../ajax/detalle_formula.php?ac=multiple&tipo='+tipoFor+'&nro='+nro);
        });
    
        $('.form_exp').live("change", function(){
            var campo_id = $(this).attr('id').split('_');
            $('#formula_eval_'+campo_id[2]).val($(this).val());
        });
    
        $('.constante').live("click", function(){
            var valor = $(this).val();
            var campo_id = $(this).attr('id').split('_');
            var campo = $('#formula_exp_'+campo_id[2]).val();
            $('#formula_exp_'+campo_id[2]).attr('value', campo+valor);
            $('#formula_eval_'+campo_id[2]).attr('value', campo+valor);
        });
    
        $('.valores').live("change", function(){
            var id = $(this).attr('id').split('_');
            var campo_valor = $(this).val();
            var formula = $('#formula_eval_'+id[1]).val();
            var reemplazo = new RegExp(id[0],'g');
            if(campo_valor != ''){
                $('#formula_eval_'+id[1]).attr('value', formula.replace(reemplazo, campo_valor));
            }
        });
        
        $('.comprobar').live("click", function(){
            var id = $(this).attr('id').split('_');
            var formula = $('#formula_eval_'+id[1]).val();
            if(formula != ''){
                formula = ($('#formula_eval_'+id[1]).serialize());
                formula = formula.split('=');
                $("#resultado_"+id[1]).load('../ajax/detalle_formula.php?ac=formu&formula_eval='+formula[1]);
            }else
                $("#resultado_"+id[1]).html('');
        });
        
        $('.recuperar').live("click", function(){
            var id = $(this).attr('id').split('_');
            $("#td_"+id[1]+" :input").each(function(){
                $(this).attr('value', '');
            });
            $("#formula_eval_"+id[1]).val($("#formula_exp_"+id[1]).val());
            $("#resultado_"+id[1]).html('');
        });
    });
    
    function CondicionNueva(id){
        var campo_id = id.split('_');
        var campo_valor = document.getElementById(id).value;
        for(i=1; i < parseInt(campo_id[1]); i++){
            var comparar = document.getElementById('condhasta_'+i).value;
            if(i < campo_id[1]){
                if(campo_valor <= comparar){
                    alert('Esta condicion ya fue evaluada');
                    document.getElementById(id).value = '';
                    return false;
                }
            }
        }
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('nroCondicion', 1, array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        NUEVA F&Oacute;RMULA<br/><hr/>
    </div>
    <fieldset>
        <legend>Informaci&oacute;n del Cultivo</legend>
        <table align="center" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="130">Tipo de Movimiento:</td>
                <td><? echo $html->select('id_mov', array('options' => $listaMov, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tr>
                <td width="130">Cultivo:</td>
                <td><? echo $html->select('id_cultivo', array('options' => $listaCultivos, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tr>
                <td>Tipo de Formulaci&oacute;n:</td>
                <td><? echo $html->select('tipo_for', array('options' => $listaTipo, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tbody id="opciones"></tbody>
            <tr>
                <td>Condici&oacute;n &Uacute;nica:</td>
                <td>
                    <? echo $html->select('multiple_cond', array('options' => $listaCondicion, 'selected' => $GPC['condicion'], 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?>
                </td>
            </tr>
            <tbody id="btnCondicion" style="visibility: hidden">
                <tr>
                    <td>&nbsp;</td>
                <td>
                <? echo $html->input('agregarcon', 'Agregar Condici&oacute;n', array('type' => 'button')); ?>
                </td>
                </tr>
            </tbody>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
        </table>
    </fieldset>
    <fieldset id="unica_formula">
        <legend>F&oacute;rmula 1</legend>
        <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <span class="msj_rojo">* </span>C&oacute;digo de la Formula: 
                    <? echo $html->input('codigo', '', array('type' => 'text', 'length' => '10', 'class' => 'cuadricula')); ?>
                </td>
            </tr>
            <tr>
                <td align="center" style="padding: 10px 0;">
                    <?
                    foreach($parametros->lista as $parametro){
                        echo $html->input("btn_".$parametro['parametro_llave']."_1", $parametro['parametro_llave'], array('type' => 'button', 'class' => 'formula_campos constante'));
                    }
                    foreach($formulas->listaF as $formula){
                        echo $html->input("btn_".$formula['codigo']."_1", $formula['codigo'], array('type' => 'button', 'class' => 'formula_campos btnFormula', 'onClick' => "asignarFormula(1, '".$formula['formula']."')"));
                    }
                    ?>
                </td>
            </tr>
            <tr>
                <td>
                    <span id="eval_cond" style="display: none;">
                        <?
                            echo $html->input('otra_condicion', '', array('type' => 'text', 'style' => 'width: 100px')).":&nbsp;";
                            echo $html->input('desde1', '', array('type' => 'text', 'class' => 'positive', 'style' => 'width: 40px'));
                            echo "<&nbsp;&nbsp;".$html->input('hasta1', '', array('type' => 'text', 'class' => 'positive', 'style' => 'width: 40px'));
                        ?>
                    </span>
                    <span id="eval_cond2" style="display: none;">
                        <?
                            echo $html->input("desde1", '', array('type' => 'text', 'class' => 'positive', 'style' => 'width: 40px'));
                            echo "<&nbsp;&nbsp;".$html->input("hasta1", '', array('type' => 'text', 'class' => 'positive', 'style' => 'width: 40px'))."<br/>";
                        ?>
                    </span>
                    <? echo $html->input('formula_exp_1', $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp')); ?>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px 0;"><hr/></td>
            </tr>
            <tr>
                <th>COMPROBAR F&Oacute;RMULA<br/><br/></th>
            </tr>
            <tr>
                <td align="center" id="td_1" style="padding: 10px 0;">
                    <?
                    foreach($parametros->lista as $parametro){
                        echo $parametro['parametro_llave']."&nbsp;&nbsp;";
                        echo $html->input($parametro['parametro_llave']."_1", '', array('type' => 'text', 'length' => '7', 'class' => 'cuadricula valores positive'));
                    }
                    ?>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <? echo $html->input('formula_eval_1', '', array('type' => 'text', 'readOnly' => true, 'class' => 'campo_formula')); ?>
                </td>
            </tr>
            <tbody id="resultado_1"></tbody>
            <tr align="center">
                <td style="padding-top: 20px;">
                    <? echo $html->input('Comprobar_1', 'Comprobar', array('type' => 'button', 'class' => 'comprobar')); ?>
                    <? echo $html->input('Recuperar_1', 'Corregir Valores', array('type' => 'button', 'class' => 'recuperar')); ?>
                </td>
            </tr>
        </table>
    </fieldset>
    <!--fieldset id="multiple" style="display: none;"></fieldset-->
    <div id="otraformula"></div>
    <table align="center" width="100%">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
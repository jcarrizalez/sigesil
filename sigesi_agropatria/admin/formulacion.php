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
        if (!empty($GPC['Formula'])) {
            //Debug::pr($GPC['Formula']);
            $GPC['Formula']['id_org'] = $_SESSION['s_org_id'];
            $GPC['Formula']['id_centro_acopio'] = $_SESSION['s_ca_id'];

            /*$formulas->save($GPC['Formula']);
            $id = $formulas->id;*/
        }
        if (!empty($id)) {
            header("location: cultivo_listado.php?msg=exitoso");
            die();
        } else {
            header("location: cultivo_listado.php?msg=error");
            die();
        }
        break;
    case 'editar':
        //$infoCultivo = $cultivo->find(array('id' => $GPC['id']));
        break;
}
require('../lib/common/header.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Formula.id_mov', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Formula.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Formula.tipo_for', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Formula.id_analisis', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Formula.multiple_cond', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('condicion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('formula_exp', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function asignarFormula(id, valor){
        var campo = $('#formula_exp_'+id).val();
        $('#formula_exp_'+id).attr('value', campo+valor);
        $('#formula_eval_'+id).attr('value', campo+valor);
    }
    
    $(document).ready(function(){
        
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        
        $('#Cancelar').click(function(){
            window.location = 'formulacion.php';
            return false;
        });
        
        $('.field_formu').live('click', function(){
            $('.botonera').attr('disabled', true);
        });
        
        $('#Formula\\[tipo_for\\]').change(function(){
            var tipo = $(this).val();
            if(tipo == 1)
                $('#opciones').load('../ajax/detalle_formula.php?ac=tipo&cul='+tipo);
            else if (tipo == 2)
                $('#opciones').html('');
            else
                $('#opciones').html('');
        });
        
        $('#Formula\\[multiple_cond\\]').change(function(){
            var cond = $(this).val();
            var tipo = $('#Formula\\[tipo_for\\]').val();
            
            if(tipo != ''){
                if(cond == 1){
                    $('#unica_formula').css('display', 'block');
                    $('#otraformula').html('');
                    $('#eval_cond').load('../ajax/detalle_formula.php?ac=campos&tipo='+tipo+'&cond='+cond);
                    $('#nroCondicion').val(1);
                    $('#btnCondicion').css('visibility', 'hidden');
                }else if(cond == 2){
                    $('#eval_cond').load('../ajax/detalle_formula.php?ac=campos&tipo='+tipo+'&cond='+cond);
                    $('#unica_formula').css('display', 'block');
                    var nombre = "multiple"+nro;
                    $('#nroCondicion').val(parseInt($('#nroCondicion').val())+1);
                    var nro = $('#nroCondicion').val();
                    otraform = "<fieldset id='"+nombre+"'></fieldset>";
                    nombre = '#'+nombre;
                    $('#otraformula').append(otraform);
                    $('#btnCondicion').css('visibility', 'visible');
                    $(nombre).load('../ajax/detalle_formula.php?ac=multiple&tipo='+tipo+'&nro='+nro);
                }else{
                    $('#unica_formula').css('display', 'none');
                    $('#nroCondicion').val(1);
                    $('#otraformula').html('');
                    $('#btnCondicion').css('visibility', 'hidden');
                }
            }else{
                $("#Formula\\[multiple_cond\\] option[value='']").attr("selected", "selected");
                alert('Seleccione un tipo de Formulacion');
            }
        });
        
        $('#agregarcon').click(function(){
            $('#nroCondicion').val(parseInt($('#nroCondicion').val())+1);
            var nro = $('#nroCondicion').val();
            var nombre = "multiple"+nro;
            var tipoFor = $('#Formula\\[tipo_for\\]').val();
            otraform = "<fieldset id='"+nombre+"'></fieldset>";
            nombre = '#'+nombre;
            $('#otraformula').append(otraform);
            $(nombre).load('../ajax/detalle_formula.php?ac=multiple&tipo='+tipoFor+'&nro='+nro);
        });
    
        $('.form_exp').live("change", function(){
            var campo_id = $(this).attr('id').split('_');
            $('#formula_eval_'+campo_id[2]).val($(this).val());
        });
    
        $('.constante').live('click', function(){
            var valor = $(this).val();
            var campo_id = $(this).attr('id').split('_');
            var campo = $('#formula_exp_'+campo_id[2]).val();
            $('#formula_exp_'+campo_id[2]).attr('value', campo+valor);
            $('#formula_eval_'+campo_id[2]).attr('value', campo+valor);
        });
    
        $('.valores').live('change', function(){
            var id = $(this).attr('id').split('_');
            var campo_valor = $(this).val();
            var formula = $('#formula_eval_'+id[1]).val().toUpperCase();
            var reemplazo = new RegExp(id[0],'g');
            if(campo_valor != ''){
                $('#formula_eval_'+id[1]).attr('value', formula.replace(reemplazo, campo_valor));
            }
            
            if($('#Formula\\[tipo_for\\]').val() == 2){
                var campo_cond = $('#condicion_eval').val().toUpperCase();
                if(campo_cond != '')
                    $('#condicion_eval').attr('value', campo_cond.replace(reemplazo, campo_valor));
            }
        });
        
        $('#otra_condicion_1').live('keypress', function(){
            if($('#Formula\\[tipo_for\\]').val() == 2){
                var cond_formu = $(this).val();
                $('#condicion_eval').val(cond_formu);
                $('.otra_con').each(function(){
                    $(this).val(cond_formu);
                });
            }
        });
        
        $('.comprobar').live('click', function(){
            var id = $(this).attr('id').split('_');
            var formula = $('#formula_eval_'+id[1]).val();
            if($('#Formula\\[tipo_for\\]').val() == 2 && $('#otra_condicion_1').val() == ''){
                alert('Evalue una Condicion');
                $('#otra_condicion_1').focus();
            }else if($('#desde_'+id[1]).val() == '' || $('#hasta_'+id[1]).val() == '')
                alert('Complete la Condicion');
            else if(formula != ''){
                formula = ($('#formula_eval_'+id[1]).serialize());
                formula = formula.split('=');
                $("#resultado_"+id[1]).load('../ajax/detalle_formula.php?ac=formu&formula_eval='+formula[1]);
            }else{
                alert('Ingrese una Formula');
                $("#resultado_"+id[1]).html('');
                $('#formula_exp_'+id[1]).focus();
            }
        });
        
        $('.recuperar').live('click', function(){
            var id = $(this).attr('id').split('_');
            $("#td_"+id[1]+" :input").each(function(){
                $(this).attr('value', '');
            });
            $("#formula_eval_"+id[1]).val($("#formula_exp_"+id[1]).val());
            $("#resultado_"+id[1]).html('');
            $("#Comprobar_"+id[1]).attr('disabled', false);
            if(id[1] == 1)
                $('#condicion_eval').val($('#otra_condicion_1').val());
        });
        
        $('.rango').live('change', function(){
            id_verif = $(this).attr('id');
            campo_verif = $(this);
            $(".rango").each(function(){
                if(id_verif != $(this).attr('id')){
                    if(campo_verif.val() <= $(this).val()){
                        alert("Condicion ya evaluada");
                        campo_verif.val('');
                        campo_verif.addClass('error');
                        return false;
                    }else{
                        campo_verif.removeClass('error');
                    }
                }
            });
        });
        
        $('#form1').submit(function(e){
            var id = 1;
            var listo = 0;
            var total = $('.comprobar').size();
            var enviar = false;
            $(".verif_resul").each(function(){
                if($(this).children().length > 0){
                    if($(this).children().find('th').attr('class') == 'msj_verde'){
                        listo++;
                        $('#Comprobar_'+id).attr('disabled', true);
                    }else{
                        alert('Verifique el resultado de las formulas');
                        e.preventDefault();
                        return false;
                    }
                }else{
                    alert('Compruebe todas las formulas');
                    e.preventDefault();
                    return false;
                }
                id++;
            });
            if(total == listo){
                $(".rango").each(function(){
                    if($(this).val() == ''){
                        enviar = false;
                        alert('Complete las Condiciones');
                        $(this).focus();
                        e.preventDefault();
                        return false;
                    }else
                        enviar = true;
                });
            }
            
            if($('#Formula\\[tipo_for\\]').val() == 1 && $('#Formula\\[multiple_cond\\]').val() == 1 && total == listo)
                $('.botonera').removeAttr('disabled');
            else if($('#Formula\\[tipo_for\\]').val() == 1 && $('#Formula\\[multiple_cond\\]').val() == 2 && total == listo && enviar == true)
                $('.botonera').removeAttr('disabled');
            else if ($('#Formula\\[tipo_for\\]').val() == 2 && total == listo && enviar == true)
                $('.botonera').removeAttr('disabled');
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('nroCondicion', 1, array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        F&Oacute;RMULA<br/><hr/>
    </div>
    <fieldset>
        <legend>Informaci&oacute;n del Cultivo</legend>
        <table align="center" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="130">Tipo de Movimiento:</td>
                <td><? echo $html->select('Formula.id_mov', array('options' => $listaMov, 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?></td>
            </tr>
            <tr>
                <td width="130">Cultivo:</td>
                <td><? echo $html->select('Formula.id_cultivo', array('options' => $listaCultivos, 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?></td>
            </tr>
            <tr>
                <td>Tipo de Formulaci&oacute;n:</td>
                <td><? echo $html->select('Formula.tipo_for', array('options' => $listaTipo, 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?></td>
            </tr>
            <tbody id="opciones"></tbody>
            <tr>
                <td>Condici&oacute;n &Uacute;nica:</td>
                <td>
                    <? echo $html->select('Formula.multiple_cond', array('options' => $listaCondicion, 'selected' => $GPC['condicion'], 'default' => 'Seleccione', 'class' => 'inputGrilla botonera')) ?>
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
    <fieldset id="unica_formula" style="display: none;" class="field_formu">
    <!--fieldset id="unica_formula"-->
        <legend>F&oacute;rmula 1</legend>
        <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <span class="msj_rojo">* </span>C&oacute;digo de la Formula: 
                    <? echo $html->input('codigo', '', array('type' => 'text', 'length' => '10')); ?>
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
                <td align="left">
                    <span id="eval_cond"></span>
                    <? echo $html->input('formula_exp_1', $GPC['formula'], array('type' => 'text', 'class' => 'campo_formula form_exp')); ?>
                </td>
            </tr>
            <tr>
                <td style="padding: 10px 0;"><hr/></td>
            </tr>
            <tr>
                <th>Comprobar F&oacute;rmula<br/><br/></th>
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
            <tbody id="resultado_1" class="verif_resul"></tbody>
            <tr align="center">
                <td style="padding-top: 20px;">
                    <? echo $html->input('Comprobar_1', 'Comprobar', array('type' => 'button', 'class' => 'comprobar')); ?>
                    <? echo $html->input('Recuperar_1', 'Corregir Valores', array('type' => 'button', 'class' => 'recuperar')); ?>
                </td>
            </tr>
        </table>
    </fieldset>
    <div id="otraformula" class="field_formu"></div>
    <table align="center" width="100%">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td>
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'button')); ?>
            </td>
        </tr>
    </table>
</form>
<?
require('../lib/common/footer.php');
?>
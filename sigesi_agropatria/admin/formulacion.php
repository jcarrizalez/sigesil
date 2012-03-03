<?
require_once('../lib/core.lib.php');

$formulas = new Formulas();
$cultivo = new Cultivo();

$idCA = $_SESSION['s_ca_id'];
$listaCultivos = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');

$listaCondicion = array(1 => 'Si', 2 => 'No');
$parametros->listaParametros(1, 6);
$formulas->listaFormulas($idCA);

/*$phrase  = "You should eat fruits, vegetables, and fiber every day.";
$healthy = array("fruits", "vegetables", "fiber");
$yummy   = array("pizza", "beer", "ice cream");
$newphrase = str_replace($healthy, $yummy, $phrase);*/

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
$validator->setRules('id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('condicion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('formula_exp', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'formula_listado.php';
    }

    function asignarFormula(valor){
        var campo = $('#formula_exp').val();
        $('#formula_exp').attr('value', campo+valor);
        $('#formula_eval').attr('value', campo+valor);
        $('#para').attr('disabled', true);
        $('#parc').attr('disabled', false);
        $('input.operador').attr('disabled', false);
        $('input.constante').attr('disabled', true);
        $('input.btnFormula').attr('disabled', true);
    }
    
    $(document).ready(function(){
        $(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
        $('input.operador').attr('disabled', true);
        
        $('#id_cultivo').change(function(){
            var cul = $(this).val();
            if(cul != '')
                $('#opciones').load('../ajax/cosecha_programa.php?ac=formu&cul='+cul);
            else
                $('#opciones').html('');
        });
        
        $('#multiple_cond').change(function(){
            var cond = $(this).val();
            if(cond != '' && cond != 1)
                $('#multiple').css('display', 'block');
            else
                $('#multiple').css('display', 'none');
        });
        
        $('.parentesis').click(function(){
            var valor = $(this).val();
            var campo = $('#formula_exp').val();
            if(valor == '('){
                $('#formula_exp').attr('value', campo+valor);
                $('#formula_eval').attr('value', campo+valor);
                $('#parc').attr('disabled', true);
                $('input.operador').attr('disabled', true);
                $('#agregar').attr('disabled', false);
                $('#numero').attr('disabled', false);
                $('input.constante').attr('disabled', false);
                $('input.btnFormula').attr('disabled', false);
            }else if (valor == ')' && campo == ''){
                alert('Abra un parentesis o elija una constante');
            }else{
                $('#formula_exp').attr('value', campo+valor);
                $('#formula_eval').attr('value', campo+valor);
                $('input.operador').attr('disabled', false);
                $('#agregar').attr('disabled', true);
                $('#numero').attr('disabled', true);
                $('input.constante').attr('disabled', false);
                $('input.btnFormula').attr('disabled', false);
            }
        });
        
        $('#borrar').click(function(){
            contenido = $('#formula_exp').val();
            $('.valores').attr('value', '');
            $('#formula_exp').attr('value', '');
            $('#formula_eval').attr('value', '');
            $('input.parentesis').attr('disabled', false);
            $('input.operador').attr('disabled', true);
            $('#agregar').attr('disabled', false);
            $('#numero').attr('disabled', false);
            $('input.constante').attr('disabled', false);
            $('input.btnFormula').attr('disabled', false);
            $("#resultado").html('');
        });
        
        $('#agregar').click(function(){
            var valor = $('#numero').val();
            var campo = $('#formula_exp').val();
            if(valor != ''){
                $('#formula_exp').attr('value', campo+valor);
                $('#formula_eval').attr('value', campo+valor);
                $('#para').attr('disabled', true);
                $('#parc').attr('disabled', false);
                $('input.operador').attr('disabled', false);
                $('#agregar').attr('disabled', true);
                $('#numero').val('');
                $('#numero').attr('disabled', true);
                $('input.constante').attr('disabled', true);
                $('input.btnFormula').attr('disabled', true);
            }else{
                alert('Valor Invalido');
            }
        });
        
        $('.constante').click(function(){
            var valor = $(this).val();
            var campo = $('#formula_exp').val();
            $('#formula_exp').attr('value', campo+valor);
            $('#formula_eval').attr('value', campo+valor);
            $('#para').attr('disabled', true);
            $('#parc').attr('disabled', false);
            $('input.operador').attr('disabled', false);
            $('#agregar').attr('disabled', true);
            $('#numero').val('');
            $('#numero').attr('disabled', true);
            $('input.constante').attr('disabled', true);
            $('input.btnFormula').attr('disabled', true);
        });
        
        $('.operador').click(function(){
            var valor = $(this).val();
            var campo = $('#formula_exp').val();
            $('#formula_exp').attr('value', campo+valor);
            $('#formula_eval').attr('value', campo+valor);
            $('input.parentesis').attr('disabled', false);
            $('input.operador').attr('disabled', true);
            $('#agregar').attr('disabled', false);
            $('#numero').attr('disabled', false);
            $('input.constante').attr('disabled', false);
            $('input.btnFormula').attr('disabled', false);
        });
        
        $('.valores').change(function(){
            var id = $(this).attr('id');
            var campo_valor = $(this).val();
            var formula = $('#formula_eval').val();
            var reemplazo = new RegExp(id,'g');
            if(campo_valor != ''){
                $('#formula_eval').attr('value', formula.replace(reemplazo, campo_valor));
                //$(this).attr('disabled', true);
            }
        });
        
        $('#Recuperar').click(function(){
            $('.valores').attr('value', '');
            $('.valores').attr('disabled', false);
            $('#formula_eval').val($('#formula_exp').val());
            $("#resultado").html('');
        });
        
        $('#Comprobar').click(function(){
            var formula = $('#formula_eval').val();
            var resultado;
            $("#resultado").html('');
            if(formula != ''){
                //FALTA VERIFICAR QUE EXISTA LA MISMA CANTIDAD DE PARENTESIS EN LA FORMULA
                var total = eval(formula).toFixed(3);
                if(total < 0){
                    resultado = "<tr><th colspan='3' class='error' align='center'><h3>El resultado debe ser Mayor o igual a Cero (0)";
                }else{
                    resultado = "<tr><th colspan='3' class='msj_verde' align='center'><h3>El resultado es: "+total;
                }
                    resultado += "</h3></th></tr>";
                    $("#resultado").append(resultado);
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        NUEVA F&Oacute;RMULA<br/><hr/>
    </div>
    <fieldset>
        <legend>Informaci&oacute;n del Cultivo</legend>
        <table align="center" width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="110">Cultivo: </td>
                <td><? echo $html->select('id_cultivo', array('options' => $listaCultivos, 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tbody id="opciones"></tbody>
            <tr>
                <td>Condici&oacute;n &Uacute;nica: </td>
                <td><? echo $html->select('multiple_cond', array('options' => $listaCondicion, 'selected' => $GPC['condicion'], 'default' => 'Seleccione', 'class' => 'inputGrilla')) ?></td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Operadores Matem&aacute;ticos</legend>
        <table align="center" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <? echo $html->input('para', '(', array('type' => 'button', 'class' => 'parentesis')); ?>
                    <? echo $html->input('parc', ')', array('type' => 'button', 'class' => 'parentesis')); ?>
                    <? echo $html->input('sum', '+', array('type' => 'button', 'class' => 'operador')); ?>
                    <? echo $html->input('res', '-', array('type' => 'button', 'class' => 'operador')); ?>
                    <? echo $html->input('mul', '*', array('type' => 'button', 'class' => 'operador')); ?>
                    <? echo $html->input('div', '/', array('type' => 'button', 'class' => 'operador')); ?>
                    <? echo $html->input('borrar', 'Borrar', array('type' => 'button')); ?>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </fieldset>
    <!---->
    <fieldset id="multiple" style="display: none;">
    <!--fieldset id="multiple"-->
        <legend>Condiciones a Evaluar</legend>
        <table align="center" border="0" cellpadding="0" cellspacing="0">
            <? for($k = 1; $k <= 2; $k++ ){ ?>
            <tr>
            <th width="100">Condicion Nro <?=$k?></th>
            <td>
                <? echo "-&nbsp;&nbsp;Desde ".$html->input('input_condi'.$k, '', array('type' => 'text', 'length' => '7', 'class' => 'formula_campos positive')); ?>
                <? echo "Hasta ".$html->input('input_condi'.$k, '', array('type' => 'text', 'length' => '7', 'class' => 'formula_campos positive')); ?>
                <? echo "Desc ".$html->input('input_condi'.$k, '', array('type' => 'text', 'length' => '7', 'class' => 'formula_campos positive')); ?>
            </td>
            </tr>
            <? } ?>
        </table>
    </fieldset>
    <!---->
    <fieldset>
        <legend>F&oacute;rmula</legend>
        <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0" class="tabla_formula">
            <tr>
                <td colspan="3">
                    <span class="msj_rojo">* </span>C&oacute;digo de la Formula: 
                    <? echo $html->input('codigo', '', array('type' => 'text', 'length' => '3', 'class' => 'cuadricula')); ?>
                </td>
            </tr>
            <tr>
                <th width="355">&nbsp;</th>
                <th align="center" width="1">Constante</th>
                <th align="center">Descripci&oacute;n</th>
            </tr>
            <tr class="segundaclase">
                <td rowspan="<?=count($parametros->lista)+count($formulas->listaF)+1?>" align="center">
                    <textarea name="formula_exp" id="formula_exp" readOnly="true"><?=$GPC['formula']?></textarea>
                </td>
                <td align="center"><? echo $html->input('agregar', '<-', array('type' => 'button', 'class' => 'formula_campos')); ?></td>
                <td align="center"><? echo $html->input('numero', '', array('type' => 'text', 'length' => '7', 'class' => 'formula_campos positive')); ?></td>
            </tr>
            <?
                $i=1;
                foreach($parametros->lista as $parametro){
                    $clase = $general->obtenerClaseFila($i);
            ?>
            <tr class="<?=$clase?>">
                <td align="center"><? echo $html->input($parametro['parametro_llave'], $parametro['parametro_llave'], array('type' => 'button', 'class' => 'formula_campos constante')); ?></td>
                <td align="center"><?=$parametro['parametro_valor']?></td>
            </tr>
            <? $i++; } ?>
            <?
                foreach($formulas->listaF as $formula){
                    $clase = $general->obtenerClaseFila($i);
            ?>
            <tr class="<?=$clase?>">
                <td align="center"><? echo $html->input($formula['codigo'], $formula['codigo'], array('type' => 'button', 'class' => 'formula_campos btnFormula', 'onClick' => "asignarFormula('".$formula['formula']."')")); ?></td>
                <td align="center"><?=$formula['formula']?></td>
            </tr>
            <? $i++; } ?>
            <tr>
                <td colspan="3">&nbsp;</td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Comprobar F&oacute;rmula</legend>
        <table align="center" border="0" width="100%" cellpadding="0" cellspacing="0" class="tabla_formula">
            <?
                $j=0;
                foreach($parametros->lista as $parametro){
                    $clase = $general->obtenerClaseFila($j);
            ?>
            <tr class="<?=$clase?>">
                <td align="center" width="1"><? echo $parametro['parametro_llave']; ?>&nbsp;</td>
                <td width="70"><? echo $html->input($parametro['parametro_llave'], '', array('type' => 'text', 'length' => '7', 'class' => 'cuadricula valores positive')); ?></td>
                <? if($parametro['parametro_llave'] == 'PL1'){ ?>
                <td rowspan="<?=count($parametros->lista)?>" align="center">
                    <textarea name="formula_eval" id="formula_eval" readOnly="true"></textarea>
                </td>
            <? } ?>
            </tr>
            <? $j++; } ?>
            <tr>
            <tbody id="resultado"></tbody>
            <tr align="center">
                <td colspan="3" style="padding-top: 20px;">
                    <? echo $html->input('Comprobar', 'Comprobar', array('type' => 'button')); ?>
                    <? echo $html->input('Recuperar', 'Corregir Valores', array('type' => 'button')); ?>
                </td>
            </tr>
        </table>
    </fieldset>
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
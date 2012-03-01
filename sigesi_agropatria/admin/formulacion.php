<?
require_once('../lib/core.lib.php');

$formulas = new Formulas();

$idCA = $_SESSION['s_ca_id'];

$parametros->listaParametros(1, 6);
$formulas->listaFormulas($idCA);
//echo "<pre>"; print_r($parametros->lista); echo "<pre>";

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
    }
    
    $(document).ready(function(){
        $('.operador').click(function(){
            var valor = $(this).val();
            var campo = $('#formula_exp').val();
            if((valor == '+' || valor == '-' || valor == '*'|| valor == '/' || valor == ')') && campo == '')
                alert('Primero Ingrese una Constante');
            else
                $('#formula_exp').attr('value', campo+valor);
        });
        
        $('.constante').click(function(){
            var valor = $(this).val();
            var campo = $('#formula_exp').val();
            $('#formula_exp').attr('value', campo+valor);
        });
        
        $('#borrar').click(function(){
            contenido = $('#formula_exp').val();
            $('#formula_exp').attr('value', '');
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Cultivo.id', $infoCultivo[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        NUEVA F&Oacute;RMULA<br/><hr/>
    </div>
    <fieldset>
        <legend>Operadores Matem&aacute;ticos</legend>
        <table align="center" width="100%" cellpadding="0" cellspacing="0">
            <tr>
                <td align="center">
                    <? echo $html->input('para', '(', array('type' => 'button', 'class' => 'operador')); ?>
                    <? echo $html->input('parc', ')', array('type' => 'button', 'class' => 'operador')); ?>
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
    <fieldset>
        <legend>F&oacute;rmula</legend>
        <table align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
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
            <?
                $i=0;
                foreach($parametros->lista as $parametro){
                    $clase = $general->obtenerClaseFila($i);
            ?>
            <tr class="<?=$clase?>">
            <? if($parametro['parametro_llave'] == 'PL1'){ ?>
                <td rowspan="<?=count($parametros->lista)+count($formulas->listaF)?>" align="center">
                    <textarea name="formula_exp" id="formula_exp" readOnly="true"><?=$GPC['formula']?></textarea>
                </td>
            <? } ?>
                <td align="center"><? echo $html->input($parametro['parametro_llave'], $parametro['parametro_llave'], array('type' => 'button', 'class' => 'btnFormula constante')); ?></td>
                <td align="center"><?=$parametro['parametro_valor']?></td>
            </tr>
            <? $i++; } ?>
            <?
                $mostrar = true;
                foreach($formulas->listaF as $formula){
                    $clase = $general->obtenerClaseFila($i);
            ?>
            <tr class="<?=$clase?>">
                <td align="center"><? echo $html->input($formula['codigo'], $formula['codigo'], array('type' => 'button', 'class' => 'btnFormula', 'onClick' => "asignarFormula('".$formula['formula']."')")); ?></td>
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
        <table align="center" border="0" width="100%">
            <? foreach($parametros->lista as $parametro){ ?>
            <tr>
                <td align="center" width="1"><? echo $parametro['parametro_llave']; ?></td>
                <td><? echo $html->input($parametro['parametro_llave'], '', array('type' => 'text', 'class' => 'cuadricula')); ?></td>
            </tr>
            <? } ?>
            <tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
        </table>
    </fieldset>
        <table align="center" width="100%">
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
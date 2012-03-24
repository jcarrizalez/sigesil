<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');

    $recepcion = new Recepcion();

    switch ($GPC['ac']) {
        case 'guardar':
            $GPC['Recepcion']['id'] = $GPC['id'];
            if (!empty($GPC['Recepcion']['id']) && (!empty($GPC['Recepcion']['romana_ent']) || !empty($GPC['Recepcion']['romana_sal'])) && (!empty($GPC['Recepcion']['peso_01l']) || !empty($GPC['Recepcion']['peso_01v']))) {
                if($GPC['mov'] == 'rec' && $GPC['estatus'] == '3'){
                    $GPC['Recepcion']['estatus_rec'] = ++$GPC['estatus'];
                    $GPC['Recepcion']['fecha_pel'] = "now()";
                }elseif($GPC['mov'] == 'des' && $GPC['estatus'] == '3'){
                    $GPC['Recepcion']['estatus_rec'] = $GPC['estatus']+2;
                    $GPC['Recepcion']['fecha_pel'] = "now()";
                }elseif($GPC['mov'] == 'rec' && $GPC['estatus'] == '6'){
                    $GPC['Recepcion']['estatus_rec'] = $GPC['estatus']+3;
                    $GPC['Recepcion']['fecha_v'] = "now()";
                }elseif($GPC['mov'] == 'des' && $GPC['estatus'] == '1'){
                    $GPC['Recepcion']['estatus_rec'] = $GPC['estatus']++;
                    $GPC['Recepcion']['fecha_v'] = "now()";
                }
                unset($GPC['Recepcion']['pesoLleno1']);
                unset($GPC['Recepcion']['pesoLleno2']);
                $recepcion->save($GPC['Recepcion']);
            }
            if (!empty($id)) {
                header("location: romana_listado.php?msg=exitoso&mov=".$GPC['mov']);
                die();
            } else {
                header("location: romana_listado.php?msg=error&mov=".$GPC['mov']);
                die();
            }
            break;
        case 'pesar':
            $romana = new Tolcarom();
            $infoRecepcion = $recepcion->listadoRecepcion($GPC['id']);
            $infoRomana = $romana->listaTolcarom($_SESSION['s_ca_id'], "'3'");
            foreach($infoRomana as $valor){
                $listaRomanas[$valor['id']] = $valor['nombre'];
            }

            $vehiculo = (!empty($infoRecepcion[0]['marca'])) ? $infoRecepcion[0]['marca']."/" : "Sin Marca/";
            $vehiculo .= $infoRecepcion[0]['placa'];
            $cultivo = trim($infoRecepcion[0]['cultivo_codigo'])." ".trim($infoRecepcion[0]['cultivo_nombre']);
            break;
    }

    $validator = new Validator('form1');
    $validator->printIncludes();
    if(($GPC['mov'] == 'rec' && $infoRecepcion[0]['estatus_rec'] == '3') || ($GPC['mov'] == 'des' && $infoRecepcion[0]['estatus_rec'] == '3')){
        $validator->setRules('Recepcion.romana_ent', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01l', array('required' => array('value' => true, 'message' => 'Requerido')));
    }elseif(($GPC['mov'] == 'rec' && $infoRecepcion[0]['estatus_rec'] == '6') || ($GPC['mov'] == 'des' && $infoRecepcion[0]['estatus_rec'] == '1')){
        $validator->setRules('Recepcion.romana_sal', array('required' => array('value' => true, 'message' => 'Requerido')));
        $validator->setRules('Recepcion.peso_01v', array('required' => array('value' => true, 'message' => 'Requerido')));
    }
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'romana_listado.php?mov=<?=$GPC['mov']?>';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
        
        $('.verifPeso').blur(function(){
            if($(this).val() != ''){
                var form = $('#form1').serialize();
                $("#resultado").load('../ajax/detalle_formula.php?ac=pesoromana&formula='+form);
            }
        });
        
        $('#Guardar').click(function(){
            var contador = 0;
            $(".verifPeso").each(function(){
                if($(this).val() == ''){
                    contador++;
                    $(this).focus();
                    return false;
                }else
                    contador = 0;
            });
            if(contador != 0){
                alert('Complete el Campo Vacio');
                return false;
            }else{
                if(!confirm('Desea Guardar'))
                    return false;
            }
        });
    });
</script>
<div id="titulo_modulo">
    ROMANA<br/><hr/>
</div>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?
        echo $html->input('id', $infoRecepcion[0]['id'], array('type' => 'hidden'));
        echo $html->input('estatus', $infoRecepcion[0]['estatus_rec'], array('type' => 'hidden'));
        echo $html->input('mov', $GPC['mov'], array('type' => 'hidden'));
    ?>
    <table align="center">
        <tr>
            <td>N&uacute;mero de Entrada</td>
            <td><? echo $html->input('entrada', $infoRecepcion[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Fecha de Recepci&oacute;n</td>
            <td><? echo $html->input('fecha', $general->date_sql_screen($infoRecepcion[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de Gu&iacute;a</td>
            <td><? echo $html->input('guia', $infoRecepcion[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Veh&iacute;culo</td>
            <td><? echo $html->input('vehiculo', $vehiculo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Chofer</td>
            <td><? echo $html->input('chofer', $infoRecepcion[0]['chofer_nombre'], array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><? echo $html->input('cultivo', $cultivo, array('type' => 'text', 'class' => 'estilo_campos2', 'readOnly' => true)); ?></td>
        </tr>
        <?
            if(($GPC['mov'] == 'rec' && $infoRecepcion[0]['estatus_rec'] == '3') || ($GPC['mov'] == 'des' && $infoRecepcion[0]['estatus_rec'] == '3')){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><? echo $html->select('Recepcion.romana_ent', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?
            for($i=1; $i<=$infoRecepcion[0]['cant_muestras']; $i++){
                if($GPC['mov'] == 'des'){
        ?>
        <tr>
            <td>Peso de la Muestra <?=$i?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'l', '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <?
                }else{
        ?>
        <tr>
            <td>Peso de la Muestra <?=$i?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'l', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <?
                }
            }
        }elseif(($GPC['mov'] == 'rec' && $infoRecepcion[0]['estatus_rec'] == '6') || ($GPC['mov'] == 'des' && $infoRecepcion[0]['estatus_rec'] == '1')){
        ?>
        <tr>
            <td>Romana de Entrada</td>
            <td><? echo $html->input('romana_ent', $infoRecepcion[0]['romana_ent'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
        </tr>
        <tr>
            <td>Romana de Salida</td>
            <td><? echo $html->select('Recepcion.romana_sal', array('options' => $listaRomanas, 'default' => 'Seleccione', 'class' => 'estilo_campos')); ?></td>
        </tr>
        <?
            for($i=1; $i<=$infoRecepcion[0]['cant_muestras']; $i++){
        ?>
        <tr>
            <td>Peso Lleno Muestra <?=$i?></td>
            <td><? echo $html->input("Recepcion.pesoLleno$i", $infoRecepcion[0]['peso_0'.$i.'l'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?></td>
        </tr>
        <? if($GPC['mov'] == 'rec'){ ?>
        <tr>
            <td>Peso Vac&iacute;o <?=$i?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'class' => 'estilo_campos integer verifPeso')); ?></td>
        </tr>
        <? }else{ ?>
        <tr>
            <td>Peso Vac&iacute;o <?=$i?></td>
            <td><? echo $html->input('Recepcion.peso_0'.$i.'v', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <?
            }
            }
        }
        ?>
        <tbody id="resultado" class="verif_resul"></tbody>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr align="center">
            <td colspan="2">
                <?
                    echo $html->input('Guardar', 'Guardar', array('type' => 'submit'));
                    echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()'));
                ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
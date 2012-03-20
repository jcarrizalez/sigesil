<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');

    $recepcion = new Recepcion();

    switch ($GPC['ac']) {
        case 'guardar':
            if (!empty($GPC['romana']) && !empty($GPC['peso'])) {
                /*$GPC['Chofer']['id_estado'] = $GPC['id_estado'];
                $GPC['Chofer']['id_municipio'] = $GPC['id_municipio'];
                $GPC['Chofer']['ced_rif'] = $GPC['nacionalidad'] . $GPC['Chofer']['ced_rif'];
                $chofer->save($GPC['Chofer']);
                $id = $chofer->id;*/
            }
            if (!empty($id)) {
                header("location: chofer_listado.php?msg=exitoso");
                die();
            } else {
                header("location: chofer_listado.php?msg=error");
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
            //Debug::pr($infoRomana);
            $vehiculo = (!empty($infoRecepcion[0]['marca'])) ? $infoRecepcion[0]['marca']."/" : "Sin Marca/";
            $vehiculo .= $infoRecepcion[0]['placa'];
            break;
    }

    $validator = new Validator('form1');
    $validator->printIncludes();
    $validator->setRules('Chofer.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->setRules('Chofer.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
    $validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'romana_listado.php';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#id_estado').change(function(){
            $('#id_municipio').load('../ajax/division_pol.php?ac=mcpos&idE=' + $(this).val());
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <?// echo $html->input('id', $infoRecepcion[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ROMANA<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td>N&uacute;mero de Entrada</td>
            <td><? echo $html->input('entrada', $infoRecepcion[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
            <!--td>
                <?
                echo $html->select('nacionalidad', array('options' => $listaNacion, 'selected' => substr($infoRecepcion[0]['ced_rif'], 0, 1)));
                echo "&nbsp;" . $html->input('Chofer.ced_rif', trim(substr($infoRecepcion[0]['ced_rif'], 1)), array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                ?>
            </td-->
        </tr>
        <tr>
            <td>Fecha de Recepci&oacute;n</td>
            <td><? echo $html->input('fecha', $general->date_sql_screen($infoRecepcion[0]['fecha_recepcion'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de Gu&iacute;a</td>
            <td><? echo $html->input('guia', $infoRecepcion[0]['numero_guia'], array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
        </tr>
        <tr>
            <td>Veh&iacute;culo</td>
            <td><? echo $html->input('vehiculo', $vehiculo, array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
        </tr>
        <tr>
            <td>Chofer</td>
            <td><? echo $html->input('chofer', $infoRecepcion[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
        </tr>
        <tr>
            <td>Cultivo</td>
            <td><? echo $html->input('cultivo', $infoRecepcion[0]['cultivo_codigo'], array('type' => 'text', 'class' => 'estilo_campos', 'disabled' => true)); ?></td>
        </tr>
        <tr>
            <td>N&uacute;mero de Romana</td>
            <td><? echo $html->select('romana', array('options' => $listaRomanas, 'default' => 'Seleccione')); ?></td>
        </tr>
        <tr>
            <td>Peso del Veh&iacute;culo</td>
            <td><? echo $html->input('peso', '', array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
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
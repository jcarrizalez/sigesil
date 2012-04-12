<?
require_once('../lib/core.lib.php');

$orden = new Orden();
$cultivo = new Cultivo();
$centroAcopio = new CentroAcopio();

$listadoC = $cultivo->find('', '', 'id, nombre', 'list', 'codigo');
//$listadoCA = $centroAcopio->find('', '', 'id, nombre', 'list', 'codigo');
$infoCA = $centroAcopio->buscarCA('', '', '', '', 'codigo');

foreach($infoCA as $dataCA){
    $listadoCA[$dataCA['id']] = "(".$dataCA['codigo'].") ".$dataCA['nombre'];
}

$listaCR = array('V' => 'V', 'E' => 'E', 'J' => 'J', 'G' => 'G');

switch ($GPC['ac']) {
    case 'guardar':
        if (!empty($GPC['Orden'])) {
            $centro_acopio = new CentroAcopio();
            $cultivo = new Cultivo();
            
            $infoCA = $centro_acopio->find(array('codigo' => substr($GPC['Orden']['numero_orden'], 0, 2)));
            $infoCU = $cultivo->find(array('codigo' => substr($GPC['Orden']['numero_orden'], 2, 2)));
            
            $GPC['Orden']['id_centro_acopio'] = $infoCA[0]['id'];
            $GPC['Orden']['id_cultivo'] = $infoCU[0]['id'];
            $fechaE = split('-', $GPC['Orden']['fecha_emision']);
            $cultivo = substr($GPC['Orden']['numero_orden'], 2, 2);
            $GPC['Orden']['cod_verificacion'] = $fechaE[0]+11+$fechaE[1]+$fechaE[2]-1570+$GPC['Orden']['numero_orden']+$GPC['Orden']['toneladas']+15+$cultivo;
            $GPC['Orden']['estatus'] = 'N';
            $orden->save($GPC['Orden']);
            $id = $orden->id;
        }
        if (!empty($id)) {
            header("location: ordenes_listado.php?msg=exitoso");
            die();
        } else {
            header("location: ordenes_listado.php?msg=error");
            die();
        }
    break;
    case 'editar':
        $infoOr = $orden->buscarOrden($GPC['id']);
        /*?>
            <script type="text/javascript">
                $(document).ready(function(){
                    var ced = "<?=trim($infoOr[0]['ced_cliente'])?>";
                    $('#orden').load('../ajax/detalle_despacho.php?ac=clienteOrden&cp='+ced);
                });
            </script>
        <?*/
    break;
}

require('../lib/common/header.php');
require('../lib/common/init_calendar.php');
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'ordenes_listado.php';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#Cliente\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion').val();
            var ced = $('#Cliente\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#orden').load('../ajax/detalle_despacho.php?ac=clienteOrden&cp='+ced);
            }
        });
        
        $('#Orden\\[cod_verificacion\\]').change(function(){
            var orden = $('#Orden\\[numero_orden\\]').val();
            var fe = $('#Orden\\[fecha_emision\\]').val();
            var to = $('#Orden\\[toneladas\\]').val();
            var co = $('#Orden\\[cod_verificacion\\]').val();
            if(orden != '' && fe != '' && to != '' && co != '')
                $('#cod_verif').load('../ajax/detalle_despacho.php?ac=numeroOrden&orden='+orden+'&fe='+fe+'&to='+to+'&co='+co);
            else
                $('#cod_verif').html('');
        });
    });
    
    function abrirPopup(){
        cedula = $('#nacion').val()+$('#Cliente\\[ced_rif\\]').val();
        var ancho;
        var alto;
        ancho = (screen.width/2)-(550/2);
        alto = (screen.height/2)-(450/2);
        ventana = window.open("cliente_popup.php?cp="+cedula,"Registro Cliente","status=no,toolbar=0,menubar=no,resizable=0,scrollbars=1,width=550,left="+ancho+",height=450,top="+alto);
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Orden.id', $infoOr[0]['id'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ORDEN<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Nro Orden </td>
            <td>
                <?
                    if($GPC['ac'] == 'editar')
                        echo $html->input('Orden.numero_orden', $infoOr[0]['numero_orden'], array('type' => 'text', 'length' => '8', 'class' => 'estilo_campos integer', 'readOnly' => true));
                    else
                        echo $html->input('Orden.numero_orden', '', array('type' => 'text', 'length' => '8', 'class' => 'estilo_campos integer'));
                ?>
            </td>
        </tr>
        <!--tr>
            <td><span class="msj_rojo">* </span>Centro de Acopio</td>
            <td>
                <?
                    if($_SESSION['s_perfil_id'] != ADMINS){
                        if($GPC['ac'] == 'editar')
                            echo $html->select('Orden.id_centro_acopio',array('options'=>$listadoCA, 'selected' => $infoOr[0]['id_centro_acopio'], 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod', 'readOnly' => true));
                        else
                            echo $html->select('Orden.id_centro_acopio',array('options'=>$listadoCA, 'selected' => $infoOr[0]['id_centro_acopio'], 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod'));
                    }else{
                        echo $html->input('centro_acopio', '('.$_SESSION['s_ca_codigo'].') '.$_SESSION['s_ca_nombre'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
                        echo $html->input('Orden.id_centro_acopio', $_SESSION['s_ca_id'], array('type' => 'hidden'));
                    }
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cultivo</td>
            <td>
                <?
                    if($GPC['ac'] == 'editar')
                        echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'selected' => $infoOr[0]['id_cultivo'], 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod', 'readOnly' => true));
                    else
                        echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'selected' => $infoOr[0]['id_cultivo'], 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod'));
                ?>
            </td>
        </tr-->
        <tbody id="orden">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                <td>
                    <?
                        echo $html->select('nacion', array('options'=>$listaCR, 'selected' => substr(trim($infoOr[0]['ced_cliente']), 0, 1)));
                        echo "&nbsp;".$html->input('Cliente.ced_rif', substr(trim($infoOr[0]['ced_cliente']), 1), array('type' => 'text', 'length' => '8', 'style' => 'width: 150px', 'class' => 'integer'));
                        
                        if($GPC['ac'] == 'editar'){
                            ?>
                            <tr>
                                <td><span class="msj_rojo">* </span>Nombre </td>
                                <td>
                                    <?
                                        echo $html->input('Cliente.nombre', trim($infoOr[0]['nombre_cliente']), array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
                                        echo $html->input('Orden.id_cliente', trim($infoOr[0]['id_cliente']), array('type' => 'hidden'));
                                    ?>
                                </td>
                            </tr>
                            <?
                        }
                    ?>
                </td>
            </tr>
        </tbody>
        <tr>
            <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
            <td>
                <?
                    echo $html->input('Orden.fecha_emision', $general->date_sql_screen($infoOr[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true));
                    if(empty($infoOr)){
                ?>
                <img src="../images/calendario.png" id="femision" width="16" height="16" style="cursor:pointer" />
                <script>
                    Calendar.setup({
                        trigger    : "femision",
                        inputField : "Orden[fecha_emision]",
                        dateFormat: "%d-%m-%Y",
                        selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoOr[0]['fecha_emision']));?>),
                        onSelect   : function() { this.hide() }
                    });
                </script>
                <? } ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Toneladas </td>
            <td><? echo $html->input('Orden.toneladas', $infoOr[0]['toneladas'], array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>C&oacute;digo de Verificaci&oacute;n </td>
            <td>
                <?
                    if($GPC['ac'] == 'editar')
                        echo $html->input('Orden.cod_verificacion', $infoOr[0]['cod_verificacion'], array('type' => 'text', 'class' => 'estilo_campos integer', 'readOnly' => true));
                    else
                        echo $html->input('Orden.cod_verificacion', '', array('type' => 'text', 'class' => 'estilo_campos integer'));
                ?>
            </td>
        </tr>
        <tbody id="cod_verif"></tbody>
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
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Orden.id_centro_acopio', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.numero_orden', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.fecha_emision', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.toneladas', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.cod_verificacion', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();

require('../lib/common/footer.php');
?>
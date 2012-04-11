<?
require_once('../lib/core.lib.php');

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
        $orden = new Orden();
        if (!empty($GPC['Orden'])) {
            $GPC['Orden']['id_centro_acopio'] = $_SESSION['s_ca_id'];
            $GPC['Orden']['id_cliente'] = $idCliente;
            
            $centro_acopio->save($GPC['CA']);
            $idCA = $centro_acopio->id;

            if (empty($GPC['Orden']['id'])) {
                $GPC['Orden']['estatus'] = 'N';

                $almacen->save($GPC['AL']);
                $idAl = $almacen->id;

                $nuevoSilo = array();
                $nuevoSilo['id_centro_acopio'] = $idCA;
                $nuevoSilo['id_almacen'] = $idAl;
                for ($i = 1; $i <= $GPC['cant_silos']; $i++) {
                    $nuevoSilo['nombre'] = "Silo " . $i;
                    $nuevoSilo['coordenada'] = "Norte";
                    $nuevoSilo['numero'] = $i;
                    $nuevoSilo['capacidad'] = 1000;
                    $nuevoSilo['modulo'] = 'A';
                    $silos->save($nuevoSilo);
                    $silos->id = null;
                }
            }
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
        $infoOr = $centro_acopio->find(array('id' => $GPC['id_ca']));
        $almacen = new Almacen();
        $infoAL = $almacen->find(array('id_centro_acopio' => $infoOr[0]['id']), '', '*', '', 'id');

        $listaMcpos = $div_pol->obtenerMcpo('', $infoOr[0]['id_estado']);
        foreach ($listaMcpos as $dataMcpo) {
            $listaM[$dataMcpo['id']] = $dataMcpo['nombre'];
        }
        $ocultarCantidad = 0;
        break;
}

require('../lib/common/header.php');
require('../lib/common/init_calendar.php');

$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Cliente.ced_rif', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cliente.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.numero_orden', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.fecha_emision', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Orden.toneladas', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
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
        
        $('.gen_cod').change(function(){
            var ca = $('#Orden\\[id_centro_acopio\\]').val();
            var cu = $('#Orden\\[id_cultivo\\]').val();
            if(ca != '' && cu != ''){
                $('#nroOrden').load('../ajax/detalle_despacho.php?ac=numeroOrden&ca='+ca+'&cu='+cu);
            }
        });
    });
    
    function abrirPopup(cedula){
        var ancho;
        var alto;
        ancho = (screen.width/2)-(550/2);
        alto = (screen.height/2)-(450/2);
        ventana = window.open("cliente_popup.php?cp="+cedula,"Registro Cliente","status=no,toolbar=0,menubar=no,resizable=0,scrollbars=1,width=550,left="+ancho+",height=450,top="+alto);
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Orden.id', $infoOr[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cliente.id', $infoOr[0]['id_cliente'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ORDEN<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Centro de Acopio</td>
            <td>
                <?
                    if($_SESSION['s_perfil_id'] != ADMINS)
                        echo $html->select('Orden.id_centro_acopio',array('options'=>$listadoCA, 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod'));
                    else{
                        echo $html->input('centro_acopio', '('.$_SESSION['s_ca_codigo'].') '.$_SESSION['s_ca_nombre'], array('type' => 'text', 'readOnly' => true, 'class' => 'estilo_campos'));
                        echo $html->input('Orden.id_centro_acopio', $_SESSION['s_ca_id'], array('type' => 'hidden'));
                    }
                ?>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Cultivo</td>
            <td><? echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'default' => 'Seleccione', 'class' => 'estilo_campos gen_cod'))?></td>
        </tr>
        <tbody id="orden">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                <td>
                    <?
                        echo $html->select('nacion', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Cliente.ced_rif', $infoOr[0]['ced_rif'], array('type' => 'text', 'length' => '8', 'style' => 'width: 150px', 'class' => 'integer'));
                    ?>
                </td>
            </tr>
        </tbody>
        <tr>
            <td><span class="msj_rojo">* </span>Nro Orden </td>
            <td>
                <div id="nroOrden">
                    <? echo $html->input('Orden.numero_orden', $infoOr[0]['numero_orden'], array('type' => 'text', 'length' => '10', 'readOnly' => true, 'class' => 'estilo_campos integer')); ?>
                <div>
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Fecha de Emisi&oacute;n: </td>
            <td>
                <? echo $html->input('Orden.fecha_emision', $general->date_sql_screen($infoOr[0]['fecha_emision'], '', 'es', '-'), array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true)); ?>
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
            </td>
        </tr>
        <tr>
            <td><span class="msj_rojo">* </span>Toneladas </td>
            <td><? echo $html->input('Orden.toneladas', $infoOr[0]['toneladas'], array('type' => 'text', 'class' => 'estilo_campos integer')); ?></td>
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
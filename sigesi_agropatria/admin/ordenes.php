<?
require_once('../lib/core.lib.php');

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
        window.location = 'centros_acopio_listado.php';
    }
    
    $(document).ready(function(){
        $('.integer').numeric();
        
        $('#Cliente\\[ced_rif\\]').live('change', function(){
            var np = $('#nacion').val();
            var ced = $('#Cliente\\[ced_rif\\]');
            if(ced.val().length >= 6){
                ced = np+ced.val();
                $('#orden').load('../ajax/detalle_despacho.php?ac=cliente&cp='+ced);
            }
        });
    });
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Orden.id', $infoOr[0]['id'], array('type' => 'hidden')); ?>
    <? echo $html->input('Cliente.id', $infoOr[0]['id_cliente'], array('type' => 'hidden')); ?>
    <div id="titulo_modulo">
        ORDEN<br/><hr/>
    </div>
    <table align="center">
        <tr>
            <td><span class="msj_rojo">* </span>Cultivo</td>
            <td><? echo $html->select('Orden.id_cultivo',array('options'=>$listadoC, 'default' => 'Seleccione'))?></td>
        </tr>
        <tbody id="orden">
            <tr>
                <td><span class="msj_rojo">* </span>C&eacute;dula/Rif Cliente</td>
                <td>
                    <?
                        echo $html->select('nacion', array('options'=>$listaCR));
                        echo "&nbsp;".$html->input('Cliente.ced_rif', $infoOr[0]['ced_rif'], array('type' => 'text', 'length' => '8', 'class' => 'crproductor integer'));
                    ?>
                </td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Nombres Cliente</td>
                <td><? echo $html->input('Cliente.nombre', $infoOr[0]['nombre_cliente'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td>Tel&eacute;fono</td>
                <td><? echo $html->input('Cliente.telefono', $infoOr[0]['telefono_cliente'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
        </tbody>
        <tr>
            <td><span class="msj_rojo">* </span>Nro Orden </td>
            <td><? echo $html->input('Orden.numero_orden', $infoOr[0]['numero_orden'], array('type' => 'text', 'length' => '10', 'class' => 'estilo_campos integer')); ?></td>
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
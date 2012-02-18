<?
    require_once('../lib/core.lib.php');
    
    $programa = new Programa();
    $cosecha = new Cosecha();
    $cultivo = new Cultivo();
    
    $estatus = array('t' => 'Activo', 'f' => 'Inactivo');
    $listaEstados = array(0 => 'Abierta', 1 => 'Cerrada');
    
    switch($GPC['ac']){
        case 'guardar':
            /*echo "<pre>"; print_r($GPC['cosechaNombre']); echo "</pre>";
            echo "<pre>"; print_r($GPC['cosechaCultivo']); echo "</pre>";
            echo "<pre>"; print_r($GPC['cosechaProyectado']); echo "</pre>";
            echo "<pre>"; print_r($GPC['cosechaArea']); echo "</pre>";
            echo "<pre>"; print_r($GPC['cosechaFechaI']); echo "</pre>";
            echo "<pre>"; print_r($GPC['cosechaFechaF']); echo "</pre>";die();
            
            if(!empty($GPC['Programa']['nombre'])){
                $GPC['Programa']['id_centro_acopio'] = $_SESSION['s_ca_id'];
                $cantProgramas = $programa->cantidadProgramasCA($_SESSION['s_ca_id']);
                $GPC['Programa']['numero'] = ++$cantProgramas[0]['total'];
                $programa->save($GPC['Programa']);
                $id = $programa->id;
                if(!empty($id)){
                    header("location: programa_listado.php?msg=exitoso");
                    die();
                }else{
                    header("location: programa_listado.php?msg=error");
                    die();
                }
            }*/
        break;
        case 'editar':
            $infoCA = $programa->find(array('id' => $GPC['id']));
        break;
    }
    require('../lib/common/header.php');
    
$validator = new Validator('form1');
$validator->printIncludes();
$validator->setRules('Programa.numero', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Programa.estatus', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha1.nombre', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cosecha1.id_cultivo', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->setRules('Cultivo.id', array('required' => array('value' => true, 'message' => 'Requerido')));
$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'programa_listado.php';
    }
    
    
    $(document).ready(function(){
        $('#Agregar').click(function(){
            $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())+1);
            filaId = $('#numeroCosecha').val();
            var tds = "<tr id='cosecha_"+filaId+"'>";
            
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".nombre' id='Cosecha"+filaId+".nombre'></td>";
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".id_cultivo' id='Cosecha"+filaId+".id_cultivo'></td>";
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".proyectado' id='Cosecha"+filaId+".proyectado'></td>";
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".area_siembra' id='Cosecha"+filaId+".area_siembra'></td>";
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".fecha_inicio' id='Cosecha"+filaId+".fecha_inicio'></td>";
            tds += "<td><input type='text' class='inputGrilla' value='' name='Cosecha"+filaId+".fecha_fin' id='Cosecha"+filaId+".fecha_fin'></td>";
            tds += "<td><img src='../images/eliminar2.png' width='16' height='16' title='Eliminar' style='cursor: pointer;' onclick='eliminarFila("+filaId+");'></td>";
            tds += "</tr>";
            $("#nuevaCosecha").append(tds);
        });
    });
    
    function eliminarFila(fila){
        $("#cosecha_"+fila).remove();	
        $('#numeroCosecha').val(parseInt($('#numeroCosecha').val())-1);
            return false;
    }
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <? echo $html->input('Programa.id', $infoCA[0]['id'], array('type' => 'hidden'));?>
    <? echo $html->input('numeroCosecha', 1, array('type' => 'hidden'));?>
    <div id="titulo_modulo">
        NUEVO PROGRAMA<br/><hr/>
    </div>
    <fieldset>
        <legend>Datos del Programa</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>N&uacute;mero: </td>
                <td><? echo $html->input('Programa.numero', $infoPrograma[0]['numero'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->input('Programa.nombre', $infoPrograma[0]['nombre'], array('type' => 'text', 'class' => 'estilo_campos')); ?></td>
            </tr>
            <tr>
                <td><span class="msj_rojo">* </span>Estatus: </td>
                <td><? echo $html->select('Programa.estatus',array('options'=>$estatus, 'selected' => $infoPrograma[0]['estatus'], 'default' => 'Seleccione'))?></td>
            </tr>
            <tr>
                <td>Observaci&oacute;n: </td>
                <td><textarea name="Programa[observacion]" cols="20" rows="2" id="Programa[observacion]"></textarea></td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>Datos de la Cosecha</legend>
        <table align="center" border="0" width="100%">
            <tr align="right">
                <td colspan="2"><? echo $html->input('Agregar', 'Agregar', array('type' => 'button')); ?></td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr><td>
                <table id="nuevaCosecha" align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr align="center">
                            <th><span class="msj_rojo">* </span>Nombre</th>
                            <th><span class="msj_rojo">* </span>Cultivo</th>
                            <th>Proyectado</th>
                            <th>Area Siembra</th>
                            <th>Fecha Inicio</th>
                            <th>Fecha Fin</th>
                            <th></th>
                        </tr>
                        <tr>
                            <td><?=$html->input('Cosecha1.nombre', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td><?=$html->input('Cosecha1.id_cultivo', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td><?=$html->input('Cosecha1.proyectado', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td><?=$html->input('Cosecha1.area_siembra', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td><?=$html->input('Cosecha1.fecha_inicio', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td><?=$html->input('Cosecha1.fecha_fin', '', array('type' => 'text', 'class' => 'inputGrilla'));?></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tbody id="nuevoCampo"></tbody>
                </table>
                <!--table align="center" width="100%" border="1" cellpadding="0" cellspacing="0">
                    <div id="nuevaCosecha"></div>
                </table-->
            </td></tr>
        </table>
    </fieldset>
    <!--fieldset>
        <legend>Datos del Cultivo</legend>
        <table align="center">
            <tr>
                <td><span class="msj_rojo">* </span>Nombre: </td>
                <td><? echo $html->select('Cultivo.id',array('options'=>$listaCultivos, 'selected' => $infoPrograma[0]['estado'], 'default'=>' Seleccione '))?></td>
            </tr>
        </table>
    </fieldset-->
    <table align="center">
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick'=>'cancelar()')); ?>
            </td>
        </tr>
    </table>
</form>
<?
    require('../lib/common/footer.php');
?>
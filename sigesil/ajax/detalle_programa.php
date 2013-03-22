<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'validar':
            if(!empty($GPC['codigo'])){
                $cultivo = new Cultivo();
                
                $dataCultivo = $cultivo->find(array('id' => $GPC['codigo']), '', 'codigo');
                $GPC['codigo'] = date('Y').$dataCultivo[0]['codigo'];
                
                $programa = new Programa();
                $cond = " AND pro.fecha_fin >= '".$GPC['fecha']."'";
                $infoPrograma = $programa->buscarProgramaCA('', $_SESSION['s_ca_id'], $GPC['codigo'], $cond, 't');
                if(empty($infoPrograma)){
                    echo $html->input('Programa.codigo', $GPC['codigo'], array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true));
                }else{
                    echo $html->input('Programa.codigo', '', array('type' => 'text', 'class' => 'estilo_campos', 'readOnly' => true));
                    ?>
                        <script type="text/javascript">
                            alert('Ya Existe un Programa para ese Cultivo');
                            $("#Programa\\[id_cultivo\\] option[value='']").attr("selected", "selected");
                        </script>
                    <?php
                }
            }
        break;
        case 'agregar':
            if(!empty($GPC['nro'])){
            ?>
                <legend class='titulo_leyenda'>Datos de la Cosecha #<?php echo $GPC['nro']?></legend>
                <table align='center' width='100%'>
                    <tr>
                        <td>
                            <table align='center' cellpadding='0' cellspacing='0'>
                                <tr>
                                    <td><span class='msj_rojo'>* </span>C&oacute;digo</td>
                                    <td rowspan="7">&nbsp;&nbsp;</td>
                                    <td><?php echo $html->input('codigo'.$GPC['nro'], $GPC['codigo'], array('type' => 'text', 'class' => 'inputGrilla', 'readOnly' => true)); ?></td>
                                </tr>
                                <tr>
                                    <td><span class='msj_rojo'>* </span>Nombre</td>
                                    <td><?php echo $html->input('nombre'.$GPC['nro'], '', array('type' => 'text', 'class' => 'inputGrilla')); ?></td>
                                </tr>
                                <tr>
                                    <td>Proyectado</td>
                                    <td><?php echo $html->input('proyectado'.$GPC['nro'], '', array('type' => 'text', 'class' => 'inputGrilla positive')); ?></td>
                                </tr>
                                <tr>
                                    <td>Area Siembra</td>
                                    <td><?php echo $html->input('area_siembra'.$GPC['nro'], '', array('type' => 'text', 'class' => 'inputGrilla positive')); ?></td>
                                </tr>
                                <tr>
                                    <td>Fecha Inicio</td>
                                    <td>
                                        <?php echo $html->input('fecha_inicio'.$GPC['nro'], '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?>&nbsp;&nbsp;
                                        <img src='../images/calendario.png' id="finicio<?php echo $GPC['nro']?>" width='16' height='16' style='cursor:pointer' />
                                        <script>
                                            Calendar.setup({
                                                trigger    : "finicio<?php echo $GPC['nro']?>",
                                                inputField : "fecha_inicio<?php echo $GPC['nro']?>",
                                                dateFormat: "%d-%m-%Y",
                                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                                onSelect   : function() { validarFecha("fecha_inicio<?php echo $GPC['nro']?>",$('#fecha_inicio<?php echo $GPC['nro']?>').val()); this.hide() }
                                            });
                                        </script>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fecha Fin</td>
                                    <td>
                                        <?php echo $html->input('fecha_fin'.$GPC['nro'], '', array('type' => 'text', 'class' => 'inputGrilla fechas', 'readOnly' => true)); ?>&nbsp;&nbsp;
                                        <img src='../images/calendario.png' id="ffin<?php echo $GPC['nro']?>" width='16' height='16' style='cursor:pointer' />
                                        <script>
                                            Calendar.setup({
                                                trigger    : "ffin<?php echo $GPC['nro']?>",
                                                inputField : "fecha_fin<?php echo $GPC['nro']?>",
                                                dateFormat: "%d-%m-%Y",
                                                selection: Calendar.dateToInt(<?php echo date("Ymd", strtotime($infoGuia[0]['fecha_emision']));?>),
                                                onSelect   : function() { validarFecha("fecha_fin<?php echo $GPC['nro']?>",$('#fecha_fin<?php echo $GPC['nro']?>').val()); this.hide() }
                                            });
                                        </script>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            <?php
            }
        break;
    }
?>
<script type="text/javascript">
    $(document).ready(function(){
        $('.positive').numeric();
    });
</script>
<?
    require_once('../lib/core.lib.php');
    $productor = new Productor();
    
    $archivo = $GPC['archivo'];
    $linea = $GPC['linea'];
    $tag = $GPC['tag'];
    $nombreArch = str_replace('_', ' ', substr($archivo, 15));
    
    switch($GPC['ac']){
        case 'cargar':
            $productor->insertarProductorArchivo($archivo, $linea);
            header("location: productor_carga.php?msg=exitoso");
            exit;
        break;
        case 'cancelar':
            unlink(APPROOT."temp_files/$archivo");
            header("location: productor_carga.php");
            exit;
        break;
    }
    
    $productor->leerArchivoProductor($archivo, $linea);
    $infoArchivo = $productor->data;

    require('../lib/common/header.php');
?>
<script language="javascript1.5" type="text/javascript">
    show_div_loader();
    
    $(document).ready(function(){
        $('#Guardar').click(function(){
            show_div_loader();
        });
    });

    function cancelar(){
        window.location = 'productor_carga_ver.php?ac=cancelar&archivo=<?=$archivo?>';
    }

</script>
<form name="form1" id="form1" method="POST" action="?ac=cargar" enctype="multipart/form-data">
    <input name="archivo" type="hidden" value="<? echo $archivo ?>" />
    <input name="linea" type="hidden" value="<? echo $linea ?>" />
    <div id="titulo_modulo">
       PRODUCTORES DEL EXCEL<br/><hr/>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%">
                <tr>
                    <th width="1">Archivo:</th>
                    <td><?=$nombreArch?></td>
                </tr>
                <tr id="botones">
                    <td colspan="2">
                        <? //echo $html->input('Guardar', 'Guardar', array('type' => 'submit', 'onClick' => 'show_div_loader();')); ?>
                        <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit')); ?>
                        <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
                    </td>
                </tr>
            </table>
            <? echo $html->input('mov', $GPC['mov'], array('type' => 'hidden')); ?>
        </form>
    </div><hr/>
    <div style="height:375px; overflow:auto; margin-top:10px;">
        <table width="100%" border="0" align="center">
            <tr align="center" class="titulos_tabla">
                <th width="1">L&iacute;nea</th>
                <th width="1">C&eacute;dula/Rif</th>
                <th>Nombre Productor</th>
                <th width="1">Tel&eacute;fono</th>
                <th>Direcci&oacute;n</th>
                <th>Error</th>
            </tr>
            <?
                $i=0;
                foreach ($infoArchivo as $indice => $linea) {
                    $clase = $general->obtenerClaseFila($i);
                    $var_error = '';
                    $arrError = array_unique(explode(",", $linea['error_msg']));
                    for ($e = 0; $e < count($arrError); $e++) {
                        if ($arrError[$e] == 'OK' && $var_error != '') {
                            break;
                        }
                        if ($arrError[$e] != '') {
                            $var_error .= $arrError[$e] . ",";
                        }
                    }
                    $var_error = substr($var_error, 0, strlen($var_error) - 1);
                    if($var_error == 'OK')
                        $var_error = '<img src="'.DOMAIN_ROOT.'images/habilitar.png" width="16" height="16" title=Activo>'.$var_error;
                    elseif((substr($var_error, 0, 9) == 'Duplicado') || (substr($var_error, 0, 15) == 'Cedula Invalida'))
                        $var_error = '<img src="'.DOMAIN_ROOT.'images/deshabilitar.png" width="16" height="16" title=Activo>'.$var_error;
                    else
                        $var_error = '<img src="'.DOMAIN_ROOT.'images/habilitar.png" width="16" height="16" title=Activo>'.$var_error;
            ?>
                <tr class="<?=$clase?>">
                    <!--td align="center" class="cell_left">
                        <?
                        if (in_array($linea['scvlines'], $productor->lineas_cargadas)) {
                        ?>
                            <img src="../images/icons/gtk-apply.png" width="16" height="16" />
                        <?
                        } else {
                            echo '&nbsp;';
                        }
                        ?>
                    </td-->
                    <td align="center"><? echo $linea['scvlines'] ?></td>
                    <td><? echo strtoupper($linea['ced_rif']) ?></td>
                    <td><? echo strtoupper($linea['nombre']) ?></td>
                    <td><? echo strtoupper($linea['telefono']) ?></td>
                    <td><? echo strtoupper($linea['direccion']) ?></td>
                    <td align="left"><? echo $var_error ?></td>
                </tr>
        <? $i++; } ?>
        </table>
    </div>

<? require('../lib/common/footer.php'); ?>
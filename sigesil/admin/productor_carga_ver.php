<?
    require_once('../lib/core.lib.php');
    $productor = new Productor();
    
    $archivo = $GPC['archivo'];
    $linea = $GPC['linea'];
    $tag = $GPC['tag'];
    
    if ($_REQUEST['ac'] == "cargar") {
        $productor->insert_archivo_venta_detalle($archivo);
        header("location: sales_file_list.php");
        exit;
    }

    $arr_tags = array();
    switch ($GPC['tab']) {
        case "invalids":
            $show = 'invalids';
            $type = array(0);
            $page_size = 100;
            $arr_tags = $productor->getCountByError($archivo);
            break;
        case 'uploaded':
            $show = 'uploaded';
            $type = array(3);
            $page_size = 1500;
            break;
        case 'deleted':
            $show = 'deleted';
            $page_size = 250;
            $type = array(4);
            break;
        case 'transfered':
            $show = 'transfered';
            $page_size = 500;
            $type = array(5);
            break;
        case "valids":
        default:
            $show = 'valids';
            $type = array(1, 3); //validos y uploaded
            $page_size = 100;
            break;
    }
    $productor->leerArchivoProductor($archivo, $linea);
    //$productor->get_lineas_cargadas($archivo);
    $infoArchivo = $productor->data;

    require('../lib/common/header.php');
?>
<script language="javascript1.5" type="text/javascript">
    show_div_loader(); //cargador en el header interno

    function selectall(lista){
        var opt = document.getElementById('select_all').checked;
        var chklinea = document.getElementsByName(lista);
        for(i=0; i<=chklinea.length; i++){
            chklinea[i].checked = opt;
        }
    }

    function openWindow(mypage,myname,w,h,scroll){
        LeftPosition = (screen.width) ? (screen.width-w)/2 : 0;
        TopPosition = (screen.height) ? (screen.height-h)/2 : 0;
        settings ='height='+h+',width='+w+',top='+TopPosition+',left='+LeftPosition+',scrollbars=yes ';
        win = window.open(mypage,myname,settings)
    }

    function cancelar(){
        window.location = 'productor_carga.php';
    }

</script>
<form name="form1" id="form1" method="POST" action="?ac=cargar" enctype="multipart/form-data">
    <input name="idfile" type="hidden" value="<? echo $archivo ?>" />
    <div id="titulo_modulo">
       PRODUCTORES DEL EXCEL<br/><hr/>
    </div>
    <table width="100%" align="center" border="0" cellspacing="0" cellpadding="1">
        <tr>
            <td>
                <div style="text-align:right; border-bottom:1px solid #919191;"  >
                    <table width="100%">
                        <tr>
                            <td width="34%" align="right">
                                <table width="100%">
                                    <tr>
                                        <th width="57%" align="right">Archivo:</th>
                                        <td width="43%" align="left"><? echo $fileProperties['name'] ?></td>
                                    </tr>
                                </table>
                            </td>
                            <td width="66%" valign="bottom">
                                <? echo $html->input('Guardar', 'Guardar', array('type' => 'submit', 'onClick' => 'show_div_loader();')); ?>
                                <? echo $html->input('Cancelar', 'Cancelar', array('type' => 'reset', 'onClick' => 'cancelar()')); ?>
                            </td>
                        </tr>
                    </table>    
                </div>
                <div style="height:375px; overflow:auto; margin-top:10px;">
                    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
                        <tr>
                            <!--td width="1%" align="center" bgcolor="#999999" style="color:#FFFFFF; padding-left:5px;"></td-->
                            <td width="4%" bgcolor="#999999" style="color:#FFFFFF;">L&iacute;nea</td>
                            <td width="15%" bgcolor="#999999" style="color:#FFFFFF;">C&eacute;dula/Rif</td>
                            <td width="15%" bgcolor="#999999" style="color:#FFFFFF;">Nombre Productor</td>
                            <td width="10%" bgcolor="#999999" style="color:#FFFFFF;">Tel&eacute;fono</td>
                            <td width="10%" bgcolor="#999999" style="color:#FFFFFF;">Direcci&oacute;n</td>
                            <td width="40%" align="center" bgcolor="#999999" style="color:#FFFFFF;">Error</td>
                        </tr>
                        <?
                        foreach ($infoArchivo as $indice => $linea) {
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
                            ?>
                            <tr>
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
                                <td align="center" class="cell_center"><? echo $linea['scvlines'] ?></td>
                                <td class="cell_center"><? echo $linea['ced_rif'] ?></td>
                                <td class="cell_center"><? echo $linea['nombre'] ?></td>
                                <td class="cell_center"><? echo $linea['telefono'] ?></td>
                                <td class="cell_center"><? echo $linea['direccion'] ?></td>
                                <td class="cell_center errormsg"><? echo $var_error ?></td>
                                <!--td align="center" class="cell_right">&nbsp;</td-->
                            </tr>
                    <? } ?>
                    </table>
                    <br />
                </div>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td>&nbsp;</td>
        </tr>
    </table>
</form>

<? require('../lib/common/footer.php'); ?>
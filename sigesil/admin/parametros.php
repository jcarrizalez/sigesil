<?php
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
    
    $parametros = new Parameter();
    $parametros->listaParametros();
?>

<script language="javascript">
    anterior = 0;
    function edit_maintenance(ids,indice){
        var ids = ids;
        var op = "edit";
        $.get("parametros_asyn.php", {  ids : ids , op : op  },
        function(data){
            $('#opc_'+indice).html(data);
        });
        if(anterior!=indice){
            $('#opc_'+anterior).html(' ');
            anterior = indice;
        }
    }
    
    function guardar(ids){
        var v_valor = $("#valor").val();
        var vids = ids;
        if(v_valor!=''){
            var vac = "edit";
            $.get("parametros_asyn.php", {  av_valor:v_valor , ids : vids , ac : vac  },
            function(data){
                window.location.reload();
            });
        }else{
            $("#error2").html('Requerido')
            $("#valor").attr('class','inputText error')
        }
    }
    
    function cerrar(){
        window.location.reload();
    }
</script>
<div id="titulo_modulo">
    Opciones del Sistema<br/><hr/>
</div>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <table align="center" width="100%">
                <tr align="center" class="titulos_tabla">
                    <th width="50%">Descripci&oacute;n</th>
                    <th width="40%">Valor</th>
                    <th width="5%" align="center">Editar</th>
                </tr>
                <?php
                    for ($i = 0, $cant = count($parametros->lista); $i < $cant; $i++) {
                        $value_id = $parametros->lista[$i]['parametro_valor'];
                        $classname = $general->obtenerClaseFila($i);
                ?>
                    <tr>
                        <td class="<?php echo $classname ?>"><?php echo ucfirst($parametros->lista[$i]['descripcion']) ?></td>
                        <td class="<?php echo $classname ?>"><?php echo $value_id ?> <div id="opc_<?php echo $i ?>"></div></td>
                        <td align="center" class="<?php echo $classname ?>"><a href="#" onclick="javascript:edit_maintenance('<?php echo $parametros->lista[$i]['id'] ?>','<?php echo $i ?>');"><img src="../images/editar.png" width="16" height="16"></a></td>
                    </tr>
                <?php } ?>
            </table>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>
<?php require('../lib/common/footer.php'); ?>
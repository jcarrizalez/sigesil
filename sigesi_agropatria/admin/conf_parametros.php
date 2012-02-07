<?
    require_once('../lib/core.lib.php');
    require('../lib/common/header.php');
    
    $objparams = new Parameter();
    $objparams->listParameters();
?>

<script language="javascript">
    anterior = 0;
    function edit_maintenance(ids,indice){
        var ids = ids;
        var op = "edit";
        $.get("conf_parametros_asyn.php", {  ids : ids , op : op  },
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
            $.get("conf_parametros_asyn.php", {  av_valor:v_valor , ids : vids , ac : vac  },
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
<div id="titulo">
    <span>Opciones del Sistema</span>
</div>
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>
            <table id="parametros" width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr>
                    <td width="50%" class="columna_titulos">Descripci&oacute;n</td>
                    <td width="40%" class="columna_titulos">Valor</td>
                    <td width="5%" align="center" class="columna_titulos">Editar</td>
                </tr>
                <?
                    for ($i = 0, $cant = count($objparams->lista); $i < $cant; $i++) {
                        $value_id = $objparams->lista[$i]['parameter_value'];
                        $classname = $general->get_classfila($i);
                ?>
                    <tr>
                        <td class="<?= $classname ?>"><? echo ucfirst($objparams->lista[$i]['description']) ?></td>
                        <td class="<?= $classname ?>"><? echo $value_id ?> <div id="opc_<?= $i ?>"></div></td>
                        <td align="center" class="<?= $classname ?>"><a href="#" onclick="javascript:edit_maintenance('<?= $objparams->lista[$i]['id'] ?>','<?= $i ?>');"><img src="../images/icons/editar.png" width="16" height="16"></a></td>
                    </tr>
                <? } ?>
            </table>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
    </tr>
</table>
<? require('../lib/common/footer.php'); ?>
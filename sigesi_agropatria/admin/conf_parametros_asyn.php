<?
    require("../lib/core.lib.php");
    
    $objparams = new Parameter();
    $op=$GPC['op'];
    $ac=$GPC['ac'];
    $ids=$GPC['ids']; 

    if($ac=="edit"){
        $objparams->update($ids, $GPC['av_valor']);
    }

    if($op=="edit"){
        $objparams->findFirst($ids);
?>

 <input name="valor" id="valor" type="text" value="<?=$objparams->data['parameter_value']?>" style="width:50%" />
 <input type="button" name="Submit" value="Guardar" onclick="javascript:guardar('<?=$GPC['ids'] ?>');" />
 <input type="button" name="Submit" value="Cerrar" onclick="javascript:cerrar();" />

<?
    }
?>
<span id="error2" class="error"></span>

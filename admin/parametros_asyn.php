<?php
    require("../lib/core.lib.php");
    
    $parametros = new Parameter();
    $op=$GPC['op'];
    $ac=$GPC['ac'];
    $ids=$GPC['ids']; 

    if($ac=="edit"){
        $parametros->update($ids, $GPC['av_valor']);
    }

    if($op=="edit"){
        $parametros->findFirst($ids);
?>

 <input name="valor" id="valor" type="text" value="<?php echo $parametros->data['parametro_valor']?>" style="width:40%" />
 <input type="button" name="Submit" value="Guardar" onclick="javascript:guardar('<?php echo $GPC['ids'] ?>');" style="font-size: 10px;" />
 <input type="button" name="Submit" value="Cerrar" onclick="javascript:cerrar();" style="font-size: 10px;" />

<?php
    }
?>
<span id="error2" class="error"></span>

<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'almacen':
            if(!empty($GPC['idCA'])){
                $almacen = new Almacen();
                $listaAlmacenes = $almacen->find(array('id_centro_acopio' => $GPC['idCA']), '', array('id', 'nombre'), 'list', 'id');
                echo '<div id="almacenes">'.$html->select('almacen',array('options'=>$listaAlmacenes, 'selected' => $infoUsuario[0]['almacen'], 'default' => 'Seleccione')).'</div>';
            }else{
                echo '<div id="almacenes">'.$html->select('almacen',array('selected' => $infoUsuario[0]['almacen'], 'default' => 'Seleccione')).'</div>';
            }
        break;
        case 'perfil':
            if(empty($GPC['idCA'])){
                echo '<div id="perfiles">'.$html->select('perfil',array('selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione')).'</div>';
            }elseif($GPC['idCA'] == 1){
                $listaPerfiles = array(1 => 'Gerente General');
                echo '<div id="perfiles">'.$html->select('perfil',array('options'=>$listaPerfiles, 'selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione')).'</div>';
            }else{
                $perfil = new Perfil();
                $listaPerfiles = $perfil->find('', '', array('id', 'nombre_perfil'), 'list', 'id');
                unset($listaPerfiles[1]);
                echo '<div id="perfiles">'.$html->select('perfil',array('options'=>$listaPerfiles, 'selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione')).'</div>';
            }
        break;
        case 'productor':
            $listaN = array('V' => 'V', 'E' => 'E');
            $listaR = array('V' => 'V', 'E' => 'E', 'J' => 'J');
            if($GPC['valor'] == '1'){
                echo $html->select('nacion',array('options'=>$listaN));
                echo "&nbsp;".$html->input('Guia.cedula_productor', '',array('type' => 'text', 'class' => 'crproductor'));
                echo $html->link('<img src="../images/buscar.png" width="16" height="16" title=Buscar Productor>', 'recepcion.php?ac=buscarPro');
            }else{
                echo $html->select('nacion',array('options'=>$listaR));
                echo "&nbsp;".$html->input('Guia.rif_productor', '', array('type' => 'text', 'class' => 'crproductor'));
                echo $html->link('<img src="../images/buscar.png" width="16" height="16" title=Buscar Productor>', 'recepcion.php?ac=buscarPro');
            }
        break;
    }
?>

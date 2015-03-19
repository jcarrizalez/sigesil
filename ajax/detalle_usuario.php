<?php
    require_once('../lib/core.lib.php');
    
    switch ($GPC['ac']){
        case 'validar':
            if(!empty($GPC['user'])){
                $usuario = new Usuario();
                $detalleUsuario = $usuario->find(array('usuario' => strtoupper($GPC['user'])));
                if(!empty($detalleUsuario))
                    echo $html->input('Usuario.usuario', '', array('type' => 'text', 'class' => 'estilo_campos'))."<span class='msj_rojo'>El Nombre de Usuario ya Existe</span> ";
                else
                    echo $html->input('Usuario.usuario', $GPC['user'], array('type' => 'text', 'class' => 'estilo_campos'))."<span class='msj_verde'>Nombre de Usuario Valido</span> ";
            }
        break;
        case 'almacen':
            if(!empty($GPC['idCA'])){
                $almacen = new Almacen();
                $listaAlmacenes = $almacen->find(array('id_centro_acopio' => $GPC['idCA']), '', array('id', 'nombre'), 'list', 'id');
                echo '<div id="almacenes">'.$html->select('almacen',array('options'=>$listaAlmacenes, 'selected' => $infoUsuario[0]['almacen'], 'default' => 'Seleccione', 'class' => 'estilo_campos')).'</div>';
            }else{
                echo '<div id="almacenes">'.$html->select('almacen',array('selected' => $infoUsuario[0]['almacen'], 'default' => 'Seleccione', 'class' => 'estilo_campos')).'</div>';
            }
        break;
        case 'perfil':
            if(empty($GPC['idCA'])){
                echo '<div id="perfiles">'.$html->select('perfil',array('selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione', 'class' => 'estilo_campos')).'</div>';
            }elseif($GPC['idCA'] == 1){
                $listaPerfiles = array(1 => 'Gerente General', 3 => 'Administrador General', 5 => 'Calidad General');
                echo '<div id="perfiles">'.$html->select('perfil',array('options'=>$listaPerfiles, 'selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione', 'class' => 'estilo_campos')).'</div>';
            }else{
                $perfil = new Perfil();
                $listaPerfiles = $perfil->find('', '', array('id', 'nombre_perfil'), 'list', 'id');
                unset($listaPerfiles[1]);
                unset($listaPerfiles[3]);
                unset($listaPerfiles[5]);
                echo '<div id="perfiles">'.$html->select('perfil',array('options'=>$listaPerfiles, 'selected' => $infoUsuario[0]['perfil'], 'default' => 'Seleccione', 'class' => 'estilo_campos')).'</div>';
            }
        break;
    }
?>
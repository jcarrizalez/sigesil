<?php
    require_once('../lib/core.lib.php');
    
    $cargo = new Cargo();
    
    $listaCargos = $cargo->find('', '', array('id', 'nombre'), 'list', 'nivel');
    
    if($GPC['ac'] == 'eliminar'){
        $id = $GPC['id'];
        $silos->eliminarSilo(1,$id);
        header('location: cargo_listado.php');
        die();
    }
    require('../lib/common/header.php');
?>
<script type="text/javascript">
    function eliminar(){
        if(confirm('¿Desea Eliminar este Silo?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'cargos.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
    <div id="titulo_modulo">
        CARGOS<br/><hr/>
    </div>
    <div id="mensajes">
        <?php
            switch($GPC['msg']){
                case 'exitoso':
                    echo "<span class='msj_verde'>Registro Guardado !</span>";
                break;
                case 'error':
                    echo "<span class='msj_rojo'>Ocurri&oacute; un Problema !</span>";
                break;
            }
        ?>
    </div>
    <div id="filtro">
        <form name="form1" id="form1" method="GET" action="" enctype="multipart/form-data">
            <table width="100%">
                <tr id="botones">
                    <td colspan="3">
                        <?php
                            if($_SESSION['s_perfil_id'] == GERENTEG){
                                echo $html->input('Nuevo', 'Nuevo', array('type' => 'button'));
                            }
                            echo $html->input('Regresar', 'Regresar', array('type' => 'button', 'onClick' => 'regresar();'));
                        ?>
                    </td>
                </tr>
            </table>
        </form>
    </div><hr/>
    <table align="center" width="100%">
        <tr align="center" class="titulos_tabla">
            <th>Nombre</th>
            <th>Nivel</th>
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <th>Acci&oacute;n</th>
            <?php } ?>
        </tr>
        <?php
            $i=0;
            foreach($listaCargos as $dataCargo){
                $clase = $general->obtenerClaseFila($i);
        ?>
        <tr class="<?php echo $clase?>">
            <td><?php echo $dataCargo['nombre']?></td>
            <td><?php echo $dataCargo['nivel']?></td>
            <?php if($_SESSION['s_perfil_id'] == GERENTEG){ ?>
            <td align="center">
                <?php
                    echo $html->link('<img src="../images/editar.png" width="16" height="16" title=Editar>', 'silos.php?ac=editar&id='.$dataCargo['id']);
                    echo $html->link('<img src="../images/eliminar2.png" width="16" height="16" title=Eliminar>', 'silos_listado.php?ac=eliminar&id='.$dataCargo['id'], array('onclick' => 'return eliminar();'));
                ?>
            </td>
            <?php } ?>
        </tr>
        <?php $i++; } ?>
        <tr>
            
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
<?php
    require('../lib/common/footer.php');
?>
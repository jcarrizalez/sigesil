<?
    require_once('../lib/core.lib.php');
    
    $Ctna = new Cuarentena();
//    $Ctna->_begin_tool();
//    $recepcion['id_centro_acopio']=$_SESSION['s_ca_id'];
//    $recepcion['id_recepcion']=2;
//    $recepcion['tipo_mov']='R';
//    $recepcion['codigo_cultivo']=1;
//    $recepcion['fecha_mov']='now()';
//    $recepcion['fecha_cultivo']='now()';
//    $recepcion['grado_infestacion']=1;
//    $recepcion['laboratorio']='C';    
//    $Ctna->guardar($recepcion);
//    $Ctna->_commit_tool();
    require('../lib/common/header.php');
?>
<script type="text/javascript">  
    function eliminar(){
        if(confirm('¿Desea Eliminar este Almacen?'))
            return true;
        else
            return false;
    }
    
    $(document).ready(function(){
        $('#Nuevo').click(function(){
           window.location = 'almacen.php';
        });
        
        $('#Regresar').click(function(){
           history.back();
        });
    });
</script>
<?
    require('../lib/common/footer.php');
?>

<?
require_once('../lib/core.lib.php');

$Ctna = new Cuarentena();
$Cultivos = new Cultivo();
$Rec = new Recepcion();

$listadoCultivos = $Cultivos->find('', null, array('id','nombre'), 'list', 'id');

foreach ($listadoCultivos as $campo =>$valor) {
    echo 'campo: '.$campo .' - '. $valor;
    
}
echo '</br><br>REC';
print_r($listaC);
echo '</br>';
        
$laboratorio = array(2 => '40tna. lab');

//echo 'id: '.$GPC['id'];
switch ($GPC['ac']) {
    case 'editar':
        $infoCtna = $Ctna->find(array('id' => $GPC['id']));      
        $infoRec = $Rec->find(array('id' => $infoCtna[0]['id_recepcion']));
      break;
}
require('../lib/common/header.php');

//$validator = new Validator('form1');
//$validator->printIncludes();
//$validator->setRules('Almacen.codigo', array('required' => array('value' => true, 'message' => 'Requerido')));
//
//$validator->printScript();
?>
<script type="text/javascript">
    function cancelar(){
        window.location = 'curentena_listado.php';
    }
    
</script>
<form name="form1" id="form1" method="POST" action="?ac=guardar" enctype="multipart/form-data">
    <div id="titulo_modulo">
        CUARENTENA<br/><hr/>
    </div>
    <table align="left">
        <tr>
            <td align="left">Nro Entrada </td>
            <td><? echo $infoRec[0]['numero']; ?></td>
            <td align="left">Fecha</td>
            <td><? echo $general->date_sql_screen($infoCtna[0]['fecha_mov']); ?></td>
        </tr>
        <tr>
            <td align="left">Cultivo </td>
            <td><? echo $listadoCultivos[$infoCtna[0]['id_cultivo']]; ?></td>
            <td align="left">Hora </td>
            <td><? echo $general->hora_sql_normal($infoCtna[0]['fecha_mov']); ?></td>
        <td><? 
        //echo $html->select('Curentena.laboratorio', array('options' => $laboratorio)); 
        ?></td>
        </tr>
    </table>          
</form>
<?
require('../lib/common/footer.php');
?>
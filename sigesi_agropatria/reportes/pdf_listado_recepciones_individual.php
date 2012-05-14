<?php
require_once('../lib/core.lib.php');
$recepcion = new Recepcion();
//$asosiacion = new Asosiacion();

//echo $_GET['id'];
//echo $GPC['id']."<br /><br />";

if(isset($GPC['id']))
{
	$arrays=explode('_',$GPC['id']);
	if(isset($arrays[2]))
			$ban = 1;
	else
			$ban = 0;
	if(isset($arrays[4]))
		$idCA =1;
		else
		$idCA = 0;

	$idPro=$arrays[0];
	$idCo=$arrays[1];
	$fdesde=$arrays[2];
	$fhasta=$arrays[3];
	$idCa=$arrays[4];


}
else
{
		$ban = 0;
   	$idCA = 0;
}

echo $ban;

$sistema='AGROPATRIA C.A.';

if($ban==1)
{

echo ' $fdesde= '.$fdesde.' $fhasta= '.$fhasta.' $9= '.'9'.' $idCo= '.$idCo.' $idPro= '.$idPro.' $idCa= '.$idCa;

if($idCA==1){ //echo '1';
$listadoAsociaciones = $recepcion->recepcionPdf($fdesde, $fhasta, '9', $idCo, $idPro, '', $idCa);}
else{ //echo'0';
$listadoAsociaciones = $recepcion->recepcionPdf($fdesde, $fhasta, '9', $idCo, $idPro, '', '');}
Debug::pr($listadoAsociaciones);


}
else
$reporte_='REPORTE_SIN_DATOS';
if($ban==1)
{
echo $t="aqui va el codigo";


for($i=0; $i<count($listadoAsociaciones); $i++)
{

echo '<br />juan = '.count($listadoAsociaciones);
/*
if($idCA==1){ echo 'si';
$listadoRecepciones = $recepcion->listadoRecepcion('', $idCa, $idCo, '', '' '9', $fdesde, $fhasta, '', '', $idPro, '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion']);
}
else{ echo  'no';
$listadoRecepciones = $recepcion->listadoRecepcion('', '', $idCo, '', '' '9', $fdesde, $fhasta, '', '', $idPro, '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion']);
}
*/



}


}







?>



<?php
require_once('../lib/core.lib.php');
include('../lib/class/tcpdf/config/lang/spa.php');
include('../lib/class/tcpdf/tcpdf.php');
$recepcion = new Recepcion();


if(isset($GPC['id']))
{
	$arrays=explode('_',$GPC['id']);
	if(isset($arrays[3]))
	{		
	$ban = 1;
	$idPro=$arrays[0];
	$idCo=$arrays[1];
	$fdesde=$arrays[2];
	$fhasta=$arrays[3];
  }
	else
	{		$ban = 0;
  }

	if(isset($arrays[4]))
	{	$idCA_ = 1;
	$idCa=$arrays[4];
  }
	else
	{	$idCA_ = 0;
  }

}
else
{
		$ban = 0;
   	$idCA_ = 0;
}

//	echo '<br />'.$ban;
$sistema='AGROPATRIA C.A.';

$reSporte_='REPORTE_SIN_DATOS';

	if($ban==1)
	{
//echo 'idCA_='.$idCA_;
		if($idCA_==1)
		{ //echo '1';
			$listadoAsociaciones = $recepcion->recepcionPdf($fdesde, $fhasta, '9', $idCo, $idPro, '', $idCa);
echo 'catn1='.count($listadoAsociaciones);
		}
		else
		{ //echo'0';
//echo "recepcionPdf(".$fdesde.", ".$fhasta.", '9', ".$idCo.", ".$idPro.", '', '');";
			$listadoAsociaciones = $recepcion->recepcionPdf($fdesde, $fhasta, '9', $idCo, $idPro, '', '');
//	Debug::pr($listadoAsociaciones);
//echo 'catn0='.count($listadoAsociaciones);
		}

	//echo 'ff';
  }

class HOJASOL extends tcpdf{
    
    var $titulo = '';

    function setearTitulo($fdesde, $fhasta){
        if($fdesde == $fhasta)
            $this->titulo = "LISTADO DE DESPACHOS PARA LA FECHA $fdesde";
        else
            $this->titulo = "LISTADO DE DESPACHOS DESDE $fdesde HASTA $fhasta";
    }
   
    function mayus($let) { return strtr(strtoupper($let),"àèìòùáéíóúçñäëïöü","ÀÈÌÒÙÁÉÍÓÚÇÑÄËÏÖÜ");}

    function Header()
    {
		$this->SetMargins(10,30, 10);	
		$this->SetDisplayMode(85) ;
		$this->writeHTMLCell(0, 0, '18', '8', 'Pagina: '.$this->getAliasNumPage().'/'.$this->getAliasNbPages(), 0, 1, 0, true, 'L');
		$this->writeHTMLCell(0, 0, '', '10', "<font><b>$this->titulo</b></font>", 0, 1, 0, true, 'C');
		$this->writeHTMLCell(0, 0, '1', '7', '<font>Fecha: '.date('d/m/Y').'</font>&nbsp;&nbsp;&nbsp;&nbsp;', 0, 1, 0, true, 'R');

    }
    function Footer()
    {
	$this->setFooterMargin(0);
	$this->SetY(-10);
    }
}

   

$pdf = new HOJASOL('L', PDF_UNIT, 'LETTER', true, 'UTF-8', false);
$fdesde = $general->date_sql_screen($arrays[1], '', 'es', '-');
$fhasta = $general->date_sql_screen($arrays[2], '', 'es', '-');
$pdf->setearTitulo($fdesde, $fhasta);

$pdf->SetAutoPageBreak(true,9.5);
$pdf->SetCreator(PDF_CREATOR);
$pdf->SetAuthor('SISTEMA AGROPATRIA');
$pdf->SetTitle("$sistema - $reporte_");  
$pdf->SetSubject("$sistema");
$pdf->SetKeywords("$sistema");
$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE, PDF_HEADER_STRING);
$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);
$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO); 
$pdf->AddPage();
$pdf->SetY(5);
$pdf->SetLineWidth(0.3);




$pdf->SetFont('helvetica','',8);

if($ban==1)
{

$t='
<table border="0" cellpadding="0" cellspacing="0">
<tr align="left"><td width="60px"><b> Cliente    : </b></td><td>$listadoDespachos[0]["cliente_nombre"] <b>RIF:</b> $listadoDespachos[0]["ced_cliente"] </td></tr>
<tr align="left"><td width="60px"><b> Cultivo    : </b></td><td>($listadoDespachos[0]["cultivo_codigo"]) $listadoDespachos[0]["cultivo_nombre"]   </td></tr>
</table>
<br />

<table border="0" cellpadding="0" cellspacing="0" width="100px" bordercolor="#000000">
<tr bgcolor="#FFFFFF" align="right">
<td width="80px"><b>Entrada #</b></td>
<td width="80px"><b>Orden</b></td>
<td width="75px"><b>Fecha</b></td>
<td width="65px"><b>Placa</b></td>
<td width="85px"><b>Peso Bruto</b></td>
<td width="65px"><b>Tara</b></td>
<td width="90px"><b>Peso Neto</b></td>
<td width="55px"><b> %Hum</b></td>
<td width="75px"><b>Dcto Hum.</b></td>
<td width="55px"><b>%Imp.</b></td>
<td width="70px"><b>Dcto Imp.</b></td>
<td width="5px">&nbsp;</td>
<td width="105px"><b>P. Acondicionado</b></td>
</tr>';

$suma_peso_bruto=0;
$suma_dcto_hum=0;
$suma_dcto_imp=0;
$suma_pacondicionado=0;
$suma_despachos=1;


for($i=0; $i<count($listadoAsociaciones); $i++)
//for($i=0; $i<5; $i++)
{
	Debug::pr($listadoAsociaciones);



		echo '<br />id_asociacion = '.$listadoAsociaciones[$i]['id_asociacion'];
		if($idCA==1)
		{
		 // aqui va todo pero con centro de acopio
		}
		else
		{

			if(isset($listadoAsociaciones[$i]['id_asociacion']))
			{
			echo '<br />existe';
			echo "<br />desde: $fdesde";
			echo "<br />hasta: $hasta";
			$listadoRecepciones = $recepcion->listadoRecepcion('', '', $idCo, '', '', '9', $fdesde, $fhasta, '', '', $idPro, '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion']);
	    echo '<br />cantexiste='.count($listadoRecepciones);
	//	echo '<br />'.$listadoRecepciones[$i]['id_productor'];

			}
			else
			{

   		echo '<br />no existe';
			$listadoRecepciones = $recepcion->listadoRecepcion('', '', $idCo, '', '', '9', $fdesde, $fhasta, '', '', $idPro, '', '', '', '', '', '', '','');
			echo '<br />cantnoexiste='.count($listadoRecepciones);
			echo '<br />'.$listadoRecepciones[$i]['id_productor'];

			}
		Debug::pr($listadoRecepciones);
//gregorya

		}


















 /*
	if($i%2==0) $class="#FFFFFF";
	else $class="#FFFFFF";
$pesobruto=($listadoDespachos[$i]['peso_01l']+$listadoDespachos[$i]['peso_02l']);	
$suma_peso_bruto+=$pesobruto;	
$pesobruto_=$pdf->decimales($pesobruto,3);
$tara=$pesobruto=($listadoDespachos[$i]['peso_01v']+$listadoDespachos[$i]['peso_02v']);
$pesoneto=($pesobruto-$tara);


$dcto_hum=$listadoDespachos[$i]['humedad_des'];	
$suma_dcto_hum+=$dcto_hum;	
$dcto_hum_=$pdf->decimales($dcto_hum,3);
$dcto_imp=$listadoDespachos[$i]['impureza_des'];	
$suma_dcto_imp+=$dcto_imp;	
$dcto_imp_=$pdf->decimales($dcto_imp,3);
$pacondicionado=$listadoDespachos[$i]['peso_acon'];	
$suma_pacondicionado+=$pacondicionado;	
$pacondicionado_=$pdf->decimales($pacondicionado,3);
$hum=$listadoDespachos[$i]['humedad'];
$fecha_des=$general->date_sql_screen($listadoDespachos[$i]['fecha_des'],'','es','-');
$fecha_des_d=$general->date_sql_screen($listadoDespachos[$i]['fecha_des'],'','es','');
$suma_despachos+=$i;



$despacho="D".$listadoDespachos[$i]['numero']."-".$fecha_des_d;
*/

$t.='
<tr bgcolor="'.$class.'">
<td width="80px" align="right">$despacho &nbsp;</td>
<td width="80px"align="right">$listadoDespachos[$i]["numero_guia"] &nbsp;</td>
<td width="75px" align="right">$fecha_des</td>
<td width="65px" align="right">$listadoDespachos[$i]["placa"]</td>
<td width="85px" align="right">$pesobruto_ &nbsp;</td>
<td width="65px" align="right">$pdf->decimales($tara,3) &nbsp;</td>
<td width="90px" align="right">$pdf->decimales($pesoneto,3) &nbsp;</td>
<td width="55px" align="right">$pdf->decimales($hum,3) &nbsp;</td>
<td width="75px" align="right">$dcto_hum_ &nbsp;</td>
<td width="55px" align="right">$listadoDespachos[$i]["impureza"] &nbsp;</td>
<td width="70px" align="right">$dcto_imp_ &nbsp;</td>
<td width="5px">&nbsp;</td>
<td width="105px" align="right">$pacondicionado_ &nbsp;</td>
</tr>
';
}
$t.='
</table>
<table border="0" cellpadding="0" cellspacing="2" width="100px">
<tr>
<td width="80px" align="right"><b>Cantidad: $suma_despachos</b> &nbsp;</td>
<td width="221px" align="right"><div><b>Total: &nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
<td width="77px" align="right"><div style="border-top: 1px solid #000000 ;"><b>$pdf->decimales($suma_peso_bruto,3)</b> &nbsp;</div></td>
<td width="65px" align="right">&nbsp;</td>
<td width="90px" align="right">&nbsp;</td>
<td width="55px" align="right">&nbsp;</td>
<td width="68px" align="right"><div style="border-top: 1px solid #000000 ;"><b>$pdf->decimales($suma_dcto_hum,3)</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="67px" align="right"><div style="border-top: 1px solid #000000 ;"><b>$pdf->decimales($suma_dcto_imp,3)</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="100px" align="right"><div style="border-top: 1px solid #000000;"><b>$pdf->decimales($suma_pacondicionado,3) </b>&nbsp;</div></td>
</tr>
</table>
';
$pdf->writeHTMLCell(200, 0, 18, 30, $t, 0, 1, 0, true, 'J',true);
}
else
{

$t='<table border="0" cellpadding="0" cellspacing="0">
<tr align="center"><td width="900px"><font size="+4" color="#FF0000"><b>NO EXISTEN REGISTRO EN LA LISTA DE DESPACHOS</b></font> </td></tr>
</table>
';
$pdf->writeHTMLCell(200, 0, 15, 30, $t, 0, 1, 0, true, 'C',true);
}


$pdf->Ln(4);
$pdf->Output($reporte_.'_'.date('d-m-Y').'.pdf', 'I');
?>




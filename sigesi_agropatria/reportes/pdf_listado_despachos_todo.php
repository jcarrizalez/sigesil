<?php
require_once('../lib/core.lib.php');
include('../lib/class/tcpdf/config/lang/spa.php');
include('../lib/class/tcpdf/tcpdf.php');
$despacho = new Despacho();

if(isset($GPC['id']))
{
	$arrays=explode('_',$GPC['id']);
	if(isset($arrays[0]) and isset($arrays[1]))
		$ban=1;
	else
		$ban=0;
}
else
$ban=0;


$sistema='AGROPATRIA C.A.';

if($ban==1)
{

$arrays=explode('_',$GPC['id']);
if (isset($arrays[3]))
$centro_acopio=$arrays[3];
else
$centro_acopio='';

$listadoDespachosdatos = $despacho->listadoDespacho('', $centro_acopio, '', '', '', "'5'",'2012-04-18','2012-04-18','','','');
//$listadoDespachos = $despacho->listadoDespacho('', $centro_acopio, '', '', '', "'5'",$arrays[1],$arrays[2],'','','');
//$listadoDespachos = $despacho->listadoDespacho($arrays[0], '', '', '', '', "'5'",$arrays[1],$arrays[2]);
//Debug::pr($listadoDespachos);


$reporte_='LISTADO_DESDE_'.$arrays[1].'_HASTA_'.$arrays[2];
}
else
$reporte_='REPORTE_SIN_DATOS';





class HOJASOL extends tcpdf{
   
    function mayus($let) { return strtr(strtoupper($let),"àèìòùáéíóúçñäëïöü","ÀÈÌÒÙÁÉÍÓÚÇÑÄËÏÖÜ");}

    function Header()
    {
		$this->SetMargins(10,30, 10);	
		$this->SetDisplayMode(85) ;
		//if($ban==1)
		$this->writeHTMLCell(0, 0, '', '10', '<font><b>LISTADO DE DESPACHOS</b></font>', 0, 1, 0, true, 'C');
		$this->writeHTMLCell(0, 0, '1', '7', '<font><b>Fecha: '.date('d/m/Y').'</b></font>&nbsp;&nbsp;&nbsp;&nbsp;', 0, 1, 0, true, 'R');
		$this->writeHTMLCell(0, 0, '18', '2', 'Pagina'.$this->getAliasNumPage().'/'.$this->getAliasNbPages(), 0, 1, 0, true, 'L');
    }
    function Footer()
    {
	$this->setFooterMargin(0);
	$this->SetY(-10);
	//$this->Cell(0, 10, 'Pagina '.$this->getAliasNumPage().'/'.$this->getAliasNbPages(),0, 1, 'C');
    }
}

   

$pdf = new HOJASOL('L', PDF_UNIT, 'LETTER', true, 'UTF-8', false);


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


////////////////////////////////////////////////////////////////

$t='';
$cant_registros=0;
for($j=0; $j<count($listadoDespachosdatos); $j++)
{

$t.='
<table border="0" cellpadding="0" cellspacing="0">
<tr align="left"><td width="100px"> Cliente    : </td><td>'.$listadoDespachosdatos[$j]['cliente_nombre'].'  RIF: '.$listadoDespachosdatos[$j]['ced_cliente'].' </td></tr>
<tr align="left"><td width="100px"> Cultivo    :  </td><td>'.$listadoDespachosdatos[$j]['cultivo_codigo'].' - '.$listadoDespachosdatos[$j]['cultivo_nombre'].'   </td></tr>
</table>
<br />

<table border="1" cellpadding="0" cellspacing="0" width="100px" bordercolor="#000000">
<tr bgcolor="#FFFFFF" align="center">
<td width="80px">Despacho #</td>
<td width="80px">Orden</td>
<td width="75px">Fecha</td>
<td width="65px">Placa</td>
<td width="85px">Peso Bruto</td>
<td width="65px">Tara</td>
<td width="90px">Peso Neto</td>
<td width="55px"> %Hum</td>
<td width="75px">Dcto Hum.</td>
<td width="55px">%Imp.</td>
<td width="70px">Dcto Imp.</td>
<td width="115px">P. Acondicionado</td>
</tr>';


$suma_peso_bruto=0;
$suma_dcto_hum=0;

$listadoDespachos = $despacho->listadoDespacho('', $centro_acopio, '', '', '', "'5'",'2012-04-18','2012-04-18','','','');

for($i=0; $i<count($listadoDespachos); $i++)
{

// $micantidad=$cant_registros+=$i;
	if($i%2==0) $class="#FFFFFF";
	else $class="#FFFFFF";
$pesobruto=($listadoDespachos[$i]['peso_01l']+$listadoDespachos[$i]['peso_02l']);	
$suma_peso_bruto+=$pesobruto;	
$pesobruto_=$pdf->decimales($pesobruto);
$tara=$pesobruto=($listadoDespachos[$i]['peso_01v']+$listadoDespachos[$i]['peso_02v']);
$pesoneto=($pesobruto-$tara);


$dcto_hum=$listadoDespachos[$i]['humedad_des'];	
$suma_dcto_hum+=$dcto_hum;	
$dcto_hum_=$pdf->decimales($dcto_hum);
$dcto_imp=$listadoDespachos[$i]['impureza_des'];	
$suma_dcto_imp+=$dcto_imp;	
$dcto_imp_=$pdf->decimales($dcto_imp);
$pacondicionado=$listadoDespachos[$i]['peso_acon'];	
$suma_pacondicionado+=$pacondicionado;	
$pacondicionado_=$pdf->decimales($pacondicionado);
$hum=$listadoDespachos[$i]['humedad'];
$fecha_des=$general->date_sql_screen($listadoDespachos[$i]['fecha_des'],'','es','');

$despacho="D".$listadoDespachos[$i]['numero']."-".$fecha_des;


$t.='
<tr bgcolor="'.$class.'">
<td width="80px" align="right">'.$despacho.' &nbsp;</td>
<td width="80px"align="right">'.$listadoDespachos[$i]['numero_guia'].' &nbsp;</td>
<td width="75px" align="center">'.$fecha_des.'</td>
<td width="65px" align="center">'.$listadoDespachos[$i]['placa'].'</td>
<td width="85px" align="right">'.$pesobruto_.' &nbsp;</td>
<td width="65px" align="right">'.$pdf->decimales($tara).' &nbsp;</td>
<td width="90px" align="right">'.$pdf->decimales($pesoneto).' &nbsp;</td>
<td width="55px" align="right">'.$pdf->decimales($hum).' &nbsp;</td>
<td width="75px" align="right">'.$dcto_hum_.' &nbsp;</td>
<td width="55px" align="right">'.$listadoDespachos[$i]['impureza'].' &nbsp;</td>
<td width="70px" align="right">'.$dcto_imp_.' &nbsp;</td>
<td width="115px" align="right">'.$pacondicionado_.' &nbsp;</td>
</tr>
';
}
$t.='
</table>
<table border="0" cellpadding="0" cellspacing="0" width="100px">
<tr>
<td width="301px" align="right"><b>Totales: &nbsp;&nbsp;&nbsp;&nbsp;</b></td>
<td width="84px" align="right"><div style="border-left: 1px solid #000000 ; border-right: 1px solid #000000;  border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_peso_bruto).'</b> &nbsp;</div></td>
<td width="65px" align="right">&nbsp;</td>
<td width="90px" align="right">&nbsp;</td>
<td width="55px" align="right">&nbsp;</td>
<td width="75px" align="right"><div style="border-left: 1px solid #000000 ; border-right: 1px solid #000000;  border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_hum).'</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="70px" align="right"><div style="border-left: 1px solid #000000 ;  border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_imp).'</b> &nbsp;</div></td>
<td width="114px" align="right"><div style="border-left: 1px solid #000000 ; border-right: 1px solid #000000;  border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado).' </b>&nbsp;</div></td>
</tr>
</table>
<br />';

}

////////////////////////////////////////////////////////////////
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



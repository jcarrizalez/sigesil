<?php
session_start();
require_once('../lib/core.lib.php');
include('../lib/class/tcpdf/config/lang/spa.php');
include('../lib/class/tcpdf/tcpdf.php');
$despacho = new Despacho();
$despacho2 = new Despacho();


$_SESSION['fdesde'] = valor;
            


if(isset($GPC['id']))
{
	$arrays=explode('_',$GPC['id']);
	if(isset($arrays[0]) and isset($arrays[1]))
	{
		$ban=1;
	$_SESSION['fdesde'] = $arrays[0];	
	}
	else
		$ban=0;
}
else
$ban=0;

$sistema='AGROPATRIA C.A.';
if($ban==1)
{
	if(isset($arrays[2]))
	$centro_acopio=$arrays[2];
	else
	$centro_acopio='';

$listadoDespachosdatos =  $despacho->despachosReporteGeneral($arrays[0], $arrays[1], $centro_acopio);
if(count($listadoDespachosdatos)<1)
{
$ban=0;
}
$reporte_='DESPACHOS_DESDE_'.$arrays[0].'_HASTA_'.$arrays[1];
}
else
$reporte_='REPORTE_SIN_DATOS';





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
		$this->writeHTMLCell(0, 0, '', '10', "<font><b>$this->titulo</b></font> <br /><font size='6'><b>SILO: (".$_SESSION['s_ca_codigo'].") ".$_SESSION['s_ca_nombre']."</b> </font>", 0, 1, 0, true, 'C');
		$this->writeHTMLCell(0, 0, '1', '7', '<font>Fecha: '.date('d/m/Y').'</font>&nbsp;&nbsp;&nbsp;&nbsp;', 0, 1, 0, true, 'R');
		
    }
    function Footer()
    {
	$this->setFooterMargin(0);
	$this->SetY(-10);
    }
}

   

$pdf = new HOJASOL('L', PDF_UNIT, 'LETTER', true, 'UTF-8', false);
$fdesde = $general->date_sql_screen($arrays[0], '', 'es', '-');
$fhasta = $general->date_sql_screen($arrays[1], '', 'es', '-');
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


$t='';
$cant_registros=0;
$suma_peso_bruto_general=0;
$suma_dcto_imp_general=0;
$suma_dcto_hum_general=0;
$suma_dcto_imp_general=0;
$suma_pacondicionado_general=0;
$suma_pneto_general=0;
$suma_tara_general=0;
$suma_despachos_general=0;


for($j=0; $j<count($listadoDespachosdatos); $j++)
{
$listadoDespachos = $despacho2->listadoDespacho('', $centro_acopio, '', '', '', "'5'",$arrays[0],$arrays[1],'','',$listadoDespachosdatos[$j]['numero_orden']);
$t.='
<table border="0" cellpadding="0" cellspacing="0">
<tr align="left"><td width="60px"><b> Cliente    :</b></td><td>'.$listadoDespachosdatos[$j]['nombre_cliente'].' <b> RIF: </b>'.$listadoDespachosdatos[$j]['ced_rif'].' </td></tr>
<tr align="left"><td width="60px"><b> Cultivo    :</b></td><td>'.$listadoDespachosdatos[$j]['cultivo'].'   </td></tr>
</table>
<br />

<table border="0" cellpadding="0" cellspacing="0" width="100px" bordercolor="#000000">
<tr bgcolor="#FFFFFF" align="right">
<td width="80px"><b>Despacho #</b></td>
<td width="80px"><b>Orden</b></td>
<td width="75px"><b>Fecha</b></td>
<td width="65px"><b>Placa</b></td>
<td width="80px"><b>Peso Bruto</b></td>
<td width="5px">&nbsp;</td>
<td width="65px"><b>Tara</b></td>
<td width="5px">&nbsp;</td>
<td width="70px"><b>Peso Neto</b></td>
<td width="55px"><b> %Hum</b></td>
<td width="75px"><b>Dcto Hum.</b></td>
<td width="55px"><b>%Imp.</b></td>
<td width="65px"><b>Dcto Imp.</b></td>
<td width="5px">&nbsp;</td>
<td width="105px"><b>P. Acondicionado</b></td>
</tr>
';

$suma_peso_bruto=0;
$suma_dcto_hum=0;
$suma_dcto_imp=0;
$suma_pacondicionado=0;
$suma_despachos=0;
$suma_peso_neto=0;
$suma_tara=0;

for($i=0; $i<count($listadoDespachos); $i++)
{
	if($i%2==0) $class="#FFFFFF";
	else $class="#FFFFFF";
$pesobruto=($listadoDespachos[$i]['peso_01l']+$listadoDespachos[$i]['peso_02l']);	
$suma_peso_bruto+=$pesobruto;	
$pesobruto_=$pdf->decimales($pesobruto,2);


$tara=($listadoDespachos[$i]['peso_01v']+$listadoDespachos[$i]['peso_02v']);
$pesoneto=($pesobruto-$tara);
$dcto_hum=$listadoDespachos[$i]['humedad_des'];	
$suma_dcto_hum+=$dcto_hum;	
$dcto_hum_=$pdf->decimales($dcto_hum,2);
$dcto_imp=$listadoDespachos[$i]['impureza_des'];	
$suma_dcto_imp+=$dcto_imp;	
$dcto_imp_=$pdf->decimales($dcto_imp,2);
$pacondicionado=$listadoDespachos[$i]['peso_acon_liq'];	
$suma_pacondicionado+=$pacondicionado;
$pacondicionado_=$pdf->decimales($pacondicionado,2);
$hum=$listadoDespachos[$i]['humedad'];
$fecha_des=$general->date_sql_screen($listadoDespachos[$i]['fecha_des'],'','es','-');
$fecha_des_d=$general->date_sql_screen($listadoDespachos[$i]['fecha_des'],'','es','');
$despacho="D".$listadoDespachos[$i]['numero']."-".$fecha_des_d;
$suma_pneto+=$pesoneto;
$suma_tara+=$tara;
$suma_despachos+=$i;

$t.='
<tr bgcolor="'.$class.'">
<td width="80px" align="right">'.$despacho.' &nbsp;</td>
<td width="80px" align="right">'.$listadoDespachos[$i]['numero_guia'].'</td>
<td width="75px" align="right">'.$fecha_des.'</td>
<td width="65px" align="right">'.$listadoDespachos[$i]['placa'].'</td>
<td width="5px">&nbsp;</td>
<td width="80px" align="right">'.$pesobruto_.' &nbsp;</td>
<td width="5px">&nbsp;</td>
<td width="65px" align="right">'.$pdf->decimales($tara,2).'</td>
<td width="70px" align="right">'.$pdf->decimales($pesoneto,2).'</td>
<td width="55px" align="right">'.$pdf->decimales($hum,2).'</td>
<td width="75px" align="right">'.$dcto_hum_.'</td>
<td width="55px" align="right">'.$listadoDespachos[$i]['impureza'].'</td>
<td width="65px" align="right">'.$dcto_imp_.'</td>
<td width="5px">&nbsp;</td>
<td width="105px" align="right">'.$pacondicionado_.'</td>
</tr>
';
}

$suma_despachos=count($listadoDespachos);
$t.='
</table>
<table border="0" cellpadding="0" cellspacing="2" width="100px">
<tr>
<td width="80px" align="right"><b>Cantidad: '.$suma_despachos.'</b> &nbsp;</td>
<td width="221px" align="right"><div><b> Total: &nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
<td width="77px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_peso_bruto,2).'</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="65px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_tara,2).'</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="60px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_pneto,2).'</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="72px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_hum,2).'</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="61px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_imp,2).'</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="101px" align="right"><div style="border-top:1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado,2).' </b>&nbsp;</div></td>
</tr>
</table>
<br /><br />';

$suma_peso_bruto_general+=$suma_peso_bruto;
$suma_dcto_hum_general+=$suma_dcto_hum;
$suma_dcto_imp_general+=$suma_dcto_imp;
$suma_pacondicionado_general+=$suma_pacondicionado;

$suma_tara_general+=$suma_tara;
$suma_pneto_general+=$suma_pneto;

$suma_despachos_general+=$suma_despachos;
}
//<tr><td colspan="11"><b>Total General: &nbsp;&nbsp;&nbsp;&nbsp;</b></td></tr>
$t.='
</table>
<table border="0" cellpadding="0" cellspacing="2" width="100px">

<tr>
<td width="305px" align="left"><b>Cantidad Total: ('.$suma_despachos_general.')&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;Total General: &nbsp;</b> </td>
<td width="75px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_peso_bruto_general,2).'</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="65px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_tara_general,2).'</b> &nbsp;</div></td>
<td width="5px" align="right">&nbsp;</td>
<td width="58px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_pneto_general,2).'</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="74px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_hum_general,2).'</b> &nbsp;</div></td>
<td width="55px" align="right">&nbsp;</td>
<td width="62px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_dcto_imp_general,2).'</b> &nbsp;</div></td>
<td width="5px">&nbsp;</td>
<td width="99px" align="right"><div style="border-bottom:1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado_general,2).'</b>&nbsp;&nbsp;</div></td>
</tr>


</table>
<br /><br />';

$pdf->writeHTMLCell(200, 0, 18, 30, $t, 0, 1, 0, true, 'J',true);

}
else
{
$t='<table border="0" cellpadding="0" cellspacing="0"><tr align="center"><td width="900px"><font size="+4" color="#FF0000"><b>NO EXISTEN REGISTRO EN LA LISTA DE DESPACHOS</b></font> </td></tr></table>';
$pdf->writeHTMLCell(200, 0, 15, 30, $t, 0, 1, 0, true, 'C',true);
}

$pdf->Ln(4);
$pdf->Output($reporte_.'.pdf', 'I');
?>



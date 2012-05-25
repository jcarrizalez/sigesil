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
	$fdesde_=$arrays[2];
	$fhasta_=$arrays[3];
$reporte_='RECEPCIONES_'.$fdesde_.'_al_'.$fhasta_;
  }
	else
	{		$ban = 0;
	$reporte_='REPORTE_SIN_DATOS';
  }

	if(isset($arrays[4]))
	{	//$idCA_ = 1;
	$idCA_=$arrays[4];
  }
	else
	{	$idCA_ = null;
  }

}
else
{
		$ban = 0;
   	$idCA_ = null;
$reporte_='REPORTE_SIN_DATOS';
}

//	echo '<br />'.$ban;
$sistema='AGROPATRIA C.A.';



	if($ban==1)
	{

//echo 'idCA_='.$idCA_;
//		if($idCA_==1)
//		{ //echo '1';
    //  echo "recepcionPdf(".$fdesde_.", ".$fhasta_.", '9', ".$idCo.", ".$idPro.", '', ".$idCA_.")";
			$listadoAsociaciones = $recepcion->recepcionPdf($fdesde_, $fhasta_, '9', $idCo, $idPro, '', $idCA_);
//echo 'catn1='.count($listadoAsociaciones);
//		}
//		else
//		{ 
//			$listadoAsociaciones = $recepcion->recepcionPdf($fdesde_, $fhasta_, '9', $idCo, $idPro, '', '');
//		}

	//echo 'ff';
  }

class HOJASOL extends tcpdf{
    
    var $titulo = '';

    function setearTitulo($fdesde, $fhasta,$cosecha=null){
        if($fdesde == $fhasta)
            $this->titulo = 'LISTADO DE RECEPCIONES PARA LA FECHA '.$fdesde.'<br />"COSECHA '.$cosecha.'"';
        else
            $this->titulo = 'LISTADO DE RECEPCIONES DESDE '.$fdesde.' HASTA '.$fhasta.'<br />"COSECHA '.$cosecha.'"';
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
$fdesde = $general->date_sql_screen($fdesde_, '', 'es', '-');
$fhasta = $general->date_sql_screen($fhasta_, '', 'es', '-');
$cosecha = $recepcion->listadoRecepcion('', $idCA_, $idCo, '', '', '9', $fdesde_, $fhasta_, '', '', $idPro);
//Debug::pr($cosecha);
$cosecha=' ['.$cosecha[0]['cosecha_codigo'].'] '.$cosecha[0]['cosecha'].' ';
$pdf->setearTitulo($fdesde, $fhasta, $cosecha);

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
//	Debug::pr($listadoAsociaciones);

			$Productor = $recepcion->listadoRecepcion('', $idCA_, $idCo, '', '', '9', $fdesde_, $fhasta_, '', '', $idPro, '', '', '', '', '', '', '');

			$t.='<table border="0" cellpadding="0" cellspacing="0">
			<tr align="left"><td width="70px"><b> Productor: </b></td><td>'.$Productor[0]['productor_nombre'].' <b>&nbsp;&nbsp;RIF:</b> '.$Productor[0]['ced_productor'].' </td></tr>
			</table>
			<br />';

for($i=0; $i<count($listadoAsociaciones); $i++)
{																																	// 		FORLISTADOASOCIADOS
			if(isset($listadoAsociaciones[$i]['id_asociacion']))				
			{																														//		IFA
	$listadoAcion = $recepcion->listadoRecepcion('', $idCA_, $idCo, '', '', '9', $fdesde_, $fhasta_, '', '', $idPro, '', '', '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion'],'','');
//Debug::pr($listadoAcion);

			$t.='
<table border="0" cellpadding="0" cellspacing="0">
	<tr align="center"><td width="890px"><b> Asociacion : </b>'.$listadoAcion[0]['asociacion_nombre'].' <b>&nbsp;&nbsp;RIF:</b> '.$listadoAcion[0]['ced_asociacion'].' </td></tr>
			</table>
			';
      $listadoProductores = $recepcion->recepcionPdf($fdesde_, $fhasta_, '9', $idCo, $idPro, $listadoAsociaciones[$i]['id_asociacion'],$idCA_,'asociado');
	//		Debug::pr($listadoProductores);
  //    echo count($listadoProductores);

for($j=0; $j<count($listadoProductores); $j++)
{																																	//   FORPRODUCTORES

			$listadoRecepciones_ = $recepcion->listadoRecepcion('',$idCA_, $idCo, '', '', '9', $fdesde_, $fhasta_, '', '', $idPro, '', '', '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion'],'',$listadoProductores[$j]['id_asociado']);
//Debug::pr($listadoRecepciones_);

			$t.='<table border="0" cellpadding="0" cellspacing="0">
			<tr align="left"><td width="70px"><b> Asociado : </b></td><td>'.$listadoRecepciones_[$j]['asociado_nombre'].' <b>&nbsp;&nbsp;RIF:</b> '.$listadoRecepciones_[$j]['ced_asociado'].' </td></tr>
			</table>
			';


      $t.='<table border="0" cellpadding="0" cellspacing="0" width="100px" bordercolor="#000000">
					<tr bgcolor="#FFFFFF" align="right">
					<td width="75px"><b>Entrada #</b></td>
					<td width="70px"><b>Orden</b></td>
					<td width="60px"><b>Fecha</b></td>
					<td width="65px"><b>Placa</b></td>
					<td width="85px"><b>Peso Bruto</b></td>
					<td width="5px">&nbsp;</td>
					<td width="65px"><b>Tara</b></td>
					<td width="5px">&nbsp;</td>
					<td width="70px"><b>Peso Neto</b></td>
					<td width="5px">&nbsp;</td>
					<td width="50px"><b> %Hum</b></td>
					<td width="5px">&nbsp;</td>
					<td width="60px"><b>Dcto Hum.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="50px"><b>%Imp.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="60px"><b>Dcto Imp.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="80px"><b>P. Acond.Liq.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="75px"><b>Peso Acond.</b></td>
					</tr>';


$suma_peso_bruto=0;
$suma_tara=0;
$suma_pesoneto=0;
$suma_dcto_hum=0;
$suma_hum=0;
$suma_dcto_imp=0;
$suma_imp=0;
$suma_pacondicionado=0;
$suma_pacondicionado_liq=0;






for($z=0; $z<count($listadoRecepciones_); $z++)     //   FORRECPCUIONES
{

				$suma_entrada=1;
				$pesobruto=($listadoRecepciones_[$z]['peso_01l']+$listadoRecepciones_[$z]['peso_02l']);	
				$suma_peso_bruto+=$pesobruto;
				$pesobruto_=$pdf->decimales($pesobruto,3);
				$tara=($listadoRecepciones_[$z]['peso_01v']+$listadoRecepciones_[$z]['peso_02v']);
				$suma_tara+=$tara;
				$pesoneto=($pesobruto-$tara);
				$suma_pesoneto+=$pesoneto;

					if(isset($listadoRecepciones_[$z]['placa_remolques']))
					{$placa=$listadoRecepciones_[$z]['placa'].'/'.$listadoRecepciones_[$z]['placa_remolques'];}
					else
					{$placa=$listadoRecepciones_[$z]['placa'];}

				$dcto_hum=$listadoRecepciones_[$z]['humedad_des'];	
				$suma_dcto_hum+=$dcto_hum;	
				$hum=$listadoRecepciones_[$z]['humedad']; //echo '<br />'.$listadoRecepciones_[$z]['humedad'];
			  $suma_hum+=$listadoRecepciones_[$z]['humedad'];
				$imp=$listadoRecepciones_[$z]['impureza'];
				$suma_imp+=$listadoRecepciones_[$z]['impureza'];

				$dcto_hum_=$pdf->decimales($dcto_hum,3);
				$dcto_imp=$listadoRecepciones_[$z]['impureza_des'];	
				$suma_dcto_imp+=$dcto_imp;
				$dcto_imp_=$pdf->decimales($dcto_imp,3);
				$pacondicionado=$listadoRecepciones_[$z]['peso_acon_liq'];	
				$suma_pacondicionado+=$pacondicionado;	
				$pacondicionado_=$pdf->decimales($pacondicionado,3);


				$pacondicionado_liq=$listadoRecepciones_[$z]['peso_acon'];	
				$suma_pacondicionado_liq+=$pacondicionado_liq;	
				$pacondicionado__liq=$pdf->decimales($pacondicionado_liq,3);


				
				$suma_entrada+=$j;

				$fecha_rep=$general->date_sql_screen($listadoRecepciones_[$z]['fecha_recepcion'],'','es','-');
				$fecha_rep_d=$general->date_sql_screen($listadoRecepciones_[$z]['fecha_recepcion'],'','es','');
				$entrada="R".$listadoRecepciones_[$z]['numero']."-".$fecha_rep_d;

				$t.='<tr bgcolor="#FFFFFF" align="right">
				<td align="right">'.$entrada.' &nbsp;</td>
				<td align="right">'.$listadoRecepciones_[$z]['numero_guia'].' </td>
				<td align="right">'.$fecha_rep.'</td>
				<td align="right">'.$listadoRecepciones_[$z]['placa'].'</td>
				<td align="right">'.$pesobruto_.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($tara,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($pesoneto,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$hum.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$dcto_hum_.' &nbsp;</td>
				<td>&nbsp;</td>
				<td align="right">'.$imp.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$dcto_imp_.' &nbsp;</td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($pacondicionado_liq,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pacondicionado_.' &nbsp;</td>
				</tr>';




}          //   FORRECPCUIONES

$t.='</table>';

if($suma_entrada>1)        //   IFB
{
      $t.='<table border="0" cellpadding="0" cellspacing="2" width="100px" bordercolor="#000000">
					<tr bgcolor="#FFFFFF" align="right">
					<td width="75px" align="right"><b>Cantidad: '.$suma_entrada.'</b> &nbsp;</td>
	        <td width="195px" align="right"><div><b>Total: &nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	        <td width="79px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_peso_bruto,3).'</b> </div></td>
					<td width="6px">&nbsp;</td>
					<td width="60px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_tara,3).'</b></div></td>
					<td width="5px">&nbsp;</td>
					<td width="65px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_pesoneto,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="42px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_hum,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="48px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_hum,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="45px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_imp,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="47px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_imp,3).'</b> </div></td>
					<td width="15px">&nbsp;</td>
					<td width="69px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado_liq,3).' </b></div></td>
					<td width="15px">&nbsp;</td>
					<td width="57px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado,3).' </b></div></td>
					</tr>
					</table>
					';

}        //   IFB
$t.='<br />'; 


$suma_peso_bruto_general+=$suma_peso_bruto;
$suma_tara_general+=$suma_tara;
$suma_pesoneto_general+=$suma_pesoneto;
$suma_dcto_hum_general+=$suma_dcto_hum;
$suma_dcto_imp_general+=$suma_dcto_imp;
$suma_pacondicionado_general+=$suma_pacondicionado;
$suma_entrada_general+=$suma_entrada;
$suma_hum_general+=$suma_hum;
$suma_imp_general+=$suma_imp;
$suma_pacondicionado_liq_general+=$suma_pacondicionado_liq;















}							//   FORPRODUCTORES



			$t.='<br />';



			}			//		IFA
			else
			{				// 		ELSEA


      $listadoProductores = $recepcion->recepcionPdf($fdesde_, $fhasta_, '9', $idCo, $idPro, 0,$idCA_,'asociado');
	//		Debug::pr($listadoProductores);
  //    echo count($listadoProductores);



for($j=0; $j<count($listadoProductores); $j++)
{																																	//   FORPRODUCTORES

			$listadoRecepciones_ = $recepcion->listadoRecepcion('',$idCA_, $idCo, '', '', '9', $fdesde_, $fhasta_, '', '', $idPro, '', '', '', '', '', '', '', '', '', $listadoAsociaciones[$i]['id_asociacion'],'',$listadoProductores[$j]['id_asociado']);
//Debug::pr($listadoRecepciones_);


if($listadoRecepciones_[$j]['asociado_nombre']!=null)
{
			$t.='<table border="0" cellpadding="0" cellspacing="0">
			<tr align="left"><td width="70px"><b> Asociado : </b></td><td>'.$listadoRecepciones_[$j]['asociado_nombre'].' <b>&nbsp;&nbsp;RIF:</b> '.$listadoRecepciones_[$j]['ced_asociado'].' </td></tr>
			</table>
			';
}



      $t.='<table border="0" cellpadding="0" cellspacing="0" width="100px" bordercolor="#000000">
					<tr bgcolor="#FFFFFF" align="right">
					<td width="75px"><b>Entrada #</b></td>
					<td width="70px"><b>Orden</b></td>
					<td width="60px"><b>Fecha</b></td>
					<td width="65px"><b>Placa</b></td>
					<td width="85px"><b>Peso Bruto</b></td>
					<td width="5px">&nbsp;</td>
					<td width="65px"><b>Tara</b></td>
					<td width="5px">&nbsp;</td>
					<td width="70px"><b>Peso Neto</b></td>
					<td width="5px">&nbsp;</td>
					<td width="50px"><b> %Hum</b></td>
					<td width="5px">&nbsp;</td>
					<td width="60px"><b>Dcto Hum.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="50px"><b>%Imp.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="60px"><b>Dcto Imp.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="80px"><b>P. Acond.Liq.</b></td>
					<td width="5px">&nbsp;</td>
					<td width="75px"><b>Peso Acond.</b></td>
					</tr>';


$suma_peso_bruto=0;
$suma_tara=0;
$suma_pesoneto=0;
$suma_dcto_hum=0;
$suma_hum=0;
$suma_dcto_imp=0;
$suma_imp=0;
$suma_pacondicionado=0;
$suma_pacondicionado_liq=0;




for($z=0; $z<count($listadoRecepciones_); $z++)     //   FORRECPCUIONES
{

				$suma_entrada=1;
				$pesobruto=($listadoRecepciones_[$z]['peso_01l']+$listadoRecepciones_[$z]['peso_02l']);	
				$suma_peso_bruto+=$pesobruto;	
				$pesobruto_=$pdf->decimales($pesobruto,3);
				$tara=($listadoRecepciones_[$z]['peso_01v']+$listadoRecepciones_[$z]['peso_02v']);
				$suma_tara+=$tara;				
				$pesoneto=($pesobruto-$tara);
				$suma_pesoneto+=$pesoneto;

					if(isset($listadoRecepciones_[$z]['placa_remolques']))
					{$placa=$listadoRecepciones_[$z]['placa'].'/'.$listadoRecepciones_[$z]['placa_remolques'];}
					else
					{$placa=$listadoRecepciones_[$z]['placa'];}

				$dcto_hum=$listadoRecepciones_[$z]['humedad_des'];	
				$suma_dcto_hum+=$dcto_hum;	

			  $suma_hum+=$listadoRecepciones_[$z]['humedad'];
				$suma_imp+=$listadoRecepciones_[$z]['impureza'];




				$dcto_hum_=$pdf->decimales($dcto_hum,3);
				$dcto_imp=$listadoRecepciones_[$z]['impureza_des'];	
				$suma_dcto_imp+=$dcto_imp;	
				$dcto_imp_=$pdf->decimales($dcto_imp,3);
				$pacondicionado=$listadoRecepciones_[$z]['peso_acon_liq'];	
				$suma_pacondicionado+=$pacondicionado;	
				$pacondicionado_=$pdf->decimales($pacondicionado,3);

				$pacondicionado_liq=$listadoRecepciones_[$z]['peso_acon'];	
				$suma_pacondicionado_liq+=$pacondicionado_liq;	
				$pacondicionado__liq=$pdf->decimales($pacondicionado_liq,3);

				$hum=$listadoRecepciones_[$z]['humedad'];
				$suma_entrada+=$j;

				$fecha_rep=$general->date_sql_screen($listadoRecepciones_[$z]['fecha_recepcion'],'','es','-');
				$fecha_rep_d=$general->date_sql_screen($listadoRecepciones_[$z]['fecha_recepcion'],'','es','');
				$entrada="R".$listadoRecepciones_[$z]['numero']."-".$fecha_rep_d;

				$t.='<tr bgcolor="#FFFFFF" align="right">
				<td align="right">'.$entrada.' &nbsp;</td>
				<td align="right">'.$listadoRecepciones_[$z]['numero_guia'].' </td>
				<td align="right">'.$fecha_rep.'</td>
				<td align="right">'.$listadoRecepciones_[$z]['placa'].'</td>
				<td align="right">'.$pesobruto_.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($tara,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($pesoneto,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$hum.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$dcto_hum_.' &nbsp;</td>
				<td>&nbsp;</td>
				<td align="right">'.$listadoRecepciones_[$z]['impureza'].' </td>

				<td>&nbsp;</td>
				<td align="right">'.$dcto_imp_.' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pdf->decimales($pacondicionado_liq,3).' </td>
				<td>&nbsp;</td>
				<td align="right">'.$pacondicionado_.' </td>
				</tr>';




}          //   FORRECPCUIONES

$t.='</table>';

if($suma_entrada>1)        //   IFB
{
      $t.='<table border="0" cellpadding="0" cellspacing="2" width="100px" bordercolor="#000000">
					<tr bgcolor="#FFFFFF" align="right">
					<td width="75px" align="right"><b>Cantidad: '.$suma_entrada.'</b> &nbsp;</td>
	        <td width="195px" align="right"><div><b>Total: &nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	        <td width="79px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_peso_bruto,3).'</b> </div></td>
					<td width="6px">&nbsp;</td>
					<td width="60px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_tara,3).'</b></div></td>
					<td width="5px">&nbsp;</td>
					<td width="65px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_pesoneto,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="42px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_hum,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="48px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_hum,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="45px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_imp,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="47px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_imp,3).'</b> </div></td>
					<td width="15px">&nbsp;</td>
					<td width="69px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado_liq,3).' </b></div></td>
					<td width="15px">&nbsp;</td>
					<td width="57px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado,3).' </b></div></td>
					</tr>
					</table>
					';



}        //   IFB
$t.='<br />';                  





$suma_peso_bruto_general+=$suma_peso_bruto;
$suma_dcto_hum_general+=$suma_dcto_hum;
$suma_dcto_imp_general+=$suma_dcto_imp;
$suma_pacondicionado_general+=$suma_pacondicionado;
$suma_entrada_general+=$suma_entrada;
$suma_tara_general+=$suma_tara;
$suma_pesoneto_general+=$suma_pesoneto;
$suma_hum_general+=$suma_hum;
$suma_imp_general+=$suma_imp;
$suma_pacondicionado_liq_general+=$suma_pacondicionado_liq;

}							//   FORPRODUCTORES




			}				//		ELSEA



}		// 		FORLISTADOASOCIADOS



      $t.='<br /> <br />
					<table border="0" cellpadding="0" cellspacing="2" width="100px" bordercolor="#000000">
					<tr bgcolor="#FFFFFF" align="right">
					<td width="75px" align="right"><b>Cantidad: '.$suma_entrada_general.'</b> &nbsp;</td>
	        <td width="195px" align="right"><div><b>Total General: &nbsp;&nbsp;&nbsp;&nbsp;</b></div></td>
	        <td width="79px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_peso_bruto_general,3).'</b> </div></td>
					<td width="6px">&nbsp;</td>
					<td width="60px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_tara_general,3).'</b></div></td>
					<td width="5px">&nbsp;</td>
					<td width="65px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_pesoneto_general,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="42px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_hum_general,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="48px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_hum_general,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="45px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_imp_general,3).'</b></div></td>
					<td width="10px">&nbsp;</td>
					<td width="47px" align="right"><div style="border-top: 1px solid #000000 ;"><b>'.$pdf->decimales($suma_dcto_imp_general,3).'</b> </div></td>
					<td width="15px">&nbsp;</td>
					<td width="69px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado_liq_general,3).' </b></div></td>
					<td width="15px">&nbsp;</td>
					<td width="57px" align="right"><div style="border-top: 1px solid #000000;"><b>'.$pdf->decimales($suma_pacondicionado_general,3).' </b></div></td>
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
$pdf->Output($reporte_.'_.pdf', 'I');
?>




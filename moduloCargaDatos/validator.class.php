<?php
/* VALIDADOR  V.1.0
	EN ESTE EJEMPLO asumimos QUE EL FORM SE LLAMA form1 <form name="form1">
	asumimos tambien que hay un input text box que  se llama txttitle <input type="text" name="txttitle">
	DENTRO DEL <HEAD> COLOCAR ALGO COMO ESTO
	 	$validator=new validator("form1"); //CREA EL OBJETO VALIDATOR E INDICA EL NOMBRE DEL FORM
		$validator->create_message("id_title", "txttitle", "(Field required)"); //CREO EL MENSAJE DE VALIDACION Y EL OBJETO QUE VOY A CONTROLAR
		$validator->print_script();  //IMPRIMO EL SCRIPT
	DONDE QUEREMOS COLOCAR EL MENSAJE DEL VALIDADOR, COLOCAMOS ESTO
		$validator->show("id_title"); 
	AL FINAL, EN EL BOTON DE ENVIO COLOCAMOS ESTO
	<a href="#" < ? $validator->validate() ? > >enviar</a>
	
*/
class validator {
	var $form_name=""; //indica el formulario que ser� validado
	var $forms=array(); //lleva un arreglo de todos los controlos html que seran validados
	var $id_client=array(); //controla un identificador del lado del cliente que permite saber donde se va a mostrar el error
	var $ar_messaje=array(); //colecciona los mensajes de error
	var $arr_type=array();
//	var $type_validation=array();

	//contructor: recibe opcionalmente el formulario que va a validar
	function validator($form="") {
		$this->form_name=$form;
	}	
	//crea el mensaje indicando como parametro el id que permitira asociarlo al momento de mostrar el error, el objeto que se va a validar y el mensaje que se va a enviar
	function create_message($idclient, $formobject, $message,$type_validation=0) {
		$this->id_client[]=$idclient;
		$this->forms[]=$formobject;
		$this->ar_messaje[]=$message;
		$this->arr_type[]=$type_validation;
	}

	/*Imprime el javascript que hace todas las acciones. antes de esto tiene que haberse 
	creado TODOS los mensajes que seran mostrados. 
	Preferiblemente, colocar esto dentro de la etiqueta <head>...</head>
	*/
	function print_script() {
		echo "<script>
		function validate () {
		sw=0; ";
		for ($i=0;$i<count($this->forms);$i++) {
			switch ($this->arr_type[$i]) {
			case 1:
				// Integer
				echo ("
				valor = document.".$this->form_name.".".$this->forms[$i].".value;
				if (valor > 0) { 	
					cad = valor.toString();
					for (var i=0; i<cad.length; i++) {
						var caracter = cad.charAt(i);
						if (caracter < '0' || caracter > '9') {
							document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
							document.".$this->form_name.".".$this->forms[$i].".focus(); return false;
							sw=1; 
						} 
					}
				} else { //Si es campo requerido tambien
					sw=1;
				}
				if (sw==1) {
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
					document.".$this->form_name.".".$this->forms[$i].".focus(); return false;
				} else { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
				}
				");
				break;
			case 2:
				//Radio Button
				echo ("
				blnRes = false;
				for(i=0; i < document." . $this->form_name . "." . $this->forms[$i].".length; i++){
					if(document." . $this->form_name . "." . $this->forms[$i]."[i].checked == true){
						blnRes = true;
						break;
					}
				}
				if (blnRes == true)
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
				else{
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
					document.".$this->form_name.".".$this->forms[$i]."[0].focus(); return false;
					sw=1; 
				} 
				");
				break;
			case 3:
				//Email
				echo ("
				apos=eval(document.".$this->form_name.".".$this->forms[$i].".value.indexOf('@'));
				dotpos=eval(document.".$this->form_name.".".$this->forms[$i].".value.lastIndexOf('.'));
				lastpos=eval(document.".$this->form_name.".".$this->forms[$i].".value.length-1);  
				if (apos < 1 || dotpos-apos < 2 || lastpos-dotpos > 3 || lastpos-dotpos < 2) { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
					document.".$this->form_name.".".$this->forms[$i].".focus(); return false;
					sw=1; 
				} else {
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
				}

				");
				break;
			case 4:
				// List Requiered
				echo ("
				if (document.getElementsByName('". $this->forms[$i] . "[]')[0].value=='') { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
					sw=1; 
				} else { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
				}
				");
				break;
				
			case 5: // Text Requiered
					echo ("
					if (document." . $this->form_name . "." . $this->forms[$i] . ".value=='' && document." . $this->form_name . "." . $this->forms[$i] . ".disabled == false) { 
						document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
						sw=1; 
					} else { 
						document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
					}
					");
	
				break;
			default:
				// Text Requiered
				echo ("
				if (document." . $this->form_name . "." . $this->forms[$i] . ".value=='') { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '" . $this->ar_messaje[$i] . "';
					document.".$this->form_name.".".$this->forms[$i].".focus(); return false;
					sw=1; 
				} else { 
					document.getElementById('" . $this->id_client[$i] . "').innerHTML = '';
				}
				");

				break;
			} //end Suitch
		} //end for

		echo "if (sw==0) {
			document." .  $this->form_name . ".submit();
		}else {
			//document.".$this->form_name.".".$this->forms[0].".focus();	
			return false;
			}
		}
	</script>";
	}
	//funcion que indica donde sera mostrado el mensaje de error, el parametro es el id del mensaje que se coloco en create_message()
	function show($id_client) {
		echo "<span id='$id_client' class='errormsg'></span>";	
	}
	//controla la validacion, se debe colocar dentro de la etqueta <input ...> o <a ...>
	function validate(){
		echo "onclick='validate()'";
	}
}
?>

<? 
class Html
{
	var $daysArray = array();
	var $monthArray = array("txtJanuary","txtFebruary","txtMarch","txtApril","txtMay","txtJune","txtJuly","txtAugust","txtSeptember","txtOctober","txtNovember","txtDecember");
	var $yearsArray = array();
    function __construct()
    {
    	for($i = 1; $i < 32; $i++)	$this->daysArray[$i] = $i;
    }

    function input($id,$value="",$params = array('type'=>"text", 'readOnly'=>false, 'length'=>null, 'size'=>null, 'class'=>null, 'calendar'=>null, 'tabIndex'=>null, 'onClick'=>null, 'disabled'=>'disabled', 'onBlur' => null, 'checked' => null, 'style' => null)) {
        $arrId = explode('.',$id);
		if(count($arrId) > 1)	$name = (count($arrId) == 2) ? $arrId[0].'['.$arrId[1].']' : $arrId[0].'['.$arrId[1].']['.$arrId[2].']';
		else					$name = $id;
        //$name = (count($arrId) == 2) ? $arrId[0].'['.$arrId[1].']' : $arrId[0].'['.$arrId[1].']['.$arrId[2].']';
		$attribs = '';
        $attribs .= ($params['readOnly']!=null)?' readonly ':'';
		$attribs .= ($params['size']!=null)?' size="'.$params['size'].'"':'';
		$attribs .= ($params['length']!=null)?' maxlength="'.$params['length'].'"':'';
		$attribs .= ($params['class']!=null)?' class="'.$params['class'].'"':'';
		$attribs .= ($params['onClick']!=null)?' onclick="'.$params['onClick'].'"':'';
		$attribs .= ($params['onBlur']!=null)?' onBlur="'.$params['onBlur'].'"':'';		
		$attribs .= ($params['tabIndex']!=null)?' tabIndex="'.$params['tabIndex'].'"':'';
		$attribs .= ($params['disabled']!=null)?' disabled ':'';
                $attribs .= ($params['checked']!=null)?' checked ':'';
                $attribs .= ($params['style']!=null)?' style="'.$params['style'].'"':'';
                $attribs .= ($params['onkeypress']!=null)?' onkeypress="'.$params['onkeypress'].'"':'';
		
		/*dateFormat: "<?php echo ($_SESSION['lng']=="en")? '%m/%d/%Y':'%d/%m/%Y'; ?>",*/
		if($params['calendar']!=null)
		{
			$calendar = '<img src="../images/icons/x-office-calendar.png" id="start_date_trigger" width="16" height="16" style="cursor:pointer" /><script>Calendar.setup({trigger    : "start_date_trigger", inputField : "'.$name.'",dateFormat: "%m/%d/%Y",onSelect   : function() { this.hide() }});</script>';
		}
		else	$calendar = '';
		if(!(isset($params['type']))) $params['type'] = 'text';
		//$output = ($params['type']=='text')? '<div class="input">':'';
        $output.= '<input type="'.$params['type'].'" id="'.$name.'" name="'.$name.'" value="'.$value.'" '.$attribs.'/>&nbsp;&nbsp;'.$calendar;
		//$output .= ($params['type']=='text')? '</div>':'';

        return $output;
        
    }
    
    function select($id,$params=array()) 
    {
        $arrId = explode('.',$id);
        if(count($arrId) > 1)	$name = (count($arrId) == 2) ? $arrId[0].'['.$arrId[1].']' : $arrId[0].'['.$arrId[1].']['.$arrId[2].']';
		else					$name = $id;
        //$name = (count($arrId) == 2) ? $arrId[0].'['.$arrId[1].']' : $arrId[0].'['.$arrId[1].']['.$arrId[2].']';
		$class = (isset($params['class'])?'class="'.$params['class'].'"':'');
		$onChange = (isset($params['onChange'])) ? 'onchange="' .$params['onChange'] . '"':'';
		$readOnly = (isset($params['readOnly'])?' disabled ':'');
        $output = '<select id="'.$name.'" name="'.$name.'" '.$class. ' '. $onChange .' '.$readOnly.'>';
		$output .= (isset($params['default'])?'<option value="">'.$params['default'].'</option>':'');
		$selected = (isset($params['selected'])?$params['selected']:null);
		
        if(isset($params['options'])){
			foreach($params['options'] as $key => $text) {
				$attributes = ($selected == $key) ? 'selected="selected"' : '';        	
				$output .= '<option value="'.$key.'" '.$attributes.'>'.$text.'</option>';                
			}
		}
        $output .= '</select>';
        return $output;
    }  
    
    function link($name = 'link',$url = '#',$options=array()) 
    {
        $output = '<a ';
        if($url != '#')	$output .= 'href="'.$url.'" ';
		foreach($options as $attribute => $value)	$output .= $attribute.'="'.$value.'" ';		
        $output .= '>'.$name.'</a>';
        return $output;
    }      

    function arrayValues($start, $end)
    {
    	$result = array();
    	for ($index = $start; $index <= $end; $index++)	$result[$index] = $index;
    	return $result;
    }
	
	function htmlize($value){
		$value = htmlentities( $value );
		return $value;
	}
	
	function unhtmlize($value){
		$value = html_entity_decode( $value );
		return $value;
	}
	
	function displayMessage($message = array(), $showCloseButton = true)
	{
		if(empty($message) || empty($message['value']) || empty($message['template']))	return ;
		if($showCloseButton) $closeButton = "<a href='#' class='close' onclick='showHide(\"msgBox_".$message['template']."\");'><img src='../images/icons/cross_grey_small.png' /></a>"; 
		switch($message['template'])
		{
			case 'info': 	$class = 'notification information png_bg';
							break;
			case 'success':	$class = 'notification success png_bg';
							break;
			case 'error': 	$class = 'notification errors png_bg';
							break;
			case 'warning':	$class = 'notification attention png_bg';
							break;																					 
		}
		$value = $message["value"];
		return "<div id='msgBox_".$message['template']."' class='$class'>$closeButton<div>$value</div></div>";
				
	}
    
}
?>
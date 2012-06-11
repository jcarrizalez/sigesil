<? 
class Javascript 
{
	//Control Variables
	var $includedFiles = array();	//List of all the files included in the actual page
	var $javascriptDir = '../js/';	//Indicates the current directory of all javascript codes
	var $autoAdvance = false;		//Code to use in the tabIndex auto Jump
	
    function __construct(){ }

    function includeFile($fileName)
    {
    	$this->includedFiles[] = $fileName;
    	echo '<script src="' . $this->javascriptDir . $fileName. '" type="text/javascript"></script>';
    }
	/*
	 *	Changes from this notation Model.attribute to Model[attribute] 
	 */
    function toArrayName($normalName)
    {
    	$tmp = explode('.',$normalName);
		if(count($tmp) > 1)	$name = (count($tmp) == 2) ? $tmp[0].'['.$tmp[1].']' : $tmp[0].'['.$tmp[1].']['.$tmp[2].']';
		else				$name = $normal;
		return $name;
    }
    
}
?>
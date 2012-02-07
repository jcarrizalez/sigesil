<?

/*
 * @name			Javascript Validator Class
 * @description		Currently using JQuery as backend framework
 * @version         v 1.0
 * @modifiedby    	$LastChangedBy: clizarraga
 * @lastmodified  	2010-07-30
 */

class Validator extends Javascript {

    var $formName = '';     //Indica el formulario que sera validado
    var $forms = array();     //lleva un arreglo de todos los controlos html que seran validados
    var $idClient = array();    //controla un identificador del lado del cliente que permite saber donde se va a mostrar el error
    var $defaultMessages = array();  //Listado de los menajes de error generados
    var $specificMessages = array();  //Listado de los menajes de error generados
    var $rules = array();    //The rules for the validation

    //constructor: recibe opcionalmente el formulario que va a validar

    function __construct($name = '') {
        $this->formName = $name;
        //$this->autoAdvance = true;
    }

    //Prints the necesary files for the usage of the library
    function printIncludes() {
        $this->includeFile('jquery/jquery.validate.js');
        if ($this->autoAdvance)
            $this->includeFile('jquery/jquery.field.min.js');
    }

    /*
     * 
     */

    function setRules($itemForm, $rules = array()) {
        foreach ($rules as $key => $rule) {
            $tmp = explode('.', $itemForm);
            if (count($tmp) > 1)
                $name = (count($tmp) == 2) ? $tmp[0] . '[' . $tmp[1] . ']' : $tmp[0] . '[' . $tmp[1] . '][' . $tmp[2] . ']';
            else
                $name = $itemForm;
            if (isset($rule['value']))
                $this->rules[$name][$key] = $rule['value'];
            if (isset($rule['message']))
                $this->specificMessages[$name][$key] = $rule['message'];
        }
    }

    /*
     * Overwrite the format of the default messages
     * Values:
     * 	required: "This field is required."
     * 	remote: "Please fix this field."
     * 	email: "Please enter a valid email address."
     * 	url: "Please enter a valid URL."
     * 	date: "Please enter a valid date."
     * 	dateISO: "Please enter a valid date (ISO)."
     * 	number: "Please enter a valid number."
     * 	digits: "Please enter only digits."
     * 	creditcard: "Please enter a valid credit card number."
     * 	equalTo: "Please enter the same value again."
     * 	accept: "Please enter a value with a valid extension."
     * 	maxlength: jQuery.validator.format("Please enter no more than {0} characters.")
     * 	minlength: jQuery.validator.format("Please enter at least {0} characters.")
     *  rangelength: jQuery.validator.format("Please enter a value between {0} and {1} characters long.")
     *  range: jQuery.validator.format("Please enter a value between {0} and {1}.")
     *  max: jQuery.validator.format("Please enter a value less than or equal to {0}.")
     *  min: jQuery.validator.format("Please enter a value greater than or equal to {0}.")
     */

    function setDefaultErrorMessages($messages = array()) {
        if (!empty($messages)) {
            echo '<script>jQuery.extend(jQuery.validator.messages, {';
            foreach ($messages as $key => $message)
                echo ' ' . $key . ': "' . $message . '", ';
            echo '});</script>';
        }
    }

    /*
     * Prints the current javascript code that allows the validator class to evaluate the constructed rules
     */

    function printScript() {
        $result = '';
        $result .= "\n<script>\n$().ready(function() {\n";
        $result .= "\t$(\"#" . $this->formName . "\").validate({\n";
        if (!empty($this->rules)) {
            $result .= "\trules: {\n";
            $k = 0;
            foreach ($this->rules as $key => $rule) {
                if ($k == 0)
                    $result .= "\n\n\t\t\"" . $key . "\": {\n";
                else
                    $result .= ",\n\t\t\"" . $key . "\": {\n";
                $j = 0;
                foreach ($rule as $ruleName => $value) {
                    if ($j == 0)
                        $result .= "\n\n\t\t\t" . $ruleName . ': ';
                    else
                        $result .= ",\n\t\t\t" . $ruleName . ': ';
                    if (is_array($value)) {
                        $result .= "{\n";
                        $i = 0;
                        foreach ($value as $subRuleName => $subValue) {
                            if ($i == 0)
                                $result .= "\t\t\t\t" . $subRuleName . ': ' . $subValue;
                            else
                                $result .= ",\n\t\t\t\t" . $subRuleName . ': ' . $subValue;
                            $i++;
                        }
                        $result .= "\t\t\t}";
                    }
                    else
                        $result .= $value;
                    $j++;
                }
                $result .= "\t\t}";
                $k++;
            }
            $result .= "\t},\n";
            $result .= "\tmessages: {\n";
            $i = 0;
            foreach ($this->specificMessages as $key => $message) {
                if ($i == 0)
                    $result .= "\t\t\"" . $key . "\": {\n";
                else
                    $result .= "\n,\t\t\"" . $key . "\": {\n";

                //$result .=  "\t\t\"" . $key . "\": {\n";
                $j = 0;
                foreach ($message as $messageType => $value) {
                    //$result .=  "\t\t\t" . $messageType . ': "' . $value . "\",\n";
                    if ($j == 0)
                        $result .= "\t\t\t" . $messageType . ': "' . $value . "\"";
                    else
                        $result .= ",\n\t\t\t" . $messageType . ': "' . $value . "\"";
                    $j++;
                }
                $result .= "\t\t}";
                $i++;
            }

            $result .= "\t}\n";
        }
        $result .= "\t});";
        if ($this->autoAdvance)
            $result .= "\n $(\"#" . $this->formName . "\").autoAdvance(); ";
        $result .= "});\n</script>";

        echo $result;
    }

}

?>

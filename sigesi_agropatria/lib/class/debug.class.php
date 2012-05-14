<?
class Debug {
	public static $executeQueryPage = null;
	public static $dump_info = null;
        public static $dump_count = null;
        public static $error = array();
        public static $error_count = array();
        public static $total_error_count = null;
        public static $checkpoint_info = null;
        public static $checkpoint_count = null;
        public static $watches_info = null;
        public static $watches_count = null;
        public static $timers = null;
        public static $timer_info = null;
        public static $timer_count = null;
        public static $watches = array();
        public static $config  = array (
	'debug' => TRUE,
	'watches' => TRUE,
        'dumps' => TRUE,
        'Handler' => TRUE,
	'checkpoints' => TRUE,
	'timers' => TRUE,
	'php_notices' => TRUE,
	'php_warnings' => TRUE,
	'php_errors' => TRUE,
        'php_deprecated' => TRUE,
        'E_PARSE' => TRUE,
	'php_suggestions' => TRUE
);
	public function __construct() {
	}
	
	function pr($array, $die=false){
		echo '<pre>';
		echo print_r($array, true);
		echo '</pre>';
		if($die){
			Debug::$executeQueryPage = DOMAIN_ROOT.'admin/debug_execute_query.php';
			Debug::showReport(array('hidden'=>false));
			die();

		}
	}


	
	function showReport($params = array('hidden'=>false)){
		if($params['hidden']){
			echo "<div id='showDebug' style='cursor:pointer;font-size:8pt;text-align:center;width:100%' onclick='showDebugReport()'> [ &darr; Debug Report &darr; ] </div>";
			echo '	<script type="text/javascript">
						function showDebugReport(){
                                                if (document.getElementById("debug").style.display =="block"){
                                                document.getElementById("debug").style.display="none"
                                                document.getElementById("showDebug").innerHTML="[&darr; Debug Report &darr;]";
                                                }else{
						document.getElementById("debug").style.display="block";
                                                document.getElementById("showDebug").innerHTML="[&uarr; Debug Report &uarr;]";
                                                }
							//document.getElementById("debug").style.display="block";
						}
					</script>
			';
			echo '<div id="debug" style="display:none">';
		} else {
			echo '<div id="debug">';
		}
		echo '<h2>DEBUG REPORT</h2>';
		Debug::printDatabaseQueries();
		Debug::printSuperGlobal('HTTP GET:',$_GET);
		Debug::printSuperGlobal('HTTP POST:',$_POST);
		Debug::printSuperGlobal('SESSION:',$_SESSION);
		Debug::printConstants();
                
		echo '</div>';
		
	}
	
	function printDatabaseQueries(){
		//echo '<div id="debug">';
		if(Debug::$executeQueryPage){
		echo '
			<script type="text/javascript">
				function executeQuery(index){
					document.debug.toExecute.value = index;
					document.debug.submit();
				}
			</script>
			<form name="debug" action="'. Debug::$executeQueryPage.'" method="post" target="_blank">
			<input type="hidden" id="toExecute" name="toExecute" value="0"/>';
		}
		echo '<br/><strong>QUERY:</strong><br/>';
		echo '<table cellpadding="3" cellspacing="0" border="1" width="100%">';
		echo '<tr>';
		echo '	<th>NUMBER</th>';
		echo '	<th>CLASS</th>';
		echo '	<th>FUNCTION</th>';
		if(Debug::$executeQueryPage){
			echo '	<th colspan="2">QUERY</th>';
                        echo '	<th COLSPAN="2">TIME</th>';
                }else{
			echo '	<th>QUERY</th>';
                         echo '	<th>TIME</th>';
                }
		echo '</tr>';
		$i=1;
		foreach(cls_dbtools::$dbDebug as $row) {
			echo '<tr>';
			echo '	<td align="center">'.$i.'</td>';
			echo '	<td>'.$row['class'].'</td>';
			echo '	<td>'.$row['method'].'</td>';
			echo '	<td>'.$row['query'].'</td>';
                        echo '	<td>'.  Debug::microtime_float($row['time']).'</td>';
			if(Debug::$executeQueryPage){
			echo '	<td><input type="hidden" name="query_'.$i.'" value="'.$row['query'].'" /><a onclick="executeQuery('.$i.')" style="cursor:pointer">Execute</a></td>';
			}
			echo '</tr>';
			$i++;
		}
		echo '</table>
		</form>
		';
		//echo '</div>';
		//var_dump(cls_dbtools::$dbDebug);
	
	}
	
	function printSuperGlobal($name,$variable){
		echo '<br/><strong>'.strtoupper($name).'</strong><br/>';
        echo '<table cellpadding="3" cellspacing="0" border="1">';
		echo '<tr>';
		echo '	<th>NUMBER</th>';
		echo '	<th>ID</th>';
		echo '	<th>VALUE</th>';
		echo '</tr>';
		$i=1;
        foreach($variable as $key=>$value) {
  			echo '<tr>';
			echo '	<td align="center">'.$i.'</td>';
			echo '	<td>'.$key.'</td>';
			if(is_array($value)){
				echo '	<td>';
				print_r($value);
				echo '</td>';
			} else
				echo '	<td>'.$value.'</td>';
			
			echo '</tr>';
			$i++;
        }
        echo '</table>';
		
	}
	
	function printConstants(){
		$consts = get_defined_constants(true);
		//echo '<pre>';
		//var_dump($consts);
		echo '<br/><strong>Constants:</strong><br/>';
        echo '<table cellpadding="3" cellspacing="0" border="1">';
		echo '<tr>';
		echo '	<th>NUMBER</th>';
		echo '	<th>ID</th>';
		echo '	<th>VALUE</th>';
		echo '</tr>';
		$i=1;
        foreach($consts['user'] as $key=>$value) {
  			echo '<tr>';
			echo '	<td align="center">'.$i.'</td>';
			echo '	<td>'.$key.'</td>';
			echo '	<td>'.$value.'</td>';
			echo '</tr>';
			$i++;
        }
        echo '</table>';
	}

        function printLables() {
            $test = new Lenguaje();
            $l = $test->etiquetasPorPagina($_SERVER['PHP_SELF']);
            //checke if the tag exist into the file
$filename= APPROOT.$_SERVER['PHP_SELF'];
if (file_exists($filename)){
$arraDataFile = file($filename);
$fileContent = "";

if($arraDataFile){
	foreach($arraDataFile as $line)
		$fileContent.=$line;
}

            echo '<br/><strong>Labels on database:</strong><br/>';
            echo '<table cellpadding="3" cellspacing="0" border="1">';
		echo '<tr>';
		echo '	<th>NUMBER</th>';
		echo '	<th>ID</th>';
		echo '	<th>VALUE</th>';
		echo '</tr>';
		$i=1;
        foreach($l as $key=>$value) {
            $style="color:blue";
            $title = "In File";
						$label = "\$lang['" . $key."']";
						if(!strstr($fileContent,$label)){
							$style="color:red";
                                                        $title = "No In File";
						}
  			echo '<tr>';
			echo '	<td align="center">'.$i.'</td>';
			echo '	<td><span style="'.$style.'" title="'.$title.'">'.$key.'<span></td>';
			echo '	<td>'.$value.'</td>';
			echo '</tr>';
			$i++;
                        $test1.=$key.',';
        }
        echo '</table>';
        //
        echo '<br/><strong>Labels on file:</strong><br/>';
        echo '<table cellpadding="3" cellspacing="0" border="1">';
		echo '<tr>';
		echo '	<th>NUMBER</th>';
		echo '	<th>NAME</th>';
		echo '	<th>ON DATABASE</th>';
		echo '</tr>';
		$i1=1;
		
		
		$archivo = APPROOT.$_SERVER['PHP_SELF'];
		
        $arraDataFile = file_get_contents($archivo);
		preg_match_all('/(\$lang\[\'([\w]+)\'\])/', $arraDataFile, $result, PREG_PATTERN_ORDER);
		$arr_txt = array_unique($result[2]);

		foreach ($arr_txt as $key => $value) {

                    $a = eregi($value,$test1);
                    if ($a){
                        $style="color:blue";
                        $title = $l[$value];
                        $exist = "Edit";
                    }else{
                        $style="color:red";
                        $title = "No In database";
                        $exist = "Add";
                    }
                    echo '<tr>';
			echo '	<td align="center">'.$i1.'</td>';
			echo '	<td><span style="'.$style.'" title="'.$title.'">'.$value.'<span></td>';
			echo "	<td><a href=javascript:showedit('".$i1."','".$value."','".$exist."','".$_SERVER['SCRIPT_NAME']."')>".$exist."</a></td>";
			echo '</tr>';
                        echo '<tbody id="tag'.$i1.'" style="display:none;"><tr><td id="tdtag'.$i1.'" colspan="3">test '.$i1.'</td></tr></tbody>';
			$i1++;
		}
echo '
    <script type="text/javascript">
    function showedit(id,tag,acc,uri){
        $("#tag"+id).slideToggle("slow",function(){
        var url = "../lib/common/asin_tag_edit.php?acc="+acc+"&file="+uri+"&tag="+tag+"&id="+id;
                $("#tdtag"+id).load(url);
        });
        }
        function savetag(id,tag,acc,uri){
        var en = $("#en"+id).attr("value");
        var es = $("#es"+id).attr("value");
        var save = "save";
        var url = "../lib/common/asin_tag_edit.php?acc="+acc+"&file="+uri+"&save=save&en="+en+"es="+es+"&id="+id;
        $.get("../lib/common/asin_tag_edit.php", { acc : acc , file : uri, save : save, en : '.  urlencode('en').', es : '.  urlencode('es').',id : id ,tag :tag},
function(data){
					if(data==1){
$("#tdtag"+id).html("Registro Guardado refresque el explorador para ver los cambios");
}else if(data!=1){
$("#tdtag"+id).html("Error en Guardado");
}
});
        }
        </script>';
        //
        }
        }
function microtime_float($a)
{
list($useg, $seg) = explode(" ", $a);
return (number_format(((float)$useg + (float)$seg),4).' seg.');
}
 /**
	 * show debug info for variable in debugToolBar,
	 * added by custom text for documentation and hints
	 *
	 * @param mixed $variable
	 * @param string $text
	 */
        function dump($variable, $text, $file='') {
                if (Debug::$config['dumps']) {
                    @ob_start();
                    /* grab current ob content */
                    $obContents = ob_get_contents();
                    ob_clean();
                    /* grap var dump from ob */
                    var_dump($variable);
                    $variableDebug = ob_get_contents();
                    ob_end_clean();
                    /* restore previous ob content */
                    if ((bool) $obContents)
                        echo $obContents;
                    /* render debug */
                    $variableDebug = htmlspecialchars($variableDebug);
                    $infos .= '<table class="dump" width="800"><tr><td width="1%" class="bg-dump">&nbsp;</td><td class="bg-info" width="99%"><p class="dump">' . $text . '<br />';
                    if (is_array($variable)) {
                        $variableDebug = str_replace(' ', '&nbsp;', $variableDebug);
                        $infos .= '<span class="source">' . $variableDebug . '</span>';
                    } else {
                        $infos .= '<strong>' . $variableDebug . '</strong>';
                    }
                    $trace = debug_backtrace();
                    $fullTraceback = $trace[0]['file'] . ' on line ' . $trace[0]['line'];
                    $trace[0]['file'] = Debug::cropScriptPath($trace[0]['file']);
                    $traceback = '<acronym class="backtrace" title="' . $fullTraceback . '">';
                    $traceback .= $trace[0]['file'] . ' on line ';
                    $traceback .= $trace[0]['line'] . '</acronym>';
                    $infos .= '<br />' . $traceback . '</td></tr></table>';
                    Debug::$dump_info .= $infos;
                    Debug::$dump_count++;
                }
            }
        /**
	 * callback method for PHP errorhandling
	 *
	 * @TODO implement more errorlevels
	 */
        public function errorHandlerCallback() {
        $details = func_get_args();
        $details[1] = str_replace("'", '"', $details[1]);
        $details[1] = str_replace('href="function.', 'target="_blank" href="http://www.php.net/', $details[1]);
        /* determine error level */
        switch ($details[0]) {
            case 1:
                if (!Debug::$config['php_errors'])
                    return;
                $errorlevel = 'error';
                break;
            case 8192:
                if (!Debug::$config['php_deprecated'])
                    return;
                $errorlevel = 'deprecated';
                break;
            case 2:
                if (!Debug::$config['php_warnings'])
                    return;
                $errorlevel = 'warning';
                break;
            case 4:
                if (!Debug::$config['E_PARSE'])
                    return;
                $errorlevel = 'PARSE';
                break;
            case 8:
                if (!Debug::$config['php_notices'])
                    return;
                $errorlevel = 'notice';
                break;
            case 2048:
                if (!Debug::$config['php_suggestions'])
                    return;
                $errorlevel = 'suggestion';
                break;
        }
        $fullTraceback = $details[2] . ' on line ' . $details[3] . ' php trace ' . $details[0];
        $file = Debug::cropScriptPath($details[2]);
        $infos = '<table class="' . $errorlevel . '" width="800"><tr><td width="1%" class="bg-' . $errorlevel . '">&nbsp;</td><td class="bg-info" width="99%"><p class="' . $errorlevel . '"><strong>';
        $infos .= 'PHP ' . strtoupper($errorlevel) . '</strong><br />';
        $infos .= $details[1] . '<br /><acronym class="backtrace" title="' . $fullTraceback . '">';
        $infos .= $file . ' on line ';
        $infos .= $details[3] . '</span></p></td></tr></table>';
        Debug::$error[$errorlevel] .= $infos;
        Debug::$error_count[$errorlevel]++;
    }
        /**
	 * shows in ToolBar that a checkpoint has been passed,
	 * additional info is the file and line which triggered
	 * the output
	 *
	 * @param string $message
	 */
        static function here($message = NULL) {
        if (Debug::$config['checkpoints']) {
            $message = (bool) $message ? $message : 'Checkpoint passed!';

            $infos = '<table class="checkpoint" width="800"><tr><td width="1%" class="bg-checkpoint">&nbsp;</td><td class="bg-info" width="99%"><p class="checkpoint"><strong>' . $message . '</strong>';
            $trace = debug_backtrace();
            $fullTraceback = $trace[0]['file'] . ' on line ' . $trace[0]['line'];
            $trace[0]['file'] = Debug::cropScriptPath($trace[0]['file']);
            $traceback = '<acronym class="backtrace" title="' . $fullTraceback . '">';
            $traceback .= $trace[0]['file'] . ' on line ';
            $traceback .= $trace[0]['line'] . '</acronym>';
            $infos .= '<br />' . $traceback . '</td></tr></table>';
            Debug::$checkpoint_info .= $infos;
            Debug::$checkpoint_count++;
            //Debug::sendCommand('write', $info);
        }
    }
        /**
	 * adds a variable to the watchlist
	 *
	 * Watched variables must be in a declare(ticks=n)
	 * block so that every n ticks the watched variables
	 * are checked for changes. If any changes were made,
	 * the new value of the variable is shown in the
	 * debugToolBar with additional information where the
	 * changes happened.
	 *
	 * @param string $variableName
	 */
        public function watch($variableName) {
        if (Debug::$config['watches']) {
            if (count(Debug::$watches) === 0) {
                $watchMethod = array(
                    Debug,
                    'watchesCallback'
                );

                register_tick_function($watchMethod);
            }

            if (isset($GLOBALS[$variableName])) {
                Debug::$watches[$variableName] = $GLOBALS[$variableName];
            } else {
                Debug::$watches[$variableName] = NULL;
            }
        }
    }

        /**
	 * tick callback: process watches and show changes
	 */
        static function watchesCallback() {
        if (Debug::$config['watches']) {
            foreach (Debug::$watches as $variableName => $variableValue) {
                if (isset($GLOBALS[$variableName]) && ($GLOBALS[$variableName] !== Debug::$watches[$variableName])) {
                    $info = '<table class="watch" width="800"><tr><td width="1%" class="bg-watch">&nbsp;</td><td class="bg-info" width="99%"><p class="watch"><strong>$' . $variableName;
                    $info .= '</strong> changed from "';
                    $info .= Debug::$watches[$variableName];
                    $info .= '" (' . gettype(Debug::$watches[$variableName]) . ')';
                    $info .= ' to "' . $GLOBALS[$variableName] . '" (';
                    $info .= gettype($GLOBALS[$variableName]) . ')';
                    $trace = debug_backtrace();
                    $fullTraceback = $trace[0]['file'] . ' on line ' . $trace[0]['line'];
                    $trace[0]['file'] = Debug::cropScriptPath($trace[0]['file']);
                    $traceback = '<acronym class="backtrace" title="' . $fullTraceback . '">';
                    $traceback .= $trace[0]['file'] . ' on line ';
                    $traceback .= $trace[0]['line'] . '</acronym>';
                    $info .= '<br />' . $traceback . '</td></tr></table>';
                    Debug::$watches[$variableName] = $GLOBALS[$variableName];
                    Debug::$watches_info .= $info;
                    Debug::$watches_count++;
                }
            }
        }
    }
    /**
	 * start timer clock, returns timer handle
	 *
	 * @return mixed
	 * @param string $comment
	 */
	public function startTimer ($comment) {
		if (Debug::$config['timers']) {
			$timerHandle = md5(microtime());

			Debug::$timers[$timerHandle] = array (
				'starttime' => Debug::getMicrotime(),
				'comment' => $comment
			);
		} else {
			$timerHandle = FALSE;
		}

		return $timerHandle;
	}

	/**
	 * stop timer clock
	 *
	 * @return bool
	 * @param string $timerHandle
	 */
	public function stopTimer ($timerHandle) {
        if (Debug::$config['timers']) {
			if (array_key_exists($timerHandle, Debug::$timers)) {
				$timerExists = TRUE;
				$timespan = Debug::getMicrotime() - Debug::$timers[$timerHandle]['starttime'];

				$info = '<table class="timer" width="800"><tr><td width="1%" class="bg-timer">&nbsp;</td><td class="bg-info" width="99%"><p class="timer"><strong>' . Debug::$timers[$timerHandle]['comment'];
				$info .= '</strong><br />The timer ran ';
				$info .= '<strong>' . number_format ($timespan, 4, '.', NULL) . '</strong>';
				$info .= ' seconds. ';
                                $trace = debug_backtrace();
                                $fullTraceback = $trace[0]['file'] . ' on line ' . $trace[0]['line'];
                                $trace[0]['file'] = Debug::cropScriptPath($trace[0]['file']);
                                $traceback = '<acronym class="backtrace" title="' . $fullTraceback . '">';
                                $traceback .= $trace[0]['file'] . ' on line ';
                                $traceback .= $trace[0]['line'] . '</acronym>';
                                $info .= $traceback . '</td></tr></table>';
                                Debug::$timer_info .= $info;
                                Debug::$timer_count++;
			} else {
				$timerExists = FALSE;
			}
		} else {
			$timerExists = FALSE;
		}

		return $timerExists;
	}
        /**
	 * crops long script path, shows only the last $maxLength chars
	 *
	 * @param string $path
	 * @param int $maxLength
	 * @return string
	 */
	protected function cropScriptPath ($path, $maxLength = 30) {
		if (strlen($path) > $maxLength) {
			$startPos = strlen($path) - $maxLength - 2;

			if ($startPos > 0) {
				$path = '...' . substr($path, $startPos);
			}
		}

		return $path;
	}
        /**
	 * returns microtime as float value
	 *
	 * @return float
	 */
	protected function getMicrotime () {
		list($usec, $sec) = explode(' ', microtime());
    	return ((float)$usec + (float)$sec);
	}
	}
?>
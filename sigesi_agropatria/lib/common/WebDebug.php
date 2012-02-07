<?php
$end_request=microtime(true);
?>
<!-- style -->
<style type="text/css">#sfWebDebug {   padding: 0;   margin: 0;   font-family: Arial, sans-serif;   font-size: 12px;   color: #333;   text-align: left;   line-height: 12px; }  #sfWebDebug a, #sfWebDebug a:hover {   text-decoration: none;   border: none;   background-color: transparent;   color: #000; }  #sfWebDebug img {   float: none;   margin: 0;   border: 0;   display: inline; }  #sfWebDebugBar {   position: absolute;   margin: 0;   padding: 1px 0;   right: 0px;   top: 0px;   opacity: 0.80;   filter: alpha(opacity:80);   z-index: 10000;   white-space: nowrap;   background-color: #ddd; }  #sfWebDebugBar[id] {   position: fixed; }  #sfWebDebugBar img {   vertical-align: middle; }  #sfWebDebugBar .sfWebDebugMenu {   padding: 5px;   padding-left: 0;   display: inline;   margin: 0; }  #sfWebDebugBar .sfWebDebugMenu li {   display: inline;   list-style: none;   margin: 0;   padding: 0 6px; }  #sfWebDebugBar .sfWebDebugMenu li.last {   margin: 0;   padding: 0;   border: 0; }  #sfWebDebugDatabaseDetails li {   margin: 0;   margin-left: 30px;   padding: 5px 0; }  #sfWebDebugShortMessages li {   margin-bottom: 10px;   padding: 5px;   background-color: #ddd; }  #sfWebDebugShortMessages li {   list-style: none; }  #sfWebDebugDetails {   margin-right: 7px; }  #sfWebDebug pre {   line-height: 1.3;   margin-bottom: 10px; }  #sfWebDebug h1 {   font-size: 16px;   font-weight: bold;   margin: 20px 0;   padding: 0;   border: 0px;   background-color: #eee; }  #sfWebDebug h2 {   font-size: 14px;   font-weight: bold;   margin: 10px 0;   padding: 0;   border: 0px;   background: none; }  #sfWebDebug h3 {   font-size: 12px;   font-weight: bold;   margin: 10px 0;   padding: 0;   border: 0px;   background: none; }  #sfWebDebug .sfWebDebugTop {   position: absolute;   left: 0px;   top: 0px;   width: 98%;   padding: 0 1%;   margin: 0;   z-index: 9999;   background-color: #efefef;   border-bottom: 1px solid #aaa; }  #sfWebDebugLog {   margin: 0;   padding: 3px;   font-size: 11px; }  #sfWebDebugLogMenu {   margin-bottom: 5px; }  #sfWebDebugLogMenu li {   display: inline;   list-style: none;   margin: 0;   padding: 0 5px;   border-right: 1px solid #aaa; }  #sfWebDebugConfigSummary {   display: inline;   padding: 5px;   background-color: #ddd;   border: 1px solid #aaa;   margin: 20px 0; }  #sfWebDebugConfigSummary li {   list-style: none;   display: inline;   margin: 0;   padding: 0 5px; }  #sfWebDebugConfigSummary li.last {   border: 0; }  .sfWebDebugInfo, .sfWebDebugInfo td {   background-color: #ddd; }  .sfWebDebugWarning, .sfWebDebugWarning td {   background-color: orange !important; }  .sfWebDebugError, .sfWebDebugError td {   background-color: #f99 !important; }  .sfWebDebugLogNumber {   width: 1%; }  .sfWebDebugLogType {   width: 1%;   white-space: nowrap; }  .sfWebDebugLogType, #sfWebDebug .sfWebDebugLogType a {   color: darkgreen; }  #sfWebDebug .sfWebDebugLogType a:hover {   text-decoration: underline; }  .sfWebDebugLogInfo {   color: blue; }  .ison {   color: #3f3;   margin-right: 5px; }  .isoff {   color: #f33;   margin-right: 5px;   text-decoration: line-through; }  .sfWebDebugLogs {   padding: 0;   margin: 0;   border: 1px solid #999;   font-family: Arial;   font-size: 11px; }  .sfWebDebugLogs tr {   padding: 0;   margin: 0;   border: 0; }  .sfWebDebugLogs td {   margin: 0;   border: 0;   padding: 1px 3px;   vertical-align: top; }  .sfWebDebugLogs th {   margin: 0;   border: 0;   padding: 3px 5px;   vertical-align: top;   background-color: #999;   color: #eee;   white-space: nowrap; }  .sfWebDebugDebugInfo {   color: #999;   font-size: 11px;   margin: 5px 0 5px 10px;   padding: 2px 0 2px 5px;   border-left: 1px solid #aaa;   line-height: 1.25em; }  .sfWebDebugDebugInfo .sfWebDebugLogInfo, .sfWebDebugDebugInfo a.sfWebDebugFileLink {   color: #333 !important; }  .sfWebDebugCache {   padding: 0;   margin: 0;   font-family: Arial;   position: absolute;   overflow: hidden;   z-index: 995;   font-size: 9px;   padding: 2px;   filter:alpha(opacity=85);   -moz-opacity:0.85;   opacity: 0.85; }  #sfWebDebugSymfonyVersion {   margin-left: 0;   padding: 1px 4px;   background-color: #666;   color: #fff; }  #sfWebDebugviewDetails ul {   padding-left: 2em;   margin: .5em 0;   list-style: none; }  #sfWebDebugviewDetails li {   margin-bottom: .5em; }  #sfWebDebug .sfWebDebugDataType, #sfWebDebug .sfWebDebugDataType a {   color: #666;   font-style: italic; }  #sfWebDebug .sfWebDebugDataType a:hover {   text-decoration: underline; }  #sfWebDebugDatabaseLogs {   margin-bottom: 10px; }  #sfWebDebugDatabaseLogs ol {   margin: 0;   padding: 0;   margin-left: 20px;   list-style: number; }  #sfWebDebugDatabaseLogs li {   padding: 6px; }  #sfWebDebugDatabaseLogs li:nth-child(odd) {   background-color: #CCC; }  .sfWebDebugDatabaseQuery {   margin-bottom: .5em;   margin-top: 0; }  .sfWebDebugDatabaseLogInfo {   color: #666;   font-size: 11px; }  .sfWebDebugDatabaseQuery .sfWebDebugLogInfo {   color: #909;   font-weight: bold; }  .sfWebDebugHighlight {   background: #FFC; }
.dump {
        }

        .dump .source {
            font-family: courier, sans-serif;
        }

        .backtrace {
			color: #aaa;
        }

        .watch {
        	border-color: #BF1CBF;
        }
.bg-watch {
        	background-color:  #BF1CBF;
        }
        .checkpoint {
        	border-color: #00E600;
        }

        .timer {
        	border-color: blue;
        }
        .bg-timer {
        	background-color:  blue;
        }
        .notice, .suggestion {
        	border-color: orange;
        }

        .warning,.error,.deprecated {
        	border-color: red;

        }

        .notice strong, .warning strong, .suggestion strong,.error strong {
        	font-weight: bold;
        	display: block;
        }

        .notice strong, .suggestion strong {
        	color: orange;
        }

        .warning strong,.error strong,.deprecated strong {
        	color: red;
        }
        .bg-warning, .bg-error,.bg-deprecated{
            background-color: red;
}
.bg-notice, .bg-suggestion{
            background-color: orange;
}
.bg-dump{
    background-color: gray;
}
.bg-info{
    background-color: white;
}
.bg-checkpoint{
    background-color: #00E600;
}
        .runtime {
            margin: 0px;
            padding: 0px;
            border: 0px;
            width: 100%;
            text-align: center;
            background-color: transparent;
            color: #666;
        }
        #div_dump {
            background-color: #eee;
            border: 1px solid #888;
            margin: 0px 0px 25px 0px;
        }
</style>
<!-- style -->
<!-- script-->
<script type="text/javascript">/* <![CDATA[ */
function sfWebDebugGetElementsByClassName(strClass, strTag, objContElm)
{
  // http://muffinresearch.co.uk/archives/2006/04/29/getelementsbyclassname-deluxe-edition/
  strTag = strTag || "*";
  objContElm = objContElm || document;
  var objColl = (strTag == '*' && document.all) ? document.all : objContElm.getElementsByTagName(strTag);
  var arr = new Array();
  var delim = strClass.indexOf('|') != -1  ? '|' : ' ';
  var arrClass = strClass.split(delim);
  var j = objColl.length;
  for (var i = 0; i < j; i++) {
    if(objColl[i].className == undefined) continue;
    var arrObjClass = objColl[i].className.split ? objColl[i].className.split(' ') : [];
    if (delim == ' ' && arrClass.length > arrObjClass.length) continue;
    var c = 0;
    comparisonLoop:
    {
      var l = arrObjClass.length;
      for (var k = 0; k < l; k++) {
        var n = arrClass.length;
        for (var m = 0; m < n; m++) {
          if (arrClass[m] == arrObjClass[k]) c++;
          if (( delim == '|' && c == 1) || (delim == ' ' && c == arrClass.length)) {
            arr.push(objColl[i]);
            break comparisonLoop;
          }
        }
      }
    }
  }
  return arr;
}

function sfWebDebugToggleMenu()
{
  var element = document.getElementById('sfWebDebugDetails');

  var cacheElements = sfWebDebugGetElementsByClassName('sfWebDebugCache');
  var mainCacheElements = sfWebDebugGetElementsByClassName('sfWebDebugActionCache');
  var panelElements = sfWebDebugGetElementsByClassName('sfWebDebugTop');

  if (element.style.display != 'none')
  {
    for (var i = 0; i < panelElements.length; ++i)
    {
      panelElements[i].style.display = 'none';
    }

    // hide all cache information
    for (var i = 0; i < cacheElements.length; ++i)
    {
      cacheElements[i].style.display = 'none';
    }
    for (var i = 0; i < mainCacheElements.length; ++i)
    {
      mainCacheElements[i].style.border = 'none';
    }
  }
  else
  {
    for (var i = 0; i < cacheElements.length; ++i)
    {
      cacheElements[i].style.display = '';
    }
    for (var i = 0; i < mainCacheElements.length; ++i)
    {
      mainCacheElements[i].style.border = '1px solid #f00';
    }
  }

  sfWebDebugToggle('sfWebDebugDetails');
  sfWebDebugToggle('sfWebDebugShowMenu');
  sfWebDebugToggle('sfWebDebugHideMenu');
}

function sfWebDebugShowDetailsFor(element)
{
  if (typeof element == 'string')
    element = document.getElementById(element);

  var panelElements = sfWebDebugGetElementsByClassName('sfWebDebugTop');
  for (var i = 0; i < panelElements.length; ++i)
  {
    if (panelElements[i] != element)
    {
      panelElements[i].style.display = 'none';
    }
  }

  sfWebDebugToggle(element);
}

function sfWebDebugToggle(element)
{
  if (typeof element == 'string')
    element = document.getElementById(element);

  if (element)
    element.style.display = element.style.display == 'none' ? '' : 'none';
}

function sfWebDebugToggleMessages(klass)
{
  var elements = sfWebDebugGetElementsByClassName(klass);

  var x = elements.length;
  for (var i = 0; i < x; ++i)
  {
    sfWebDebugToggle(elements[i]);
  }
}

function sfWebDebugToggleAllLogLines(show, klass)
{
  var elements = sfWebDebugGetElementsByClassName(klass);
  var x = elements.length;
  for (var i = 0; i < x; ++i)
  {
    elements[i].style.display = show ? '' : 'none';
  }
}

function sfWebDebugShowOnlyLogLines(type)
{
  var types = new Array();
  types[0] = 'info';
  types[1] = 'warning';
  types[2] = 'error';
  for (klass in types)
  {
    var elements = sfWebDebugGetElementsByClassName('sfWebDebug' + types[klass].substring(0, 1).toUpperCase() + types[klass].substring(1, types[klass].length));
    var x = elements.length;
    for (var i = 0; i < x; ++i)
    {
      if ('tr' == elements[i].tagName.toLowerCase())
      {
        elements[i].style.display = (type == types[klass]) ? '' : 'none';
      }
    }
  }
}
/* ]]> */</script>

<!--script-->
<div id="sfWebDebug">
        <div id="sfWebDebugBar">
          <a onclick="sfWebDebugToggleMenu(); return false;" href="#"><img alt="Debug toolbar" src="<?=DOMAIN_ROOT?>images/icons/debug.gif" height="20px" width="20px"></a>

          <ul class="sfWebDebugMenu" id="sfWebDebugDetails" style="">
              <li><span id="sfWebDebugSymfonyVersion">1.0.0</span></li>
              <li class="sfWebDebugInfo"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugQueries'); return false;" href="#" title="Configuration"><img alt="Config" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png"> QUERY</a></li>
              <li class="sfWebDebugError"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugHTTP_GET'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png">HTTP GET</a></li>
              <li class="sfWebDebugInfo"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugHTTP_POST'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png">HTTP POST</a></li>
              <li class="sfWebDebugError"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugSESSION'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png">SESSION</a></li>
              <li class="sfWebDebugInfo"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugConstants'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png">Constants</a></li>
              <li class="sfWebDebugInfo"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugLabels'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/MultiLanguage.png" height="20px" width="20px">Labels</a></li>
              <li class="sfWebDebugError"><a onclick="sfWebDebugShowDetailsFor('sfWebDebugTest'); return false;" href="#" title="Logs"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png" height="20px" width="20px">Track</a></li>
              <li class="sfWebDebugInfo"><img alt="Log" src="<?=DOMAIN_ROOT?>images/icons/internet-web-browser.png"><?= number_format(($time_request = $end_request - $ini_request),4).' seg' ?></li>
              <li class="last">
                  <a onclick="document.getElementById('sfWebDebug').style.display='none'; return false;" href="#"><img alt="Close" src="<?=DOMAIN_ROOT?>images/icons/emblem-unreadable.png"></a>
              </li>
          </ul>
        </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugQueries">
        <h1>&nbsp;</h1>
        <? Debug::printDatabaseQueries();?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugHTTP_GET">
        <h1>&nbsp;</h1>
        <? Debug::printSuperGlobal('HTTP GET:',$_GET);?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugHTTP_POST">
        <h1>&nbsp;</h1>
        <? Debug::printSuperGlobal('HTTP POST:',$_POST);?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugSESSION">
        <h1>&nbsp;</h1>
        <? Debug::printSuperGlobal('SESSION:',$_SESSION);?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugConstants">
        <h1>&nbsp;</h1>
        <? 
        Debug::printConstants();
        ?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugTest">
        <?php if (Debug::$config['watches']){?>
        <h1>Watches(<?= Debug::$watches_count?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugWatch'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h1>
        <div style="display: none;" id="sfWebDebugWatch">
        <?= Debug::$watches_info?>
            </div>
        <?php } ?>
        <?php if (Debug::$config['dumps']){?>
        <h1>&nbsp;DUMP on File(<?=  Debug::$dump_count?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugDump'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h1>
        <div style="display: none;" id="sfWebDebugDump">
        <?php echo Debug::$dump_info;?>
        </div>
        <?php }?>
        <?php if (Debug::$config['Handler']){?>
         <h1>&nbsp;HandlerCallback<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugHandler'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h1>
         <div style="display: none;" id="sfWebDebugHandler">
             <table width="800">
                 <tr>
                     <td width="1%">&nbsp;</td>
                     <td width="99%">
        <?php if (Debug::$config['php_errors']){?>
         <h2>Errors on File(<?= Debug::$error_count['error']?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugErrors'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h2>
         <div style="display: none;" id="sfWebDebugErrors">
        <?php echo Debug::$error['error'];?>
         </div>
         <?php }?>
         <?php if (Debug::$config['php_warnings']){?>
         <h2>Warnings on File(<?= Debug::$error_count['warning']?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugwarning'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h2>
         <div style="display: none;" id="sfWebDebugwarning">
        <?php echo Debug::$error['warning'];?>
         </div>
         <?php }?>
         <?php if (Debug::$config['php_notices']){?>
          <h2>Notice on File (<?= Debug::$error_count['notice']?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugnotice'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h2>
         <div style="display: none;" id="sfWebDebugnotice">
        <?php echo Debug::$error['notice'];?>
         </div>
          <?php }?>
          <?php if (Debug::$config['php_suggestions']){?>
           <h2>Suggestion on File(<?= Debug::$error_count['suggestion']?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugsuggestion'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h2>
         <div style="display: none;" id="sfWebDebugsuggestion">
        <?php echo Debug::$error['suggestion'];?>
         </div>
           <?php }?>
           <?php if (Debug::$config['php_deprecated']){?>
            <h2>Deprecated on File(<?= Debug::$error_count['deprecated']?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugdeprecated'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h2>
         <div style="display: none;" id="sfWebDebugdeprecated">
        <?php echo Debug::$error['deprecated'];?>
         </div>
            <?php }?>
           </td>
                 </tr>
             </table>
    </div>
         <?php }?>
         <?php if (Debug::$config['checkpoints']){?>
         <h1>&nbsp;Checkpoints on File(<?= Debug::$checkpoint_count?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugCheckpoints'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h1>
         <div style="display: none;" id="sfWebDebugCheckpoints">
        <?php echo Debug::$checkpoint_info;?>
         </div>
         <?php }?>
         <?php if (Debug::$config['timers']){?>
         <h1>&nbsp;Timers on File(<?= Debug::$timer_count?>)<a title="Toggle details" onclick="sfWebDebugToggle('sfWebDebugtimers'); return false;" href="#"><img alt="Toggle details" src="<?=DOMAIN_ROOT?>images/icons/toggle.gif"></a></h1>
         <div style="display: none;" id="sfWebDebugtimers">
        <?php echo Debug::$timer_info;?>
         </div>
         <?php }?>
    </div>
    <div style="display: none;" class="sfWebDebugTop" id="sfWebDebugLabels">
        <h1>&nbsp;</h1>
        <?
        Debug::printLables();
        ?>
    </div>
            </div>

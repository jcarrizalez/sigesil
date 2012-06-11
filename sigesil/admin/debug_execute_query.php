<? require_once('../lib/core.lib.php'); 
if(DEBUG==1){
    $dbTool = new cls_dbtools();
    $i = $_POST['toExecute'];
    $query =  $_POST['query_' .$i];
    $result =$dbTool->_SQL_tool($dbTool->SELECT, __METHOD__, $query);
    //echo '<pre>';
    //var_dump($result);
    $i = 0;
    if($result>0){ ?>

        <table width="100%" border="1">
            <tr>
                <? foreach($result[0] as $column=>$value) {
                    if($i%2) { ?>
                    <th><? echo $column ?></th>
                <?  }
                    $i++;
                   }?>
            </tr>
            <? foreach($result as $row) {?>
                <tr>
            <?  $i=0;
                foreach($row as $column=>$value) {
                    if($i%2) { ?>
                    <td><? echo $value ?></td>
                <?  }
                    $i++;
                   }?>
            </tr>
            <? } ?>    
        </table>
        Query:
<?    } else{
        echo "NO RESULTS FOR THIS QUERY.<br/>";
    }
    echo $query; 
}

?>
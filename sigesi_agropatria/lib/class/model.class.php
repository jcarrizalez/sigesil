<?
class Model extends cls_dbtools {
    
    var $id=null;
    var $table;
	
    function __construct(){  }
    
    function find($condition, $limit=null,$fields='*',$type = '',$order = '')
    {
            $queryCondition = "'1'";
            $query = 'SELECT '; 
            foreach($condition as $field=>$value)
                    $queryCondition.= ' AND '.get_class($this).".".$field."='".$value."' ";

            if(is_array($fields))	
            	foreach($fields as $i => $value)
            	{
            		if($i > 0 ) $query.= ',';
            		$query.= $value;
            	}
            else					$query.= $fields;
            
            if(!empty($order))	$order = " ORDER BY ".$order;
                    
            $query .= " FROM ".$this->table." ".get_class($this)." where ".$queryCondition.$order;
			//var_dump($query);
            $result = false;
            /*if(!is_null($limit)){
                $result = $this->_SQL_tool('SELECT_SINGLE', __METHOD__, $query);
            } else {
                $result = $this->_SQL_tool('SELECT', __METHOD__, $query);
            }*/
            if(!is_null($limit)) $query .= " $limit ";
            $result = $this->_SQL_tool('SELECT', __METHOD__, $query);
            
            if(strcasecmp('list',$type) == 0)
            {
            	$list = array();
            	$key = (count($fields) > 1) ? $fields[0] : 'id';
            	$value =  (count($fields) > 1) ? $fields[1] : 'nombre';
				if (count($result)>0)
					foreach ($result as $element)	$list[$element[$key]] = $element[$value];
            	$result = $list; 
            }
                
            return $result;
    }
    
    function save($data)
    {
        if($data['id']!=null)	$this->id = $data['id'];
        //else					$this->id = null;
        
		if(empty($data['id']))
			unset($data['id']);
		
        if($this->id!=null){
            $query = "UPDATE " . $this->table ." SET ";
            $values = " ";
            $sw = false;
            foreach($data as $field=>$value) {
                if($sw)
                    $values.= ", ";
                else
                    $sw = true;
                
                $values.= (!empty($value)) ? $field." = '".strtoupper($value)."'" : $field.' = null';
                //$values.= $field."='".$value."'";
            }
            
            $values.=", modificado=now()";
            $query.= $values . ' WHERE id='.$this->id;
            $result = $this->_SQL_tool('UPDATE', __METHOD__, $query);
            
        } else {
            $query = "INSERT INTO " . $this->table;
            $sw = false;
 
            foreach($data as $field=>$value){
                if($sw){
                    $fields.=", ";
                    $values.=", ";
                } else {
                    $fields =" (";
                    $values =" (";
                    $sw = true;
                }        
                $fields.= $field;
                $values.= (!empty($value)) ? "'".strtoupper($value)."'" : 'null';
            }
            $fields.=", creado)";
            $values .=",now())";
            
            $query.=" " . $fields." VALUES ".$values;
            $result = $this->_SQL_tool('INSERT', __METHOD__, $query);
            $this->id = $result;
        }
        return $result;
        
    }

    function saveAll($data)
    {
        // Debug::pr($data);
    	$this->_begin_tool();
    	
    	foreach ($data as $element){
			$result[] = $this->save($element);
			$this->id = null;
		}
    	if($result)	$this->_commit_tool();
    	else		$this->_rollback_tool();
    	
        return $result;
        
    }
	
	
	function getLastId(){
		$query = "SELECT MAX(id) AS lastId FROM " . $this->table ;
		$result = $this->_SQL_tool($this->SELECT_SINGLE, __METHOD__, $query);
		return $result;
	}
  

    
}

?>
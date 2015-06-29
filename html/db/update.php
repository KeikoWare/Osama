<?php
include 'connect.php';
$addr = $_SERVER['HTTP_REFERER'];
$argArr = parse_url($addr);
$addr = $argArr["scheme"]."://".$argArr["host"].$argArr["path"];

if(strlen($argArr["query"])>0){
	$addr .= "?";
	foreach(explode("&",$argArr["query"]) as $val){
		if(substr($val,0,4) != "res=") $addr .= $val."&"; 
	}
}

$table = @$_REQUEST["_table"];
$row = @$_REQUEST["_row"];
$sql = "";
$attributes = "";
$values = "";
$result = "";

if($table == ""){
	// abort with error msg
	$result = "You did not specify the table. Aborting.";
} else {
	if($row == ""){
		//INSERT
		$sql = "INSERT INTO $table ";
		foreach ($_REQUEST as $key => $value)  
		{
			// $value = mysql_real_escape_string( $value );  
			// $value = addslashes($value);  
			// $value = strip_tags($value);  

			if($value != "" && substr($key,0,1) != "_"){			
				$attributes .= "$key, ";
				if(substr($key,0,4) == "pass") $value = md5($value);		
				$values .= "'$value', ";
			}  
		}
		$attributes = substr($attributes,0,strlen($attributes)-2);
		$values = substr($values,0,strlen($values)-2);

		$sql .= "($attributes) VALUES ($values)";
	} else {
		//UPDATE
		$sql = "UPDATE $table SET ";
		foreach ($_REQUEST as $key => $value)  
		{  
			// $value = mysql_real_escape_string( $value );  
			// $value = addslashes($value);  
			// $value = strip_tags($value);  
			if(substr($key,0,1) != "_"){
				if(substr($key,0,4) == "pass") $value = md5($value);		
				$sql .= "$key = '$value', ";
			}
		}
		$sql = substr($sql,0,strlen($sql)-2);
		$sql .= " WHERE $row";
	}
}


if ($conn->query($sql) === TRUE) {
    $result =  "New record created successfully " . $sql;
} else {
    $result =  "Error: " . $sql . "<br>" . $conn->error;
}
header("location: ".$addr."res=".$result);
exit;
?>

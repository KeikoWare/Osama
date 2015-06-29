<?php
	$currentService = $_REQUEST["service"];	
	$query = "SELECT * FROM service ";
	$result = $conn->query($query);
	$option = "";
	while($row = $result->fetch_assoc()) {
		$option .= "<option value=\"".$row["id"] . "\"";
		if($row["id"]==$currentService) $option .= " selected ";
		$option .=  " >".$row["name"] ."</option>";
	}
?>
<h1>Opgaver</h1>
Valgt Service: <select name=selectService onChange="">
<option value=""> ingen valgt </option>
<?php echo $option;?>
</select>

<br>
<?php 
if($currentService != ""){

	$query = "SELECT * FROM task WHERE service_id = $currentService";
	$result = $conn->query($query);
	$optionParentTask = "";
	while($row = $result->fetch_assoc()) {
		$optionParentTask .= "<option value=\"". $row["id"] . "\">" . $row["taskUID"] . " " . $row["title"] . "</option>";
	}
	$query = "SELECT * FROM usergroup INNER JOIN serviceusergroup ON usergroup.id = serviceusergroup.usergroup_id WHERE usergroup.service_id = $currentService ";
	$result = $conn->query($query);
	$optionUserGroup = "";
	while($row = $result->fetch_assoc()) {
		$optionUserGroup .= "<option value=\"".$row["id"] . "\">".$row["name"] ."</option>";
	}
	echo "<hr>";
?>


<form name="myTask" action="db/update.php" method="POST">
<table>
<tr><td>Unikt ID</td><td><input name="taskUID" type=text title="Indtast brugerens username"></td></tr>
<tr><td>Titel</td><td><input name="title" type=text title=""></td></tr>
<tr><td>Forudsætninger</td><td><textarea name="prerequisites" type=text title=""></textarea></td></tr>
<tr><td>Beskrivelse</td><td><textarea name="description" type=text title=""></textarea></td></tr>
<tr><td>Varighed</td><td>Timer: <input name="expectedDurationHours" type=text title=""> Minutter: <input name="expectedDurationMinutes" type=text title=""></td></tr>
<tr><td>Udføres efter task:</td><td><select name="parentTask_id" title="eks CNS01"><option value=""> - ingen valgt - </option><?php echo $optionParentTask;?></select></td></tr>
<tr><td>Kan udføres af :</td><td><select name="usergroup_id" title="eks CNS01"><option value=""> - ingen valgt - </option><?php echo $optionUserGroup;?></select></td></tr>
<tr><td></td><td><input type=submit name="_btnSubmit" value="Opret ny opgave"></td></tr>
</table>
<input type=hidden name="_table" value="task">
<input type=hidden name="service_id" value="<?php echo $currentService; ?>">
<input type=hidden name="updatedDatetime" value="2015-06-24 14:19:00">
<input type=hidden name="updatedBy" value="me">
<input type=hidden name="_row" value="">
</form>
<br><br>
<script language="Javascript">

function fillForm(uid,ti,pr,de,edh,edm,pt,ug,id){
	var x = document.forms.namedItem("myTask");
	var d = new Date();
	var hr = d.getHours();
	if (hr < 10) {
		hr = "0" + hr;
	}
	var min = d.getMinutes();
	if (min < 10) {
		min = "0" + min;
	}
	var date = d.getDate();
	if (date < 10) {
		date = "0" + date;
	}
	var month = d.getMonth();
	if (month < 10) {
		month = "0" + month;
	}
	var year = d.getFullYear();
	var updateDatetime = year + "-" + month + "-" + date + " " + hr + ":" + min + ":00";
	x.elements.namedItem("taskUID").value = uid;
	x.elements.namedItem("title").value = ti;
	x.elements.namedItem("prerequisites").value = pr;
	x.elements.namedItem("description").value = de;
	x.elements.namedItem("expectedDurationHours").value = edh;
	x.elements.namedItem("expectedDurationMinutes").value = edm;
	x.elements.namedItem("parentTask_id").value = fn;
	x.elements.namedItem("usergroup_id").value = ln;
	x.elements.namedItem("_row").value = id;
	x.elements.namedItem("updatedDatetime").value = updateDatetime;
	x.elements.namedItem("_btnSubmit").value = 'Opdater';
}
</script>
<?php
	$query = "SELECT * FROM user ";
	$result = $conn->query($query);

	if ($result->num_rows > 0) {
		// output data of each row
		echo "<table>";
		while($row = $result->fetch_assoc()) {
			echo "<tr><td onclick=\"fillForm('".$row["taskUID"]."','".$row["title"]."','".$row["description"]."','" . $row["parenttask_id"]."','" . $row["usergroup_id"] . "','" . $row["title"]. "','" . $row["prerequisites"] . "','" . $row["description"] . "','" . $row["expectedDurationHours"]."','" . $row["expectedDurationMinutes"] . "','id=" . $row["id"] . "');\" style=\"background-color:$colorGreen; cursor: pointer; cursor: hand;\">";
			echo $row["id"];
			echo "</td><td>";
			echo $row["taskUID"];		
			echo "</td><td>";
			echo $row["title"];		
			echo "</td><td>";
			echo $row["retired"];			
			echo "</td></tr>";
		}
		echo "</table>";
	} else {
		echo "0 results";
	}
	$conn->close();

}
?>

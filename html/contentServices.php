<?php
	$query = "SELECT * FROM user WHERE retired = 0";
	$result = $conn->query($query);
	$option = "";
	while($row = $result->fetch_assoc()) {
		$option .= "<option value=\"".$row["id"] . "\">".$row["firstname"] . " " .$row["lastname"]."</option>";
	}
?>

<h1>Services</h1>

<form name="myService" action="db/update.php" method="POST">
<table>
<tr><td>Service Navn</td><td><input name="name" type=text title="Indtast servicens kaldenavn. eks LDAP."></td></tr>
<tr><td>Service beskrivelse</td><td><textarea name="description" title="" ></textarea></td></tr>
<tr><td>Service Ejer</td><td><select name="owner" title="eks CNS01"><option value=""> - ingen valgt - </option><?php echo $option;?></select></td></tr>
<tr><td></td><td><input type=submit name="_btnSubmit" value="Opret ny service"></td></tr>
</table>
<input type=hidden name="_table" value="service">
<input type=hidden name="updatedDatetime" value="2015-06-24 14:19:00">
<input type=hidden name="updatedBy" value="me">
<input type=hidden name="_row" value="">
</form>
<br><br>
<script language="Javascript">

function fillForm(sn,sd,so,id){
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
	var month =d.getMonth();
	if (month < 10) {
		month = "0" + month;
	}
	var year = d.getFullYear();
	var updateDatetime = year + "-" + month + "-" + date + " " + hr + ":" + min + ":00";
	var x = document.forms.namedItem("myService");
	x.elements.namedItem("name").value = sn;
	x.elements.namedItem("description").value = sd;
	x.elements.namedItem("owner").value = so;
	x.elements.namedItem("_row").value = id;
	x.elements.namedItem("_btnSubmit").value = 'Opdater';
	x.elements.namedItem("updatedDatetime").value = updateDatetime;	
}
</script>
<?php
	$query = "SELECT service.*, user.firstname, user.lastname FROM service LEFT JOIN user ON service.owner = user.id ";
	$result = $conn->query($query);

	if ($result->num_rows > 0) {
		// output data of each row
		echo "<table>";
		while($row = $result->fetch_assoc()) {
			echo "<tr><td onclick=\"fillForm('".$row["name"]."','".$row["description"]."','".$row["owner"]."','id=".$row["id"]."');\" style=\"background-color:$colorGreen; cursor: pointer; cursor: hand;\">";
			echo $row["id"];
			echo "</td><td>";
			echo $row["name"];
			echo "</td><td>";
			echo $row["description"];
			echo "</td><td>";
			echo $row["firstname"] . " " . $row["lastname"];			
			echo "</td><td>";
			echo "<a href='?page=tasks&service=".$row["id"]."'>tasks</a>";
			echo "</td></tr>";
		}
		echo "</table>";
	} else {
		echo "0 results";
	}
	$conn->close();
?>

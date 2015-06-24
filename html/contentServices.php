<h1>Services</h1>

<form name="myService" action="db/update.php" method="POST">
<table>
<tr><td>Service Navn</td><td><input name="serviceName" type=text title="Indtast servicens kaldenavn. eks LDAP."></td></tr>
<tr><td>Service beskrivelse</td><td><textarea name="serviceDescription" title="" ></textarea></td></tr>
<tr><td>Service Ejer</td><td><input name="serviceOwner" type=text title="eks CNS01"></td></tr>
<tr><td></td><td><input type=submit name="_btnSubmit" value="Opret ny service"></td></tr>
</table>
<input type=hidden name="_table" value="service">
<input type=text name="updatedDatetime" value="2015-06-24 14:19:00">
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
	x.elements.namedItem("serviceName").value = sn;
	x.elements.namedItem("serviceDescription").value = sd;
	x.elements.namedItem("serviceOwner").value = so;
	x.elements.namedItem("_row").value = id;
	x.elements.namedItem("_btnSubmit").value = 'Opdater';
	x.elements.namedItem("updatedDatetime").value = updateDatetime;	
}
</script>
<?php
	$query = "SELECT * FROM service ";
	$result = $conn->query($query);

	if ($result->num_rows > 0) {
		// output data of each row
		echo "<table>";
		while($row = $result->fetch_assoc()) {
			echo "<tr><td onclick=\"fillForm('".$row["serviceName"]."','".$row["serviceDescription"]."','".$row["serviceOwner"]."','id=".$row["id"]."');\">";
			echo $row["id"];
			echo "</td><td>";
			echo $row["serviceName"];
			echo "</td><td>";
			echo $row["serviceDescription"];
			echo "</td><td>";
			echo $row["serviceOwner"];			
			echo "</td><td>";
			echo $row["createdDatetime"];			
			echo "</td><td>";
			echo $row["updatedDatetime"];			
			echo "</td><td>";
			echo $row["retired"];			
			echo "</td></tr>";
		}
		echo "</table>";
	} else {
		echo "0 results";
	}
	$conn->close();
?>
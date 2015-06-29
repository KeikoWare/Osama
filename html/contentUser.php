<h1>Users</h1>

<form name="myUser" action="db/update.php" method="POST">
<table>
<tr><td>Username</td><td><input name="username" type=text title="Indtast brugerens username"></td></tr>
<tr><td>password</td><td><input name="password" type=text title="" ></td></tr>
<tr><td>Titel</td><td><input name="title" type=text title=""></td></tr>
<tr><td>Fornavn</td><td><input name="firstname" type=text title=""></td></tr>
<tr><td>Efternavn</td><td><input name="lastname" type=text title=""></td></tr>
<tr><td>E-Mail</td><td><input name="mail" type=text title=""></td></tr>
<tr><td>Mobil Telefon</td><td><input name="phone" type=text title=""></td></tr>
<tr><td></td><td><input type=submit name="_btnSubmit" value="Opret ny bruger"></td></tr>
</table>
<input type=hidden name="_table" value="user">
<input type=hidden name="updatedDatetime" value="2015-06-24 14:19:00">
<input type=hidden name="updatedBy" value="me">
<input type=hidden name="_row" value="">
</form>
<br><br>
<script language="Javascript">

function fillForm(un,pw,fn,ln,em,ti,ph,id){
	var x = document.forms.namedItem("myUser");
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
	x.elements.namedItem("username").value = un;
	x.elements.namedItem("password").value = pw;
	x.elements.namedItem("firstname").value = fn;
	x.elements.namedItem("lastname").value = ln;
	x.elements.namedItem("mail").value = em;
	x.elements.namedItem("title").value = ti;
	x.elements.namedItem("phone").value = ph;
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
			echo "<tr><td onclick=\"fillForm('".$row["username"]."','".$row["password"]."','".$row["firstname"]."','".$row["lastname"]."','".$row["mail"]."','".$row["title"]."','".$row["phone"]."','id=".$row["id"]."');\" style=\"background-color:$colorGreen; cursor: pointer; cursor: hand;\">";
			echo $row["id"];
			echo "</td><td>";
			echo $row["title"];
			echo "</td><td>";
			echo $row["firstname"];			
			echo "</td><td>";
			echo $row["lastname"];			
			echo "</td><td>";
			echo $row["phone"];			
			echo "</td><td>";
			echo $row["mail"];			
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

<?php
include("db/connect.php");
$colorGreen = "#8AC007";
$page = @$_REQUEST["page"];
if ($page == ""){
	$page = "main";
}
?>

<html>
<head>
<style>
#topFrame {
    border-radius: 25px;
    border: 2px solid <?php echo $colorGreen;?>;
    padding: 10px; 
    width: 1040px;
    height: 80px; 
}
#bottomFrame{
    width: 1060px;
    height: 100%; 

}
#leftMenuframe {
    border-radius: 25px;
    border: 2px solid <?php echo $colorGreen;?>;
    padding: 10px; 
	margin-top: 10px;
    width: 200px;
	float:left;
}
#rightContentFrame {
    border-radius: 25px;
    border: 2px solid <?php echo $colorGreen;?>;
    padding: 10px; 
	margin-top: 10px;
    width: 800px;
    height: 70%; 
	float:right;
}
li:not(:last-child) {
    margin-bottom: 5px;
}
</style>
</head>

<body>



<div id=topFrame><?php
echo "<span align=center><h1>O<span style=\"color:$colorGreen;\">pen</span>S<span style=\"color:$colorGreen;\">ource</span>A<span style=\"color:$colorGreen;\">dministrators</span>M<span style=\"color:$colorGreen;\">anagement</span>A<span style=\"color:$colorGreen;\">pplication</span></h1></span>"; 
?></div>
<div id=bottomFrame> 
	<div id=leftMenuframe> 
	<?php
echo "<span align=center><h2>N<span style=\"color:$colorGreen;\">avi</span>G<span style=\"color:$colorGreen;\">ation</span></h2></span>"; 
?>
<ul id=menu style="list-style-type:none;padding-left:0;">
	<li><b>Daglig drift</b></li>
	<ul id=submenu_dd style="list-style-type:disc">
		<li><a href="?page=scheduled">Planlagte opgaver</a></li> 
	</ul>
	<li>&nbsp;</li>
	<li><b>Entiteter</b></li>
	<ul id=submenu_en style="list-style-type:disc">
		<li><a href="?page=services">Services</a></li> 
		<li><a href="?page=pools">Ressource Pools</a></li> 
		<li><a href="?page=people">People</a></li> 
		<li><a href="?page=tasks">Opgaver</a></li> 
	</ul>
</ul>
	</div>
	<div id=rightContentFrame>
<?php
$err = 0;
	switch ($page) {
    case "main":
        if ((include 'contentMain.php') != 'OK') $err++; 
        break;
    case "scheduled":
        if ((include 'contentScheduled.php') != 'OK') $err++; 
        break;
    case "services":
        if ((include 'contentServices.php') != 'OK') $err++; 
        break;
    case "pools":
        if ((include 'contentPools.php') != 'OK') $err++; 
        break;
    case "people":
        if ((include 'contentPeople.php') != 'OK') $err++; 
        break;
	default:
		$err++;
}
        if($err>0) include("contentError.php");
?>
	</div>
</div>


</body>
</html>
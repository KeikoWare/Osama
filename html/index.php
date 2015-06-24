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
    min-height: 400px; 
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
	<li><b>Startside</b></li>
	<ul id=submenu_dd style="list-style-type:disc">
		<li><a href="?page=main">Startside</a></li> 
	</ul>
	<li>&nbsp;</li>
	<li><b>Daglig drift</b></li>
	<ul id=submenu_dd style="list-style-type:disc">
		<li><a href="?page=scheduled">Planlagte opgaver</a></li> 
	</ul>
	<li>&nbsp;</li>
	<li><b>Entiteter</b></li>
	<ul id=submenu_en style="list-style-type:disc">
		<li><a href="?page=services">Services</a></li> 
		<li><a href="?page=pools">Ressource Pools</a></li> 
		<li><a href="?page=users">People</a></li> 
		<li><a href="?page=tasks">Opgaver</a></li> 
	</ul>
</ul>
	</div>
	<div id=rightContentFrame>
<?php
$err = 0;
	switch ($page) {
    case "main":
		try {
			require 'contentMain.php';
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
       break;
    case "scheduled":
		try {
			require 'contentScheduled.php';
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
        break;
    case "services":
		try {
			require 'contentServices.php';
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
        break;
    case "pools":
		try {
			require 'contentPools.php';
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
        break;
    case "users":
		try {
			require 'contentUser.php';
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
        break;
	default:
		try {
			require "content".$page.".php";
		} catch (Exception $e) {
			$err++;
			$errmsg = $e->getMessage();
		}
}
        if($err>0) include("contentError.php");
?>
	</div>
</div>


</body>
</html>
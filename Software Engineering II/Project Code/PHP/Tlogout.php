<?php
	require "conn.php";

	$user_name = $_POST["user_name"];
	$user_pass = $_POST["password"];
	$sql = "UPDATE Teacher SET Loggedin=0 WHERE username='$user_name' AND password='$user_pass'";
	if($conn->query($sql) === TRUE){	
		echo "logged out";
	}
	else{
		echo "logout not successful...";
	}

?>
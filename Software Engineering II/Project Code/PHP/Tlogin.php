<?php
	require "conn.php";

	$user_name = $_POST["user_name"];
	$user_pass = $_POST["password"];
	$sql = "SELECT * FROM Teacher WHERE username='$user_name' AND password='$user_pass';";	
	$result = $conn->query($sql);
	if($result->num_rows > 0){	
		$sql2 = "UPDATE Teacher SET Loggedin=1 WHERE username='$user_name' AND password='$user_pass'";
		$result = mysqli_query($conn,$sql2);
		echo "login success!!!!! Welcome user!";
	}
	else{
		echo "Loggin unsuccessful...";
	}

?>
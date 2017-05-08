<?php

	require "conn.php";
	$username = $_POST["username"];
	$password = $_POST["password"];
	$msg = $_POST["message"];
	
	$sql = "SELECT * FROM Teacher WHERE username='$username' AND password='$password'";
	if($result = mysqli_query($conn,$sql)){	
		$sql2 = "INSERT INTO Notification (msg,nameTeacher) VALUES('$msg','$username')";
		$result = mysqli_query($conn,$sql2);
		mysqli_close($conn);
		echo "Message Sent!";
	}
	else{
		echo "ERROR: Message NOT sent";
	}
?>
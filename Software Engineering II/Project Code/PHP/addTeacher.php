<?php

	require "conn.php";

	$username = $_POST["name"];
	$password = $_POST["password"];
	
	$sql2 = "INSERT INTO Teacher (username,password) VALUES('$username','$password')";
	$result = mysqli_query($conn,$sql2);
	if($result == 1)
	{
		echo "Teacher Added!";
	}
	else
	{
		echo "ERROR: Teacher not Added";
	}
	mysqli_close($conn);
?>
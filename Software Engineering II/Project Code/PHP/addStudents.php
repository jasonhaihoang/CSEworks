<?php

	require "conn.php";

	$username = $_POST["username"];
	$password = $_POST["password"];
	
	$name = $_POST["name"];
	$usernamenew = $_POST["usernamenew"];
	$passwordnew = $_POST["passwordnew"];
	$instrument= $_POST["instrument"];
	$classes= $_POST["classes"];
	$fieldNum= $_POST["fieldNum"];
		
	$sql2 = "INSERT INTO Student (name,username,password,instrument,class,FieldNum) VALUES ('$name','$usernamenew','$passwordnew','$instrument','$classes','$fieldNum')";
	if($result = mysqli_query($conn,$sql2)){	
		echo "Student Added!";
		mysqli_close($conn);
	}
	else{
		echo "ERROR: Student NOT Added OR already in the system";
	}
?>
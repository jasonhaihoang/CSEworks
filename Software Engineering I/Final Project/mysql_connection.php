<?php	//shortcut to create connection to the database

	$servername = "127.0.0.1";
	$db_username = "cadudi_project";
	$db_password = "password123";
	$db_name = "cadudi_resProject";
	
	// Create MySQL connection
	$conn = new mysqli($servername, $db_username, $db_password, $db_name);
	
	// Check connection
	if ($conn->connect_error)
	{
		die("Connection failed: " . $conn->connect_error);
	}
?>
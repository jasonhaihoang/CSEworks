<?php

	//open session
	session_start();
	
	//import connection to mysql
	require_once('mysql_connection.php');
	
	// update customers money
	$money = round($_POST["cash"],2);
	$sql = "UPDATE Coustomers SET creditsDollar=(creditsDollar + " . $money . ") WHERE tableid=" . $_POST["tableid"];
	if ($conn->query($sql))
	{
		// go back to wait staff home page
		header( "Location: /waitStaffHome.php", true);
	}
	else { //if not connected, error
  		echo $conn->error;
  	}
	
	mysqli_close($conn);
?>
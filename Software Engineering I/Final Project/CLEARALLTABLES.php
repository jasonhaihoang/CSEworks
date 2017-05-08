<?php
	//Open session
	session_start();
	require_once('mysql_connection.php');
	
	// RESET ALL TABLES
	$conn->query("UPDATE Coustomers SET billPaid=0, gameCounter=0, canOrder=1, loggedInToday=0");
	$conn->query("UPDATE Orders SET orderStatus='N/A'");
	$conn->query("DELETE FROM YourOrder");
	$conn->query("UPDATE Tables SET status='Reading Menu'");
	$conn->query("UPDATE Waitstaff SET gratuity=0");
	$conn->query("DELETE FROM Comps");
	$conn->query("UPDATE MenuItems SET timesOrdered=0, availability=1");
	//$conn->query("UPDATE Employees SET totalOrders=0");

	// go back to manager home
	header("Location: http://evan.cadudi.com/manager.php");
	exit();
?>
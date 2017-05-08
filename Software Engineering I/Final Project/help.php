<?php
	session_start();
	// import $conn connection
	require_once('mysql_connection.php');

	// set table status to help
	$sql = "UPDATE Tables SET status='HELP' WHERE id=".$_SESSION["tableid"];
	if ($conn->query($sql) == TRUE) {
        	//error hanling
    	} else {
        	echo "Error adding item: " . $conn->error;
    	}
	
	// go back home
	header("Location: /place_order.php");
?>

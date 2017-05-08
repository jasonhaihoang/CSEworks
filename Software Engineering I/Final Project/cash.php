<?php
	session_start();
	// import $conn connection
	require_once('mysql_connection.php'); //get cpmmectopm
	header("Location: /place_order.php");

	$sql = "UPDATE Tables SET status='HELP' WHERE coustomerid='".$_SESSION["userid"]."'";
	if ($conn->query($sql) == TRUE) {  //if connection is successful
        	//echo "MenuItem added successfully";
    	} else {  //connection failed
        	echo "Error adding item: " . $conn->error;
    	}	

?>
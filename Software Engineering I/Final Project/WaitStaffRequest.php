<?php

   	session_start();
    	require_once('mysql_connection.php');
    	$tableid = $_SESSION["tableid"];
	$itemid = $_SESSION["itemid"];
	$issueD = date("mdY");
	$requestText = $_POST["special_request"];

	// add item to YourOrder - Do not delete the line below!
	$conn->query("INSERT INTO YourOrder (id, menuItemId, specialRequest, date) VALUES ('". ($tableid + 9) ."','$itemid','".$requestText."','$issueD')");
	
	//update the menu item's timesOrdered variable by adding 1 in the menu database
	$sql = "SELECT id FROM MenuItems WHERE id=".$itemid;	//Select the item being added
	if($result = $conn->query($sql)) {
        	$row = $result->fetch_assoc();
		$orderedCount = $row["timesOrdered"];
		$orderedCount = $orderedCount + 1;	//increment
		//update MenuItems
		$sql4 = "UPDATE MenuItems SET timesOrdered='$orderedCount' WHERE id=".$itemid;		
		if ($conn->query($sql4)) {
        		//echo "MenuItem added successfully";
    		} else {
        		echo "Error adding item: " . $conn->error;
    		}
	}
	else {
        	echo $conn->error;
       }

	// start the dump and catch of output buffer
	ob_start();

	// set the url to be the home page
	$url = 'waitStaffHome.php';

	// clear out the output buffer
	while (ob_get_status()) 
	{
    		ob_end_clean();
	}

	// go to home
	header( "Location: $url" );

	mysqli_close($conn);

?>
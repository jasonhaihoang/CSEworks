<?php
	session_start();	//SESSION variables
	require_once('mysql_connection.php');	//connect to database
	$yourOrderId = $_SESSION["yourOrderId"];
	//Update the selected menu item to being split from the order
	for($i = 0; $i <= 30; $i++){	//traverses order's list of items
		if(isset($_POST[$i])){	//if the item is selected
			//limit the number of items being split at a time
			$sql = "UPDATE YourOrder SET split=1 WHERE id='$yourOrderId' and menuItemID='$_POST[$i]' LIMIT 1";
			if ($conn->query($sql) == TRUE) {
        			//echo "MenuItem added successfully";
    			} else {
        			echo "Error adding item: " . $conn->error;
    			}
		}
	}

	ob_start(); // ensures anything dumped out will be caught

	// do stuff here
	$url = 'newsplit_check.php'; // this can be set based on whatever

	// clear out the output buffer
	while (ob_get_status()) 
	{
    		ob_end_clean();
	}

	// no redirect
	header( "Location: $url" );

?>
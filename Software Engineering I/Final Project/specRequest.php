<?php

    	session_start();
    	require_once('mysql_connection.php');	//connect to database
    	$userid = $_SESSION["userid"];
	$itemid = $_SESSION["itemid"];
	$issueD = date("mdY");		//calculate the date
	$requestText = $_POST["special_request"];
	
	//collect the data about the customer's order in order to insert the added item
	$sql = "SELECT orderid FROM Coustomers WHERE id=".$userid;
	if($result = $conn->query($sql)) {
        	$row = $result->fetch_assoc();
		$sql2 = "SELECT yourOrderId FROM Orders WHERE id=".$row["orderid"];
		if($result2 = $conn->query($sql2)) {
        		$row2 = $result2->fetch_assoc();
			$orderId = $row2[yourOrderId];
			//Insert item with the special request to the customer's order
			$sql3 = "INSERT INTO YourOrder (id, split, menuItemId, specialRequest, date) VALUES ('$orderId',0,'$itemid','".$requestText."','$issueD')";
		
			if ($conn->query($sql3) === TRUE) {
        			//echo "MenuItem added successfully";
    			} else {
        			echo "Error adding item: " . $conn->error;
    			}
		}
		else {
        		echo $conn->error;
        	}
	}
	else {
        	echo $conn->error;
        }

	//update the menu item's timesOrdered variable by adding 1 in the menu database
	$sql = "SELECT id FROM MenuItems WHERE id=".$itemid;	//Select the item being added
	if($result = $conn->query($sql)) {
        	$row = $result->fetch_assoc();
		$orderedCount = $row["timesOrdered"];
		$orderedCount = $orderedCount + 1;	//increment
		//update MenuItems
		$sql4 = "UPDATE MenuItems SET timesOrdered='$orderedCount' WHERE id=".$itemid;		
		if ($conn->query($sql4) === TRUE) {
        		//echo "MenuItem added successfully";
    		} else {
        		echo "Error adding item: " . $conn->error;
    		}
	}
	else {
        	echo $conn->error;
        }

	ob_start(); // ensures anything dumped out will be caught

	// do stuff here
	$url = 'review_order.php'; // this can be set based on whatever

	// clear out the output buffer
	while (ob_get_status()) 
	{
    		ob_end_clean();
	}

	// no redirect
	header( "Location: $url" );

	mysqli_close($conn);

?>
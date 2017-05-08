<?php
	//adds a menu item to an order

	session_start();
	require_once('mysql_connection.php');

	$userid = $_SESSION["userid"];
	$itemid = $_POST["add"];
	$issueD = date("mdY");

	//determine order id
	$sql = "SELECT orderid FROM Coustomers WHERE id=".$userid;
	if($result = $conn->query($sql)) {
        	$row = $result->fetch_assoc();
		$sql2 = "SELECT yourOrderId FROM Orders WHERE id=".$row["orderid"];
		if($result2 = $conn->query($sql2)) {
			//add the order
        		$row2 = $result2->fetch_assoc();
			$orderId = $row2["yourOrderId"];
			$sql3 = "INSERT INTO YourOrder (id, split, menuItemId, date) VALUES ('$orderId',0,'$itemid','$issueD')";
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

	//increment the times ordered
	$sql = "SELECT * FROM MenuItems WHERE id=".$itemid;
	if($result = $conn->query($sql)) {
        	$row = $result->fetch_assoc();
		$orderedCount = $row["timesOrdered"];
		$orderedCount = $orderedCount + 1;
	
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

<?php
	session_start();
	require_once('mysql_connection.php');	connect to database
	
	// input vars from html page
	$email = $_POST["email"];
	$date = date('m-d-Y H:i:s A e');
	
	
	// generate order to send
	$content = "Thank you for eating at our restraunt!\r\n";
	$totalSum = 0;
	//Collect data from database about the order being split, then display it on the receipt
	$sql = "SELECT * FROM Coustomers WHERE id=".$_SESSION["userid"];
	if($result = $conn->query($sql))
	{
            	while($row = $result->fetch_assoc())
		{
			$tax = 0;
			$totalSum = 0;
            	    	if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
				while($row2 = $result2->fetch_assoc()) {
					if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"]." && split=1")) {
						while($row4 = $result4->fetch_assoc()) {
							if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
								while($row5 = $result5->fetch_assoc()) {
									$totalSum += $row5["price"];
						 	  	 	$content = $content . $row5["name"] . " - " . $row4["specialRequest"] . " - " . $row5["price"] . "\r\n";
								}
							}
						}
					}
				}
		    	}
            	    	else {
                		echo $conn->error;
            	   	}

		}
	}
	//calculate the tax and totals
	$tax = round($totalSum * 0.08, 2);
	$totalSum = round($totalSum + $tax, 2);
	$content = $content."----------\r\nTax = $".$tax."\r\nTotal = \$".$totalSum;
	$content = $content . "\r\n\r\n$date";
	// end generating order to send
	
	//Update all items on the order to paid by setting split to 9
	$yourOrderId = $_SESSION["yourOrderId"];
	$sql = "UPDATE YourOrder SET split=9 WHERE id='$yourOrderId' and split=1";
	if ($conn->query($sql) == TRUE) {
        	//echo "MenuItem updated successfully";
    	} else {
        	echo "Error adding item: " . $conn->error;
    	}

	// input button value and email order to user
	$button_value = $_POST["email-button"];	
	if($button_value == "Email")
	{
		mail($email, 'Your receipt', $content);
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

	mysqli_close($conn);
?>
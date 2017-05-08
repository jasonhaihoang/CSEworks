<?php
	//open session
	session_start();
	require_once('mysql_connection.php');
	
	// input vars from html page
	$email = $_POST["email"];
	$date = date('m-d-Y H:i:s A e');

	
	
	
	// generate order to send
	$content = "Thank you for eating at our restraunt!\r\n";
	$totalSum = 0;
	$sql = "SELECT * FROM Coustomers WHERE id=".$_SESSION["userid"];
	if($result = $conn->query($sql))
	{	//as long as data exist, keep reading 
            	while($row = $result->fetch_assoc())
		{
			$tax = 0;
			$totalSum = 0;
            	    	if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {  //connection succeeded
				while($row2 = $result2->fetch_assoc()) {
					if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
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
            	    	else { //connection failed
                		echo $conn->error;
            	   	}

		}
	}
	$tax = round($totalSum * 0.08, 2);  //tax is 8%. round up to 2 decimals
	$tip = round($totalSum*.17,2);  //tip is 17%
	$subTotal = $totalSum;		//get total charge amount 
	$totalSum = round($totalSum + $tax + $tip, 2);   //add all together
	$content = $content."----------\r\nSub Total = ". $subTotal . "\r\nGratuity = " . $tip . "\r\nTax = $".$tax."\r\nTotal = \$".$totalSum;
	$content = $content . "\r\n\r\n$date";
	// end generating order to send
	
	// input button value and email order to user
	$button_value = $_POST["email-button"];	
	if($button_value == "Email")	//if customer chooses to send their receipt to their email
	{
		mail($email, 'Your receipt', $content);
		echo file_get_contents("survey.html", true);
	}
	
	mysqli_close($conn);
?>
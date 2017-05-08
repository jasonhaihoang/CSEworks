<?php

	// start php session
	session_start();
	require_once('mysql_connection.php');

	// update status user

	$sql = "UPDATE Coustomers SET billPaid=1, visitNum=IF(visitNum>4, 0, visitNum+1), creditsDollar=IF(visitNum>4, creditsDollar +10, creditsDollar) WHERE id=" . $_SESSION["userid"];

	if ($conn->query($sql))
	{
		// update Table's tatus to paid
		$sql = "UPDATE Tables SET status='Paid' WHERE id=" . $_SESSION["orderid"];
		// update Employees totalOrders value. Incriment by 1 everytime survey is taken. 
		$sql = "UPDATE Employees SET totalOrders=(totalOrders +1)";
		if ($conn->query($sql))
		{
			// go back to home screen
			//echo file_get_contents("place_order.php", true);
			header('Location: place_order.php');
		}
		else {
  			echo $conn->error;
  		}
	}
	else {
  		echo $conn->error;
  	}
	
	// close mysql connection
	mysqli_close($conn);

?>
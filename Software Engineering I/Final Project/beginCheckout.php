<?php
	session_start();
	require_once('mysql_connection.php');

	$_SESSION["canOrder"] = 0;
	
	//note that the customer has submitted an order
	if($result = $conn->query("UPDATE Coustomers SET canOrder=0 WHERE id=".$_SESSION["userid"]))
	{
		//header('Location: http://evan.cadudi.com/place_order.php');
	}
	else {
  		echo $conn->error;
  	}
//updates table status
	if($result = $conn->query("UPDATE Tables SET status='Placed Order' WHERE id=".$_SESSION["tableid"]))
	{
		header('Location: http://evan.cadudi.com/place_order.php');
	}
//error handling
	else {
  		echo $conn->error;
  	}
	
	exit();
?>

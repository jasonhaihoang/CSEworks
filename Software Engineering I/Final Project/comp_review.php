<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/comped_order.css"/>

  </head>

  <body>

    <img src="images/BG - Faded.png" />

    <div id="ribbon"></div>

    <div id="interface">

	<!--Back button to previous page-->
        <div class="logout">
		<button onclick="location.href='manager.php'">Back</button>
			
	</div>

	<!--show a message -->
        <h1>Review Comped Orders</h1>

        <div id="order-box" style="height:450px;">

		<div style="width:800px;height:450px;line-height:3em;overflow:auto;padding:0px; font-size:20px;">




<?php
	session_start();  //open session
	require_once('mysql_connection.php');  //open connection
  	$categories = array("id", "waitStaffName", "menuItemId", "compReason");

	//if connection succeeds
	if($result = $conn->query("SELECT * FROM Comps")) {
		while($row5 = $result->fetch_assoc()) {  //fetch data and message
			echo "<li style='margin-bottom:-25px;'>Menu ID# = ". $row5["menuItemId"]."  -  ".$row5["waitStaffName"]." - ".$row5["compReason"]."</li>";
      		}
  	}
  	else { //connection fails
  		echo $conn->error;
  	}
?>




		</div>
	</div>



    </div>

    
  </body>
</html>
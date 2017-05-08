<!-- screen to set an item to complementary (wait staff) -->
<!DOCTYPE html> 


<html>

    <head>

    	<title>Comp Item</title>

    	<link type="text/css" rel="stylesheet" href="styles/waitStaffHome.css"/>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/place_order.js"></script>
    </head>

    

    <body>

       <img src="images/BG - Faded.png" />

    <div id="ribbon"></div>

    <div id="interface">
	
	<!-- global button for back/logout -->
	<div class="logout">
		<button onclick="location.href='waitStaffHome.php'">Back</button>
	</div>
	<?php
		//start session
		session_start();
		echo "<h1>Comp Menu Item - ".$_SESSION["username"]."</h1>";
	?>
	
	
	<?php
		//Start the session
	    session_start();
		//get connection
	    require_once('mysql_connection.php');

	    
	    $content = "";

            $sql = "SELECT * FROM Tables WHERE waitStaffId=".$_SESSION["userid"];
            if($result = $conn->query($sql)) { //get connection
            	while($row = $result->fetch_assoc()) { //and fetch data


		    $content = $content .  "<form action='compItem.php' method='post'>
						<div id='order_list' style='margin-left:0;' disabled>
						<div style='position:absolute; top: 0; left: 10;'>";
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				//list order items and add their prices
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE comped=0 AND id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								$totalSum = $totalSum + $row5["price"]; //find the total sum
						   	 	$content = $content. "ID# = ". $row5["id"]."  -  ".$row5["name"]." - ".$row4["specialRequest"]."<br>";
							}
						}
					}
				}
			}
		    }
            	    else { //connection fail
                		echo $conn->error;
            	    }
			//for adding tax to the sum of their charged amount
		    $tax = round($totalSum * 0.0825, 2); 
		    $totalSum = round($totalSum + $tax, 2);  //round up to 2nd decimal point
		    $content = $content ."----------<br>
		    				</div>

			</div>
		    	<p>

			//reason for comping, and get input 
			<div>
	  			<h1>Reason for comp:</h1> 
			</div>
			<input type='hidden' name='orderId' value = ".$row['orderid'].">
	    		<input style='width: 600px; margin-top: -5px; margin-right: 10px;' type='text' name='reason' placeholder='Explain the reason for comping this item.' required>
			
			///////////////////////////////////////////////////////////////
	      		<div>
	        		<h1>Comped Menu Item ID:</h1>
			</div>
			<input style='width: 100px; ' type='text' name='menuID' placeholder='Item ID #' required><p>

			<input style='width: 250px; height:50px; background-color: #23a21d; color:white; font-size: 20px; font-weight: 100; border: none;text-align: left;'
				name='compItem' type='submit' value='Submit Comp Item'>

			</form>";
		}
	     }
            else { //connection failed
                echo $conn->error;
            }
            echo $content;
			
		mysqli_close($conn);
	?>

    </div>

    </body>

</html>


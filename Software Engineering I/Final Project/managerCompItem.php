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
	
	<!-- Back Button -->
	<div class="logout">
		<button onclick="location.href='manager.php'">Back</button>
	</div>

	<!-- Print manager's name -->
	<?php
		session_start();
		echo "<h1>Comp Menu Item - Manager</h1>";
	?>
	
	
	<?php
	    session_start();
	    require_once('mysql_connection.php');

	    // declare variable
	    $content = "";

	     // select all tables
            $sql = "SELECT * FROM Tables";
            if($result = $conn->query($sql)) {
            	while($row = $result->fetch_assoc()) {

			// add table name to output buffer
		    $content = $content .  "<form action='compItemManager.php' method='post'>
						<div id='order_list' style='margin-left:0;' disabled>
						<div style='position:absolute; top: 0; left: 10;'>";

			// loop through all ordered items from the table
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE comped=0 AND id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc())
							{
								// add ordered items to output
								$totalSum = $totalSum + $row5["price"];
						   	 	$content = $content. "ID# = ". $row5["id"]."  -  ".$row5["name"]." - ".$row4["specialRequest"]."<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    
		    // close table and print the reason and menu item id and text boxes
		    $content = $content ."----------<br>
		    				</div>

			</div>
		    	<p>

			<div>
	  			<h1>Reason for comp:</h1> 
			</div>
                        <input type='hidden' name='orderId' value = ".$row['orderid'].">
	    		<input style='width: 600px; margin-top: -5px; margin-right: 10px;' type='text' name='reason' placeholder='Explain the reason for comping this item.' required>

	      		<div>
	        		<h1>Comped Menu Item ID:</h1>
			</div>
			<input style='width: 100px; ' type='text' name='menuID' placeholder='Item ID #' required><p>

			<input style='width: 250px; height:50px; background-color: #23a21d; color:white; font-size: 20px; font-weight: 100; border: none;text-align: left;'
				name='compItem' type='submit' value='Submit Comp Item'>

			</form>";
		}
	     }
            else {
                echo $conn->error;
            }
	
	     // output everything
            echo $content;

			
		mysqli_close($conn);
	?>

    </div>

    </body>

</html>


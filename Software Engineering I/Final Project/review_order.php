<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/review_order.css"/>
    <link type="text/css" rel="stylesheet" href="styles/help_refill_social_media.css"/>
    <script type="text/javascript" src="scripts/place_order.js"></script>
  </head>

  <body>

    <img src="images/BG - Faded.png" />

    <div id="ribbon"></div>

    <div id="interface">

	<!-- Global Back Button -->
	<button style="position: absolute;
			width: 30px; height: 20px; font-size: 20px;
			font-weight: 100; padding: 5px 70px 30px 5px;
			margin-top: 5px; margin-left: 800px;"
			onclick="location.href = 'place_order.php'">Back
	</button>
	<!-- End Global Back Button -->

        <h1>Your Order</h1>

        <div id="order-box" style="position:absolute; overflow:auto;  margin-right:-200px;">



<?php
	    session_start();	//SESSION variables
	    require_once('mysql_connection.php');	//connect to database

	    $content = "";
	    //Collect data for all items that were added to the customer's order and display them in order form
            $sql = "SELECT * FROM Coustomers WHERE id=".$_SESSION["userid"];
            if($result = $conn->query($sql)) {
            	while($row = $result->fetch_assoc()) {
		$tax = 0;
		$totalSum = 0;
		    $content = $content . "<div style=' top: 0; left: 10;  margin-right:150px;'>";
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//calculate the total and display item info
								$totalSum += $row5["price"];
						   	 	$content = $content . $row5["name"] . " - " . $row4["specialRequest"] . "<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //calculate the tax, gratuity, and totals
		    $tax = round($totalSum * 0.08, 2);
		    $tip = round($totalSum*.17,2);
		    $subTotal = $totalSum;
		    $totalSum = round($totalSum + $tax + $tip, 2);

		    $content = $content."</div><div>
					----------<br>
					SubTotal<br>
					Gratuity<br>
					Tax<br>
					Total<br>
				</div>
				<div style='position:absolute; top:0; right:10px;'>";
		    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//displays the price for each ordered item
						   	 	$content = $content . "\$" . $row5["price"] . "<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //display financial info
		    $content = $content."----------<br>
					\$". $subTotal."<br>
					\$" . $tip ."<br>
					\$".$tax."<br>
					\$".$totalSum."</div>";
		}
	     }
            else {
                echo $conn->error;
            }
	    //display the order info to the screen and close connection
            echo $content;
            mysqli_close($conn);
	?>

	</div>

        <div class="bot" style="margin-top:450px;">	<!-- Add items to order/Submit order buttons -->

            <button onclick="location.href='menu.php'"> Add more items to order </button>

            <button onclick="location.href='submitorder.php'"> Submit order </button>
        </div>

    </div>
  </body>


<!-- Below is code for the Refill, Help, and Twitter Buttons -->

<?php
session_start();
?>
	<div class="assistance" style="vertical-align: top; position: Relative; left: 130px; top: 650px; margin-right:200px;">
		<!-- Refill -->
		<button onclick="toggle_visibility('popup-box1');">Refill</button>
		
		<!-- Help -->
		<button onclick="toggle_visibility('popup-box2');">Help</button>
	</div>
	<div id="outer">
	<!-- Refill Interface -->
	<div id="popup-box1" class="popup-position">

	<div id="popup-wrapper">

	    <form action="refill.php" method="post">

		<div id="popup-container">	<!-- sends notification to waitstaff -->
			<h3>Please Select the Drink(s) that you want refilled:</h3>
			<table>
			    <tr>
				<th></th>
				<th>Drinks</th>
			    </tr>

			    <tr>
				<td><input name="drink1" type="checkbox" value="Coke"></td>
				<td>Coke</td>
			    </tr>

			    <tr>
				<td><input name="drink2" type="checkbox" value="Sprite"></td>
				<td>Sprite</td>
			    </tr>

			    <tr>
				<td><input name="drink3" type="checkbox" value="Fanta"></td>
				<td>Fanta</td>
			    </tr>			

			    <tr>
				<td><input name="drink4" type="checkbox" value="Water"></td>
				<td>Water</td>
			    </tr>
			</table>
			<p><input name="drink-submit" type="submit" value="Submit" onclick="toggle_visibility('popup-box1');"></a></p>
		</div>	<!-- input button submits notification -->

	    </form>

	</div>

    </div>
    <!-- Help Interface -->
    <div id="popup-box2" class="popup-position">

	<div id="popup-wrapper">
	    <form action="help.php" method="post">	<!-- sends notification to waitstaff -->
		<div id="popup-container">
			<h3>HELP!</h3>
			<p>The Wait staff has been notified! they will be with you shortly, Thank you!</p>
			<p><input name="help-submit" type="submit" value="Close"  onclick="toggle_visibility('popup-box2');" text-align="right"></a></p>
		</div>	<!-- input button submits notification -->
	    </form>
	</div>

    </div>  <!-- Close Outer -->

  </div>  <!-- Close Interface -->

</html>
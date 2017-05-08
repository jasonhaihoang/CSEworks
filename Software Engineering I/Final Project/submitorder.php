
<!DOCTYPE html>

<html>

<head>

    <title></title>

    <link type="text/css" rel="stylesheet" 
href="styles/submitorder.css"/>

</head>

<body>

<img src="images/BG - Faded.png" />

<div id="ribbon"></div>

<div id="interface">




<?php
		//create connection to the SQL database using these login details
		session_start();
		require_once('mysql_connection.php');
		
		// if has paid bill, redirect to back home
		if($result = $conn->query("SELECT * FROM Coustomers WHERE id=". $_SESSION["userid"]))
		{
			while($row = $result->fetch_assoc())
			{
				if($row["billPaid"] == 1 || $row["canOrder"] == 0)
				{
 					echo "<script>window.location = 'http://evan.cadudi.com/place_order.php'</script>";
				}
			}
		}
?>
<script>
	window.alert("Once you have submited you will not be able to change your order.");
</script>


    <div class="logout">	<!-- Back Button -->
        <button onclick="location.href='review_order.php'">Back</button>

    </div>

        <div class ="submit">
            <button onclick="location.href='beginCheckout.php'"> Submit Order </button>
        </div>

    <div id="order-box" style="position:absolute; overflow:auto;">

<?php
	    session_start();
	    
	    require_once('mysql_connection.php');	//connect to database
	    $content = "";
	    $totalSum = 0;
	    //Collect all data from database about the customer's order being submitted and display them on the screen
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
								//Calculate the subtotal
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
		    //calcualte the tax and gratuity and totals for the order
		    $tax = round($totalSum * 0.08, 2);
		    $tip = round($totalSum*.17,2);
		    $subTotal = $totalSum;
		    $totalSum = round($totalSum + $tax + $tip, 2);
		    //display info to screen
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
								//displays the prices for each item
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
		    //display data to the screen
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
            echo $content;	//display
            mysqli_close($conn);
	?>
	
    </div>

</div>

<!-- To choose takeout order-->
	<div class ="takeout">
            <button onclick="location.href='beginCheckout2.php'"> Submit order for takeout </button>
        </div>


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
	
	<div id="popup-box1" class="popup-position">

	<div id="popup-wrapper">

	    <form action="refill.php" method="post">

		<div id="popup-container">
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
		</div>

	    </form>

	</div>

    </div>

    <div id="popup-box2" class="popup-position">

	<div id="popup-wrapper">
	    <form action="help.php" method="post">
		<div id="popup-container">
			<h3>HELP!</h3>
			<p>The Wait staff has been notified! they will be with you shortly, Thank you!</p>
			<p><input name="help-submit" type="submit" value="Close"  onclick="toggle_visibility('popup-box2');" text-align="right"></a></p>
		</div>
	    </form>
	</div>

    </div>

  </div>

</html>

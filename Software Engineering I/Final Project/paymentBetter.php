<!-- FROM HERE -->
<!DOCTYPE html>
<html>
<head>

	<title></title>

	<link type="text/css" rel="stylesheet" href="/styles/paymentBetter.css"/>
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

<?php
		//create connection to the SQL database using these login details
		session_start();
		require_once('mysql_connection.php');
		
		// if user hasn't submittend order yet, redirect to back home
		if($result = $conn->query("SELECT * FROM Coustomers WHERE id=". $_SESSION["userid"]))
		{
			while($row = $result->fetch_assoc())
			{
				if($row["canOrder"] == 1)
				{
 					echo "<script>window.location = 'http://evan.cadudi.com/place_order.php'</script>";
				}
			}
		}
?>

		<div class="regular_payment_top">
			<h1>Select Payment</h1>
			<button onclick="location.href='card1.html'">Credit Card</button>
			<button onclick="location.href='cash.html'">Cash</button>
		</div>
		<div class="regular_payment_bottom">
			<button onclick="location.href='newsplit_check.php'" >Split Check</button>
		</div>	

		<div class="special_payment">	


		<?php

			//create connection to the SQL database using these login details
			session_start();
			require_once('mysql_connection.php');
			
			//get data using session
			$userid = $_SESSION["userid"];
			$originalCredit = $_SESSION["creditsDollar"];
			
			//using POST, get the coupon code entered through form on the website
			$codeEntered = $_POST["gift_code"];

			//get expiration date to check if the coupon is still valid
			$expdate = "SELECT expDate FROM Coupons WHERE code='$codeEntered'";
			
			//get current date to check if the coupon is still valid
			$date = date(mdY);

			//Coupon's issued date
			$issdate = "SELECT issuedDate FROM Coupons WHERE code='$codeEntered'";
			//gift-code needs to be within 3 months of issue date,
			//and it matches the one issued.

					
			//if connection succeeds, 
			$sql1 = "SELECT * FROM Coupons WHERE code='$codeEntered' AND id=". $userid;
			if($result = $conn->query($sql1))
			{	//check data in the database
				while($row = $result->fetch_assoc())
				{	//if the code in database matches the code entered
					if($row["code"] == $codeEntered)
					{	//and if the database says the code exists but was used before,
						//or expired, show a message
						if ($row["price"] <= 0)
						{
							echo "We are sorry. That coupon code<br>
								has already been used or has expired.<br>";
						}
						//if their coupon is still less than 3 months old, and have not been used before
						else
						{
							echo $date ." Thank you for coming back to us!<br>";
							echo "Your coupon was successfully processed <br> and your meal will be offered with a $10 discount";
							
							$conn->query("UPDATE Coustomers SET creditsDollar = (creditsDollar + 10) WHERE id='$userid';");
							$conn->query("UPDATE Coupons SET price = (price - 10) WHERE code='$codeEntered' AND id=". $userid);
						}
					}
					//Otherwise, coupon does not exist
					else{
						echo "Your code is either expired or does not exist.";
					}
				
				}
			}

			?>



			<form action="paymentBetter.php" method="post">
				Type Gift Code:
				<input type="text" name="gift_code" required>
				<br>
				<button type="submit">Redeem Gift Code</button>
			</form>

		</div>
	</div>
</body>

 <!-- Below is code for the Refill, Help, and Twitter Buttons -->

<?php
session_start();
?>
	<div class="assistance" style="vertical-align: top; position: Relative; left: 130px; top: 450px; margin-right:200px;">
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



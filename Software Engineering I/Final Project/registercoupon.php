<!DOCTYPE html>

<html>

<head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/chancegame.css"/>
    <link type="text/css" rel="stylesheet" href="styles/help_refill_social_media.css"/>
    <script type="text/javascript" src="scripts/place_order.js"></script>

<?php
	session_start();
	require_once('mysql_connection.php');

	// import user's id fromt the php session
	$userid = $_SESSION["userid"];

	// get today's date
	$todaysdate = date(mdY);

	//If the expiration date is the next year (for month)
	$a = date(m);
	$a = $a + 3;

	//If the expiration date is the next year (for year)
	$b = date(Y);
	$b = $b + 1;
	
	// fix expiration date
	if($a == 13) $a = "01";
	elseif($a == 14) $a = "02";
	else $a = "03";
	if($a < 13)
		$dexp = "$a" . date(dY);
	else //If $a is more than 13, the year needs to be +1
		$dexp = "$a" . date(d) . "$b";

	// declare variables
	$codeEntered = array();
	$codeEntered = $_POST["gift_code"];
	$content = "";

	// get all coupons from the database
	$sql1 = "SELECT * FROM Coupons WHERE id='$userid'";
	if ($result1 == $conn->query($sql1)) {

		// get each individual coupon
		$row1 = $result1->fetch_assoc();
		if($row1["price"] == 10)
		{
			// if user already has a coupon, add $10 to it
			$sql="UPDATE Coupons SET price=20 WHERE id='$userid'";
		}
	}
	else {
		// create a new coupon
    		$sql = "INSERT INTO Coupons(id, code, issuedDate, expDate, price) VALUES('$userid','$codeEntered','$todaysdate','$dexp',10)";
		if ($conn->query($sql) === TRUE) {
			//worked
		} else {
   			echo "Error2" . $conn->error;
		}
	}


mysqli_close($conn);

?>

</head>


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

    <h1>Restaraunt Lottery</h1>

    <div id="order-box">
        <h2>Register your coupon </h2>
        <form action="registercoupon.php" method="post">
            Type Coupon Code:
            <input type="text" name="gift_code" required>
            <br>
            <button type="submit">Register Coupon</button>
        </form>

    </div>
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
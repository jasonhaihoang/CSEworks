<!-- FROM HERE -->
<!DOCTYPE html>
<html>
<head>

	<title></title>
//selects style sheet to use
	<link type="text/css" rel="stylesheet" href="styles/paymentBetter.css"/>



</head>

<body>
//background images and format
	<img src="images/BG - Faded.png" />
	<div id="ribbon"></div>
	<div id="interface">
	
	<!-- Global Back Button -->
	<button style="position: absolute;
			width: 30px; height: 20px; font-size: 20px;
			font-weight: 100; padding: 5px 70px 30px 5px;
			margin-top: 5px; margin-left: 800px;"
			onclick="goBack()">Back</button>	
	<script>
//back button js
	function goBack() {
		window.history.back();
	}
	</script>
	<!-- End Global Back Button -->

		<div class="regular_payment">
			<div class="regular_payment_top">
				<h1>Select Payment</h1>
				<button onclick="location.href='http://evan.cadudi.com/card1.html'">Credit Card</button>
				<button onclick="location.href='cash.html'">Cash</button>
			</div>

		</div>

		<div class="special_payment">	

			<?php		
    			session_start();
			$codeEntered = $_POST["gift_code"];
			//gift-code needs to be within 3 months of issue date, 
			//and it matches the one issued.
			if($codeEntered == 4444 /*&& less than 3 months old*/){
				echo "Thank you for coming back to us!";
				echo "Your gift code was successfully processed <br> and your meal will be offered with $10 discount!";
			}
			else{
				echo "Your gift code is either expired or does not exist."; 			
			}
			?>
			//form for text initiates php file
			//redeem gift card field and button
			<form action="afterSplit.php" method="post">
			Type Gift Code:<br>
			<input type="text" name="gift_code" required>
			<br>
			<button type="submit">Redeem Gift Code</button>
			</form>
		

		</div>

		<div class="assistance">
			<button onclick="location.href=''">Refill</button>
			<button onclick="location.href=''">Help</button>
		</div>
 
	</div>
</body>

</html>

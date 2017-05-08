<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/place_order.css"/>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/place_order.js"></script>

  </head>

  <body>

    <img src="images/BG - Faded.png" />

    <div id="ribbon"></div>

    <div id="interface">

	<div class="logout">
		<button onclick="location.href ='login.html'">Logout</button>
			
	</div>
	<?php 
			session_start();
			require_once('mysql_connection.php');
			//$msg = 'Times Ordered:';
			$sql = "SELECT totalOrders FROM Employees LIMIT 1";
			$result = $conn->query($sql);

			if ($result->num_rows > 0) {
				// output data of each row
				while($row = $result->fetch_assoc()) {
					//echo "Total Orders: " . $row["totalOrders"]. "<br>";
					 echo "<div style= 'font-size: 20px; color: white;background-color: #0d3149;width:300px;text-align:center;'>"; 
					echo "We've served " .$row["totalOrders"]. " orders.<br>"; 
					echo "</div>";
				}
			}
 			else {
				echo "0 results";
			}
			
			$conn->close();

	?>

        <h1>Welcome to Our Restaurant</h1>

	<div class="menu">	<!-- Access the menu Button -->

		<button class="menu" onclick="location.href ='menu.php'"> Menu </button>

	</div>

	<div class="bot">	<!-- Review order and payment buttons -->

		<button onclick="location.href ='review_order.php'"> Review Order </button>


		<button onclick="location.href ='paymentBetter.php'"> Pay Now </button>

	</div>

	<p>&nbsp</p>

	<h1>Games</h1>

	<div id="games">	<!-- System's games -->

        	<button onclick="location.href ='kidsgames.html'"> Kids Games </button>

		<button onclick="location.href ='bettergame.html'"> Chance to Win $10 </button>
	
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
	<!-- Refill popup -->
	<div id="popup-box1" class="popup-position">

	<div id="popup-wrapper">

	    <form action="refill.php" method="post">

		<div id="popup-container">	<!-- Only 4 FREE refills -->
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
			</table>	<!-- Submit refill order -->
			<p><input name="drink-submit" type="submit" value="Submit" onclick="toggle_visibility('popup-box1');"></a></p>
		</div>

	    </form>

	</div>

    </div>
    <!-- Help popup -->
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

	    <!-- Facebook QR Code -->
	    <img src="images/facebookQR.png" style="position: absolute; top: 630px; left: 650px;" height="80" width="80" alt="QR code for twitter">

	    <!-- Share on FB -->
	    <a href="http://www.facebook.com/sharer/sharer.php?u=www.facebook.com&t=Come%20join%20us%20at%20Group%20One's%20restaurant!" target="_blank">
	        <img src="images/facebook.png" style="position: absolute; top: 630px; left: 740px;" height="80" width="80" alt="facebook logo">
	    </a>

	    <!-- Twitter QR Code -->
	    <img src="images/QR.jpg" style="position: absolute; top: 630px; left: 850px;" height="80" width="80" alt="QR code for twitter">
	    
	    <!-- Twitter logo -->
	    <a href="http://twitter.com/home?status=Come%20join%20us%20at%20Group%20One's%20restaurant!" target="_blank">
	        <img src="images/twitter.png" style="position: absolute; top: 630px; left: 940px;" height="80" width="80" alt="twitter logo">
	    </a>
  </div>

</html>

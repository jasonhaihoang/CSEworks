<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/manager.css"/>

  </head>

  <body>
	
	<meta http-equiv="refresh" content="30">
	<img src="images/BG - Faded.png" />
	<div id="ribbon"></div>
	<div id="interface">
       <h1 style='display:inline;'>Manager UI</h1><button style='position: fixed; top:10px; right:20px;' onclick="location.href='RESETTABLES.php'" type="button" class="btn">RESET TABLES FOR NEW DAY</button>
	<h3> Top 3 Item Per Category </h3>
	<ul id="menu">

<?php
	session_start();	//start session for manager
	require_once('mysql_connection.php');	// including files to connect to database
	
	//print top three Appetizers
	echo "<table>";
	echo "<tr>";
  	$categories = array("name", "timesOrdered");
	if($result = $conn->query("SELECT * FROM MenuItems WHERE category=0 ORDER BY timesOrdered DESC LIMIT 3")) {
		echo "<div style='background-color: #0d3149;'><h2 style='font-size: 15px; margin-top:-10px;'>Appetizer</h2>";
		while($row5 = $result->fetch_assoc()) {
			echo "<li>".$row5["name"]."</li>";
		}
		echo '</div><br>';
  	}
  	else {
  		echo $conn->error;
  	}
	
	//print top three Entrees
	if($result = $conn->query("SELECT * FROM MenuItems WHERE category=1 ORDER BY timesOrdered DESC LIMIT 3")) {
		echo "<div style='background-color: #0d3149;'><h2 style='font-size: 15px; margin-top:-10px;'>Entree</h2>";
		while($row5 = $result->fetch_assoc()) {
			echo "<li>".$row5["name"]."</li>";
      		}
		echo '</div><br>';
  	}
  	else {
  		echo $conn->error;
  	}
	
	//print top three Desserts
	if($result = $conn->query("SELECT * FROM MenuItems WHERE category=2 ORDER BY timesOrdered DESC LIMIT 3")) {
		echo "<div style='background-color: #0d3149;'><h2 style='font-size: 15px; margin-top:-10px;'>Dessert</h2>";
		while($row5 = $result->fetch_assoc()) {
			echo "<li>".$row5["name"]."</li>";
      		}
		echo '</div><br>';
  	}
  	else {
  		echo $conn->error;
  	}
	
	//print top three Drinks
	if($result = $conn->query("SELECT * FROM MenuItems WHERE category=3 ORDER BY timesOrdered DESC LIMIT 3")) {
		echo "<div style='background-color: #0d3149;'><h2 style='font-size: 15px; margin-top:-10px;'>Drink</h2>";
		while($row5 = $result->fetch_assoc()) {
			echo "<li>".$row5["name"]."</li>";
      		}
		echo '</div><br>';
  	}
  	else {
  		echo $conn->error;
  	}
	
	// close table
	echo "</tr>";
	echo "</table>";
?>

	<!-- Manager's control buttons -->
	<div class="buttons">
	 <button  onclick="location.href='managerCompItem.php'" type="button" class="btn">Adjust Bill</button>
	 <button  onclick="location.href='comp_review.php'" type="button" class="btn">Review Comps</button>
	 <button  onclick="location.href='managerEditMenu.php'" type="button" class="btn">Remove/Add Menu Item</button>
	</div>

	<h3> Daily Revenue: </h3>
	
	<!-- Start last table -->
	<div id="menu1">
	<h2 style='font-size: 15px; margin-top:-5px; margin-bottom:-1px;'>Menu Items Sold</h2>

<?php

    session_start();
    require_once('mysql_connection.php');

	// print menu items sold
	echo "<div class=\"scroll\">";
       $subtotal = 0.00;
	if($result = $conn->query("SELECT * FROM MenuItems")) {
		while($row = $result->fetch_assoc()) {
			
			// get and print menu items sold
                     $comps = $conn->query("SELECT COUNT(menuItemId) AS TimesComped FROM Comps WHERE menuItemId = ".$row["id"]);
                     $count = $comps->fetch_assoc();
			$timesComped = $count["TimesComped"];
			$timesOrdered = $row["timesOrdered"] - $timesComped;
			if($timesOrdered > 0) {
                        	echo $row["name"]." x".$timesOrdered." - $".($timesOrdered * $row["price"])."<br>";
                        	$subtotal = $subtotal + ($timesOrdered * $row["price"]);
                        }
		}
	}
  	else {
  		echo $conn->error;
  	}
	
	// calculate tax and total for the items sold
       $tax = round($subtotal * 0.0825, 2);
	echo "</div><h2 style='font-size: 15px; margin-top:0px; margin-bottom:-1px;'>Subtotal = $".$subtotal."<br>Tax = $".$tax."  <h2></p>
		";
?>

	<!-- Start a new list for the staff gratuity -->
	</div>
	<div id="menu2">
	<h2 style='font-size: 15px; margin-top:-5px; margin-bottom:-19px;width:594px;'>Gratuity Per Staff</h2><br>

<?php
    session_start();
    require_once('mysql_connection.php');

	// print table for staff's tip
	echo "<div class=\"scroll\">";
       $subtotalGratuity = 0.0;
	if($result = $conn->query("SELECT * FROM Waitstaff")) {
		while($row = $result->fetch_assoc()) {

			// raund gratuity and print to screen
			$gratuity = round($row["gratuity"],2);
			echo $row["name"]." - $".round($row["gratuity"],2)."<br>";
                     $subtotalGratuity = $subtotalGratuity + $row["gratuity"];
		}
	}
  	else {
  		echo $conn->error;
  	}
	
	// close table and print gratuity
	echo "</div>
	<h2 style='font-size: 15px; margin-top:0px;width:594px;'>Total Gratuity = $".round($subtotalGratuity,2)." </h2>";
?>

<!-- close list of tables and add a break for total revenue -->
</div><br>

<?php     

    session_start();
    require_once('mysql_connection.php');

	// sum total items sold
	$subtotal = 0.00;
	if($result = $conn->query("SELECT * FROM MenuItems")) {		
		while($row = $result->fetch_assoc()) {
                     $comps = $conn->query("SELECT COUNT(menuItemId) AS TimesComped FROM Comps WHERE menuItemId = ".$row["id"]);
                     $count = $comps->fetch_assoc();
			$timesComped = $count["TimesComped"];
			$timesOrdered = $row["timesOrdered"] - $timesComped;
			
			// if item has been ordered add it to the sum
			if($timesOrdered > 0) {
                      		$subtotal = $subtotal + ($timesOrdered * $row["price"]);
                     }
		}
	}
  	else {
  		echo $conn->error;
  	}

	// calcualte tax and gratuit
	$tax = round($subtotal * 0.0825, 2);
	$subtotalGratuity = 0.0;

	// check for wait staff
	if($result = $conn->query("SELECT * FROM Waitstaff")) {
		
		// loop through wait staff and add tip to total tips
		while($row = $result->fetch_assoc()) {
			$subtotalGratuity = $subtotalGratuity + $row["gratuity"];
		}
	}
  	else {
  		echo $conn->error;
  	}
	
	// calculate total revenue
	$totalRevenue = $subtotal + $tax + $subtotalGratuity; 
	echo "";
	
	// print total revenue
	echo "<h2> Total Revenue: $".$totalRevenue. "</h2>";

?>

</body>      
</html>
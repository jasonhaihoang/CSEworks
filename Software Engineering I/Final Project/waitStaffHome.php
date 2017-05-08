<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/waitStaffHome.css"/>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/place_order.js"></script>

  </head>

  <body>
<meta http-equiv="refresh" content="3">
    <img src="images/BG - Faded.png" />

    <div id="ribbon"></div>

    <div id="interface">
	
	<div class="logout">
		<button onclick="location.href='login.html'">Logout</button>
	</div>
	<?php
		session_start();
		echo "<h1>".$_SESSION["username"]."</h1>";	//Display the wiat staff user's name
	?>
	
	<!-- Row titles -->
	<div class="titles">
		<button style="margin-right: 60px;" disabled>Table</button>
		<button style="width: 400px;" disabled>Table Status</button>
		<button style="width: 300px;" disabled>Order Status</button>
		<p>
	</div>
	<!-- /Row titles -->
	
<?php
    	session_start();
   	require_once('mysql_connection.php');	//connect to database
	
	// check if we need to delete a table.
	if ($_POST["del"] == 'clearOrder')
	{
		echo "<h1>Table ".$_POST["rowid"]."'s Order has been cleared</h1>";
		$conn->query("UPDATE Waitstaff SET gratuity=(gratuity + " . round($_POST["tip"],2) . ") WHERE id=" . $_SESSION["userid"]);
		$conn->query("DELETE FROM YourOrder WHERE id=".($_POST["rowid"]+9));
		$conn->query("UPDATE Orders SET orderStatus='Paid' WHERE id=".$_POST["rowid"]);
		$conn->query("UPDATE Tables SET status='Paid' WHERE id=".$_POST["rowid"]);
	}
	
	// check if we need to set a table as eating.
	if ($_POST["setEating"] == 'READY')
	{
		echo "<h1>Table ".$_POST["rowid"]."'s now eating</h1>";
		$conn->query("UPDATE Tables SET status='Eating' WHERE id=".$_POST["rowid"]);
	}
	
	$content = "";
	$totalSum = 0;
	
	//Collect all data about restaurant tables and their orders from the database and display them onto the wiatstaff's device
        $sql = "SELECT * FROM Tables WHERE waitStaffId=".$_SESSION["userid"];
        if($result = $conn->query($sql))
	{
            	while($row = $result->fetch_assoc())
		{
            	    $content = $content."<div style='display:inline;'><form action='waitStaffHome.php' method='POST'>
		    	<button style='cursor: arrow; width: 130px;' type='submit' name='del' value='clearOrder'>CLEAR ".$row["id"]."</button>
			<input type='hidden' name='rowid' value='".$row["id"]."'>
			
		    	<button style='width: 400px; cursor: arrow;' disabled>".$row["status"]."</button>";


			// print order status
			$sql2 = "SELECT * FROM Orders WHERE id=".$row["orderid"];
			if($result2 = $conn->query($sql2))
			{
				$row2 = $result2->fetch_assoc();
				$content = $content."<button style='width: 298px; cursor: arrow;' name='setEating' value='".$row2["orderStatus"]."'>".$row2["orderStatus"]."</button><p>";
			}

		    	
		$tax = 0;
		$totalSum = 0;
		    $content = $content . "<div id='order_list' style='margin-left:140px;' disabled>
						<div style='position:absolute; top: 0; left: 10; margin-left:10px'>";
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								if($row4["comped"] == 0) {
									$totalSum = $totalSum + $row5["price"];
								}
						   	 	$content = $content.$row5["name"]." - ".$row4["specialRequest"]."<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //Calculate the tax, gratuity, subtotal, and total for each table/order
		    $tax = round($totalSum * 0.08, 2);
		    $tip = round($totalSum*.17,2);
		    $content = $content."<input type='hidden' name='tip' value='".$tip."'>";
		    $subTotal = $totalSum;
		    $totalSum = round($totalSum + $tax + $tip, 2);

		    $content = $content ."
					----------<br>
					SubTotal<br>
					Gratuity<br>
					Tax<br>
					Total<br>
					Cash<br>
					Change<br>
				</div>
				<div style='position:absolute; top:0; right:10px;'>";
		    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
						   	 	if($row4["comped"] == 0) {
									$content = $content . "\$" . $row5["price"] . "<br>";
								}
								else {
									$content = $content . "\$0.00<br>";
								}
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
//Get data from the database about the customer's credits and coupons attached to their account
$sql7 = "SELECT * FROM Coustomers WHERE orderid=".$row["id"];
if($result7 = $conn->query($sql7))
{
	while($row7 = $result7->fetch_assoc())
	{
		$cash = $row7["creditsDollar"];
	}
}

//add data to be printed onto the screen
$_SESSION["tempCustomerID"] = $_POST["customerid"];
		    $content = $content."----------<br>
					\$".$subTotal."<br>
					\$".$tip."<br>
					\$".$tax."<br>
					\$".$totalSum."<br>
					\$".$cash."<br>
					\$". ($cash - $totalSum) ."<br>
				</div>

			</div>
			<p></form>
		    	<div>
			
			<button style='width: 350px; background-color: #23a21d; margin-left: 140px;' onclick='location.href =`comp_item.php`'>
	  			Submit Comp Item Report
			</button>
			
			<form style='display:inline; margin:0px; padding:opx;' action='addCash.php' method='POST'>
	      			<button id='button' style='width: 200px; background-color: #23a21d; ' type='submit'>
	        			Add cash: $
	      			</button>
	      			<input style='width: 60px; margin-left: -85px; margin-top: -5px; margin-right: 10px;' type='text' name='cash' placeholder='xx.xx' required>
				<input type='hidden' name='tableid' value=".$row["id"].">
			</form>
			<form style='display:inline; margin:0px; padding:opx;' action='waitStaffMenu.php' method='POST'>
				<input id='button' style='display:inline; ' name='submit-button' type='submit' value='Add Items to Order'>
				<input type='hidden' name='tableid' value=".$row["id"].">
			</form>
			</div><p>";
		}
	     }
            else {
                echo $conn->error;
            }
            echo $content;	//print data to the screen
            mysqli_close($conn);
	?>

    </div>

  </body>

</html>
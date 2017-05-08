<!DOCTYPE html> 

<html>

    <head>

    	<title>Split Check</title>
	<link type="text/css" rel="stylesheet" href="styles/menu.css"/>
    	<link type="text/css" rel="stylesheet" href="styles/split_check.css"/>
	<link type="text/css" rel="stylesheet" href="styles/help_refill_social_media.css"/>
    	<script type="text/javascript" src="scripts/place_order.js"></script>

    </head>
    
    <body>

        <img src="images/BG - Faded.png"/>

        <div id="ribbon"> </div>    

        <div id="interface">

        	<!-- Global Back Button -->
		<button style="position: absolute;
			width: 30px; height: 20px; font-size: 20px;
			font-weight: 100; padding: 5px 70px 30px 5px;
			margin-top: 5px; margin-left: 800px;"
			onclick="location.href='paymentBetter.php'">Back</button>	
		<!-- End Global Back Button -->
            
            <p>Split Check</p>
              
            <div id="order_list">
	    <h2>Original Order</h2>

	    <?php

	    session_start();		//SESSION Variables
	    require_once('mysql_connection.php');	//connect to database

	    $i = 0;
	    
	    //Collect data from the database about the menu items within the order being paid for
	    //Original Check order items
	    $content = "";
	    $totalSum = 0;
            $sql = "SELECT * FROM Coustomers WHERE id=".$_SESSION["userid"];
            if($result = $conn->query($sql)) {
            	while($row = $result->fetch_assoc()) {
		$tax = 0;
		$totalSum = 0;
		    $content = $content . "<div style=' float:left; width:250px; top: 0; left: 10;'><form action='split.php' method='POST'>";
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row["orderid"])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"]." && split=0")) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//calculate total cost
								$totalSum += $row5["price"];
								$_SESSION["yourOrderId"] = $row2["yourOrderId"];
								//add checkbox input to split the check
						   	 	$content = $content ." <input type='checkbox' name='$i' value='".$row4["menuItemId"]."'>". $row5["name"] . " - " . $row4["specialRequest"] . "<br>";
								$i = $i + 1;	//increment for input tracking
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //calculate tax and totals
		    $tax = round($totalSum * 0.08, 2);
		    $totalSum = round($totalSum + $tax, 2);
		    $content = $content."
					----------<br>
					Tax<br>
					Total<br>
				</div>
				<div style=' float:right; width:50px; margin-top:5px; right:10px;'>";
		    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row["orderid"])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"]." && split=0")) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//display item prices on the screen
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
		    $content = $content."---------<br>\$".$tax."<br>
					\$".$totalSum."</div>";
		    //implement split order button
		    $content = $content."<input style='float:right; margin-top:220px;' name='order-split' type='submit' value='Split'></form>";
		}
	     }
            else {
                echo $conn->error;
            }
	    //display original order content
            echo $content;


	    //Collect data from the database about the menu items within the SPLIT order being paid for
	    //Split Check order items
	    $content1 = "</div><div id='split_list'><h2>Split Order</h2>";
	    $totalSum = 0;
            $sql = "SELECT * FROM Coustomers WHERE id=".$_SESSION["userid"];
            if($result = $conn->query($sql)) {
            	while($row = $result->fetch_assoc()) {
		$tax = 0;
		$totalSum = 0;
		    $content1 = $content1 . "<div style=' float:left; width:250px; top: 0; left: 10;'>";
            	    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row["orderid"])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"]." and split=1")) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//calculate the total cost
								$totalSum += $row5["price"];
						   	 	$content1 = $content1 . $row5["name"] . " - " . $row4["specialRequest"] . "<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //calculate the tax and totals
		    $tax = round($totalSum * 0.08, 2);
		    $totalSum = round($totalSum + $tax, 2);
		    $content1 = $content1."
					----------<br>
					Tax<br>
					Total<br>
				</div>
				<div style=' float:right; width:50px; margin-top:5px; right:10px;'>";
		    if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row["orderid"])) {
			while($row2 = $result2->fetch_assoc()) {
				if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"]." and split=1")) {
					while($row4 = $result4->fetch_assoc()) {
						if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
							while($row5 = $result5->fetch_assoc()) {
								//display the prices for each item
						   	 	$content1 = $content1 . "\$" . $row5["price"] . "<br>";
							}
						}
					}
				}
			}
		    }
            	    else {
                		echo $conn->error;
            	    }
		    //display financial info for the SPLIT check
		    $content1 = $content1."---------<br>\$".$tax."<br>
					\$".$totalSum."</div>";
		}
	     }
            else {
                echo $conn->error;
            }

            echo $content1;	//display SPLIT check
            mysqli_close($conn);//close connection

	    ?>
	    
		
	    </div>

	    <div class="bot">	<!-- Input buttons for paying with cash or credit for either the original order and the split order -->
	
		<button style="float:right; margin-right:20px; margin-top: 20px;" onclick="location.href ='cash.php'"> Pay with Cash </button>		

		<button style="float:right; margin-right:40px; margin-top: 20px;" onclick="location.href='splitcard1.html'"> Pay with Card </button>

	    	<button style="float:left; margin-left:80px; margin-top: 20px;" onclick="location.href ='Osplitcard1.html'"> Pay with Card </button>

		<button style="float:left; margin-left:20px; margin-top: 20px;" onclick="location.href ='cash.php'"> Pay with Cash </button>

	    </div>

        </div>           

<!-- Below is code for the Refill, Help, and Twitter Buttons -->

<?php
session_start();//This php code is utilized to continue the transfer of SESSION variables to the next page.
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
	    <form action="refill.php" method="post">	<!-- sends notification to waitstaff -->
		<div id="popup-container">
			<h3>Please Select the Drink(s) that you want refilled:</h3>
			<table>	<!-- list of FREE refills only -->
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
	</div>

    </div>  <!-- Close Outer -->

  </div>  <!-- Close Interface -->

</html>
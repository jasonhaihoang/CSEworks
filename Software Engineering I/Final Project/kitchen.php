<!DOCTYPE html>

<html>

  <head>

    <title>Kitchen UI</title>

    <link type="text/css" rel="stylesheet" href="styles/kitchen.css"/>
    <link type="text/css" rel="stylesheet" href="styles/waitStaffHome.css"/>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
  </head>
<meta http-equiv="refresh" content="3">
  <body style="background-color:black;">


    <div>
	

<?php 
	session_start();
	echo "<h1>Kitchen</h1>";
?>
	


<?php  		//begin a session
	    session_start(); 
	    require_once('mysql_connection.php'); //get connection 

if ($_POST["CLAIMED"] == 'CLAIMED') //check the input. if it matches, show a message and update the database
{
	echo "<h1>Table ".$_POST["rowid"]."'s Order has been set to CLAIMED.</h1>";
	$conn->query("UPDATE Orders SET orderStatus='CLAIMED' WHERE id=".$_POST["rowid"]);
}

if ($_POST["IN_PROGRESS"] == 'IN_PROGRESS') //check the input. if it matches, show a message and update the database
{
	echo "<h1>Table ".$_POST["rowid"]."'s Order has been set to IN_PROGRESS.</h1>";
	$conn->query("UPDATE Orders SET orderStatus='IN PROGRESS' WHERE id=".$_POST["rowid"]);
}
if ($_POST["READY"] == 'READY')  //check the input. if it matches, show a message and update the database
{
	echo "<h1>Table ".$_POST["rowid"]."'s Order has been set to READY.</h1>";
	$conn->query("UPDATE Orders SET orderStatus='READY' WHERE id=".$_POST["rowid"]);
	$conn->query("UPDATE Tables SET status='Waiting on Food' WHERE id=".$_POST["rowid"]);
}

echo '<div class="titles">';
echo '<button style="width: 300px;" disabled>Order Status</button>';
echo '<p>';
echo '</div>';


	$content = "";
		
	$sql = "SELECT * FROM Coustomers WHERE canOrder=0";
       if($result = $conn->query($sql)) {  //connection succeeded
       	while($row = $result->fetch_assoc())
		{
			//print Row titles and Set Status buttons
            		$content = $content."<div style='display:inline;'><form action='kitchen.php' method='POST'>
				<h1 style='display:inline;'>Table ".$row["tableid"]."<div style='margin-left:450px; display:inline;'>Order Status</div></h1><p>
		    		<button style='cursor: arrow; width: 130px;background-color: red;' type='submit' name='CLAIMED' value='CLAIMED'>CLAIMED</button>
		    		<button style='cursor: arrow; width: 230px;background-color: darkcyan;' type='submit' name='IN_PROGRESS' value='IN_PROGRESS'>IN PROGRESS</button>
		    		<button style='cursor: arrow; width: 130px;background-color: green;' type='submit' name='READY' value='READY'>READY</button>
				<input type='hidden' name='rowid' value='".$row["tableid"]."'>";
			
			// print Order Status
			$sql2 = "SELECT * FROM Orders WHERE id=".$row["orderid"];
			if($result2 = $conn->query($sql2))
			{
				$row2 = $result2->fetch_assoc();
				$content = $content."<button style='width: 298px; cursor: arrow;' disabled>".$row2["orderStatus"]."</button><p>";
			}
		    	
			// Generate each list of items and print them in a list
		    	$content = $content . "<div id='order_list' style='height: 300px; margin-left:20px;margin-bottom:50px;' disabled>
						<div style='position:absolute; top: 0; left: 10; margin-left:10px'>";
            	    	if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$row['orderid'])) {
				while($row2 = $result2->fetch_assoc()) {
					if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
						while($row4 = $result4->fetch_assoc()) {
							if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
								while($row5 = $result5->fetch_assoc()) {
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
		    	$content = $content."----------<br>END OF ORDER<br>
				</div></div><p></form>";
		}
	}
       else {  //if connection failed.
       	echo $conn->error;
       }
       echo $content;
	mysqli_close($conn);
?>




</div>

    <div>
	<!--Button for remove/add menu -->
        <button style="width:400px; height:50px;" onclick="location.href='kitchenEditMenu.php'" type="button" class="red-btn">Remove/Add Menu Items</button>

    </div>
</body>      
</html>



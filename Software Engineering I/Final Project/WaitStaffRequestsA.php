<!DOCTYPE html> 
<html>

    <head>

    	<title>Special Request</title>

    	<link type="text/css" rel="stylesheet" href="styles/special_requests.css"/>

    </head>

    

    <body>

        <img src="images/BG - Faded.png"/>
        <div id="ribbon"></div>    
        <div id="interface">

		<!-- Global Back Button -->
		<button style="position: absolute;
			width: 30px; height: 20px; font-size: 20px;
			font-weight: 100; padding: 5px 70px 30px 5px;
			margin-top: 5px; margin-left: 800px;"
			onclick="location.href='waitStaffMenu.php'">Back</button>	
		<!-- End Global Back Button -->
        	
		<h2> Special Request </h2>

		<?php

    		    session_start();
    		    require_once('mysql_connection.php');

		    // import variables from the php session and declare new ones
		    $userid = $_SESSION["customerid"];
		    $itemList = $_SESSION["itemList"];
		    $itemValue = array();
		    $itemValue = $_POST["specRequest"];
		    $itemid = $_POST["menuid"];
		    $_SESSION["itemid"] = $itemid;
		    $content = "";

		    // loop through all Appetizers menu items and print them to the screen
		    $sql = "SELECT * FROM MenuItems WHERE id=".$itemid;
                    if($result = $conn->query($sql)) {
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Appetizers/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories');\">Calories</button>
				    <div id=\"calories\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>".$row["price"]."</p>
			        </td>
                            </tr></table>";
			}
		    }
                    else {
                        echo $conn->error;
                    }

		      // close the mysql session and print to the screen
                    mysqli_close($conn);
                    echo $content;

		?>
		
		<!-- Ask the user for any special requests, and submit them -->
		<div class="container">
            	<form valign="bottom" action="WaitStaffRequest.php" method="post">
			<br><br>
			<p text-color="white">Any special requests or allergies?</p>
			<input type="text" name="special_request" size="100" value="">
			<br>
			<input id="submit-button" name="submit-button" type="submit" value="Add item to order">
		</form>
               </div>
         </div>
             
    </body>

</html>

<!DOCTYPE html>

<html>

  <head>

    <title></title>
    <link type="text/css" rel="stylesheet" href="styles/menu.css"/>
    <link type="text/css" rel="stylesheet" href="styles/tabs.css"/>
    <link type="text/css" rel="stylesheet" href="styles/help_refill_social_media.css"/>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="scripts/place_order.js"></script>
    <script type="text/javascript" src="scripts/tabs.js"></script> 

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
			onclick="location.href='place_order.php'">Back</button>	
	<!-- End Global Back Button -->
	
	<div class="tabs">	<!-- Sets up the tabs that splits each section of the menu. -->
    	    <ul class="tab-links">
        	<li name="#tab1">Appetizers</li>
        	<li name="#tab2">Entrees</li>
        	<li name="#tab3">Desserts</li>
        	<li name="#tab4">Drinks</li>
		<li name="#tab5">Kids Entrees</li>
    	    </ul>
 
    	    <div class="tab-content">	<!-- The container for each section of the menu. -->

                <?php
		    session_start();	//SESSION variables
                    //create connection
                    $servername = "127.0.0.1";
                    $username = "cadudi_project";
                    $password = "password123";
                    $db = "cadudi_resProject";
		    $userid = $_SESSION["userid"];	//get the user id

		    // back to home page if already ordered
		    if ($_SESSION["canOrder"] == 0)
		    {
		    	header('Location: http://evan.cadudi.com/place_order.php');
		    	exit();
		    }

                    $conn = new mysqli($servername, $username, $password, $db);	//connect to database
                    $content = "";	//content variable holds the content for the page
                    $i = 0;		//counter

		    //The following operations/code will collect all of the data for each available menu item and display them to the screen under their respective categories
                    //Appetizers
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 0";	//only select the items that are in stock for Appetizers
                    if($result = $conn->query($sql)) {					//locate within the database
                        $content = "<div id=\"tab1\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";	//set up the visuals
                        while($row = $result->fetch_assoc()) {	//while there are appetizers available
			    //pull all of the information for each item off the database and into $content to be printed on the screen
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Appetizers/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requestsA.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requestsA.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
				    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"add.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"add-button\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"add\" value=\"".$row["id"]."\">
				    </form>
			        </td>
                            </tr></table>";
                            $i = $i + 1;	//increment for next appetizer calories info
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
                    echo $content;	//print the content into the appetizer tab


                    //Entrees - Same process as above, but for Entrees tab
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 1";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab2\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Entrees/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requestsE.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\">
				    <input type=\"hidden\" name=\"menuid\" value='".$row["id"]."'>
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"add.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"add-button\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"add\" value=\"".$row["id"]."\">
				    </form>
			        </td>
                            </tr></table>";
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
                    echo $content;


                    //Desserts - Same process as above, but for Desserts tab
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 2";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab3\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Desserts/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requestsDes.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requestsDes.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"add.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"add-button\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"add\" value=\"".$row["id"]."\">
				    </form>
			        </td>
                            </tr></table>";
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
                    echo $content;


                    //Drinks - Same process as above, but for Drinks tab
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 3";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab4\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Drinks/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requestsDrk.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requestsDrk.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"add.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"add-button\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"add\" value=\"".$row["id"]."\">
				    </form>
			        </td>
                            </tr></table>";
                            $i = $i + 1;	//increment for calories variable tracking
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }

                    //mysqli_close($conn);	//close connection
                    echo $content;

		
			//Kids Entrees - Same process as above, but for kids menu tab
			$sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 4";
			if($result = $conn->query($sql)){
				$content = "<div id=\"tab5\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
				while($row = $result->fetch_assoc()){
					$content = $content."
					<table><tr>
						<td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/kidsmenu/".$row["photo"]."\"/></td>
						<td align=\"left\" valign=\"top\">
							<h3>".$row["name"]."</h3>
							<div id=\"description-area\"><p>".$row["description"]."</p></div>
							<form action=\"special_requestsK.php\" method=\"POST\">
							<input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requestsK.php'\">
				    			<input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				  			</form>
							<button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                   			<div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
						</td>
						<td align=\"center\" valign=\"top\" width=\"50px\">
							<p>$".$row["price"]."</p>
							<p style=\"margin-top:20px;\">&nbsp</p>
							<form action=\"add.php\" method=\"POST\">
						        <input id=\"add-button\" name=\"add-button\" type=\"submit\" value=\"Add\">
						        <input type=\"hidden\" name=\"add\" value=\"".$row["id"]."\">
						        </form>
						</td>
					</tr></table>";
					$i = $i + 1;	//increment for calories variable tracking
				}
				$content = $content."</div>";	
			}
			else{
				echo $conn->error;
			}
			echo $content; 
			mysqli_close($conn);	//close connection
				
                ?>

    	    </div>
	</div>

    </div>

  </body>

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
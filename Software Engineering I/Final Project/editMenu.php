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
	
	
	<div class="tabs">
    	    <ul class="tab-links">
        	<li name="#tab1">Appetizers</li>
        	<li name="#tab2">Entrees</li>
        	<li name="#tab3">Desserts</li>
        	<li name="#tab4">Drinks</li>
                <li name="#tab5">Kids Entrees</li>
    	    </ul>
 
    	    <div class="tab-content">


			

                <?php
		    session_start();
                    //create connection
                    $servername = "127.0.0.1";
                    $username = "cadudi_project";
                    $password = "password123";
                    $db = "cadudi_resProject";
                    
                    $conn = new mysqli($servername, $username, $password, $db);
                    $content = "";
                    $i = 0;

                    //appetizers
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 0";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab1\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
							$id = $row["id"];
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Appetizers/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requests.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requests.php'\">
				    <input type=\"hidden\" name=\"specRequest\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
				    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
					
					<form action=\"addtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form> 
					  
					<form action=\"addtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Remove\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form> 			        </td>
                            </tr></table>";

				// incriment i
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }

		      // print content
                    echo $content;


                    //Entrees
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
                                    <form action=\"special_requests.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requests.php'\">
				    <input type=\"hidden\" name=\"specRequest\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <input id=\"add-button\" name=\"".$row["name"]."\" type=\"submit\" value=\"Add\">
			        </td>
                            </tr></table>";

				// incriment i
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }

		      // print content
                    echo $content;


                    //Desserts
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
                                    <form action=\"special_requests.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requests.php'\">
				    <input type=\"hidden\" name=\"specRequest\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <input id=\"add-button\" name=\"".$row["name"]."\" type=\"submit\" value=\"Add\">
			        </td>
                            </tr></table>";

				// incriment i
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }

		      // print content
                    echo $content;


                    //Drinks
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
                                    <form action=\"special_requests.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requests.php'\">
				    <input type=\"hidden\" name=\"specRequest\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <input id=\"add-button\" name=\"".$row["name"]."\" type=\"submit\" value=\"Add\">
			        </td>
                            </tr></table>";
							
				// incriment i
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }

			// close mysql connection	
                  //  mysqli_close($conn);

                    echo $content;

                //Kids Entrees
                $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 4";
                if($result = $conn->query($sql)) {
                    $content = "<div id=\"tab5\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                    while($row = $result->fetch_assoc()) {
                        $id = $row["id"];
                        $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/kidsmenu/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"special_requests.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Make a Special Request\" onclick=\"location.href='special_requests.php'\">
				    <input type=\"hidden\" name=\"specRequest\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
				    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>

					<form action=\"addtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>

					<form action=\"addtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Remove\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form> 			        </td>
                            </tr></table>";

                        // incriment i
                        $i = $i + 1;
                    }
                    $content = $content."</div>";
                }
                else {
                    echo $conn->error;
                }

                // print content
                echo $content;
		mysqli_close($conn);	//clock connection

                ?>
				


				

    	    </div>
	</div>

    </div>

  </body>

<!-- Below is code for the Refill, Help Buttons -->

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
		<div id="popup-container">
			<h3>HELP!</h3>
			<p>The Wait staff has been notified! they will be with you shortly, Thank you!</p>
			<p><a href="javascript:void(0)" onclick="toggle_visibility('popup-box2');" text-align="right">Close</a></p>
		</div>
	</div>

    </div>

  </div>

</html>

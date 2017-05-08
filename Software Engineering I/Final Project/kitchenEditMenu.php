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
			onclick="location.href='kitchen.php'">Back</button>	
	<!-- End Global Back Button -->

<!--creates tabs for item categories -->
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
                    
			// declare vars
                    $conn = new mysqli($servername, $username, $password, $db);
                    $content = "";
                    $i = 0;

                    //appetizers

                    $sql = "SELECT * FROM MenuItems WHERE category = 0";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab1\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
				//checks to see if it exists
                        while($row = $result->fetch_assoc()) {
							$id = $row["id"];
                            $content = $content."
				
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Appetizers/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
				    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>";
			//if it is not avaiable button is "add"
			  if($row["availability"] == 0) {		
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
			  }
			//if it is available the button toggles to remove
                          else {
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Delete\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                          }

                          $content = $content."</td></tr></table>";
				//$product_list = <a href='editMenu.php?deleteid=$id'>delete</a><br/>
			    //$itemList[$j] = $row["name"];
                            $i = $i + 1;
                            //$j = $j + 1;
			    //function add(){
				//INSERT INTO Orders(OrderedItems) VALUES ($row["name"]);
			    //}

                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
		    //$_SESSION['itemList'] = $itemList;
                    echo $content;


                    //Entrees
                    $sql = "SELECT * FROM MenuItems WHERE category = 1";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab2\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
		
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Entrees/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>";
			//if the item is not available the item can only be added the add button is shown
			  if($row["availability"] == 0) {		
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
			  }
			//if the item is available the remove item button is displayed
                          else {		  
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Delete\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                          }

                          $content = $content."</td></tr></table>";
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
                    echo $content;


                    //Desserts
                    $sql = "SELECT * FROM MenuItems WHERE category = 2";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab3\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Desserts/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>";
			  if($row["availability"] == 0) {		
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
			  }
                          else {		  
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Delete\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                          }

                          $content = $content."</td></tr></table>";
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }
                    echo $content;


                    //Drinks
                    $sql = "SELECT * FROM MenuItems WHERE category = 3";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab4\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Drinks/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>";
			  if($row["availability"] == 0) {		
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
			  }
                          else {		  
				$content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Delete\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                          }

                          $content = $content."</td></tr></table>";
							
							
                            $i = $i + 1;
                        }
                        $content = $content."</div>";
                    }
                    else {
                        echo $conn->error;
                    }


                    echo $content;

                //Kids Entrees
                $sql = "SELECT * FROM MenuItems WHERE category = 4";
                if($result = $conn->query($sql)) {
                    $content = "<div id=\"tab5\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                    while($row = $result->fetch_assoc()) {
                        $content = $content."

                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/kidsmenu/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>";
                        //if the item is not available the item can only be added the add button is shown
                        if($row["availability"] == 0) {
                            $content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"add-button\" name=\"additem\" type=\"submit\" value=\"Add\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                        }
                        //if the item is available the remove item button is displayed
                        else {
                            $content = $content."<form action=\"kitchenAddtomenu.php\" method=\"POST\">
				    <input id=\"remove-button\" name=\"removeitem\" type=\"submit\" value=\"Delete\">
				    <input type=\"hidden\" name=\"id\" value=\"".$row["id"]."\">
					 </form>";
                        }

                        $content = $content."</td></tr></table>";
                        $i = $i + 1;
                    }
                    $content = $content."</div>";
                }
                else {
                    echo $conn->error;
                }
                echo $content;


                mysqli_close($conn);
                ?>
				


				

    	    </div>
	</div>

    </div>

  </body>

</html>

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
			onclick="location.href='waitStaffHome.php'">Back</button>	
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
		    session_start();	//initialize SESSION variables
                    //create connection
                    $servername = "127.0.0.1";
                    $username = "cadudi_project";
                    $password = "password123";
                    $db = "cadudi_resProject";

//do not delete this line!
$_SESSION["tableid"] = $_POST["tableid"];

                    $conn = new mysqli($servername, $username, $password, $db);	//connect to database
                    $content = "";
                    $i = 0;	//counter
		    
		    //Access all menu items in the database and display them onto the screen under their respective tabs
                    //Appetizers
                    $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 0";
                    if($result = $conn->query($sql)) {
                        $content = "<div id=\"tab1\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                        while($row = $result->fetch_assoc()) {
                            $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/Appetizers/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">    
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"WaitStaffRequestsA.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Add Item\" onclick=\"location.href='WaitStaffRequestsA.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
				    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"WaitStaffadd.php\" method=\"POST\">

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
                    echo $content;	//displays content to screen


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
                                    <form action=\"WaitStaffRequestsE.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Add Item\">
				    <input type=\"hidden\" name=\"menuid\" value='".$row["id"]."'>
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"WaitStaffadd.php\" method=\"POST\">

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
                                    <form action=\"WaitStaffRequestsDes.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Add Item\" onclick=\"location.href='WaitStaffRequestsDes.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"WaitStaffadd.php\" method=\"POST\">

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
                                    <form action=\"WaitStaffRequestsDrk.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Add Item\" onclick=\"location.href='WaitStaffRequestsDrk.php'\">
				    <input type=\"hidden\" name=\"menuid\" value=\"".$row["id"]."\">
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"WaitStaffadd.php\" method=\"POST\">

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

            //kids entrees
            $sql = "SELECT * FROM MenuItems WHERE availability = 1 AND category = 4";
            if($result = $conn->query($sql)) {
                $content = "<div id=\"tab5\" class=\"tab\" style=\"width:830px;height:520px;overflow:auto;\">";
                while($row = $result->fetch_assoc()) {
                    $content = $content."
                            <table><tr>
                                <td align=\"left\" width=\"250px\"><img id=\"img-resize\" src=\"images/menu_images/kidsmenu/".$row["photo"]."\"/></td>
                                <td align=\"left\" valign=\"top\">
                                    <h3>".$row["name"]."</h3>
                                    <div id=\"description-area\"><p>".$row["description"]."</p></div>
                                    <form action=\"WaitStaffRequestsE.php\" method=\"POST\">
				    <input id=\"submit-button\" name=\"specRequest\" type=\"submit\" value=\"Add Item\">
				    <input type=\"hidden\" name=\"menuid\" value='".$row["id"]."'>
				    </form>
				    <button class=\"calories-button\" type=\"button\" onclick=\"toggle_visibility('calories".$i."');\">Calories</button>
                                    <div id=\"calories".$i."\" style=\"display:none;text-indent:1em;\">".$row["calories"]." calories</div>
                                </td>
                                <td align=\"center\" valign=\"top\" width=\"50px\">
                                    <p>$".$row["price"]."</p>
				    <p style=\"margin-top:20px;\">&nbsp</p>
				    <form action=\"WaitStaffadd.php\" method=\"POST\">

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
            mysqli_close($conn);
                ?>

    	    </div>
	</div>

    </div>

  </body>

</html>

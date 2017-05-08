<?php
session_unset();
session_start();

$servername = "127.0.0.1";
$db_username = "cadudi_project";
$db_password = "password123";
$db_name = "cadudi_resProject";

// Create connection
$conn = new mysqli($servername, $db_username, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

//get variables
$username = $_POST["username"];
$password = $_POST["password"];
$button_value = $_POST["submit-button"];
//$_SESSION["name"] = $username;

if($button_value == "Login")
{
    if ($_SESSION["loginAs"] == "Customer") {  //if logged in as a customer
        $sql = "SELECT * FROM Coustomers WHERE name = '" . $username . "';";

	//updating database for newly registered customers
        if ($result = $conn->query($sql)) {
            $row = $result->fetch_assoc();
		//information
            if ($row["pass"] == $password) {
                $_SESSION["userid"] = $row["id"];
                $_SESSION["menuid"] = $row["manuid"];
                $_SESSION["tableid"] = $row["tableid"];
                $_SESSION["orderid"] = $row["orderid"];
                $_SESSION["email"] = $row["email"];
		  $_SESSION["canOrder"] = 1;
		  
		  // update database so user can order after logging in 
		  $date = date(md);
		  if($setCanOrder = $conn->query("UPDATE Coustomers SET billPaid=0, gameCounter=0, canOrder=1, creditsDollar = IF( birthday = ".$date." AND loggedInToday = 0, creditsDollar+10, creditsDollar), loggedInToday = 1 WHERE id=".$row["id"]))
		  {

			// set their table's status as reading menu
			$conn->query("UPDATE Orders SET orderStatus='N/A' WHERE id=".$row["orderid"]);
			$conn->query("UPDATE Tables SET status='Reading Menu' WHERE id=".$row["tableid"]);
			
			// delete all invalid coupons
			$conn->query("DELETE FROM Coupons WHERE id = 0 OR code = 0 OR price <= 0");
			
			//$conn->query("UPDATE Coustomers SET loggedInToday = 1 WHERE id =".$row["id"]);
		  }
		  else {
  			echo $conn->error;
  		  }

                header("Location: http://evan.cadudi.com/place_order.php?game=0", true);
                //echo "<div style='color:white;' >Your ID =<br>" . $_SESSION["userid"] . "</div>";
            } else {
                echo file_get_contents("login.html", true);
                echo "<div id='interface' style='margin-left:130px; margin-top:120px; color:white;'>
				Error: Bad username or password.".$_SESSION["loginAs"]."</div>";
            }
        }
    }
	//if logged in as a wait staff, basically do the same stuff as customer login
    else if ($_SESSION["loginAs"] == "WaitStaff")// login as Wait Staff
    {
        $sql = "SELECT * FROM Waitstaff WHERE name = '".$username."';";

        if($result = $conn->query($sql)) {
            $row = $result->fetch_assoc();
            if($row["pass"] == $password) {
                $_SESSION["userid"] = $row["id"];
		  $_SESSION["username"] = $row["name"];
                $_SESSION["orderid"] = $row["orderid"];
                header('Location: http://evan.cadudi.com/waitStaffHome.php');
            }
            else {
                echo file_get_contents("login.html", true);
                echo "<div id='interface' style='margin-left:130px; margin-top:120px; color:white;'>
		        Error: Bad username or password.</div>";
            }
        }
    }
}
mysqli_close($conn);
?>
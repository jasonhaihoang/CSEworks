<?php
	//makes adjustments in database for comped items (waitStaff)
	error_reporting(E_ALL);
	ini_set('display_errors','1');

	session_start();
	require_once('mysql_connection.php');
	$button_value = $_POST["compItem"];
        $orderId = $_POST["orderId"];
	$menuId = $_POST["menuID"];
	$reason = $_POST["reason"];

	if ($button_value == "Submit Comp Item") {
		$sql = "SELECT * FROM Orders WHERE id = ".$orderId;
		if($result = $conn->query($sql)) {
			$row = $result->fetch_assoc();
			$sql2 = "SELECT * FROM YourOrder WHERE comped=0 AND menuItemId=".$menuId." AND id=".$row["yourOrderId"];
			$result = $conn->query($sql2);
			//true if the menuID and orderID match an item to be comped
			if($result->fetch_assoc()) {
				$sql3 = "UPDATE YourOrder SET comped=1 WHERE comped=0 AND menuItemId=".$menuId." AND id=".$row["yourOrderId"]." LIMIT 1";
        			$sql4 = "INSERT INTO Comps (waitStaffName, menuItemId, compReason) VALUES ('".$_SESSION["username"]."', " . $menuId . ", '" .$reason. "')";
				if($conn->query($sql3)) {
					if($conn->query($sql4)) {
						header('Location: http://evan.cadudi.com/waitStaffHome.php');
               	        		}
				}
			}
			else {
				//say that the item was not ordered or was already comped
				header('Location: http://evan.cadudi.com/comp_item.php');
			}
		}
	}
	mysqli_close($conn);
?>

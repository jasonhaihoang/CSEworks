<?php     
	//start session
	session_start();
	// import $conn connection
	require_once('mysql_connection.php');
	
	$refilCoke = $_POST["drink"];
	//$requestList = "";
	header("Location: /place_order.php");
	$content = "Refill-";	

	//Show messages after they asked for refill. XXXXXX on the way!
	echo "<h2 style='position: absolute; left: 230px; top: 580px;'>";
	if(isset($_POST['drink1']) && $_POST['drink1'] == "Coke"){
		$content = $content."Coke-";
		//echo "Coke's on the way! ";
	}
	if(isset($_POST['drink2']) && $_POST['drink2'] == "Sprite"){
		$content = $content."Sprite-";
		//echo "Sprite's on the way! ";
	}
	if(isset($_POST['drink3']) && $_POST['drink3'] == "Fanta"){
		$content = $content."Fanta-";
		//echo "Fanta's on the way! ";
	}
	if(isset($_POST['drink4']) && $_POST['drink4'] == "Water"){
		$content = $content."Water";
		//echo "Water's on the way! ";
	}
	echo "</h2>";
	
	
	// UPDATE Status to Refil with a list of refils sent to wait staff
	
	$sql = "UPDATE Tables SET status='".$content."' WHERE id='".$_SESSION["tableid"]."'";
	if ($conn->query($sql) == TRUE) {
        	//echo "MenuItem added successfully";
    	} else {
        	//echo "Error adding item: " . $conn->error;
    	}

?>
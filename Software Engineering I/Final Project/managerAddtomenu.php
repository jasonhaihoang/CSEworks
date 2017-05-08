<?php

	// force error reporting 
	error_reporting(E_ALL);
	ini_set('display_errors','1');

	// input sql 
    	require_once('mysql_connection.php');

	// see if item is to be removed
	if(isset($_POST['removeitem'])){

		// set new vars and update menu item
		$notAvailable = 0;
		$displayedMenuID = $_POST['id'];
		$sql4 = "UPDATE MenuItems SET availability='$notAvailable' WHERE id='$displayedMenuID'";
              $conn->query($sql4);
	}
	//see if item to to be added
        else if(isset($_POST['additem'])){

		// set new vars and update menu item
		$available = 1;
		$displayedMenuID = $_POST['id'];
		$sql4 = "UPDATE MenuItems SET availability='$available' WHERE id='$displayedMenuID'";
		$conn->query($sql4);
	}

	// go back to manager edit menu screen
	header("location:managerEditMenu.php");

?>






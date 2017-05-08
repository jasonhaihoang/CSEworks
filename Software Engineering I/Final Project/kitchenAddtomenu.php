<?php

	// force error reporting
	error_reporting(E_ALL);
	ini_set('display_errors','1');

	// inport mysql connection
    	require_once('mysql_connection.php');	

	// if need to remove item, remove it
	if(isset($_POST['removeitem'])){
		$notAvailable = 0;
		$displayedMenuID = $_POST['id'];
		$sql4 = "UPDATE MenuItems SET availability='$notAvailable' WHERE id='$displayedMenuID'";
              $conn->query($sql4);
	} // else if need to add item add it
        else if(isset($_POST['additem'])){
	
		$available = 1;
		$displayedMenuID = $_POST['id'];
		
		$sql4 = "UPDATE MenuItems SET availability='$available' WHERE id='$displayedMenuID'";
                $conn->query($sql4);
	}

	// go back to kitchen page
	header("location:kitchenEditMenu.php");

?>






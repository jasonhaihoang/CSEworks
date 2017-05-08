<?php
	session_start();	//SESSION variables
	$_SESSION["loginAs"] = "Customer";	//Set login status to Waitstaff, so the system draws the login info from the waitstaff database
?>
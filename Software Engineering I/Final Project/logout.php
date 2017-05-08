<?php
	session_start();	//Start session
	session_unset();	//Clears all session variables

	// catch dumped items
	ob_start();

	// set url to go to
	$url = 'login.html';

	// clear the output buffer
	while (ob_get_status()) {
    		ob_end_clean();
	}

	// go back to login
	header( "Location: $url" );
?>
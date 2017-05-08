<?php
	require "conn.php";
	
	$sql2 = "SELECT * FROM Student WHERE Loggedin=1";
	$result = mysqli_query($conn,$sql2);
	$response = array();
		
	while($row = mysqli_fetch_array($result))
	{
		array_push($response, array('name'=>$row[1],'instrument'=>$row[4],'FieldNum'=>$row[6]));		
	}
		
	echo json_encode(array('server_response'=>$response));
	mysqli_close($conn);
?>
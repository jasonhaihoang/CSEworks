<?php
	require "conn.php";
	$username = $_POST["username"];
	$password = $_POST["password"];
	
	$sql2 = "SELECT * FROM Notification";
	$result = mysqli_query($conn,$sql2);
	$response = array();
		
	while($row = mysqli_fetch_array($result))
	{
		array_push($response, array('msg'=>$row[1],'nameTeacher'=>$row[2]));		
	}
		
	mysqli_close($conn);
		
	echo json_encode(array('server_response'=>$response));
?>
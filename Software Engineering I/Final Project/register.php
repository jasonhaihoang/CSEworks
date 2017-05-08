<!DOCTYPE>

<html>

  <head>

    <title>Registration Page</title>

    <link type="text/css" rel="stylesheet" href="styles/register.css"/>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/login.js"></script> 

  </head>

  <body>

    <img src="images/BG - Login.png" />

    <div id="ribbon"></div>

    <div id="interface">

        <h1>Register</h1>
	<div class="register-form">
	<h1></h1>

	<!-- Register form -->
	<form method='post' action='register.php'>	
	
    		<p><label>User Name : </label>
		<input type='text' name='name' /></p>
	
		<p><label>E-Mail&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : </label>
	 	<input type='text' name='email'/></p>

		<p><label>Birthday Month and Day only: </label>
		<input type='text' name='birthday' placeholder="mmdd" /></p>
 
     		<p><label>Password&nbsp;&nbsp; : </label>
	 	<input type ='password' name='pass' /></p>
	
 		<!-- Back button -->
   		<button type="button" onclick="location.href='login.html'">Back</button>
		<!-- submit button -->
    		<input type='submit' name='submit' value='Register' />
    	</form>

	</div>

    </div>

  </body>
</html>
  
<?php
	session_start();		//SESSION variables
	require_once('mysql_connection.php');	//connect to database

	if(isset($_POST['submit']))
	{
		$user_name = $_POST['name'];	//input data
		$user_pass = $_POST['pass'];
		$user_email = $_POST['email'];
		$user_dob = $_POST['birthday'];
		$num = 0;
		//Requires user to input the required data fields to create account
		if($user_name ==''){
			echo "<script> alert ('Please enter your name!')</script>";
			exit();
		
		}
		if($user_pass ==''){
			echo "<script> alert ('Password field is blank!')</script>";
			exit();
		
		}
		if($user_email ==''){
			echo "<script> alert ('Email field is blank!')</script>";
			exit();
		
		}
		if($user_dob ==''){
			echo "<script> alert ('Birthday field is blank!')</script>";
			exit();
		
		}
		//checks for unique email
		$check_user = "select * from Coustomers where email='$user_email'";
			
		$run = mysql_query($check_user);
		if(mysql_num_rows($run)>0){
			echo "<script>alert('Email $user_email already exist in database.')</script>";
			exit();
		}
		else {	
			// get table and order ids from last person
			$sql = "SELECT * FROM Coustomers ORDER BY id DESC LIMIT 1";
			//echo "mysql> " . $sql . "<br>";
			if($result = $conn->query($sql))
			while($row = $result->fetch_assoc())
			{
				$num = $row["tableid"] + 1;
				//get 	tableid from here, add one and update the new user
			}

			// add new user
			$sql = "INSERT INTO Coustomers (name, pass, billPaid, tableid, orderid, email, gameCounter, visitNum, birthday, canOrder, creditsDollar, loggedInToday)
				VALUES ('" . $user_name . "', '" . $user_pass . "', 0, " . $num . ", " . $num . ", '" . $user_email . "', 0, 0, " . $user_dob . ", 1, 0, 0);";
			if ($conn->query($sql))
			{
				//echo "Account created";
			}
			else {
  				echo $conn->error;
  			}

			// add new order
			$sql = "INSERT INTO Orders (id, yourOrderId, orderStatus)
				VALUES (".$num.", ".($num + 9).", 'Not Paid');";
			if ($conn->query($sql))
			{
				//echo "Order created";
			}
			else {
  				echo $conn->error;
  			}

			// add new Table
			if ($num%2 ==0)
				$waitStaffId = 7;
			else
				$waitStaffId = 8;
			$sql = "INSERT INTO Tables (id, waitStaffId, orderid, status) VALUES (".$num.", ".$waitStaffId.", ".$num.", 'Reading Menu')";
			if ($conn->query($sql))
			{
				//echo "Order created";
			}
			else {
  				echo $conn->error;
  			}
			
			//display confirmation result to screen
			//echo get_file_contents("login.php");
               	echo "<div id='interface' style='margin-left:130px; margin-top:110px; color:white;'>
			Account Created.</div>";
		}
	}

?>







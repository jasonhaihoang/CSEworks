<!DOCTYPE html>
<html>
<head>
</head>
<!-- Set Dark red background -->
<body style='background-color: darkred;'>

<!-- Print warning -->
<h1 style='color: white;font-family: Myriad Pro;'>Warning!<br>This will reset ALL Database Tables! All inputted data will be lost!<p>Ensure all Wait Staff have "deleted" their tables.<br>Are you sure you want to do this?</h1>

<!-- Back button with formatting -->
<button style='position: fixed; top:250px; left:0px;
   	font-family: Myriad Pro;
  	color: white;
  	font-size: 40px;
  	background: green;
  	padding: 150px 100px 190px 100px;
  	text-decoration: none;
	display:inline;
  	border: none;' onclick="location.href='manager.php'" type="button" class="btn">Back to Manager Home Page</button>

<!-- Clear all tables with formatting -->
<button style='position: fixed; top:250px; right:0px;
   	font-family: Myriad Pro;
  	color: white;
  	font-size: 15px;
  	background: black;
  	padding: 100px 10px 140px 10px;
  	text-decoration: none;
	display:inline;
  	border: none;' onclick="location.href='CLEARALLTABLES.php'" type="button" class="btn">Clear All tables </button>
</body>
</html>
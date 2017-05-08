<!-- Prints our system's database -->

<!DOCTYPE html>
<html>
<head>
</head>
<body>
<!--<meta http-equiv="refresh" content="5">-->
<?php
	session_start();
  //create connection
  $servername = "127.0.0.1";
  $username = "cadudi_project";
  $password = "password123";
  $db = "cadudi_resProject";
  
  $conn = new mysqli($servername, $username, $password, $db);




$sql = $_POST["command"];
echo "mysql> " . $_POST["command"] . "<br>";
//if($conn->query($sql))
//	echo "Command Successful";
//else {
	echo "Command unsuccessful<br>".$conn->error;
//}




  $allCategories = array(
//  array("MenuItems", "id", "name", "description", "photo", "calories", "price", "category", "timesOrdered", "availability"),  array("Coupons", "id", "expDate", "price"),
  array("Coupons", "id", "code", "issuedDate", "expDate", "price"),
  array("Coustomers", "id", "name", "pass", "billPaid", "tableid", "orderid", "email", "gameCounter", "visitNum", "birthday", "canOrder", "creditsDollar", "loggedInToday"),
  array("Employees", "id", "user", "pass", "totalOrders"),
  array("Orders", "id", "yourOrderId", "orderStatus", "takeout"),
  array("YourOrder", "id", "split", "menuItemId", "specialRequest", "comped", "date"),
  array("Tables", "id", "waitStaffId", "orderid", "status"),
  array("Waitstaff", "id", "name", "pass", "orderid", "gratuity"),
  array("Comps", "id", "waitStaffName", "menuItemId", "compReason")
  );


    // loop through all categories
    foreach($allCategories as $categories)
    {
	echo "<p><b>$categories[0]</b>";
 	if($result = $conn->query("SELECT * FROM $categories[0]")) {
		echo "<table><tr>";
		for($i = 1; $i < count($categories); ++$i)
	      	{
             		echo "<td style='width:100px'><b>" . $categories[$i] . "</b></td>";
             	}
	  	echo "</tr>";
		while($row = $result->fetch_assoc()) {
			echo "<tr>";
			for($i = 1; $i < count($categories); ++$i)
	       	{
				if (strlen($row[$categories[$i]]) > 30)
              			echo "<td style='width:100px'>" . substr($row[$categories[$i]], 0, 30) . "...</td>";
              		else
					echo "<td style='width:100px'>" . $row[$categories[$i]] . "</td>";
              	}
	   		echo "</tr>";
      		}
  	}
  	else {
  		echo $conn->error;
  	}
	echo "</table>";
    }

  mysqli_close($conn);
  echo $content;
?>




<div onclick="document.getElementById('bio_1').style.display = document.getElementById('bio_1').style.display == 'none' ? 'block' : 'none';">
 <b> >>> Click to Reveal MenuItems <<< (then scroll down)</b></div>
 <div id="bio_1" style="display: block;">

<?php
	session_start();
  //create connection
  $servername = "127.0.0.1";
  $username = "cadudi_project";
  $password = "password123";
  $db = "cadudi_resProject";
  
  $conn = new mysqli($servername, $username, $password, $db);

  $allCategories = array(
  array("MenuItems", "id", "name", "description", "photo", "calories", "price", "category", "timesOrdered", "availability")
  );


    foreach($allCategories as $categories)
    {
	echo "<b>".$categories[0]."</b>";
 	if($result = $conn->query("SELECT * FROM $categories[0]")) {
		echo "<table><tr>";
		for($i = 1; $i < count($categories); ++$i)
	      	{
             		echo "<td style='width:100px'><b>" . $categories[$i] . "</b></td>";
             	}
	  	echo "</tr>";
		while($row = $result->fetch_assoc()) {
			echo "<tr>";
			for($i = 1; $i < count($categories); ++$i)
	       	{
				if (strlen($row[$categories[$i]]) > 30)
              			echo "<td style='width:100px'>" . substr($row[$categories[$i]], 0, 30) . "...</td>";
              		else
					echo "<td style='width:100px'>" . $row[$categories[$i]] . "</td>";
              	}
	   		echo "</tr>";
      		}
  	}
  	else {
  		echo $conn->error;
  	}
	echo "</table>";
    }

  mysqli_close($conn);
?>


</div>
</body>
</html>
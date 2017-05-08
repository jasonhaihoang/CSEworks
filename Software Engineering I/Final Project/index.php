<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/login2.css"/>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/login.js"></script> 

  </head>

  <body>

    <img src="images/BG - Login.png" />

    <div id="ribbon"></div>

    <div id="interface">

        <h1>Welcome</h1>

	<h2>Please select a page to continue:</h2>
	<p>

       	<button id="button" type="order-button" onclick='newPopupCustomer()'>Customer Login</button><br>
		<button id="button" type="order-button" onclick='newPopupWaitStaff()' style="background: darkGreen;">Wait Staff Login</button><br>
		<button id="button" type="order-button" onclick='newPopupManager()' style="background: darkred;">Manager</button><br>
		<button id="button" type="order-button" onclick='newPopupKitchen()' style="background: black;">Kitchen</button><br>
	
	<form action="aPRINT.php" method="post">
	
		<div style="font-size:16px; color:white; margin-bottom:0px;">
			Type MYSQL Command below.
		</div>
		<!-- Text box -->
		<input id="password-input" style="height:30px; width:800px;" type="command" name="command" value="" placeholder="ONLY use this to ADD to the database: INSERT INTO tableName (id, user, pass) VALUES (1234, ''user'',''password'')"><br>
		<!-- Send Command Button -->
		<input style="height:30px; width:100px; background: red; border:0px; color: white;" name="submit-button" type="submit" value="Send Command">
		<!-- Print Database Button -->
		<input style="position:absolute; bottom:-40px; left: 0px; height:30px; width:100px; background: darkgreen; border:0px; color: white;"
		name="print" type="submit" value="Print Database">
	
	</form><br>
    </div>
    
    <div style="position:absolute; bottom:20px; left: 130px; font-size:15px; color:white;">*Note this page will not be visible to any users. It is for demonstration purposes only.</div><br>
    
    <script type="text/javascript">
    // Popup window code for Customer
    function newPopupCustomer() {

	$.get("setCustomerLogin.php");

      popupWindow = window.open('login.php','CustomerPopUpWindow',',height=740,width=1050,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
    // Popup window code for Manager
    function newPopupManager() {
<?php
	session_start();
	$_SESSION["userid"] = 777;// manager id
	$_SESSION["username"] = "Manager";
?>
      popupWindow = window.open('manager.php','ManagerPopUpWindow',',height=740,width=1050,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
    // Popup window code for Wait Staff
    function newPopupWaitStaff() {
	$.get("setWaitStaffLogin.php");
      popupWindow = window.open('login.php','WaitStaffPopUpWindow',',height=740,width=1050,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
    // Popup window code for Kitchen
    function newPopupKitchen() {
<?php
	session_start();
	$_SESSION["userid"] = 111;// kitchen id

?>
      popupWindow = window.open('kitchen.php','KitchenPopUpWindow',',height=740,width=1050,left=10,top=10,resizable=no,scrollbars=yes,toolbar=no,menubar=no,location=no,directories=no,status=yes')
    }
  </script>
  
  </body>

</html>
 
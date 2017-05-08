<!DOCTYPE html>

<html>

<head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/chancegame.css"/>

    <script>
	function display(){
		document.getElementById("test").style.display = "block";
	}
//this function creates a 1 in 5 chance that the button will =1
// in the case of a 1 being rolled a random 4 numbers is generated
//and stored in the database as a coupon
        function spin(){
            //var wheel = document.getElementById("wheel");
            var status = document.getElementById("status");
            var d = Math.floor(Math.random() * 5) + 1;
            var coupon = Math.floor((Math.random()*9000) +1000);
            //wheel.innerHTML = d;
            //status.innerHTML = "Your coupon code is  "+ coupon;
            if(d == 1){
                //status.innerHTML = "Your coupon code is  "+ coupon;
               // document.getElementById('result').innerHTML = "You won your coupon is " + coupon;
                window.alert("You Win! Your coupon code is displayed.");
                document.getElementById('result').innerHTML = coupon;
		display();
            }
            else {
                document.getElementById('result').innerHTML = "You lost :(";
                //document.write("Sorry did not win.");
            }

        }
	
    </script>


</head>

//bg image
<img src="images/BG - Faded.png" />

<div id="ribbon"></div>

<div id="interface">
//when the player wins they are redirected to a page to enter in the
//number. I chose to do this to utilize the form action
//the form action sends this code to the database
//the user is then redirected to the home screen
    <div class="logout">
	<!--
     <form action="chancegame.php" method="post">
          <input type="hidden" value=”result” name="coupon_code"  required>
		<br>
		<input type=”submit” >
            <br>
        </form> -->
        <button onclick="location.href='place_order.php'">Back</button>
    </div>

    <h1>Restuarant Lottery</h1>


//general box outline thing text and lottery button
    <div id="order-box">
        <!---<div id="wheel" class="dice">0</div>--->
        <h3>Play this lottery for a chance to win a $10 coupon. Just click the button! </h3>
        <div class="spin">
            <button onclick="spin()">Play the Lottery</button>
            <p id="result"> </p>
            <h2 id="status" style="clear:left;"></h2>
        </div>
	<div class="registerCode" id="registerCodeShow">
		<form action="chancegame.php" method="POST" >
			<input name="coupon-code" type="text" value="" required>
			<input name="submit-button" type="submit" value="Register your Lottery Code!">
		</form>
	</div>

    </div>
</div>


//the code below is for the help and refil buttons
<div class="assistance" style="vertical-align: top; position: Relative; left: 130px; top: 650px">

    <button onclick="toggle_visibility('popup-box1');">Refill</button>


    <button onclick="toggle_visibility('popup-box2');">Help</button>
</div>
<div id="outer">

    <div id="popup-box1" class="popup-position">

        <div id="popup-wrapper">
            <div id="popup-container">
                <h3>Please Select the Drink(s) that you want refilled:</h3>
                <p>Drink 1</p><p>Drink 2</p><p>Drink 3</p><p>Drink 4</p>
                <p><a href="javascript:void(0)" onclick="toggle_visibility('popup-box1');">Submit</a></p>
            </div>
        </div>

    </div>

    <div id="popup-box2" class="popup-position">

        <div id="popup-wrapper">
            <div id="popup-container">
                <h3>HELP!</h3>
                <p>Press the "Submit" button if you need assistance from the wait staff.</p>
                <p><a href="javascript:void(0)" onclick="toggle_visibility('popup-box2');">Submit</a></p>
            </div>
        </div>

    </div>

    <img src="images/QR.jpg" style="position: absolute; top: 630px; left: 850px;" height="80" width="80" alt="QR code for twitter">


    <a href="http://twitter.com/home?status=Come%20join%20us%20at%20Group%20One's%20restaurant!" target="_blank">
        <img src="images/twitter.png" style="position: absolute; top: 630px; left: 940px;" height="80" width="80" alt="twitter logo">
    </a>
</div>

</body>
</html>
//php to send the number entered in the form to the database
//this also creates an issuddate and expiration date variable so the
//customer cannot use the coupon the same day it is aquired
<?php
session_start();
require_once('mysql_connection.php');
$userid = $_SESSION["userid"];

$result = $_POST["coupon_code"];
$todaysdate = date("mdY");
$a = date("m");
$a = $a + 3;

//
//if($a == 13){ 
//      $a = "01";}
//elseif($a == 14){
//      $a = "02";}
//else{ 
//      $a = "03";}

//this loop is to account for the 3 months expiraton dates that 
//exceed 12
if($a == 13) $a = "01";
elseif($a == 14) $a = "02";
else $a = "03";
$dexp = "$a" . date(dY);
////PRINT THIS FOR TEST LATER/////echo $dexp;
//echo $dexp;
//$dexp2 = date("dY");
//echo $dexp2;
//
//$dexp= $a + $dexp2;
//

echo $result;

$sql = "INSERT INTO Coupons (id, code, issuedDate, expDate, price) VALUES ($id, $result, $todaysdate, $dexp, 10);

//$sql = "INSERT INTO Coupons (id, code, issuedDate, expDate, price) 
//VALUES (^ $


if ($conn->query($sql) === TRUE) {
} else {
    echo "Error" . $conn->error;
}

mysqli_close($conn);

?>


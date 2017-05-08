<!DOCTYPE html>

<html>

<head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="chancegame.css"/>

    <script>
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
            }
            else {
                document.getElementById('result').innerHTML = "You lost :(";
                //document.write("Sorry did not win.");
            }

        }
    </script>


</head>


<img src="BG - Faded.png" />

<div id="ribbon"></div>

<div id="interface">

    <div class="logout">
        <button onclick="location.href='login.php'">Logout</button>

    </div>

    <h1>Restaraunt Lottery</h1>

    <?php
    $d = date(mdY);
    echo "$d";
    ?>


    <div id="order-box">
        <!---<div id="wheel" class="dice">0</div>--->
        <h2>Play this lottery for a chance to win a $10 coupon. Just click the button! </h2>
        <div class="spin">
            <button onclick="spin()">Play the Lottery</button>
            <p id="result"> </p>
            <h2 id="status" style="clear:left;"></h2>
        </div>

    </div>
</div>



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
        .
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

    <img src="QR.jpg" style="position: absolute; top: 630px; left: 850px;" height="80" width="80" alt="QR code for twitter">


    <a href="http://twitter.com/home?status=Come%20join%20us%20at%20Group%20One's%20restaurant!" target="_blank">
        <img src="twitter.png" style="position: absolute; top: 630px; left: 940px;" height="80" width="80" alt="twitter logo">
    </a>
</div>

</body>
</html>

<?php
session_start();
require_once('mysql_connection.php');
$userid = $_SESSION["userid"];
$tableid = $_SESSION["tableid"];
$orderid = $_SESSION["orderid"];

$todaysdate = date(mdY);
$a = date(m);
$a = $a + 3;
if($a == 13) $a = "01";
elseif($a == 14) $a = "02";
else $a = "03";
$dexp = "$a" . date(dY);


//if($button_value == "Submit") {		//Add the item to the order
$sql = "INSERT INTO Coupons(id, issuedDate, expDate, price) VALUES($result, $todaysdate,$dexp, 10);

if ($conn->query($sql) === TRUE) {
    //menu item added to order
} else {
    echo "Error" . $conn->error;
}

mysqli_close($conn);

?>
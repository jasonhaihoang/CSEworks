<?php
/**
 * Created by PhpStorm.
 * User: taylor
 * Date: 11/2/15
 * Time: 8:14 PM
 */
<!DOCTYPE html>

<html>

<head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="submitorder.css"/>

</head>

<body>

<img src="BG - Faded.png" />

<div id="ribbon"></div>

<div id="interface">

    <div class="logout">
        <button onclick="location.href='login.php'">Logout</button>

    </div>

        <div class ="submit">
            <button onclick="location.href=''"> Submit Order </button>
        </div>

    <div id="order-box">
        <?php
	    	session_start();
	    	require_once('mysql_connection.php');
	    	$userid = $_SESSION["userid"];
	    	$tableid = $_SESSION["tableid"];
	    	$orderid = $_SESSION["orderid"];
	    	$content = "";

            	    $content = $content."

		    $tax = 0;
		    $totalSum = 0;
		    $content = $content . "<div style='position:absolute; top: 0; left: 10;'>";
        if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$orderid)) {
        while($row2 = $result2->fetch_assoc()) {
        if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
        while($row4 = $result4->fetch_assoc()) {
        if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
        while($row5 = $result5->fetch_assoc()) {
        $totalSum += $row5["price"];
        $content = $content . $row5["name"] . " - " . $row4["specialRequest"] . "<br>";
        }
        }
        }
        }
        }
        }
        else {
        echo $conn->error;
        }
        $tax = round($totalSum * 0.08, 2);
        $totalSum = round($totalSum + $tax, 2);
        $content = $content."</div><div>
----------<br>
    Tax<br>
    Total<br>
</div>
    <div style='position:absolute; top:0; right:10px;'>";
        if($result2 = $conn->query("SELECT * FROM Orders WHERE id=".$orderid)) {
        while($row2 = $result2->fetch_assoc()) {
        if($result4 = $conn->query("SELECT * FROM YourOrder WHERE id=".$row2["yourOrderId"])) {
        while($row4 = $result4->fetch_assoc()) {
        if($result5 = $conn->query("SELECT * FROM MenuItems WHERE id=".$row4["menuItemId"])) {
        while($row5 = $result5->fetch_assoc()) {
        $totalSum += $row5["price"];
        $content = $content . "\$" . $row5["price"] . "<br>";
        }
        }
        }
        }
        }
        }
        else {
        echo $conn->error;
        }
        $content = $content."----------<br>\$".$tax."<br>
        \$".$totalSum."<br>
    </div>";


    mysqli_close($conn);
    echo $content;
    ?>
    </div>

    <div class ="goback">
        <button onclick="location.href='evan.cadudi.com/review_order.php'"> Go Back </button>
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

<script>window.alert("Is your order correct?\nYou will NOT be able to\nchange your order after submitting");</script>

</body>
</html>
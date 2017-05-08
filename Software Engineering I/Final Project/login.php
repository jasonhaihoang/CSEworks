<!DOCTYPE html>

<html>

  <head>

    <title></title>

    <link type="text/css" rel="stylesheet" href="styles/login.css"/>

    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <script type="text/javascript" src="scripts/login.js"></script> 

  </head>

  <body> <!--onLoad="window.location.href = 'login.php'">-->

    <img src="images/BG - Login.png" />
    <div id="ribbon"></div>
    <div id="interface">

        <h1>Login</h1>

	<!-- Prompt for username and password -->
       <form action="attempt-login.php" method="post">

            <h2 id="username">Username</h2>
            <input id="username-input" type="text" name="username" value="" required autofocus>

            <h2 id="password">Password</h2>
            <input id="password-input" type="password" name="password" value="" required>
            <br>

	     <!-- Print login and create new accounts buttons -->
            <input id="login-button" name="submit-button" type="submit" value="Login">
            <br>

        </form>
	<input id="create-account-button" name="submit-button" type="submit" onclick="location.href = 'register.php'" value="Create new account">

    </div>

  </body>
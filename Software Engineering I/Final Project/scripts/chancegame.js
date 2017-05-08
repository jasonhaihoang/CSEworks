/**
 * Created by taylor on 10/29/15.
 */

//function for customers to play lottery
function spin(){
    var wheel = document.getElementById("wheel");
    var status = document.getElementById("status");
	//The customer has a chance to win with 1/5 possibility
	//This function limits the returned value from random() between 1-5
    var w1 = Math.floor(Math.random()*5)+1;
    wheel.innerHTML = w1;
    if(w1==1){ // 1 = win, 2-5 = lose. show a message for winners
        status.innerHTML = "You Won!";
        window.alert("You Won!");
    }
    else{ //Show a message for losers
        status.innerHTML = "You Lost :(";
    }
}
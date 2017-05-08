/**
 * Created by taylor on 10/29/15.
 */

function spin()
{
    var wheel = document.getElementById("wheel");
    var status = document.getElementById("status");
    var w1 = Math.floor(Math.random()*5)+1;
    wheel.innerHTML = w1;
    if(w1==1)
    {
        status.innerHTML = "You Won!";
        window.alert("You Won!");
    }
    else
    {
        status.innerHTML = "You Lost :(";
    }
}
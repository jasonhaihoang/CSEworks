//function to show a message after a certain time
function afterWait(){
	document.getElementById("afterTime").innerHTML =
	"Thank you!" + "<br>" + "Payment Accepted.";
	document.getElementById('payment').style.display = "block";	
}

//After 3 seconds, they will be sent to card2.html
setTimeout(function(){
	//alert('Jump to the survey page.');
	location.href='card2.html';
}, 3000);
		
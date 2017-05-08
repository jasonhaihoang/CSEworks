var username;
//check if the user is manager or customer and depending on the value, 
//jump to different pages
$(document).ready(function(){
    $("#login-button").click(function() {
        username = $("input[name=username]").val();
        if(username == "customer"){
            location.href = "place_order.html";
        }
        else if(username == "manager"){
            location.href = "manager.html";
        }
    });
});
//Function to skip survey
//First, create a variable that keeps track of the number of 
//questions answered by the user, because depending on the value,
//the program will return different results

function skipSurvey(){
	var numQuestionsFilled, numQuestions = 3, i = 0, j = 0;
	//while i is less than 3
	while(i<numQuestions){
		//count the number of questions answered by the user
		numQuestionsFilled = document.getElementsByName('q' + (i+1));
		
		//if the user answers a few questions and tries to skip
		while(j < (numQuestionsFilled.length)){
			if(numQuestionsFilled[j].checked){
				//If this confirmation gets "yes", it jumps to 
				//the home page. If "no", the customer will 
				//go back to the survey
				if(confirm("Your answers will not be saved.")){
					window.alert("Thanks. Have a nice day!");
					location.href = 'markAsBillPaid.php';
				}
				return;
			} 
			j++; // DO NOT FORGET TO 
		}
		i++;		//INCREMENT
	}
	//If the user just clicks skip button without answering a question,
	//simply print a thank you message
	window.alert("Thanks. Have a nice day!");
	location.href = 'markAsBillPaid.php';
	
}

//function for "submit"
//Basically do the same work as "skip"
//The customer cannot "submit" their survey until they fill 
//all questions. If they try to do it, they will get an error message
//and will be taken back to the survey
function submitSurvey(){
	var numQuestionsFilled, numQuestions = 3, i = 0, j = 0, counter = 0;
	while(i<numQuestions){
		//check the number of questions answered
		numQuestionsFilled = document.getElementsByName('q' + (i+1));
		while(j < (numQuestionsFilled.length)){
			//increment the counter if checked
			if(numQuestionsFilled[j].checked){
				counter++;
				break;
			}
			j++;
		}
		i++;
	}
	//if the customer answers 0 or a few questions and clicks "submit"
	if(counter < numQuestions){
		window.alert("You have not completed your survey.");
	}
	//if the customer answers all questions 
	else if(counter == numQuestions){
		window.alert("Thank you for participating in our survey.");
		location.href = 'markAsBillPaid.php';
	}
	//this else should never happen, but in case something happens
	else{
		window.alert("Unexpected error occurred.");
	}
}
		

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// ******************************************************************
//   Here's a "quick and dirty" assignment for you.  Write a program 
//   that will take a command line and "parse" the arguments.  So, 
//   we'll assume that your command line
//   looks something like:
//
//      pgmName  options
//
//   for example,  it might be
//
//   ls -ltga
//   
//   What your program should do is 1) list the pgm name (ls in this 
//   example) and each of the options (l, t, g, a) on separate lines, 
//   and THEN actually run the command.
//
//   We'll assume that each command has one set of options that start 
//   the '-' character and includes each option as a single letter.
//
//   So, we could have sort -n, but not sort --key=1 since that wouldn't 
//   fit our model at this point.
//
// ***********************************************************************


// ****************************************************
// CSCE 3600 - SWEANY
// Minor Assignment #2 - Group 24
// Members that participated: Jason Hoang, Jeff Foster
// ****************************************************

int main(int argc, char** argv)
{
    int i, j;		//counters
    int len;		//string length counter
    char temp1[50];	//temporary string

    printf("\nList of Command Arguments: ");
    printf("%s ", argv[0] + 2);		//print a.out/or other form
    for( i = 1; i < argc; i++ )		
    {
        printf("%s ", argv[i] );	//print command line arguments
    }
    printf("\n");

    for( i = 2; i < argc; i++ )
    {
	len = strlen(argv[i]);		//measure length of options command string
	
	printf("\nList of Options:\n")
	for(j = 1; j < len; j++)	//exclude the '-' dash
	{
        	printf("option %d = %c\n", j, argv[i][j]);	//print the seperate options
	}
    }

    printf("\n")
    strcat(temp1, argv[1]);		//Concatenate the main command arguments together
    strcat(temp1, " ");			//add the space needed within the string
    strcat(temp1, argv[2]);
    
    system(temp1);			//run the command string through the system function
   

    return 0;
}



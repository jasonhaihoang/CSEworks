//******************************************************************************
//
//	CSCE 3600 - Dr. Sweany
//	Minor Program 6 - Sockets
//
//	The purpose of this program was to write a server that gives out 5 digit
//	Ticket ID numbers to 2 clients. The clients can also cancel these tickets.
//	Ticket Numbers are randomly generated and sockets are used to communicate
//	the server and the client. The program daemonizes the server by using
//	a fork function, thus the client-server programs can operate on one 
//	terminal.
//
//	This is the 1st CLIENT file
//
//	This program was written and completed by:
//	Group 24 - Jason Hoang and Austin Harris
//
//******************************************************************************

#include <sys/types.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <stdio.h>
void error(const char *);

int main(int argc, char *argv[])
{
   int sockfd, servlen,n;
   struct sockaddr_un  serv_addr;
   char buffer[82];
   int i, ticketID, value;
   int x = 0, y =0;		//x and y variable to keep track of tickets
   char ticketStr[5];	//temporary ticket ID holder
   int BticketID[7];	//Client can only hold 7 tickets
   //initialize client tickets and set to -1
   for(i=0; i<7; i++)
   {
	BticketID[i] = -1;
   }
   ticketID = 0;	//initialize ticketID
   srand(time(NULL)); 	//seed randomizer with time
   printf("\n------CLIENT #1------\n");
   
   //client socket configuration
   bzero((char *)&serv_addr,sizeof(serv_addr));
   serv_addr.sun_family = AF_UNIX;
   strcpy(serv_addr.sun_path, argv[1]);
   servlen = strlen(serv_addr.sun_path) + sizeof(serv_addr.sun_family);
   //creats client socket
   if ((sockfd = socket(AF_UNIX, SOCK_STREAM,0)) < 0)
       error("Creating socket");
   //connect to server socket
   if (connect(sockfd, (struct sockaddr *) &serv_addr, servlen) < 0)
       error("Connecting");
   
   bzero(buffer,82);			//clear buffer
   n=read(sockfd, buffer, 80);		//read message from server
   //write(1, buffer, n);			//write message from server
   printf("\nConnection made\n");
   //cycle through each of the client's 7 transactions
   for(i=0; i<7; i++)
   {
   	if(rand() % 10 == 0)	//randomize transaction so that 90% = BUY and 10% = CANCEL
   	{
		//cancel
		value = 1;
   	}
   	else
   	{
		//buy
		value = 0;
   	}
   	bzero(buffer,82);
	//conduct transaction
   	switch(value)
   	{
		case 0://BUY
			bzero(buffer,82);
			write(sockfd, "buy", 3);		//send buy signal to server
			n = read(sockfd, buffer, 80);		//read server response
			//buffer[n] = '\0';			//error correct buffer

			if(strcmp(buffer, "out") == 0)		//if server is out of tickets
			{
				printf("\nSorry, all tickets are SOLD OUT\n");
				break;
			}
			else					//server gives client ticket
			{
				ticketID = atoi(buffer);	//convert ticket ID string to integer
				printf("You Bought ticket #%d\n", ticketID);	//confirmation
				BticketID[x] = ticketID;	//store ticketID into client ticket database
				x++;				//increment number of tickets that client has
				bzero(buffer,80);
				break;
			}
		case 1://CANCEL
			ticketID = BticketID[y];		//get ticket ID to be cancelled
			if(ticketID == -1)		//if there are no tickets to be cancelled
			{
				write(sockfd, "none", 4);	
				bzero(buffer, 80);
				break;
			}
			else				//if there is a ticket to be cancelled
			{
				//convert ticketID to string to send to server
				sprintf(ticketStr, "%d", ticketID);
				write(sockfd, ticketStr, strlen(ticketStr));
				n=read(sockfd, buffer, 80);	//get response from server
				write(1, buffer, n);
				y++;			//increment ticket number to access existing tickets
							//within the client database
				bzero(buffer, 80);
				break;
			}
		default:
			error("with transaction");
   	}
   }
   close(sockfd);	//close socket connection
   return 0;
}

//error message function
void error(const char *msg)
{
    perror(msg);
    exit(0);
}

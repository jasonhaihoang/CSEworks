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
//	This is the SERVER file
//
//	This program was written and completed by:
//	Group 24 - Jason Hoang and Austin Harris
//
//******************************************************************************

#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/un.h>
#include <stdio.h>

void error(const char *);
void ticketData(int Tdata[10]);
int checkRepeat(int Tdata[10], int x, int ticketID);

int main(int argc, char *argv[])
{
   int i, j, value, ticketID;
   int x = 0;	//x variable used to keep track of tickets
   int sockfd, newsockfd, servlen, n, numClients, numTransaction;
   socklen_t clilen;
   struct sockaddr_un  cli_addr, serv_addr;
   char buf[80];
   int Tdata[10];
   //initialize Ticket database and set to zero
   for(i=0; i<10; i++)
   {
	Tdata[i] = 0;
   }
   ticketData(Tdata);	//set the ticket Id database
   
   numClients = 2;	//set server to cooperate with only 2 clients
	
   //create socket
   if ((sockfd = socket(AF_UNIX,SOCK_STREAM,0)) < 0)
   {
       error("creating socket");
   }
   //socket configuration
   bzero((char *) &serv_addr, sizeof(serv_addr));
   serv_addr.sun_family = AF_UNIX;
   strcpy(serv_addr.sun_path, argv[1]);
   servlen=strlen(serv_addr.sun_path) + sizeof(serv_addr.sun_family);
   //bind socket to server address
   if(bind(sockfd,(struct sockaddr *)&serv_addr, servlen)<0)
   {
       error("binding socket"); 
   }
   //daemonize the server to connect to multiple servers via 1 terminal
   switch (fork()) 
   {
        case -1: //error
            error("fork");
        default: //close parent to run clients
            close(sockfd);
            return 0;
            break;
        case 0: //daemonized server continues
            break;
   }

   printf("\nSocket Created!\n Waiting for a client!\n");
   //listen for a connection
   listen(sockfd,5);
   clilen = sizeof(cli_addr);
   //run server until 2 clients have been served
   while(numClients > 0)
   {	
	//accept client connection
	newsockfd = accept(sockfd,(struct sockaddr *)&cli_addr,&clilen);	
	if (newsockfd < 0)
	{ 
        	error("accepting");
   	}
	write(newsockfd, "\nA connection has been established\n", 42);
	
	numTransaction = 7;	//reset number of transactions that a client can make
	while(numTransaction > 0)
	{	
		bzero(buf,80);			//clear buffer
		n=read(newsockfd, buf, 80);	//read from client
		buf[n] = '\0';
		if(strcmp(buf, "buy") == 0)	//if client is buying
		{
			bzero(buf, 80);
			//deal out tickets until they run out
			if(x < 10)	
			{
				char ticketStr[5];
   				ticketID = Tdata[x];	//retrieve ticket ID
				x++;			//increment next ticket ID
				//convert ticketID number into a string to send to client
				sprintf(ticketStr, "%d", ticketID);
				write(newsockfd, ticketStr, strlen(ticketStr));
				bzero(buf,80);
			}
			else	//if server runs out of tickets
			{
				write(newsockfd, "out", 3);
				bzero(buf, 80);
			}
		}
		else				//if client is cancelling
		{   	
			//printf("%s\n", buf);
			if(strcmp(buf, "none") == 0)	//if there are no tickets to be cancelled
			{
				write(newsockfd, "ERROR: There are no tickets to be CANCELLED\n", 44);
			}
			else				//if there is a ticket to be cancelled
			{
				//convert ticketID number being cancelled to int from string
				ticketID = atoi(buf);
				printf("\nCANCEL Ticket ID: #%d\n", ticketID);	
				for(j=0; j<10; j++)	//check for existing ticket
				{
					if(ticketID == Tdata[j])	//ticket exists
					{
						write(newsockfd, "Ticket CANCELLED. Thank You.\n\n", 30);
						break;
					}
					else if(j == 9)			//ticket does not exist
					{
						write(newsockfd, "ERROR: This ticket does not exist in our database.\n", 52);
						break;
					}
				}
			}
			bzero(buf,80);
		}
   		numTransaction--;
	}
	numClients--;
	close(newsockfd);	//close client socket
   }
   close(sockfd);	//close server socket
   return 0;
}

//print error message
void error(const char *msg)
{
    perror(msg);
    exit(0);
}

//randomize ticket ID numbers
void ticketData(int Tdata[10])
{
	int i;
	int ticketID;
	srand(time(NULL));	//use time to randomize the seed
	for(i=0; i<10; i++)
	{
		ticketID = 10000 + rand() % 90000;	//randomize a 5 digit number
		//check if the 5 digit number has been repeated by the randomizer
		while (checkRepeat(Tdata, i, ticketID) == 1) 
		{
			//replace the repeated number with a new one
            		ticketID = 10000 + rand() % 90000;
        	}
                //set the tickit ID into the database
		Tdata[i] = ticketID;
	}    	
	return;
}

//Checks for a repeat ticketID
int checkRepeat(int Tdata[10], int x, int ticketID)
{
    int i;
    
    for (i=0; i<x; i++) {
        if (Tdata[i] == ticketID) {
            return 1;       //Has repeated ID
        }
    }
    
    return 0;       //No repeated ID
    
}

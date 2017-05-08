///////////////////////////////////////////////////////////////////////////
//
//      Name:   Jason Hoang
//      Course: CSCE 3530 - Networking
//      Assignment:     PROGRAM 1 - HTML Sockets - Server and Client
//      Due Date:       9-24-15 at 11:55 PM
//
//	CLIENT.C
//      NOTES:  The goal of this program is to accept a connection with the client
//              program, receive a website request, and then return to the client
//              an HTML GET request to be printed into a file titled: "HTML_GET_output.txt"
//
//              This program was built from the basic socket programs that I worked on in
//              CSCE 3600 with Dr. Sweany in Spring 2015. I also utilized an HTTP socket
//              example program to help build these programs.
//              The example was posted here: "https://gist.github.com/nolim1t/126991"
//
//		Website input can be as simple as: "www.google.com"
//		There is no need for argv and argc input.
//
///////////////////////////////////////////////////////////////////////////


#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>

void error(char *msg)	//ERROR messaging - function
{
	perror(msg);
	exit(0);
}

int main()
{
	int sockfd, portno, n;
	struct sockaddr_in serv_addr;
	struct hostent *server;
	FILE *htmlFile;
	char buffer[1024];
	
	portno = 117116;	//fixed port number to connect client and server

	sockfd = socket(AF_INET, SOCK_STREAM, 0);	//creat socket to connect to server
	if(sockfd < 0)
	{
		error("ERROR opening socket");		//error handling
	}
	
	server = gethostbyname("cse01");		//fixed host server for client to connect to
	if(server == NULL)				
	{
		fprintf(stderr,"ERROR, no such host\n");//error handling
                exit(1);
	}
	//set up the socket to bind to the host using the port number
	bzero((char *)&serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	bcopy((char *)server->h_addr, (char *)&serv_addr.sin_addr.s_addr, server->h_length);
	serv_addr.sin_port = htons(portno);
	//Connect client to the host server
	if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		error("ERROR connecting");		//error handling
	}
	while(1){
	printf("Please enter the website request: ");	
	bzero(buffer, 1024);				//clear buffer
	scanf("%s", buffer);				//input saved in buffer
	
	n = write(sockfd, buffer, strlen(buffer));	//write input website to server
	if (n < 0)
	{
		error("ERROR writing to socket");	//error handling
	}
	bzero(buffer,1024);
	
	htmlFile = (fopen("HTML_GET_output.txt", "w"));	//Open file to write requested HTML code to
	while((read(sockfd, buffer, 1024)) != 0)	//while packets are being sent, read packets from server
	{
		if (n < 0)
		{
			error("ERROR reading from socket");	//error handling
		}
		printf("%s", buffer);
		fprintf(htmlFile, "%s", buffer);	//print packet to file
	}
	fclose(htmlFile);				//close file
	}
	close(sockfd);					//close socket
	printf("\nThe HTML GET code was printed to a file titled: HTML_GET_output.txt\n\n");
	return 0;
}

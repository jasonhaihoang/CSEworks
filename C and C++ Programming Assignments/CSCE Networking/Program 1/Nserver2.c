///////////////////////////////////////////////////////////////////////////
//
//	Name:	Jason Hoang
//	Course:	CSCE 3530 - Networking
//	Assignment:	PROGRAM 1 - HTML Sockets - Server and Client
//	Due Date:	9-24-15 at 11:55 PM
//
//	SERVER.C
//	NOTES:	The goal of this program is to accept a connection with the client
//		program, receive a website request, and then return to the client 
//		an HTML GET request to be printed into a file titled: "HTML_GET_output.txt"
//
//		This program was built from the basic socket programs that I worked on in
//		CSCE 3600 with Dr. Sweany in Spring 2015. I also utilized an HTTP socket
//		example program to help build these programs.
//		The example was posted here: "https://gist.github.com/nolim1t/126991"
//
//              Website input can be as simple as: "www.google.com"
//              There is no need for argv and argc input.
//
///////////////////////////////////////////////////////////////////////////

#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<fcntl.h>
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netinet/tcp.h>
#include<netdb.h>
#include<arpa/inet.h>

int requestConnect(char *hostname, in_port_t port);

void error(char *msg)	//ERROR messaging - function
{
	perror(msg);
	exit(1);
}

int main()
{
	int sockfd, newsockfd, portno, clilen, socket_desc;
	char buffer[1024];
	char *message;
	struct in_addr *addr;
	struct sockaddr_in serv_addr, cli_addr;
	int n, fd;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);	//Create a socket
	if (sockfd < 0)
	{	
		error("ERROR opening socket");		//ERROR handling
	}
	bzero((char *) &serv_addr, sizeof(serv_addr));	//initialize and clear serv_addr

	portno = 1171166;	//fixed port number to connect client and server

	serv_addr.sin_family = AF_INET;			//set up the socket to bind to the host using the port number
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(portno);
	//Binds a socket to the host to be used for this instance
	if (bind(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		error("ERROR on binding");		//error handling
	}
	
	printf("Socket CONNECTED!\nWaiting for client...\n");
	listen(sockfd,5);				//Listen for the client to connect
	clilen = sizeof(cli_addr);			//adjust client size
	//Accept the client's connection to the server socket
	newsockfd = accept(sockfd,(struct sockaddr *)&cli_addr, &clilen);
	if (newsockfd < 0)
	{
		error("ERROR on accept");		//error handling
	}
	printf("CLIENT ACCEPTED!\n");
	bzero(buffer, 1024);				//clear buffer
	
	n = read(newsockfd, buffer, 1024);		//read in input from the client
	if (n < 0)
	{
		error("ERROR reading from socket");	//error handling
	}
	message = buffer;
	printf("\nWebsite to GET: %s\n\n", message);
	
	fd = requestConnect(message, 80);		//make connection with requested server
	write(fd, "GET /\r\n", strlen("GET /\r\n"));	//send HTML GET request to requested server
	bzero(buffer, 1024);
	
	while(read(fd, buffer, 1023) != 0)		//read HTML GET response from requested server in packets of 1024 char
	{
		n = write(newsockfd, buffer, 1024);	//write to client at same time
		if (n < 0)
		{	
			error("ERROR writing to socket");	//error handling
		}
		printf("%s", buffer);			//print to server console for visual display
		bzero(buffer, 1024);			//clear buffer for the next packet
	}			
        close(fd);					//close socket
	printf("\n\nThis HTML GET was sent to CLIENT.\n\n");
	return 0;
}

//REQUEST CONNECTION TO WEBSITE HOST SERVER - FUNCTION
int requestConnect(char *hostname, in_port_t port)
{
	struct hostent *host;
	struct sockaddr_in addr;
	int on = 1, req_sock;     
	
	if((host = gethostbyname(hostname)) == NULL)	//get hostname to connect to requested host
	{
		error("gethostbyname");
	}
	//Convert HTML port to struct addr type and set to new socket connection to requested host
	bcopy(host->h_addr, &addr.sin_addr, host->h_length);
	addr.sin_port = htons(port);
	addr.sin_family = AF_INET;
	req_sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);	//create new socket for connection to requested website
	//setup socket options for the new socket
	setsockopt(req_sock, IPPROTO_TCP, TCP_NODELAY, (const char *)&on, sizeof(int));
	if(req_sock < 0)
	{
		error("setsockopt");			//error handling
	}
	//connect new socket to requested website
	if(connect(req_sock, (struct sockaddr *)&addr, sizeof(struct sockaddr_in)) < 0)
	{
		error("connect");			//error handling
	}
	return req_sock;				//return connected socket int
}

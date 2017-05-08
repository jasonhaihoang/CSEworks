///////////////////////////////////////////////////////////////////////////
//
//	Name:	Jason Hoang
//	Course:	CSCE 3530 - Networking
//	Assignment:	PROGRAM 2 - HTML Socket CACHE - Server and Client
//	Due Date:	10-8-15 at 11:55 PM
//
//	SERVER.C
//	NOTES:	The goal of this program is to add on a cache system for 5 websites that are not blacklisted.
//		This program was incredibly tedious and difficult to manage due to openning several files and
//		attempting to organize them all and keep track of them all. My attemp is obviously incomplete
//		because I was unable to figure out how to efficiently sort the file names by date within the
//		website_names_list file. But I did manage to get most of the requests satisfied and actually
//		make a program that caches the website data. However I did run into a weird issue where the 
//		data is being completely sent to the client like my previous program, which was successful.
//		I will have to go back and make some adjustments there.
//
//		The last issue that I encountered was making the socket application continuous. so that the
//		user can send more website requests to the server and thus build the 5 file cache.
//		I understand the concept, but I ran out of time to implement it in fully functioning form.
//	
//		This program was built from the basic socket programs.
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

#include<time.h>

int requestConnect(char *hostname, in_port_t port);

void error(char *msg)	//ERROR messaging - function
{
	perror(msg);
	exit(1);
}

void fileError(FILE *ferror)	//ERROR messaging - FILE
{
	if(ferror = NULL)
	{
		perror("FILE ERROR");
		exit(2);
	}
}

int main()
{
	int sockfd, newsockfd, portno, clilen, socket_desc;
	char buffer[1024], timeSort[5][20];
	char buf[1024];
	char timeBuf[20], headMsg[13];
	char *message, *fileBuf, tempBuf[20], *timeRemove;
	char webAdd[1024];
	struct in_addr *addr;
	struct sockaddr_in serv_addr, cli_addr;
	int n, fd, i;
	int cacheCount = 0;
	FILE *webName, *newWebCache, *webCache, *blackList;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);	//Create a socket
	if (sockfd < 0)
	{	
		error("ERROR opening socket");		//ERROR handling
	}
	bzero((char *) &serv_addr, sizeof(serv_addr));	//initialize and clear serv_addr

	portno = 117116;	//fixed port number to connect client and server

	serv_addr.sin_family = AF_INET;			//set up the socket to bind to the host using the port number
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(portno);
	//Binds a socket to the host to be used for this instance
	if (bind(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		error("ERROR on binding");		//error handling
	}
	
	printf("Socket CONNECTED!\nWaiting for client...\n");
	while(1)	//infinite while loop
	{
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
	bzero(buf, 1024);
	n = read(newsockfd, buffer, 1024);		//read in input from the client
	if (n < 0)
	{
		error("ERROR reading from socket");	//error handling
	}
	message = buffer;
	strcpy(webAdd, buffer);
	////BLACL LIST CODE////
	blackList = fopen("blacklist.txt", "r");	//open File
	fileError(blackList);				//error check
	time_t now;
        now = time(NULL);
        strftime(timeBuf, 20, "%Y%m%d%H%M%S", localtime(&now));		//Get the current time to test
        while(fscanf(blackList, "%s", buf) == 1)	//traverse file to compare to check if request is blacklisted
        {
                if(buf == message)
                {
                        bzero(buf, 1024);
                        fscanf(blackList, "%s", buf);
                        if(timeBuf > buf)
                        {
                                bzero(buf, 1024);
                                fscanf(blackList, "%s", buf);
                                if(timeBuf < buf)		//if blacklisted, notify client
                                {
                                        printf("This website is blacklisted at this time.\n");
                                        n = write(newsockfd, "This website is blacklisted at this time.\n", 1024);
                                        if (n < 0)
                                        {
                                                error("ERROR writing to socket");       //error handling
                                        }
                                        bzero(buf, 1024);               //clear buffer for the next packet
                                	fclose(blackList);		//close file
				}
                        }
                }
        }

	printf("\nWebsite to GET: %s\n\n", message);
	// CODE FOR CACHING //
	bzero(buf, 1024);                            //clear buffer
	if(cacheCount > 5)		//If cache is FULL
	{	
		webName = fopen("Website_Name_Cache.txt", "r"); 	//open website list file for reading
        	fileError(webName);
        	while(fscanf(webName, "%s", buf) == 1)	//traverse file to see if request is already in cache
        	{
                	if(buf == message)
                	{
                        	break;		//break from loop if file found in cache
                	}
        	}
		if(strcmp(buf, message) == 0)		//website exists in cache
		{
			bzero(buf, 1024);                            //clear buffer
			fscanf(webName, "%s", buf);	//get the file's name
			webCache = fopen(buf, "r");	//open the cached file
			bzero(buffer, 1024);                    //clear buffer for the next packet
			while(fgets(buffer, 1024, (FILE*)webCache))	//Get the file and send in packets to client
			{
				n = write(newsockfd, buffer, 1024);     //write to client
                        	if (n < 0)
                        	{
                        		error("ERROR writing to socket");       //error handling
                        	}
                        	bzero(buffer, 1024);                    //clear buffer for the next packet
			}
			fclose(webCache);	//close files
			fclose(webName);
		}
		else		//website do not exist in cache and cacheCount > 5
		{
			printf("Website does not exist in the cache.\n");
			fd = requestConnect(message, 80);               //make connection with requested server
			write(fd, "GET\r\n", strlen("GET\r\n"));    //send HTML GET request to requested server
                	n = read(fd, buffer, 1024);
                	if (n < 0)
                	{
                        	error("ERROR writing to socket");       //error handling
                	}
		
                	if(strcmp(buffer, "HTTP/1.0 200 OK") < 0)    //HTTP request did not return "200 OK"
                	{       
                        	n = write(newsockfd, buffer, 1024);     //write to client the issue
                        	if (n < 0)
                        	{
                        		error("ERROR writing to socket");       //error handling
                        	}
                        	printf("%s\n", buffer);                 //print to server console for visual display
				bzero(buffer, 1024);                    //clear buffer for the next packet
                	}
			else	//HEAD returned 200 OK - thus save to cache and send to client
			{
				time_t now;		//get the current time accessing the data
                		now = time(NULL);
                		strftime(timeBuf, 20, "%Y%m%d%H%M%S", localtime(&now));	//store in YYYYMMDDhhmmss
				strcat(timeBuf, ".txt");	//append the file name string with .txt
                		printf("Time accessed website: ");
                		puts(timeBuf);
				
                               	//need to clear a cache file
				timeRemove = timeSort[0];	//remove the oldest file to be replaced
				strcpy(timeSort[0], timeBuf);	//start replacing
				webName = fopen("Website_Name_Cache.txt", "a+");        //open file for reading and appending
				fprintf(webName, "%s ", message);       //append website list with the new website
                        	fprintf(webName, "%s\n", timeBuf);
				for(i=0; (i+1)<5; i++)	//SORT the times for each file currently in the cache
                        	{			//Oldest will always be first in the list
                               		if(timeSort[i+1] >= timeSort[i])
                                	{
                                      		strcpy(tempBuf,timeSort[i+1]);
                                       		strcpy(timeSort[i+1], timeSort[i]);
                                     		strcpy(timeSort[i], tempBuf);
                               		}
				}
				bzero(buffer, 1024);
				//Now we send the request back to the client
                               	fd = requestConnect(message, 80);               //make connection with requested server
                               	write(fd, "GET /\r\n", strlen("GET /\r\n"));    //send HTML GET request to requested server
                               	while(read(fd, buffer, 1023) != 0)              //read HTML GET response from requested server in packets of 1024 char
                               	{
                                       	n = write(newsockfd, buffer, 1024);     //write to client at same time
                                       	if (n < 0)
                                       	{
                                       		error("ERROR writing to socket");       //error handling
                                       	}
                                       	fprintf(newWebCache, "%s", buffer);                   //print to server console for visual display
                               		bzero(buffer, 1024);                    //clear buffer for the next packet
                               	}
				printf("\n\nThis HTML GET was sent to CLIENT.\n\n");
				fclose(webCache);	//close files
                        	fclose(webName);
			}// HEAD 200 OK else
		}//not exist in cache else
	}//if cacheCount > 5
	else if(cacheCount == 0)
	{
		printf("Website does not exist in the cache.\n");
		fd = requestConnect(message, 80);               //make connection with requested server
		write(fd, "GET\r\n", strlen("GET\r\n"));    //send HTML GET request to requested server
                n = read(fd, buffer, 1024);
                if (n < 0)
                {
                        error("ERROR writing to socket");       //error handling
                }
		
                if(strcmp(buffer, "HTTP/1.0 200 OK") < 0)    //Request did not return "200 OK"
                {       
                        n = write(newsockfd, buffer, 1024);     //write to client about issue
                        if (n < 0)
                        {
                        	error("ERROR writing to socket");       //error handling
                        }
                        printf("%s\n", buffer);                   //print to server console for visual display
			bzero(buffer, 1024);                    //clear buffer for the next packet
                }
		else
		{
			time_t now;		//get the current time accessing the data
                	now = time(NULL);
                	strftime(timeBuf, 20, "%Y%m%d%H%M%S", localtime(&now));	//store in YYYYMMDDhhmmss
                	strcat(timeBuf, ".txt");	//append the file name string with .txt
                	printf("Time accessed website: ");
                	puts(timeBuf);
	
               		webName = fopen("Website_Name_Cache.txt", "w");        //open file for writing
                	fprintf(webName, "%s ", webAdd);       //add to webname list the first website
                	fprintf(webName, "%s\n", timeBuf);
                	newWebCache = fopen(timeBuf, "w");	//Open a new file to record the HTTP request to cache
                	for(i=0; i<5; i++)	//SORT the times for each file currently in the cache
                	{			//Oldest will always be first in the list
                        	if(timeSort[i] < timeBuf)
                        	{
                                	strcpy(tempBuf, timeSort[i]);
                                	strcpy(timeSort[i], timeBuf);
                                	strcpy(timeBuf, tempBuf);
                        	}       	
                	}               
                	fd = requestConnect(webAdd, 80);               //make connection with requested server
                	bzero(buffer, 1024);
			write(fd, "GET /\r\n", strlen("GET /\r\n"));    //send HTML GET request to requested server
			while(read(fd, buffer, 1023) != 0)              //read HTML GET response from requested server in packets of 1024 char
                	{
                        	n = write(newsockfd, buffer, 1024);     //write to client at same time
                        	if (n < 0)
                        	{
                                	error("ERROR writing to socket");       //error handling
                        	}
                        	fprintf(newWebCache, "%s", buffer);     //print to server console for visual display
                        	bzero(buffer, 1024);                    //clear buffer for the next packet
                	}
			printf("\n\nThis HTML GET was sent to CLIENT.\n\n");
                	cacheCount++;		//increment cache count
                	fclose(webName);	//close files
			fclose(newWebCache);
		}
	}
	else	//cacheCount < 5 and > 0
	{
		
		printf("Website does not exist in the cache.\n");
		fd = requestConnect(message, 80);               //make connection with requested server
		write(fd, "GET\r\n", strlen("GET\r\n"));    //send HTML GET request to requested server
                n = read(fd, buffer, 1024);
                if (n < 0)
                {
                        error("ERROR writing to socket");       //error handling
                }
		
                if(strcmp(buffer, "HTTP/1.0 200 OK") < 0)    //Request did not return "200 OK"
                {       
                        n = write(newsockfd, buffer, 1024);     //write to client at same time
                        if (n < 0)
                        {
                        	error("ERROR writing to socket");       //error handling
                        }
                        printf("%s\n", buffer);                   //print to server console for visual display
			bzero(buffer, 1024);                    //clear buffer for the next packet
                }
                else    //HEAD returned 200 OK - thus save to cache and send to client
                {
			time_t now;		//get the current time accessing the data
                	now = time(NULL);
                	strftime(timeBuf, 20, "%Y%m%d%H%M%S", localtime(&now));	//store in YYYYMMDDhhmmss
                	strcat(timeBuf, ".txt");	//append the file name string with .txt
                	printf("Time accessed website: ");
                	puts(timeBuf);
			
			webName = fopen("Website_Name_Cache.txt", "a+");        //open file for reading and appending
                	fprintf(webName, "%s ", message);       //append webname list
                	fprintf(webName, "%s\n", timeBuf);
                	newWebCache = fopen(timeBuf, "w");	//Open a new file to record the HTTP request to cache
                	for(i=0; i<5; i++)	//SORT the times for each file currently in the cache
                	{			//Oldest will always be first in the list
                		if(timeSort[i] < timeBuf)
                        	{
                        		strcpy(tempBuf, timeSort[i]);
                                	strcpy(timeSort[i], timeBuf);
                                	strcpy(timeBuf, tempBuf);
                        	}       
                	}          	
                	bzero(buffer, 1024);
                	fd = requestConnect(webAdd, 80);               //make connection with requested server
                	write(fd, "GET /\r\n", strlen("GET /\r\n"));    //send HTML GET request to requested server
                	while(read(fd, buffer, 1023) != 0)              //read HTML GET response from requested server in packets of 1024 char
                	{
                		n = write(newsockfd, buffer, 1024);     //write to client at same time
                        	if (n < 0)
                        	{
                       			error("ERROR writing to socket");       //error handling
                       		}
                       		fprintf(newWebCache, "%s", buffer);                   //print to server console for visual display
                       		bzero(buffer, 1024);                    //clear buffer for the next packet
                	}
			printf("\n\nThis HTML GET was sent to CLIENT.\n\n");
                	cacheCount++;		//increment cache count
                	fclose(webCache);	//close files
        		fclose(webName);
		}
	}
	}//infinite while loop
	close(sockfd);		//close sockets
	close(newsockfd);		
        close(fd);		
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

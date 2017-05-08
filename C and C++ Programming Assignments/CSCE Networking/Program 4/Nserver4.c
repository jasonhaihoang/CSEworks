///////////////////////////////////////////////////////////////////////////
//
//	Name:	Jason Hoang
//	Course:	CSCE 3530 - Networking
//	Assignment:	PROGRAM 4 - TCP Data File Transmission - Server and Client
//	Due Date:	11-19-15 at 11:55 PM (DUE DATE CHANGED)
//
//	SERVER.C
//	NOTES:	The goal of this program is to add on to program 3 and add a 
//		TCP file transfer from the client to the server. This program 
//		will change sequence and acknowledgement numbers appropriately 
//		with the addition of the data payload and calculate correct 
//		checksums. The data payload size for each segment is fixed at 
//		128 bytes. The file being transferred by the client will be 
//		named "data.txt" as requested by the professor.
//
//		Finally, all of the TCP header segments will be printed to the 
//		screen before sending through the socket and after receiving 
//		from the socket. The information will be printed to both the 
//		screen and a separate .txt file named "TCPSegmentS" for server 
//		and "TCPSegmentC" for the client.
//
//		A separate file named, "dataRecvFile.txt" is where the contents
//		of the file being transfered will be stored.
//
//		NOTE: All integer data values printed out to the screen are 
//		printed in their HEXADECIMAL form.
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

struct TCPsegment{			//Structure for TCP header segment
        short int srcPort, destPort;	//port numbers
        int seqNum, ackNum;		//sequence and acknowledgement numbers

        short int offRsvdFlag;		//Offset(4), reserved(6), and flag bits(6)
        short int wnd;			//Receive Window
        unsigned short int chksum;	//checksum
        short int urgPtr;		//urgent pointer
        int options;
	char data[128];
};

//FUNCTION - Calculates the Checksum
unsigned short calcCheck(unsigned short *tcpSeg, int len)
{
        unsigned int Chksum = 0;
        unsigned short int answer = 0;
        unsigned short int *w = tcpSeg;
        int nleft = len;

        while (nleft > 1)	//shifts the bits in half and stores in another segment to calculate the checksum
        {
                Chksum += *w++;
                nleft -= 2;
        }
        //if odd number of bits - this shouldn't happen
        if (nleft == 1)
        {
                *(u_char *) (&answer) = *(u_char *) w;
                Chksum += answer;
        }
        //add overflow bits at the front end to the back end
        Chksum = (Chksum >> 16) + (Chksum & 0xffff);       //add hi 16 to low 16
        Chksum += (Chksum >> 16);       //add overflow
        answer = ~Chksum;              	//truncate to 16 bits
        return (answer);		//return checksum
}

//ERROR messaging - function
void error(char *msg)
{
	perror(msg);
	exit(1);
}

//MAIN
int main()
{
	int sockfd, newsockfd, portno, clilen, socket_desc;
	char buffer[1024];
	char databuff[128];
	struct in_addr *addr;
	struct sockaddr_in serv_addr, cli_addr;
	int n, fd;
	short int offset;
	FILE *tcpFile;
	struct TCPsegment tcp;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);	//Create a socket
	if (sockfd < 0)
	{	
		error("ERROR opening socket");		//ERROR handling
	}
	bzero((char *) &serv_addr, sizeof(serv_addr));	//initialize and clear serv_addr

	portno = 117115;	//fixed port number to connect client and server

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

	tcpFile = (fopen("TCPsegmentS.txt", "w"));       //Open file to write output into	
	bzero(databuff, 128);

	printf("\nDEMONSTRATION 1: 3-Way Handsake\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 1: 3-Way Handsake\n\n");
	//WAY-1 Handshake - Receives Client's initial Handshake and sends the 2nd handshake
	n = recv(newsockfd, buffer, 1024,0);		//read in input from the client
	if (n < 0)
	{
		error("ERROR reading from socket");	//error handling
	}
	
	memcpy(&tcp, buffer, sizeof(struct TCPsegment));		//Copy the received segment in the buffer to the tcp struct
	printf("TCP SYN header info RECV(in hexadecimal form):\n");	//Print the struct
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP SYN segment recieved!\n");
	fprintf(tcpFile, "TCP SYN header info RECV(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP SYN segment recieved!\n");	

	short int source = tcp.destPort;	//flip the destination and source ports for sending back to the client
	short int destination = tcp.srcPort;
	unsigned short int chksum = tcp.chksum;	//temporary checksum variable

	tcp.chksum = 0;	//set to 0 and calulate checksum of tcp
	tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));
	if(tcp.chksum == chksum)	//compare the received tcp to the calculated to see if data is corrupted
	{
		printf("Checksums MATCH! TCP segment not corrupted.\n\n");
		fprintf(tcpFile, "Checksums MATCH! TCP segment not corrupted.\n\n");
	}
	else
	{
		printf("ERROR: Checksums did not match - TCP segment was corrupted.\n");
	}

	////
	//WAY-2 Handshake - Responds to Client's SYN segment with a SYN-ACK segment
	tcp.srcPort = source;           //client-source port
        tcp.destPort = destination;     //server-destination port
	tcp.ackNum = tcp.seqNum + 1;	//increment ACK number by adding 1 to sequence number
	tcp.seqNum = 0;		//implement a new sequence number for the server response
        offset = tcp.offRsvdFlag;	//reset offset bits
        offset = (offset | 0x0010);     //bitwise OR to set the ACK bit to 1 and keep SYN bit as 1
        tcp.offRsvdFlag = offset;

	tcp.chksum = 0;		//calculate a new checksum for the new segment
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

	bzero(buffer, 1024);                    //clear buffer for the next packet
	memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer

	n = send(newsockfd, buffer, sizeof(struct TCPsegment), 0);	//send segment to client at same time
	if (n < 0)
	{	
		error("ERROR writing to socket");	//error handling
	}
	printf("TCP SYN-ACK header info SENT(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        printf("TCP SYN-ACK segment sent!\n\n");
	fprintf(tcpFile, "TCP SYN-ACK header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP SYN-ACK segment sent!\n\n");
	bzero(buffer, 1024);			//clear buffer for the next packet
				
	//WAY-3 Handshake - Receives Client ACK Response from SYN-ACK segment
        n = recv(newsockfd, buffer, 1024,0);            //receive TCP segment from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment));		//Copy the received segment in the buffer to the tcp struct
        printf("TCP ACK header info RECV(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP ACK segment recieved!\n");
	fprintf(tcpFile, "TCP ACK header info RECV(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP ACK segment recieved!\n");

        source = tcp.destPort;		//flip the destination and source ports for sending back to the client
        destination = tcp.srcPort;
        chksum = tcp.chksum;

        tcp.chksum = 0;			//set to 0 and calulate checksum of tcp
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));
        if(tcp.chksum == chksum)	//compare the received tcp to the calculated to see if data is corrupted
        {
                printf("Checksums MATCH! TCP segment not corrupted.\n\n");
		fprintf(tcpFile, "Checksums MATCH! TCP segment not corrupted.\n\n");
        }
        else
        {
                printf("ERROR: Checksums did not match - TCP segment was corrupted.\n");
        }

	printf("3-Way Handshake COMPLETE!\n\n");
	fprintf(tcpFile, "3-Way Handshake COMPLETE!\n\n");

	/////SEND DATA
	printf("\nDEMONSTRATION 2: Transfer Data File\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 2: Transfer Data File\n\n");
        printf("Receiving Data Packets!\n\n");
	fprintf(tcpFile, "Receiving Data Packets!\n\n");

	FILE *dataFile;
        size_t nread;
	int seqCount = 0;    

	dataFile = fopen("dataRecvFile.txt", "w");

        while ((n = recv(newsockfd, buffer, 1024,0)) > 0)
        {
		memcpy(&tcp, buffer, sizeof(struct TCPsegment));//Copy the received segment in the buffer to the tcp struct
		if(tcp.data[0] != '\0')
		{
			bzero(databuff, 128);		//clear data buffer
			source = tcp.destPort;		//set port numbers
			destination = tcp.srcPort;
        		chksum = tcp.chksum;		//calculate checksum
                	tcp.chksum = 0;                 //set to 0 and calulate checksum of tcp
                	tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));
                	if(tcp.chksum == chksum)        //compare the received tcp to the calculated to see if data is corrupted
                	{
                        	printf("Checksums MATCH! TCP segment not corrupted.\n\n");
                        	fprintf(tcpFile, "Checksums MATCH! TCP segment not corrupted.\n\n");
                	}
                	else
                	{
                        	printf("ERROR: Checksums did not match - TCP segment was corrupted.\n");
				break;
                	}
			
			printf("TCP DATA-Seg header info RECV(in hexadecimal form):\n");
        		printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
			printf("TCP DATA segment recieved!\n\n");
			fprintf(tcpFile, "TCP DATA-Seg header info RECV(in hexadecimal form):\n");
        		fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        		fprintf(tcpFile, "TCP DATA segment recieved!\n\n");

                	//set up next data segment
                	memcpy(databuff, tcp.data, sizeof(tcp.data));	//copy data payload to buffer to be put in dataRecvFile.txt
			tcp.ackNum = tcp.seqNum + (sizeof(databuff));	//first iteration = 0-127 bits + 1 bit = 128 bits
                	tcp.seqNum = seqCount;		//set sequence number
			tcp.srcPort = source;           //client-source port
                	tcp.destPort = destination;     //server-destination port
                	tcp.chksum = 0;			//reset checksum
			bzero(tcp.data, 128);
			offset = tcp.offRsvdFlag;       //set offset bits
        		offset = (offset ^ 0x0010);     //bitwise XOR to set the ACK bit to 1
        		tcp.offRsvdFlag = offset;       
			tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));	//calculate checksum

			fprintf(dataFile, "%s", databuff);	//print packet to file

			bzero(buffer, 1024);                    //clear buffer for the next packet
                	memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer
                	n = send(newsockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
                	if (n < 0)
                	{
                        	error("ERROR writing to socket");       //error handling
                	}
			printf("TCP DATA-ACK header info SENT(in hexadecimal form):\n");
        		printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
			printf("TCP DATA-ACK segment sent!\n\n");
			seqCount++;		//increment sequence number
			fprintf(tcpFile, "TCP DATA-ACK header info SENT(in hexadecimal form):\n");
        		fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        		fprintf(tcpFile, "TCP DATA-ACK segment sent!\n\n");
		}
		else
		{
			break;	//end of file transfer
		}
        }
        fclose(dataFile);	//close file

        printf("All Data Packets Received!\n\n");
	fprintf(tcpFile, "All Data Packets Received!\n\n");
        /////DATA SENT

	printf("\nDEMONSTRATION 3: TCP Close Connection\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 3: TCP Close Connection\n\n");
        ////
	//Server receives Clients FIN segment to close the TCP connection
	bzero(buffer, 1024);                    //clear buffer for the next packet
        n = recv(newsockfd, buffer, 1024,0);            //receive TCP segment from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment));		//Copy the received segment in the buffer to the tcp struct
        printf("TCP FIN header info RECV(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP FIN segment recieved!\n");
	fprintf(tcpFile, "TCP FIN header info RECV(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP FIN segment recieved!\n");

        source = tcp.destPort;		//flip the destination and source ports for sending back to the client
        destination = tcp.srcPort;
        chksum = tcp.chksum;

        tcp.chksum = 0;			//set to 0 and calulate checksum of tcp
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));
        if(tcp.chksum == chksum)	//compare the received tcp to the calculated to see if data is corrupted
        {
                printf("Checksums MATCH! TCP segment not corrupted.\n\n");
		fprintf(tcpFile, "Checksums MATCH! TCP segment not corrupted.\n\n");
        }
        else
     	{
                printf("ERROR: Checksums did not match - TCP segment was corrupted.\n");
        }
	
	////
	//Server responds to Client by sending an ACK bit
        tcp.srcPort = source;           //client-source port
        tcp.destPort = destination;     //server-destination port
	tcp.ackNum = tcp.seqNum + 1;	//increment ACK number by adding 1 to sequence number
	tcp.seqNum = 0;		//implement a new sequence number for the server response
        offset = tcp.offRsvdFlag;
        offset = (offset ^ 0x0011);     //bitwise OR to set the ACK bit to 1 and FIN bit to 0
        tcp.offRsvdFlag = offset;

        tcp.chksum = 0;			//set to 0 and calulate checksum of tcp
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

        bzero(buffer, 1024);                    //clear buffer for the next packet
        memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer

        n = send(newsockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
        if (n < 0)
        {
                error("ERROR writing to socket");       //error handling
        }
	printf("TCP ACK header info SENT(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        printf("TCP ACK segment sent!\n\n");
	fprintf(tcpFile, "TCP ACK header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP ACK segment sent!\n\n");

	////
	//Server sends FIN segment to Client indicating that the server will close the TCP connection
        tcp.seqNum = tcp.seqNum + 1;		//increment Sequence number by adding 1 to sequence number
	tcp.ackNum = 0;				//Set ACK number to 0, because this segment is not an ACK
        offset = (offset ^ 0x0011);             //bitwise XOR to set the FIN bit to 1 and ACK bit to 0
        tcp.offRsvdFlag = offset;

        tcp.wnd = 0;
        tcp.chksum = 0;
        tcp.urgPtr = 0;
        tcp.options = 0;

        tcp.chksum = 0;			//set to 0 and calulate checksum of tcp
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

        bzero(buffer, 1024);                    //clear buffer for the next packet
        memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer

        n = send(newsockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
        if (n < 0)
        {
                error("ERROR writing to socket");       //error handling
        }
	printf("TCP ACK header info SENT(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        printf("TCP ACK segment sent!\n\n");
	fprintf(tcpFile, "TCP ACK header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP ACK segment sent!\n\n");

	////
	//Server receives ACK from the client to confirm that TCP segment was well received
        n = recv(newsockfd, buffer, 1024,0);            //receive TCP segment from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment));		//Copy the received segment in the buffer to the tcp struct
        printf("TCP ACK header info RECV(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP ACK segment recieved!\n");
	fprintf(tcpFile, "TCP ACK header info RECV(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP ACK segment recieved!\n");

        source = tcp.destPort;		//flip the destination and source ports for sending back to the client
        destination = tcp.srcPort;
        chksum = tcp.chksum;

        tcp.chksum = 0;			//set to 0 and calulate checksum of tcp
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));
        if(tcp.chksum == chksum)	//compare the received tcp to the calculated to see if data is corrupted
        {
                printf("Checksums MATCH! TCP segment not corrupted.\n\n");
		fprintf(tcpFile, "Checksums MATCH! TCP segment not corrupted.\n\n");
        }
        else
        {
                printf("ERROR: Checksums did not match - TCP segment was corrupted.\n");
        }
	
	printf("\n\nThis TCP Close Connection is complete!\n\n");
	fprintf(tcpFile, "\n\nThis TCP Close Connection is complete!\n\n");

	fclose(tcpFile);				//close file
        close(fd);					//close socket
	printf("\nThe above TCP header info SERVER output was printed to the file: TCPsegmentS.txt\n\n");
	return 0;
}

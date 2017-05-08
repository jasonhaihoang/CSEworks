///////////////////////////////////////////////////////////////////////////
//
//	Name:	Jason Hoang
//	Course:	CSCE 3530 - Networking
//	Assignment:	PROGRAM 4 - TCP Data File Transmission - Server and Client
//	Due Date:	11-19-15 at 11:55 PM (DUE DATE CHANGED)
//
//	Client.C
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
#include<sys/types.h>
#include<sys/socket.h>
#include<netinet/in.h>
#include<netdb.h>

struct TCPsegment{			//Structure for TCP header segment
        short int srcPort, destPort;	//port numbers
        int seqNum, ackNum;		//sequence and acknowledgement numbers

        short int offRsvdFlag;		//Offset(4), reserved(6), and flag bits(6)
        short int wnd;			//Receive Window
        unsigned short int chksum;	//checksum
        short int urgPtr;		//urgent pointer
        int options;
	char data[128];			//ADDED - data field holding 128 bits
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
	exit(0);
}

int main()
{
	int sockfd, portno, n;
	struct sockaddr_in serv_addr;
	struct hostent *server;
	FILE *tcpFile;
	char buffer[1024];
	char databuff[128];
	short int offset;
	struct TCPsegment tcp;

	portno = 117115;	//fixed port number to connect client and server

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
	
	tcpFile = (fopen("TCPsegmentC.txt", "w"));       //Open file to write output into
	bzero(databuff, 128);
	
	printf("\nDEMONSTRATION 1: 3-Way Handsake\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 1: 3-Way Handsake\n\n");
	tcp.srcPort = htons(12345);		//client-source port
	tcp.destPort = serv_addr.sin_port;	//server-destination port
	tcp.seqNum = 1;				//set sequence number to 1
	tcp.ackNum = 0;				//Ack number is 0 because segment is not an ACK
	offset = sizeof(struct TCPsegment)/4;	//get the length of the header
	offset = offset << 12;			//set the header bits(first 4 bits)
	offset = (offset | 0x0002);		//bitwise OR to set the SYN bit to 1
	tcp.offRsvdFlag = offset;

	tcp.wnd = 0;				//all these bits set to 0 according to instructions
	tcp.chksum = 0;
	tcp.urgPtr = 0;
	tcp.options = 0;
	tcp.data[0] = '\0';
	memcpy(tcp.data, databuff, sizeof(databuff));
	
	tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));	//calculate checksum
	memcpy(buffer, &tcp, sizeof(struct TCPsegment));	//copy TCP struct to the buffer

	//Connect client to the host server
	if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) < 0)
	{
		error("ERROR connecting");		//error handling
	}
	
	printf("TCP SYN header info SENT(in hexadecimal form):\n");
	printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
	printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	fprintf(tcpFile, "TCP SYN header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	n = send(sockfd, buffer, sizeof(struct TCPsegment),0);	//send TCP segment to server
	if (n < 0)
	{
		error("ERROR writing to socket");	//error handling
	}
	printf("TCP SYN segment sent!\n\n");
	fprintf(tcpFile, "TCP SYN segment sent!\n\n");
	
	//WAY-2 Handshake - Receives Client Response from WAY-2 Handshake
        n = recv(sockfd, buffer, 1024,0);            //receive segment from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment));		//Copy the received segment in the buffer to the tcp struct	
        printf("TCP SYN-ACK header info RECV(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP SYN-ACK segment recieved!\n");
	fprintf(tcpFile, "TCP SYN-ACK header info RECV(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP SYN-ACK segment recieved!\n");

        short int source = tcp.destPort;	//flip the destination and source ports for sending back to the client
        short int destination = tcp.srcPort;
        unsigned short int chksum = tcp.chksum;	//temporary checksum variable

        tcp.chksum = 0;		//set to 0 and calulate checksum of tcp
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
	//WAY-3 Handshake - ACK response to SYN-ACK response from server
	tcp.srcPort = source;           //client-source port
        tcp.destPort = destination;     //server-destination port
        tcp.ackNum = tcp.seqNum + 1;	//increment ACK number by adding 1 to sequence number
        tcp.seqNum = 2;			//set the next sequence number from client
	offset = tcp.offRsvdFlag;	//reset offset bits
        offset = (offset ^ 0x0002);     //bitwise OR to set the SYN bit to 0 and keep the ACK bit at 1
        tcp.offRsvdFlag = offset;

        tcp.chksum = 0;		//calculate a new checksum for the new segment
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

        bzero(buffer, 1024);                    //clear buffer for the next packet
        memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer

        n = send(sockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
        if (n < 0)
        {
                error("ERROR writing to socket");       //error handling
        }
	printf("TCP ACK header info SENT(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
	printf("TCP ACK segment sent!\n\n");

	printf("TCP 3-way handshake COMPLETE!\n\n");

	fprintf(tcpFile, "TCP ACK header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP ACK segment sent!\n\n");

        fprintf(tcpFile, "TCP 3-way handshake COMPLETE!\n\n");
	
	/////SEND DATA
	printf("\nDEMONSTRATION 2: Transfer Data File\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 2: Transfer Data File\n\n");
	printf("Sending Data Packets!\n\n");
	fprintf(tcpFile, "Sending Data Packets!\n\n");
	
	FILE *dataFile;
	size_t nread;
	int tempSeq = 0;	//temporary counter

        //set up data segment
        tcp.ackNum = 0;				//set ACK and Sequence numbers
        tcp.seqNum = 0;
        offset = sizeof(struct TCPsegment)/4;   //get the length of the header
        offset = offset << 12;                  //set the header bits(first 4 bits)
	offset = (offset ^ 0x0010);             //bitwise XOR to set the ACK bit to 0
	tcp.chksum = 0;         //calculate a new checksum for the new segment

	dataFile = fopen("data.txt", "r");
	if(dataFile)
	{
    		while ((nread = fread(databuff, 1, sizeof(databuff), dataFile)) > 0)
		{
        		tcp.offRsvdFlag = offset;
			//send to socket
			memcpy(tcp.data, databuff, sizeof(databuff));	//copy data payload from file to tcp struct
        		tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));	//calculate checksum

			bzero(buffer, 1024);                    //clear buffer for the next packet
        		memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer
        		n = send(sockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
			if (n < 0)
        		{
                		error("ERROR writing to socket");       //error handling
        		}
			printf("TCP DATA-seg header info SENT(in hexadecimal form):\n");
        		printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
			printf("TCP DATA segment sent!\n\n");

			fprintf(tcpFile, "TCP DATA-seg header info SENT(in hexadecimal form):\n");
        		fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        		fprintf(tcpFile, "TCP DATA segment sent!\n\n");
			
			//receive ACK
			n = recv(sockfd, buffer, 1024,0);            //receive TCP segment from the client
        		if (n < 0)
        		{
                		error("ERROR reading from socket");     //error handling
        		}
        		memcpy(&tcp, buffer, sizeof(struct TCPsegment));//Copy the received segment in the buffer to the tcp struct
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

			printf("TCP DATA-ACK header info RECV(in hexadecimal form):\n");
        		printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
			printf("TCP DATA-ACK recieved!\n\n");
			fprintf(tcpFile, "TCP DATA-ACK header info RECV(in hexadecimal form):\n");
        		fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        		fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        		fprintf(tcpFile, "TCP DATA-ACK recieved!\n\n");

			//set up next data segment
			bzero(databuff, 128);		//clear data payload buffer
			tempSeq = (tcp.seqNum + 1);	//increment expected ACK number
			tcp.seqNum = tcp.ackNum;	//set sequence number
			tcp.ackNum = tempSeq;		//set ACK number
			tcp.srcPort = source;           //client-source port
        		tcp.destPort = destination;     //server-destination port
			tcp.chksum = 0;			//reset checksum
		}
	}
	bzero(databuff, 128);		//clear data payload buffer
	tcp.data[0] = '\0';		//end of data file transmission
	memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer
	n = send(sockfd, buffer, sizeof(struct TCPsegment), 0);      //write to client at same time
        if (n < 0)
        {
        	error("ERROR writing to socket");       //error handling
        }
    	fclose(dataFile);	//close file

	printf("Data Packets Sent!\n\n");
	fprintf(tcpFile, "All Data Packets Sent!\n\n");
	/////DATA SENT

	printf("\nDEMONSTRATION 3: Closing TCP Connection\n\n");
	fprintf(tcpFile, "\nDEMONSTRATION 3: Closing TCP Connection\n\n");
	tcp.srcPort = htons(12345);             //client-source port
        tcp.destPort = serv_addr.sin_port;      //server-destination port
        tcp.seqNum = 1;				//set sequence number to 1
        tcp.ackNum = 0;				//ACK number is 0 because segment is not an ACK
        offset = sizeof(struct TCPsegment)/4;   //get the length of the header
        offset = offset << 12;                  //set the header bits(first 4 bits)
        offset = (offset | 0x0001);             //bitwise OR to set the FIN bit to 1
        tcp.offRsvdFlag = offset;

        tcp.wnd = 0;
        tcp.chksum = 0;
        tcp.urgPtr = 0;
        tcp.options = 0;
	tcp.data[0] = '\0';

	tcp.chksum = 0;		//calculate a new checksum for the new segment
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

        bzero(buffer, 1024);                    //clear buffer for the next packet
        memcpy(buffer, &tcp, sizeof(struct TCPsegment));

        n = send(sockfd, buffer, sizeof(struct TCPsegment), 0);      //write to client at same time
        if (n < 0)
        {
                error("ERROR writing to socket");       //error handling
        }
	printf("TCP FIN header info SENT(in hexadecimal form):\n");
        printf("Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        printf("Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        printf("TCP FIN segment sent!\n\n");
	fprintf(tcpFile, "TCP FIN header info SENT(in hexadecimal form):\n");
        fprintf(tcpFile, "Source Port:%x  Destination Port:%x  Sequence Number:%x\n", tcp.srcPort,tcp.destPort,tcp.seqNum);
        fprintf(tcpFile, "Acknowledgement Number: %x  Data Offset-Reserved-Flags:%x  Checksum:%x\n", tcp.ackNum,tcp.offRsvdFlag,tcp.chksum);
        fprintf(tcpFile, "TCP FIN segment sent!\n\n");
	
	////
	//Receives ACK from server in response to clients request for TCP close connection
        n = recv(sockfd, buffer, 1024,0);            //read in input from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment)); //copy TCP struct to the buffer
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

        tcp.chksum = 0;		//set to 0 and calulate checksum of tcp
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
        //Receive FIN segment from Server confirming that connection is being closed
        n = recv(sockfd, buffer, 1024,0);            //receive TCP segment from the client
        if (n < 0)
        {
                error("ERROR reading from socket");     //error handling
        }

        memcpy(&tcp, buffer, sizeof(struct TCPsegment));	//Copy the received segment in the buffer to the tcp struct
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
	//Client sends ACK back to server to confirm TCP close connection
        tcp.srcPort = source;           //client-source port
        tcp.destPort = destination;     //server-destination port
        tcp.ackNum = tcp.seqNum + 1;	//increment ACK number by adding 1 to sequence number		
	tcp.seqNum = 2;			//set sequence number to 2 for the next segment
        offset = tcp.offRsvdFlag;	//reset offset bits
        offset = (offset ^ 0x0011);     //bitwise XOR to set the ACK bit to 1
        tcp.offRsvdFlag = offset;

        tcp.chksum = 0;			//calculate a new checksum for the new segment
        tcp.chksum = calcCheck((unsigned short *)&tcp, sizeof(struct TCPsegment));

        bzero(buffer, 1024);                    //clear buffer for the next packet
        memcpy(buffer, &tcp, sizeof(struct TCPsegment)); //copy TCP struct to the buffer

        n = send(sockfd, buffer, sizeof(struct TCPsegment), 0);      //send to client at same time
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

	printf("\n\nThis TCP Close Connection is complete!\n\n");
	fprintf(tcpFile, "\n\nThis TCP Close Connection is complete!\n\n");
	
	fclose(tcpFile);				//close file
	close(sockfd);					//close socket
	printf("\nThe above TCP header info CLIENT output was printed to the file: TCPsegmentC.txt\n\n");
	return 0;
}

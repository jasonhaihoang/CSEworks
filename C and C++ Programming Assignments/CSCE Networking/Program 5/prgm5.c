///////////////////////////////////////////////////////////////////////////
//
//	Name:	Jason Hoang
//	Course:	CSCE 3530 - Networking
//	Assignment:	PROGRAM 5 - Dijkstra's Algorithm and the Distance Vector Algorithm
//	Due Date:	12-3-15 at 11:55 PM
//
//	prgm5.C
//	NOTES:	The goal of this program is to createa C program that can emulate
//		the properties and functions of the Dijkstra'sAlgorithm and the 
//		Distance Vector Algorithm. 
//
//		My version of the program will output in the following format:
//			Vertex V from N (N, Distance from N to V(value))
//		I chose this format because it makes much more sensein terms 
//		of what we learned about these algorithms in class and what we 
//		really want to find using these algorithms.
//
//		Cite: Various sources and tutorials from the internet were used to put 
//		this program together.
///////////////////////////////////////////////////////////////////////////

#include<stdio.h>
#include<stdlib.h>

char vertex[6] = {'u', 'v', 'w', 'x', 'y', 'z'};	//global array for vertex variable names

void dijsktra(int v, int cost[6][6], FILE *output1);
void DistanceVector(int cost[6][6]);

int main()
{
	FILE *input, *output1;
	char ch;
	int i, j, cost;
	char sV1[2], sV2[2], V1, V2;	//input characters

	//6 Verticies - u,v,w,x,y,z = 0,1,2,3,4,5
	int graph[6][6];

	for(i=0; i<6; i++)	//initialize the graph with 999 in place of infinity
	{
		for(j=0; j<6; j++)
		{
			graph[i][j] = 999;
		}
	}

	input = (fopen("router.txt", "r"));	//open input file
	if( input == NULL )
   	{
      		perror("Error while opening the file.\n");
      		exit(EXIT_FAILURE);
   	}
	printf("\n<<router.txt input values>>\n");
        while( fscanf(input, "%1s %1s %d", sV1, sV2, &cost) != EOF )	//input the values for the graph matrix byscanning from te input file
        {
		V1 = sV1[0];	//transpose the strings to characters
		V2 = sV2[0];
		printf("%c %c %d\n", V1, V2, cost);	//print input graph
                switch(V1)	//switch for first node input
                {
                        case 'u':
                                i = 0;
                                break;
                        case 'v':
                                i = 1;
                                break;
                        case 'w':
                                i = 2;
                                break;
                        case 'x':
                                i = 3;
                                break;
                        case 'y':
                                i = 4;
                                break;
                        case 'z':
                                i = 5;
                                break;
                }
                switch(V2)	//switch for second node input
                {
                        case 'u':
                                j = 0;
                                break;
                        case 'v':
                                j = 1;
                                break;
                        case 'w':
                                j = 2;
                                break;
                        case 'x':
                                j = 3;
                                break;
                        case 'y':
                                j = 4;
                                break;
                        case 'z':
                                j = 5;
                                break;
                }
                graph[i][j] = cost;	//input the cost into the appropriate places in the graph for each node.
		graph[j][i] = cost;
        }
	
	printf("\nThe following output is in the format:\n");
	printf("\tVertex V from N (N, Distance from N to V(value))\n");

	output1 = (fopen("LS.txt", "a+"));	//print output to file LS.txt
	fprintf(output1, "\nThe following output is in the format:\n");
	fprintf(output1, "\tVertex V from N (N, Distance from N to V(value))\n");
	fprintf(output1, "\nPart I: Dijsktra's Algorithm\n");
	
	printf("\nPart I: Dijsktra's Algorithm\n");	//run algorithms and print results
	for(i=0; i<6; i++)
        {
                dijsktra(i, graph, output1);
        }
	fclose(output1);
	printf("\nPART II: Distance Vector Algorithm\n");
	DistanceVector(graph);
	return 0;
}

void dijsktra(int v, int cost[6][6], FILE *output1)
{
	int i, j, u, count, w, visit[6], min;
	int distVal[6];	//distance array, to hold the distance values for each node from v
 	for(i=0; i<6; i++)	//initialize the distance array
 	{
		if(i == v)
		{
			visit[i] = 111;	//vertex v is already set to visited
		}
		else
		{
			visit[i] = 0;	//initialize the visited array
		}
		distVal[i] = cost[v][i];	//pull the known costs for the initial node v into the distance array.
 	}
	
	count=1;
 	while(count < 6)	//Dijkstra's algorithm
 	{
 		min=99; //initial minimum

  		for(w=0; w<6; w++)	//find the minimum distance for each node
		{
   			if((distVal[w] < min) && (!visit[w]))
			{
    				min = distVal[w];
				u = w;
  			}
		}
		visit[u] = count;	//set the path number
		count++;		//increment path number
  		for(w=0; w<6; w++)	//calculate the other paths thatare related or open up due to the selection of the miniumum node distance
   		{
			if((distVal[u] + cost[u][w] < distVal[w]) && (!visit[w]))
    			{
				distVal[w] = distVal[u] + cost[u][w];	//set the new minimum distance for the node
			}
 		}
	}

	count = 1;
	while(count < 6)	//print the output for the node v
	{
		for(i=0; i<6; i++)
        	{
                	if((visit[i] == count) && (i != v))
                	{
				printf(" %c (%c, %d)\n", vertex[i], vertex[v], distVal[i]);
				fprintf(output1, " %c (%c, %d)\n", vertex[i], vertex[v], distVal[i]);
				count++;
                	}
        	}
	}
	printf("--------\n");
	fprintf(output1, "--------\n");
}

void DistanceVector(int cost[6][6])
{
	FILE *output2;
	int i, j, k;
	int count;
	int dist2Val[6][6];	//this distance matrix will be similar to the cost matrix

	for(i=0; i<6; i++)	//initialize the entire distance matrix
	{
		for(j=0; j<6; j++)
		{
			dist2Val[i][i] = 0;		//0 if the node is itself
			dist2Val[i][j] = cost[i][j];	//equal to costs that are already known
		}
	}

	do	//Distance Vector Algorithm
        {  
            	count=0;	//reset count to 0
            	for(i=0; i<6; i++)
	    	{
            		for(j=0; j<6; j++)
            		{
				for(k=0; k<6; k++)
                		{
					if(dist2Val[i][j] > cost[i][k] + dist2Val[k][j]) //find the minimum between the current "minimum" distance and another possible path
                			{
                    				dist2Val[i][j] = dist2Val[i][k] + dist2Val[k][j];	//set the new minimum
                    				count++;	//increment count to recalculate the minimum according to other possible pathswithin the graph
                			}
				}
			}
		}
        }while(count != 0);
	
	output2 = (fopen("DV.txt", "w"));       //print output to file LS.txt
        fprintf(output2, "\nThe following output is in the format:\n");
        fprintf(output2, "\tVertex V from N (N, Distance from N to V(value))\n");
	fprintf(output2, "\nPART II: Distance Vector Algorithm\n");

	for(i=0; i<6; i++)	//print the output for all nodes
        {
            	for(j=0; j<6; j++)
            	{
                	if(i != j)
			{
				printf("%c (%c, %d)\n", vertex[j], vertex[i], dist2Val[i][j]);
            			fprintf(output2, "%c (%c, %d)\n", vertex[j], vertex[i], dist2Val[i][j]);
			}
		}
		printf("--------\n");	
		fprintf(output2, "--------\n");
        }
	fclose(output2);
}

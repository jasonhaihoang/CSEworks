/***************
Name:	Jason Hoang
Course:	CSCE 3110
Assignment:	PROGRAM 5 - Breadth First Search
Due Date:	8-8-2015 (REVISED)

NOTE: Output is setup to print the starting vertex being used for the Breadth Fisrt Search algorithm, followed by 
	each adjacent edge to that initial vertex. Then the following edges are the edges connected to each of the 
	adjacent vertices, and so on. all the conneced edges within the initially searched graph are printed before 
	searching for any other sub non-connected graphs

	So, if there is only one complete graph built from the input, then the graph is connected and all of their 
	connected edges are printed to show each connection. If there are multiple graphs built that are not connected 
	from the input, their edges will still be printed to show their connections. 

****************/

#include <iostream>
#include <string>
#include <sstream>	//for use of istringstream
#include <queue>	//for uses of built in queues

using namespace std;

class AdjList		//Asjacency List
{

	private:
		struct node		//nodes to create the list of vertices
		{
			string status;	//EMPTY, VERTEX. or EXPLORED
			bool visited;
			int vertex;	//vertex value
			node* next;	//pointer to adjacent vertices, edges
		};
		
		node* GraphList[1001];	//Adjacency List required by assignment to hold 1000 vertices

	public:
		AdjList();		//constructor
		void inputGraph();	//function to build the graph from redirected input
		void BFsearch();	//Breadth First Search function
};

//Constructor used to initialize each blank vertex
AdjList::AdjList()
{
	for(int i=0; i<1001; i++)
	{
		GraphList[i] = new node;		//creates list for vertex connections/edges
		GraphList[i]->status = "EMPTY";		//sets vertex to EMPTY, because no vertices have been added yet
		GraphList[i]->vertex = -1;		//vertices are temporarily set to -1
		GraphList[i]->next = NULL;		//sets up linked lists for the Adjacency List
		GraphList[i]->visited = false;		//vertex is not yet visited
	}
}

//FUNCTION - Builds graph from redirected input from an outside file provided by user
void AdjList::inputGraph()
{
	int vertex, adjV;	//main vertex value and adjacent vertices
	string line;
	while(cin>>vertex)
	{
		
		GraphList[vertex]->status = "VERTEX";		//marks the added vertex to be existing in the graph
		GraphList[vertex]->vertex = vertex;		
		getline(cin, line);				//gets all of the adjacent vertices on one line
		istringstream iss(line);			//separates the adjacent vertices within the line
		while(iss >> adjV)				
		{						
			//linked list for adjacent vertices to the main vertex
			node* Ptr = GraphList[vertex];		//set List pointer
			node* NextEdge = new node;		//create new temporary Edge List
			NextEdge->vertex = adjV;		//set vertex value
			NextEdge->next = NULL;			//set next node within List
			
			//cycles through edge List to find the end of the list
			while(Ptr->next != NULL)
			{	
				Ptr = Ptr->next;
			}
			Ptr->next = NextEdge;			//adds node to Adjacency List
		}
	}
	return;	
}

//FUNCTION - Breadth First Search
void AdjList::BFsearch()
{
	int i, current, adj;	//iterator, and vertex holders
	int edges;		//number of edges tracker - for error checking
	int numGraphs = 0;	//number of separate graphs found - for error checking
	queue <int> vertices;	//initialize the queue data structure
	node* Ptr;		//temporary pointers for Lists
	node* temp;
	for(i=0; i<1001; i++)	//traverse all vertices
	{
		if((GraphList[i]->status == "EMPTY") || (GraphList[i]->status == "EXPLORED"))
		{
			//skip search if the vertex doesn't exist in the graph or is already explored
		}
		else
		{
			edges = 0;		//set/reset number of edges - for error checking
			vertices.push(i);	//place starting vertex in queue
			cout << "Starting at Vertex " << i << " Edges - ";	//starting output
			while(!vertices.empty())	//while the queue is not empty
			{
				current = vertices.front();		//current vertex to the next vertex in queue
				vertices.pop();				//remove the next vertex in queue
				GraphList[current]->visited = true;	//visit the vertex
				Ptr = GraphList[current];		//temporary pointers
				Ptr = Ptr->next;
				while(Ptr != NULL)			//while a node in the adjacency list exist
				{
					if(Ptr->visited == false)	//if the adjacent vertex has not been visited yet
					{
						adj = Ptr->vertex;	
						vertices.push(adj);	//place the adjacent vertex in queue
						Ptr->visited = true;	//visit the adjacent vertex
						temp = GraphList[adj];	
						while(temp != NULL)	//traverse adjacent vertex other edges
						{			//and mark the edges (adj, current) as visited
							if((temp->vertex == current))
							{
								temp->visited = true;
							}
							temp = temp->next;
						}
						cout << "(" << current << ", " <<  adj << "), ";	//edge output
					}
					Ptr = Ptr->next;
					edges++;	//track number of edges- for error checking
				}
				if(edges == 0)		//ERROR CHECKING - if the vertex has NO edges
				{
					cout << "(" << current << ")";	//vertec output
					numGraphs++;	//track the number of separate graphs - for error checking
				}
				GraphList[current]->status = "EXPLORED";	//current vertex has been explored
			}
			numGraphs++;	//track the number of separate graphs - for error checking
			cout << endl;
		}
	}
	if(numGraphs > 1)		//ERROR CHECKING - output for if the graph is connected or not
	{
		cout << "This Graph is NOT CONNECTED." << endl;
	}
	else
	{
		cout << "This Graph is CONNECTED." << endl;
	}
	return;
}

//MAIN
int main()
{
	AdjList list;			//initialize AdjList class
	
	list.inputGraph();		//build the graph from redirected input from a file provided by the user
	list.BFsearch();		//call Breadth First Search on the graph, output edges and graph connection

	return 0;
}

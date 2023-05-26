# Work Log

## GROUP MEMBER 1
Stanley Tung (I'm working by myself)
For info on the specifics, check my commits: They mention what I mention in this worklog.


### Day 1: Monday, May 22nd 
Classwork:
- created essential classes for graph visualizer (Node, Graph, Edge, Algorithm)
- Started writing Node class (I was writing out methods that I mentioned in my UML diagram)
- Started structuring my main program (add setup, draw, space for important setup variables and event functions, e.g. mousePressed)

Homework:
- Wrote edge and node classes (I might add more to them later) 
  - Wrote edge and node display methods: They display properly (edges change when nodes move) 
- Current main program involves: Arraylist of nodes and edges that change based on user input.
  - Added both default (setup - e.g. node color) and important (e.g. mode of user input) variables to main program
  
- Wrote five different modes of user input:
  - 1: Mouse drag / default: User can click and drag nodes around the screen. 
  - 2: Add node: User can click on a location and a node will be added. 
  - 3: Remove node: User can click on a location. If a node exists, it will be deleted, and so will its edges. 
  - 4: Add edge: User has to select two nodes (highlighted) to add edge. The first node can be deselected. 
  - 5: Delete edge: User can click to delete an edge if it exists near click location. 
In terms of how much I tested the five modes:
   - I'm pretty confident they all work fine. #4 is the most technical and it works as of now, but I'll see if
   something happens with it later on.

- Started working on graph class 
  - Basic information: adjacency list, nodes, edges, etc...
  - Started formatting methods (addNode, removeNode, etc...)
  
### Day 2: Tuesday, May 23rd 
Classwork:
- Fixed issue with mode 4, or add edge: Before if you clicked on two nodes already with an edge, a new edge is still created. I've fixed that issue by prohibiting redundant edges (edges are bidirectional for now, but that may change for different algorithms I decide to implement)

- Started to move methods from my main program (findEdge, removeEdges; i.e. helper functions) into the Graph class so that I can call the methods from a graph in main program later on. I also plan to store nodes, edges, etc.. all into the graph class.

Homework - Graph class:
- Wrote addNode(), deleteNode(), addEdge(), deleteEdge(): I haven't tested them, but I will doing that later. I also wrote some other versions of deleteEdge() and addNode() with different parameters.

- Wrote toString() of adjacency list to help with later debugging 

- My graph class currently relies on these things for information storing:
 - Nodes have a 1-1 correspondence with integer id
 - Edges are stored in both adjacency list and array list

- Commented out my main program code except for setup so that I can test my graph class later 

Main Branch: Merge #1
- At this point, I will merge my demo branch into my main branch, since I've commented out my code (for now) and I'll be testing my graph class later on.

### Day 3: Wednesday, May 24th
Classwork:
- Started rewriting user input in the main program to be processed using graph class methods. 
  - I am currently testing graph.addNode(), addEdge(), removeNode(), and removeEdge() 
  -
- Figured out an issue with deleteNode() (Some edges are not removed for some reason), which I will need to fix

Homework:
- Today was a busy day for me, so I did not have any time to work on the project for homework.

### Day 4: Thursday, May 25th
Classwork:
- Fixed issue with edges not being properly deleted from graph class, when I call removeEdges() within the class.
 - I wasn't deleting the correct edge since I did not send the correct reference to the adjacency list, but I've fixed that by editing removeEdges in the graph class.

- Finished adding and testing other user input methods (add node, remove edge, add edge) to be compatible with methods inside the graph class. My graph seems to be functional (for now), but future bugs may or may not occur. (Hopefully not)

- At this point: I'm going to start writing algorithms for my graph visualizer. I started this in class by writing the Algorithm class.
 - Started organizing Algorithm methods (run(), quit(), etc...)
 - algorithms will likely extend the Algorithm class

Homework:
Main Branch: Merge #2
- Since I've tested my graph methods for compatability with user input and it seems to be functional, I'll merge my demo code into the main branch. 
- Once I've tested the algorithm class, I'll do another merge, but that'll take a while.


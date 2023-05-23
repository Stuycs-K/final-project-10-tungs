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
  - 
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
Classwork

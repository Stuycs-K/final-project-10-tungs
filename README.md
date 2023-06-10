# APCS Final Project
Group name: Depth-first visualizer

## Group Info
Period 10 APCS
Group members: Stanley Tung (I am working by myself)
- See my updated project planner here: https://docs.google.com/document/d/1eLPfnbbbFlSupLofqKisawQsjjbZgH_5ptykyuCg0Jw/edit
- Here's my original planner: https://docs.google.com/document/d/1fiUxm2_And5JgNx6-8jnjluo5q7tKGMZjtssJb-djuQ/edit
- Here's my updated UML diagram: https://drive.google.com/file/d/1cPDvwPd3R3B2CaZoJknVhbpqBjJFCdLh/view?usp=sharing

## Some technicalities that I should address
- In my code, I don't use private variables (variables in processing are public by default)
, because it would be really inconvenient, as I rely on using public variables from instances in 
my main program.

- I just noticed my git merge commit messages aren't displayed on screen when they first appear.
(i.e. they have a {...}, so you need to click on the message to see my messages, which I do for every git merge into
the main branch.)

- The maximum number of nodes in the graph is 1000, but you can change that variable. 

- I had some c++ code, written by myself, in my convex hull class (as a comment) for reference while coding the java version. 
If you see it on the internet, it's probably on CSES (an online coding judge) because I submitted that code to test my c++ convex hull code,
before I coded the java version. (My username is Coding Sucks, for reference). Here's a link to my code submission for the convex hull question:
https://cses.fi/problemset/result/6185951/

- In reference to above, the same note applies for my C++ code snippet on DSU in the SpanningTree class. See the SpanningTree class for more info.

## Overview
I've created a graph visualizer, where users can customize their own graph network by adding nodes and edges
(connected between nodes) on the graph. Users have access to 5 "utility modes": move nodes around, add node,
delete node, add edge, and delete edge. 

To add an edge, users select two nodes (highlighted) with the mouse, 
and they can deselect a node if they want to by reclicking on the node. 

After they customize their graph, they can select a certain algorithm to simulate. My graph visualizer currently
supports five algorithms. These are the "algorithm modes" the user has access to:
- Bipartite coloring (undirected graphs)
- Cycle detection (undirected/directed graphs)
- Topological sort (directed graphs)
- Spanning tree (directed graphs)
- Convex hull (undirected/directed graphs)
- See the instructions for details about the specifics of how these algorithms work.

When the user is currently in an algorithm mode and they click their mouse, the graph simulation 
begins. How the visuals appear depends on the specific algorithm, but for all algorithms, a change
in the color of a node represents a change in its "state", whether that's from being unvisited -> visited,
processed -> finished (e.g. for topological sort), and so on and so forth. 

The visualization occurs smoothly over time, so the user can clearly understand what's going on in the algorithm.
  - My personal favorite visualization is the Spanning Tree algorithm, since it merges connected components
    of different colors together, which is very cool to see. (And edges in the spanning tree are marked as green)

In addition to the visuals, I've also included a "text box" that tells the user what's currently occuring in 
the algorithm as the algorithm is visualized for the user. (e.g. node being visited, or a cycle was detected, etc.)

Users can also reset the graph or delete all edges, or change the directionality of edges via text buttons.

## Instructions
Press any key asides from 'r' if you want to change the current mode. 
 - Modes are either "utility" (see above) or "algorithm". For a shortcut, press 1 to go to the first utility mode
  (move nodes), and press 2 to go to the first algorithm mode (bipartite coloring algorithm). 
  
 - Once you move past the last algorithm mode, the mode cycles back to the first utility mode.

If you press 'r', the graph visualization that's currently running will stop the process early.

Utility modes:
1. Move node: Click and drag the nodes.
2. Add node: Click to add a node where the mouse is located.
3. Remove node: Click, and if a node exists where the mouse is located, the node (and all edges connected to it) is deleted.
4. Add edge: Select two nodes (you can deselect the first) with mouse clicks, and an edge will be added between the nodes.
5. Remove edge: Click, and if an edge exists where the mouse is located, the edge will be deleted. 
   - If the edge mode is directed and the edge goes both ways between two nodes, try clicking on one arrow (there should be two arrows,
     representing two directed edges) if you want to accurately remove a single edge.
  
Algorithm modes:
1, 2, 3, 4: See above in Overview for relative order of algorithms.
To start the simulation, click the mouse, and the graph visualization will start. To end it early, press 'r'.
A textbox is also provided, which updates text based on what's currently visualized in the graph.

NOTE: Some algorithms are only intended to work for certain edge types. For instance, the bipartite coloring algorithm
might not work as you expect if you use directed edges, but cycle detection definitely works for both directed and undirected edges.
The specific edge types an algorithm is NOT compatible with, will be mentioned to the user in the graph simulation, if they are currently in that algorithm's mode. 
   - Two edge types: Directed (unidirectional) and undirected (bidirectional)
   - Directed edges will have an arrow, while undirected edges do not have arrows. All edges are either directed or undirected.

NOTE 2: I was going to write a "Minimum" Spanning tree for spanning tree, but implementing weighted edges is too tedious, so instead in my Spanning Tree algorithm,
I simply randomize the order of edges visited and construct a spanning tree based on that order.
 
To change the directionality of edge, click the button for it. (The graph will be reset in the process)
There are also buttons that will reset the graph without changing edge types, or remove all edges in the current graph.

Tips to avoid technical errors:
- Don't click to simulate another algorithm if an algorithm is currently being visualized, and you haven't reset it yet.

- Try to do things in order. In other words, try not to use another mode unless you're done with whatever it is that you're currently doing.
  - But note that I've done the best I could to avoid technical difficulties, so even if you don't do things in order, you shouldn't encounter errors (if any).

- As mentioned in my note above, try not to use algorithms if they are not compatible with a certain edge type, and you are currently in that edge type. 

## A note on text/screen size (user options) 
- While I was working on the project, I set the screen size to be 2000 x 1000 because I was working on a mac computer (whose screen size was approximately that). 
I know that this size might not fit for all devices, so if it does not, then please do the following:
- Go to the processing file finalProject.pde, and change size(sizeX, sizeY) as you need to. 
- Then, call compressText() in the setup() after text boxes have been initialized and added to the arraylist.
- You can change the scaling constants in compressText() if not every text box shows up. These text boxes are:
  - Info on what's happening in current algorithm
  - Some keyboard shortcuts
  - Option to randomize node colors in graph and algorithms
  - Reset graph, remove all edges
  - Change directionality of the graph

- Moreover, if you want to change anything like default color of nodes, the size of nodes, text size, etc., you can edit the variables in the main program. 
 
## How the Algorithms work
For people that are confused about how a certain algorithm works, here is some information:
1. Bipartite coloring (undirected)
  - We try to color all nodes of the graph with two colors, so that no neighbor of a node with color A also has the same color.
  To do this, we can run a depth-first search from arbitrary nodes, and assign visited nodes the opposite color of the previously
  visited node, i.e. it's neighbors. It turns out that if the graph does not have an odd-length cycle, then a bipartite coloring
  will always exist.

2. Cycle detection (undirected/directed)
   - A cycle in a graph is a path of edges that start and end at the same node. We can detect a cycle using a depth-first search and a recursion stack.
   When we visit a node, we mark it as "processing" and add it to the stack. If it's neighbor is currently "processing", then we know that it has been
   visited before, and a cycle must exist. Once we run a DFS from all of its neighbors, we mark the node as "done" 'and pop it from the recursion stack.
   If we detect a cycle, we can use the recursion stack to track the nodes that are part of the cycle. 
   
3. Topological sort (directed)
  - A topological sort of a graph is an ordering of the nodes, such that for every node, it appears earlier than the nodes that it points to,
  i.e. has an edge from that node to it's neighbor that is later in the topological sort. To do a topological sort, we use the idea of cycle detection. 
  If a cycle exists, a topological sort cannot exist. Otherwise, we track the order in which nodes are marked as "done," and the reverse order turns
  out to be a topological sort of the nodes.
  
4. Spanning Tree (undirected)
 - A spanning tree is a subgraph of the graph that is a tree, which has some X amount of nodes and X - 1 edges, which is minimum # of edges
 needed to connect the nodes together. If we want a "Minimum" spanning tree, we would sort edge weights in increasing order and add an edge
 to the subgraph, as long as it connects two separate "connected components" of the graph together. Initially, each node is in its separate
 "connected component," but at the end, nodes should be merged in the same "connected component."
 
 - I didn't have time to implement weighted edges, so instead I just randomized the order of edges and that determines the specific spanning tree
 is formed. 
 
 - Technically a "Spanning forest", since the graph could consist of disjoint components of nodes 

5. Convex Hull
- A convex hull, of a set of points, is a subset such that the convex polygons formed by the points of the subset contain the entire set of points in its interior.
To calculate a convex hull, there's an algorithm known as the "Graham Scan." You first pick a pivot point, and then sort the points counterclockwise relative
to the pivot. Afterwards, we build the convex hull with a stack. If the current point, when connected to the previous points, turns the polygon concave, then
we remove points from the convex hull until the polygon is convex again, and then add the current point. If we repeat the entire process, then eventually
we get the convex hull of the set of points.
